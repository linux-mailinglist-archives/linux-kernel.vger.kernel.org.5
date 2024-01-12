Return-Path: <linux-kernel+bounces-25029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EADE82C655
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 21:18:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8B4B1F24ED0
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 20:18:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03CC31642A;
	Fri, 12 Jan 2024 20:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VrZWim+i"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8CC3168DF;
	Fri, 12 Jan 2024 20:17:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBF0AC43390;
	Fri, 12 Jan 2024 20:17:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705090661;
	bh=KQK8HFiBrFS+woTYBZq/zjxyfwiNhcRq/lPA21igALA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VrZWim+inB6OKSmrcDRQCJXApNgnbzYfZ9uTS8SNBUBdhQG/oxgvvoQzOBwNeMaP+
	 XLD3iv4BsHx2xOSk0gjTrh/YwLfjKvguCL2QCrQi6J9ffPm4aU6RCSIkQyDw770EyK
	 1PJOBhZAzxoVVNDGQ+jKyvzpbuB4B/g3GplLBFXs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 5.10.207
Date: Fri, 12 Jan 2024 21:17:29 +0100
Message-ID: <2024011229-skipper-luxurious-3a24@gregkh>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2024011229-oyster-basically-df9f@gregkh>
References: <2024011229-oyster-basically-df9f@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

diff --git a/Makefile b/Makefile
index 134fba99314d..2435bf3197de 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 5
 PATCHLEVEL = 10
-SUBLEVEL = 206
+SUBLEVEL = 207
 EXTRAVERSION =
 NAME = Dare mighty things
 
diff --git a/drivers/scsi/scsi.c b/drivers/scsi/scsi.c
index 034f2c8a9e0b..d6c25a88cebc 100644
--- a/drivers/scsi/scsi.c
+++ b/drivers/scsi/scsi.c
@@ -197,7 +197,7 @@ void scsi_finish_command(struct scsi_cmnd *cmd)
 				"(result %x)\n", cmd->result));
 
 	good_bytes = scsi_bufflen(cmd);
