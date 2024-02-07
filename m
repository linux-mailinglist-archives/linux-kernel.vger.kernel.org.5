Return-Path: <linux-kernel+bounces-56921-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB75884D16A
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 19:44:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EEB2C1C25225
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 18:44:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DE6D86AD4;
	Wed,  7 Feb 2024 18:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qez9rF5q"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0087885C55
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 18:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707331354; cv=none; b=tBvasGo3yb3+U/Ld3cK3XD6+Q+uooEVwjOTwaKpnAcEJp5YXWk6REpaynM48/efa2WpZgvEL+5LQMQJFqOi7OlohXoDkJLQIAG6RQwJFMHgjUuKJ13YYKro6wE6UToNWdRNLF5qk/df5Zu/MLWDEzU4UloJWqJM0hmErAkvSEHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707331354; c=relaxed/simple;
	bh=WqtFxcWaLhMLfcgOm6/fPisBGllXDcSk/ewd1nnwqAo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PGXVQ7A6IHm+eltN/5TOtbV4f4m8kmDiDloxLir9Ib04vc6gqvnCg4DZQlk8EEhfBYTuLzJx1NXChYL06tXnfMcq/Gx3a+PTYqDT+eXdt8RuSVTEgcqpLnQXr6RCWhDamMOGZhYpHlPBapT4UFSQA+Sw01TtUY6qdtWRob6hJf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Qez9rF5q; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707331352;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CkqM01Ya14Nn8HXhASJf/0/vp8tMuDctYMCTKWoKrUI=;
	b=Qez9rF5q83g+zLRbfk8AG8419pUiEpu+YN8evHmwO+y9a6LM3n0a02QSF/aQYJsSOf1Wb0
	gKf3Re9aRUk+2a+0x6muWMtaQcNprTAQ6OujsnTzAeG/MDFbWpUHaFJzXcNNlp4Ti3S+HK
	gk3/fGVS3ENWcLprC0wO2V1mE+Nv9Mo=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-180-Nw_CWQa9P_abWidS2p2VLA-1; Wed,
 07 Feb 2024 13:42:26 -0500
X-MC-Unique: Nw_CWQa9P_abWidS2p2VLA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7AE253C23FC6;
	Wed,  7 Feb 2024 18:42:26 +0000 (UTC)
Received: from fedora-work.redhat.com (unknown [10.22.32.236])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 1127740C9444;
	Wed,  7 Feb 2024 18:42:26 +0000 (UTC)
From: David Jeffery <djeffery@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	David Jeffery <djeffery@redhat.com>,
	Laurence Oberman <loberman@redhat.com>
Subject: [RFC PATCH 5/6] scsi mid layer support for async command submit
Date: Wed,  7 Feb 2024 13:40:59 -0500
Message-ID: <20240207184100.18066-6-djeffery@redhat.com>
In-Reply-To: <20240207184100.18066-1-djeffery@redhat.com>
References: <20240207184100.18066-1-djeffery@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2

Create scsi_execute_cmd_nowait to allow asynchronous scsi command submit.
Parts of the code originally in scsi_execute_cmd are shifted into helper
functions used by both scsi_execute_cmd and the new scsi_execute_cmd_nowait.

The scsi_exec_args struct is expanded to contain the fields needed for
the completion and callback for the async path.

Signed-off-by: David Jeffery <djeffery@redhat.com>
Tested-by:     Laurence Oberman <loberman@redhat.com>

---
 drivers/scsi/scsi_lib.c    | 138 +++++++++++++++++++++++++++++--------
 include/scsi/scsi_device.h |   8 +++
 2 files changed, 118 insertions(+), 28 deletions(-)

diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index 1fb80eae9a63..fe35bc2021e3 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -185,42 +185,37 @@ void scsi_queue_insert(struct scsi_cmnd *cmd, int reason)
 }
 
 /**
- * scsi_execute_cmd - insert request and wait for the result
+ * scsi_execute_init - helper for setting up a scsi_cmnd in a request
  * @sdev:	scsi_device
  * @cmd:	scsi command
  * @opf:	block layer request cmd_flags
- * @buffer:	data buffer
- * @bufflen:	len of buffer
  * @timeout:	request timeout in HZ
  * @retries:	number of times to retry request
- * @args:	Optional args. See struct definition for field descriptions
+ * @args:	scsi command args
  *
- * Returns the scsi_cmnd result field if a command was executed, or a negative
- * Linux error code if we didn't get that far.
+ * Returns a request if successful, or an error pointer if there was a failure.
  */
-int scsi_execute_cmd(struct scsi_device *sdev, const unsigned char *cmd,
-		     blk_opf_t opf, void *buffer, unsigned int bufflen,
-		     int timeout, int retries,
-		     const struct scsi_exec_args *args)
+static struct request *scsi_execute_init(struct scsi_device *sdev,
+					 const unsigned char *cmd,
+					 blk_opf_t opf,
+					 int timeout, int retries,
+					 struct scsi_exec_args *args)
 {
-	static const struct scsi_exec_args default_args;
 	struct request *req;
 	struct scsi_cmnd *scmd;
 	int ret;
 
-	if (!args)
-		args = &default_args;
-	else if (WARN_ON_ONCE(args->sense &&
-			      args->sense_len != SCSI_SENSE_BUFFERSIZE))
-		return -EINVAL;
+	if (WARN_ON_ONCE(args->sense &&
+			 args->sense_len != SCSI_SENSE_BUFFERSIZE))
+		return ERR_PTR(-EINVAL);
 
 	req = scsi_alloc_request(sdev->request_queue, opf, args->req_flags);
 	if (IS_ERR(req))
-		return PTR_ERR(req);
+		return req;
 
-	if (bufflen) {
-		ret = blk_rq_map_kern(sdev->request_queue, req,
-				      buffer, bufflen, GFP_NOIO);
+	if (args->bufflen) {
+		ret = blk_rq_map_kern(sdev->request_queue, req, args->buffer,
+				      args->bufflen, GFP_NOIO);
 		if (ret)
 			goto out;
 	}
@@ -232,19 +227,27 @@ int scsi_execute_cmd(struct scsi_device *sdev, const unsigned char *cmd,
 	req->timeout = timeout;
 	req->rq_flags |= RQF_QUIET;
 
-	/*
-	 * head injection *required* here otherwise quiesce won't work
-	 */
-	blk_execute_rq(req, true);
+	return req;
+out:
+	blk_mq_free_request(req);
+	return ERR_PTR(ret);
+}
+
+static int scsi_execute_uninit(struct request *req,
+				struct scsi_exec_args *args)
+{
+	struct scsi_cmnd *scmd;
 
+	scmd = blk_mq_rq_to_pdu(req);
 	/*
 	 * Some devices (USB mass-storage in particular) may transfer
 	 * garbage data together with a residue indicating that the data
 	 * is invalid.  Prevent the garbage from being misinterpreted
 	 * and prevent security leaks by zeroing out the excess data.
 	 */
-	if (unlikely(scmd->resid_len > 0 && scmd->resid_len <= bufflen))
-		memset(buffer + bufflen - scmd->resid_len, 0, scmd->resid_len);
+	if (unlikely(scmd->resid_len > 0 && scmd->resid_len <= args->bufflen))
+		memset(args->buffer + args->bufflen - scmd->resid_len, 0,
+		       scmd->resid_len);
 
 	if (args->resid)
 		*args->resid = scmd->resid_len;
@@ -254,14 +257,93 @@ int scsi_execute_cmd(struct scsi_device *sdev, const unsigned char *cmd,
 		scsi_normalize_sense(scmd->sense_buffer, scmd->sense_len,
 				     args->sshdr);
 
-	ret = scmd->result;
- out:
+	args->result = scmd->result;
+
+	if (args->callback)
+		args->callback(scmd, args);
+
+	return scmd->result;
+}
+
+/**
+ * scsi_execute_cmd - insert request and wait for the result
+ * @sdev:	scsi_device
+ * @cmd:	scsi command
+ * @opf:	block layer request cmd_flags
+ * @buffer:	data buffer
+ * @bufflen:	len of buffer
+ * @timeout:	request timeout in HZ
+ * @retries:	number of times to retry request
+ * @args:	Optional args. See struct definition for field descriptions
+ *
+ * Returns the scsi_cmnd result field if a command was executed, or a negative
+ * Linux error code if we didn't get that far.
+ */
+int scsi_execute_cmd(struct scsi_device *sdev, const unsigned char *cmd,
+		     blk_opf_t opf, void *buffer, unsigned int bufflen,
+		     int timeout, int retries,
+		     const struct scsi_exec_args *const_args)
+{
+	struct scsi_exec_args args;
+	int ret;
+	struct request *req;
+
+	if (!const_args)
+		memset(&args, 0, sizeof(struct scsi_exec_args));
+	else
+		args = *const_args;
+
+	args.buffer = buffer;
+	args.bufflen = bufflen;
+
+	req = scsi_execute_init(sdev, cmd, opf, timeout, retries, &args);
+
+	if (IS_ERR(req))
+		return PTR_ERR(req);
+
+	/*
+	 * head injection *required* here otherwise quiesce won't work
+	 */
+	blk_execute_rq(req, true);
+
+	ret = scsi_execute_uninit(req, &args);
+
 	blk_mq_free_request(req);
 
 	return ret;
 }
 EXPORT_SYMBOL(scsi_execute_cmd);
 
+
+static enum rq_end_io_ret scsi_execute_cmd_complete(struct request *req,
+						    blk_status_t ret)
+{
+	struct scsi_exec_args *args = req->end_io_data;
+
+	scsi_execute_uninit(req, args);
+	return RQ_END_IO_FREE;
+}
+
+int scsi_execute_cmd_nowait(struct scsi_device *sdev, const unsigned char *cmd,
+			    blk_opf_t opf, int timeout, int retries,
+			    struct scsi_exec_args *args)
+{
+	struct request *req;
+
+	req = scsi_execute_init(sdev, cmd, opf, timeout, retries, args);
+
+	if (IS_ERR(req))
+		return PTR_ERR(req);
+
+	req->end_io = scsi_execute_cmd_complete;
+	req->end_io_data = args;
+
+	blk_execute_rq_nowait(req, true);
+
+	return 0;
+}
+EXPORT_SYMBOL(scsi_execute_cmd_nowait);
+
 /*
  * Wake up the error handler if necessary. Avoid as follows that the error
  * handler is not woken up if host in-flight requests number ==
diff --git a/include/scsi/scsi_device.h b/include/scsi/scsi_device.h
index 5ec1e71a09de..c80c98b48bc1 100644
--- a/include/scsi/scsi_device.h
+++ b/include/scsi/scsi_device.h
@@ -497,6 +497,10 @@ struct scsi_exec_args {
 	blk_mq_req_flags_t req_flags;	/* BLK_MQ_REQ flags */
 	int scmd_flags;			/* SCMD flags */
 	int *resid;			/* residual length */
+	void *buffer;			/* data buffer */
+	unsigned int bufflen;		/* buffer length */
+	int result;			/* scsi layer result */
+	void (*callback)(struct scsi_cmnd *scmd, struct scsi_exec_args *args);
 };
 
 int scsi_execute_cmd(struct scsi_device *sdev, const unsigned char *cmd,
@@ -504,6 +508,10 @@ int scsi_execute_cmd(struct scsi_device *sdev, const unsigned char *cmd,
 		     int timeout, int retries,
 		     const struct scsi_exec_args *args);
 
+int scsi_execute_cmd_nowait(struct scsi_device *sdev, const unsigned char *cmd,
+			    blk_opf_t opf, int timeout, int retries,
+			    struct scsi_exec_args *args);
+
 extern void sdev_disable_disk_events(struct scsi_device *sdev);
 extern void sdev_enable_disk_events(struct scsi_device *sdev);
 extern int scsi_vpd_lun_id(struct scsi_device *, char *, size_t);
-- 
2.43.0