-	if (!blk_rq_is_passthrough(scsi_cmd_to_rq(cmd))) {
+	if (!blk_rq_is_passthrough(cmd->request)) {
 		int old_good_bytes = good_bytes;
 		drv = scsi_cmd_to_driver(cmd);
 		if (drv->done)
diff --git a/drivers/scsi/scsi_error.c b/drivers/scsi/scsi_error.c
index 30eb8769dbab..3d3d139127ee 100644
--- a/drivers/scsi/scsi_error.c
+++ b/drivers/scsi/scsi_error.c
@@ -50,6 +50,8 @@
 
 #include <asm/unaligned.h>
 
+static void scsi_eh_done(struct scsi_cmnd *scmd);
+
 /*
  * These should *probably* be handled by the host itself.
  * Since it is allowed to sleep, it probably should.
@@ -228,7 +230,7 @@ scsi_abort_command(struct scsi_cmnd *scmd)
  */
 static void scsi_eh_reset(struct scsi_cmnd *scmd)
 {
-	if (!blk_rq_is_passthrough(scsi_cmd_to_rq(scmd))) {
+	if (!blk_rq_is_passthrough(scmd->request)) {
 		struct scsi_driver *sdrv = scsi_cmd_to_driver(scmd);
 		if (sdrv->eh_reset)
 			sdrv->eh_reset(scmd);
@@ -498,8 +500,7 @@ int scsi_check_sense(struct scsi_cmnd *scmd)
 		/* handler does not care. Drop down to default handling */
 	}
 
-	if (scmd->cmnd[0] == TEST_UNIT_READY &&
-	    scmd->submitter != SUBMITTED_BY_SCSI_ERROR_HANDLER)
+	if (scmd->cmnd[0] == TEST_UNIT_READY && scmd->scsi_done != scsi_eh_done)
 		/*
 		 * nasty: for mid-layer issued TURs, we need to return the
 		 * actual sense data without any recovery attempt.  For eh
@@ -767,7 +768,7 @@ static int scsi_eh_completed_normally(struct scsi_cmnd *scmd)
  * scsi_eh_done - Completion function for error handling.
  * @scmd:	Cmd that is done.
  */
-void scsi_eh_done(struct scsi_cmnd *scmd)
+static void scsi_eh_done(struct scsi_cmnd *scmd)
 {
 	struct completion *eh_action;
 
@@ -1067,7 +1068,7 @@ static int scsi_send_eh_cmnd(struct scsi_cmnd *scmd, unsigned char *cmnd,
 	shost->eh_action = &done;
 
 	scsi_log_send(scmd);
-	scmd->submitter = SUBMITTED_BY_SCSI_ERROR_HANDLER;
+	scmd->scsi_done = scsi_eh_done;
 	scmd->flags |= SCMD_LAST;
 
 	/*
@@ -1095,7 +1096,6 @@ static int scsi_send_eh_cmnd(struct scsi_cmnd *scmd, unsigned char *cmnd,
 	if (rtn) {
 		if (timeleft > stall_for) {
 			scsi_eh_restore_cmnd(scmd, &ses);
-
 			timeleft -= stall_for;
 			msleep(jiffies_to_msecs(stall_for));
 			goto retry;
@@ -1168,7 +1168,7 @@ static int scsi_request_sense(struct scsi_cmnd *scmd)
 
 static int scsi_eh_action(struct scsi_cmnd *scmd, int rtn)
 {
-	if (!blk_rq_is_passthrough(scsi_cmd_to_rq(scmd))) {
+	if (!blk_rq_is_passthrough(scmd->request)) {
 		struct scsi_driver *sdrv = scsi_cmd_to_driver(scmd);
 		if (sdrv->eh_action)
 			rtn = sdrv->eh_action(scmd, rtn);
@@ -1734,24 +1734,22 @@ static void scsi_eh_offline_sdevs(struct list_head *work_q,
  */
 int scsi_noretry_cmd(struct scsi_cmnd *scmd)
 {
-	struct request *req = scsi_cmd_to_rq(scmd);
-
 	switch (host_byte(scmd->result)) {
 	case DID_OK:
 		break;
 	case DID_TIME_OUT:
 		goto check_type;
 	case DID_BUS_BUSY:
-		return req->cmd_flags & REQ_FAILFAST_TRANSPORT;
+		return (scmd->request->cmd_flags & REQ_FAILFAST_TRANSPORT);
 	case DID_PARITY:
-		return req->cmd_flags & REQ_FAILFAST_DEV;
+		return (scmd->request->cmd_flags & REQ_FAILFAST_DEV);
 	case DID_ERROR:
 		if (msg_byte(scmd->result) == COMMAND_COMPLETE &&
 		    status_byte(scmd->result) == RESERVATION_CONFLICT)
 			return 0;
 		fallthrough;
 	case DID_SOFT_ERROR:
-		return req->cmd_flags & REQ_FAILFAST_DRIVER;
+		return (scmd->request->cmd_flags & REQ_FAILFAST_DRIVER);
 	}
 
 	if (status_byte(scmd->result) != CHECK_CONDITION)
@@ -1762,7 +1760,8 @@ int scsi_noretry_cmd(struct scsi_cmnd *scmd)
 	 * assume caller has checked sense and determined
 	 * the check condition was retryable.
 	 */
-	if (req->cmd_flags & REQ_FAILFAST_DEV || blk_rq_is_passthrough(req))
+	if (scmd->request->cmd_flags & REQ_FAILFAST_DEV ||
+	    blk_rq_is_passthrough(scmd->request))
 		return 1;
 
 	return 0;
@@ -2323,6 +2322,11 @@ void scsi_report_device_reset(struct Scsi_Host *shost, int channel, int target)
 }
 EXPORT_SYMBOL(scsi_report_device_reset);
 
+static void
+scsi_reset_provider_done_command(struct scsi_cmnd *scmd)
+{
+}
+
 /**
  * scsi_ioctl_reset: explicitly reset a host/bus/target/device
  * @dev:	scsi_device to operate on
@@ -2358,9 +2362,9 @@ scsi_ioctl_reset(struct scsi_device *dev, int __user *arg)
 	scsi_init_command(dev, scmd);
 	scmd->request = rq;
 	scmd->cmnd = scsi_req(rq)->cmd;
-
-	scmd->submitter = SUBMITTED_BY_SCSI_RESET_IOCTL;
 	scmd->flags |= SCMD_LAST;
+
+	scmd->scsi_done		= scsi_reset_provider_done_command;
 	memset(&scmd->sdb, 0, sizeof(scmd->sdb));
 
 	scmd->cmd_len			= 0;
diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index 20c2700e1f63..99b90031500b 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -153,15 +153,13 @@ scsi_set_blocked(struct scsi_cmnd *cmd, int reason)
 
 static void scsi_mq_requeue_cmd(struct scsi_cmnd *cmd)
 {
-	struct request *rq = scsi_cmd_to_rq(cmd);
-
-	if (rq->rq_flags & RQF_DONTPREP) {
-		rq->rq_flags &= ~RQF_DONTPREP;
+	if (cmd->request->rq_flags & RQF_DONTPREP) {
+		cmd->request->rq_flags &= ~RQF_DONTPREP;
 		scsi_mq_uninit_cmd(cmd);
 	} else {
 		WARN_ON_ONCE(true);
 	}
-	blk_mq_requeue_request(rq, true);
+	blk_mq_requeue_request(cmd->request, true);
 }
 
 /**
@@ -200,7 +198,7 @@ static void __scsi_queue_insert(struct scsi_cmnd *cmd, int reason, bool unbusy)
 	 */
 	cmd->result = 0;
 
-	blk_mq_requeue_request(scsi_cmd_to_rq(cmd), true);
+	blk_mq_requeue_request(cmd->request, true);
 }
 
 /**
@@ -510,7 +508,7 @@ void scsi_run_host_queues(struct Scsi_Host *shost)
 
 static void scsi_uninit_cmd(struct scsi_cmnd *cmd)
 {
-	if (!blk_rq_is_passthrough(scsi_cmd_to_rq(cmd))) {
+	if (!blk_rq_is_passthrough(cmd->request)) {
 		struct scsi_driver *drv = scsi_cmd_to_driver(cmd);
 
 		if (drv->uninit_command)
@@ -660,7 +658,7 @@ static void scsi_io_completion_reprep(struct scsi_cmnd *cmd,
 
 static bool scsi_cmd_runtime_exceeced(struct scsi_cmnd *cmd)
 {
-	struct request *req = scsi_cmd_to_rq(cmd);
+	struct request *req = cmd->request;
 	unsigned long wait_for;
 
 	if (cmd->allowed == SCSI_CMD_RETRIES_NO_LIMIT)
@@ -679,7 +677,7 @@ static bool scsi_cmd_runtime_exceeced(struct scsi_cmnd *cmd)
 static void scsi_io_completion_action(struct scsi_cmnd *cmd, int result)
 {
 	struct request_queue *q = cmd->device->request_queue;
-	struct request *req = scsi_cmd_to_rq(cmd);
+	struct request *req = cmd->request;
 	int level = 0;
 	enum {ACTION_FAIL, ACTION_REPREP, ACTION_RETRY,
 	      ACTION_DELAYED_RETRY} action;
@@ -851,7 +849,7 @@ static int scsi_io_completion_nz_result(struct scsi_cmnd *cmd, int result,
 {
 	bool sense_valid;
 	bool sense_current = true;	/* false implies "deferred sense" */
-	struct request *req = scsi_cmd_to_rq(cmd);
+	struct request *req = cmd->request;
 	struct scsi_sense_hdr sshdr;
 
 	sense_valid = scsi_command_normalize_sense(cmd, &sshdr);
@@ -940,7 +938,7 @@ void scsi_io_completion(struct scsi_cmnd *cmd, unsigned int good_bytes)
 {
 	int result = cmd->result;
 	struct request_queue *q = cmd->device->request_queue;
-	struct request *req = scsi_cmd_to_rq(cmd);
+	struct request *req = cmd->request;
 	blk_status_t blk_stat = BLK_STS_OK;
 
 	if (unlikely(result))	/* a nz result may or may not be an error */
@@ -1008,7 +1006,7 @@ static inline bool scsi_cmd_needs_dma_drain(struct scsi_device *sdev,
 blk_status_t scsi_alloc_sgtables(struct scsi_cmnd *cmd)
 {
 	struct scsi_device *sdev = cmd->device;
-	struct request *rq = scsi_cmd_to_rq(cmd);
+	struct request *rq = cmd->request;
 	unsigned short nr_segs = blk_rq_nr_phys_segments(rq);
 	struct scatterlist *last_sg = NULL;
 	blk_status_t ret;
@@ -1137,7 +1135,7 @@ void scsi_init_command(struct scsi_device *dev, struct scsi_cmnd *cmd)
 {
 	void *buf = cmd->sense_buffer;
 	void *prot = cmd->prot_sdb;
-	struct request *rq = scsi_cmd_to_rq(cmd);
+	struct request *rq = blk_mq_rq_from_pdu(cmd);
 	unsigned int flags = cmd->flags & SCMD_PRESERVED_FLAGS;
 	unsigned long jiffies_at_alloc;
 	int retries, to_clear;
@@ -1596,21 +1594,12 @@ static blk_status_t scsi_prepare_cmd(struct request *req)
 
 static void scsi_mq_done(struct scsi_cmnd *cmd)
 {
-	switch (cmd->submitter) {
-	case SUBMITTED_BY_BLOCK_LAYER:
-		break;
-	case SUBMITTED_BY_SCSI_ERROR_HANDLER:
-		return scsi_eh_done(cmd);
-	case SUBMITTED_BY_SCSI_RESET_IOCTL:
-		return;
-	}
-
-	if (unlikely(blk_should_fake_timeout(scsi_cmd_to_rq(cmd)->q)))
+	if (unlikely(blk_should_fake_timeout(cmd->request->q)))
 		return;
 	if (unlikely(test_and_set_bit(SCMD_STATE_COMPLETE, &cmd->state)))
 		return;
 	trace_scsi_dispatch_cmd_done(cmd);
-	blk_mq_complete_request(scsi_cmd_to_rq(cmd));
+	blk_mq_complete_request(cmd->request);
 }
 
 static void scsi_mq_put_budget(struct request_queue *q)
@@ -1694,7 +1683,6 @@ static blk_status_t scsi_queue_rq(struct blk_mq_hw_ctx *hctx,
 
 	scsi_set_resid(cmd, 0);
 	memset(cmd->sense_buffer, 0, SCSI_SENSE_BUFFERSIZE);
-	cmd->submitter = SUBMITTED_BY_BLOCK_LAYER;
 	cmd->scsi_done = scsi_mq_done;
 
 	blk_mq_start_request(req);
diff --git a/drivers/scsi/scsi_logging.c b/drivers/scsi/scsi_logging.c
index f0ae55ad0973..8ea44c6595ef 100644
--- a/drivers/scsi/scsi_logging.c
+++ b/drivers/scsi/scsi_logging.c
@@ -28,9 +28,8 @@ static void scsi_log_release_buffer(char *bufptr)
 
 static inline const char *scmd_name(const struct scsi_cmnd *scmd)
 {
-	struct request *rq = scsi_cmd_to_rq((struct scsi_cmnd *)scmd);
-
-	return rq->rq_disk ? rq->rq_disk->disk_name : NULL;
+	return scmd->request->rq_disk ?
+		scmd->request->rq_disk->disk_name : NULL;
 }
 
 static size_t sdev_format_header(char *logbuf, size_t logbuf_len,
@@ -92,7 +91,7 @@ void scmd_printk(const char *level, const struct scsi_cmnd *scmd,
 	if (!logbuf)
 		return;
 	off = sdev_format_header(logbuf, logbuf_len, scmd_name(scmd),
-				 scsi_cmd_to_rq((struct scsi_cmnd *)scmd)->tag);
+				 scmd->request->tag);
 	if (off < logbuf_len) {
 		va_start(args, fmt);
 		off += vscnprintf(logbuf + off, logbuf_len - off, fmt, args);
@@ -189,7 +188,7 @@ void scsi_print_command(struct scsi_cmnd *cmd)
 		return;
 
 	off = sdev_format_header(logbuf, logbuf_len,
-				 scmd_name(cmd), scsi_cmd_to_rq(cmd)->tag);
+				 scmd_name(cmd), cmd->request->tag);
 	if (off >= logbuf_len)
 		goto out_printk;
 	off += scnprintf(logbuf + off, logbuf_len - off, "CDB: ");
@@ -211,7 +210,7 @@ void scsi_print_command(struct scsi_cmnd *cmd)
 
 			off = sdev_format_header(logbuf, logbuf_len,
 						 scmd_name(cmd),
-						 scsi_cmd_to_rq(cmd)->tag);
+						 cmd->request->tag);
 			if (!WARN_ON(off > logbuf_len - 58)) {
 				off += scnprintf(logbuf + off, logbuf_len - off,
 						 "CDB[%02x]: ", k);
@@ -374,8 +373,7 @@ EXPORT_SYMBOL(__scsi_print_sense);
 /* Normalize and print sense buffer in SCSI command */
 void scsi_print_sense(const struct scsi_cmnd *cmd)
 {
-	scsi_log_print_sense(cmd->device, scmd_name(cmd),
-			     scsi_cmd_to_rq((struct scsi_cmnd *)cmd)->tag,
+	scsi_log_print_sense(cmd->device, scmd_name(cmd), cmd->request->tag,
 			     cmd->sense_buffer, SCSI_SENSE_BUFFERSIZE);
 }
 EXPORT_SYMBOL(scsi_print_sense);
@@ -394,8 +392,8 @@ void scsi_print_result(const struct scsi_cmnd *cmd, const char *msg,
 	if (!logbuf)
 		return;
 
-	off = sdev_format_header(logbuf, logbuf_len, scmd_name(cmd),
-				 scsi_cmd_to_rq((struct scsi_cmnd *)cmd)->tag);
+	off = sdev_format_header(logbuf, logbuf_len,
+				 scmd_name(cmd), cmd->request->tag);
 
 	if (off >= logbuf_len)
 		goto out_printk;
diff --git a/drivers/scsi/scsi_priv.h b/drivers/scsi/scsi_priv.h
index 89992d8879ac..180636d54982 100644
--- a/drivers/scsi/scsi_priv.h
+++ b/drivers/scsi/scsi_priv.h
@@ -82,7 +82,6 @@ void scsi_eh_ready_devs(struct Scsi_Host *shost,
 int scsi_eh_get_sense(struct list_head *work_q,
 		      struct list_head *done_q);
 int scsi_noretry_cmd(struct scsi_cmnd *scmd);
-void scsi_eh_done(struct scsi_cmnd *scmd);
 
 /* scsi_lib.c */
 extern int scsi_maybe_unblock_host(struct scsi_device *sdev);
diff --git a/include/scsi/scsi_cmnd.h b/include/scsi/scsi_cmnd.h
index 2e26eb0d353e..b1c9b52876f3 100644
--- a/include/scsi/scsi_cmnd.h
+++ b/include/scsi/scsi_cmnd.h
@@ -65,12 +65,6 @@ struct scsi_pointer {
 #define SCMD_STATE_COMPLETE	0
 #define SCMD_STATE_INFLIGHT	1
 
-enum scsi_cmnd_submitter {
-	SUBMITTED_BY_BLOCK_LAYER = 0,
-	SUBMITTED_BY_SCSI_ERROR_HANDLER = 1,
-	SUBMITTED_BY_SCSI_RESET_IOCTL = 2,
-} __packed;
-
 struct scsi_cmnd {
 	struct scsi_request req;
 	struct scsi_device *device;
@@ -94,7 +88,6 @@ struct scsi_cmnd {
 	unsigned char prot_op;
 	unsigned char prot_type;
 	unsigned char prot_flags;
-	enum scsi_cmnd_submitter submitter;
 
 	unsigned short cmd_len;
 	enum dma_data_direction sc_data_direction;
@@ -169,9 +162,7 @@ static inline void *scsi_cmd_priv(struct scsi_cmnd *cmd)
 /* make sure not to use it with passthrough commands */
 static inline struct scsi_driver *scsi_cmd_to_driver(struct scsi_cmnd *cmd)
 {
-	struct request *rq = scsi_cmd_to_rq(cmd);
-
-	return *(struct scsi_driver **)rq->rq_disk->private_data;
+	return *(struct scsi_driver **)cmd->request->rq_disk->private_data;
 }
 
 extern void scsi_finish_command(struct scsi_cmnd *cmd);
@@ -233,18 +224,6 @@ static inline int scsi_sg_copy_to_buffer(struct scsi_cmnd *cmd,
 				 buf, buflen);
 }
 
-static inline sector_t scsi_get_sector(struct scsi_cmnd *scmd)
-{
-	return blk_rq_pos(scsi_cmd_to_rq(scmd));
-}
-
-static inline sector_t scsi_get_lba(struct scsi_cmnd *scmd)
-{
-	unsigned int shift = ilog2(scmd->device->sector_size) - SECTOR_SHIFT;
-
-	return blk_rq_pos(scsi_cmd_to_rq(scmd)) >> shift;
-}
-
 /*
  * The operations below are hints that tell the controller driver how
  * to handle I/Os with DIF or similar types of protection information.
@@ -307,11 +286,9 @@ static inline unsigned char scsi_get_prot_type(struct scsi_cmnd *scmd)
 	return scmd->prot_type;
 }
 
-static inline u32 scsi_prot_ref_tag(struct scsi_cmnd *scmd)
+static inline sector_t scsi_get_lba(struct scsi_cmnd *scmd)
 {
-	struct request *rq = blk_mq_rq_from_pdu(scmd);
-
-	return t10_pi_ref_tag(rq);
+	return blk_rq_pos(scmd->request);
 }
 
 static inline unsigned int scsi_prot_interval(struct scsi_cmnd *scmd)
diff --git a/include/scsi/scsi_device.h b/include/scsi/scsi_device.h
index 993e1e79dd0c..1a5c9a3df6d6 100644
--- a/include/scsi/scsi_device.h
+++ b/include/scsi/scsi_device.h
@@ -264,15 +264,13 @@ sdev_prefix_printk(const char *, const struct scsi_device *, const char *,
 __printf(3, 4) void
 scmd_printk(const char *, const struct scsi_cmnd *, const char *, ...);
 
-#define scmd_dbg(scmd, fmt, a...)					\
-	do {								\
-		struct request *__rq = scsi_cmd_to_rq((scmd));		\
-									\
-		if (__rq->rq_disk)					\
-			sdev_dbg((scmd)->device, "[%s] " fmt,		\
-				 __rq->rq_disk->disk_name, ##a);	\
-		else							\
-			sdev_dbg((scmd)->device, fmt, ##a);		\
+#define scmd_dbg(scmd, fmt, a...)					   \
+	do {								   \
+		if ((scmd)->request->rq_disk)				   \
+			sdev_dbg((scmd)->device, "[%s] " fmt,		   \
+				 (scmd)->request->rq_disk->disk_name, ##a);\
+		else							   \
+			sdev_dbg((scmd)->device, fmt, ##a);		   \
 	} while (0)
 
 enum scsi_target_state {

