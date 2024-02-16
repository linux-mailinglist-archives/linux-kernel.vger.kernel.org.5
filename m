Return-Path: <linux-kernel+bounces-68261-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DDE88577EF
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 09:49:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE4F92849F7
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 08:49:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC6D91BF27;
	Fri, 16 Feb 2024 08:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="zoqV4ddp";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="6j7XmLkw";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="zoqV4ddp";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="6j7XmLkw"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 467B01804F
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 08:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708073145; cv=none; b=Wief8Iu7zRitEa+LKCrGIyX4+aKFm1ByYBODfCBczIOu4fajc9qDhyiXrwmHHDDvAiyMZ7b8eEohRmDHOt85PgJdKJ9z3aM9G+4RgnwlkHN82cCRhrDyCT/ZGmBvA4UZ8wMscvYI12JlORJjoJQDuSMv3XS0qP+iW7ig9DBx5BQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708073145; c=relaxed/simple;
	bh=dxyqoBlToMlpFGgTCP/YtH2AdtfWA6pmR+U0ABbo54k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M8ycdH7ncrj+wRab3drQT65GzmahRyALOvVzRFimYsnR/QpIk0BJ/vstlZcCQxCzWI+QFWAFUOBSr3g3FMZ3nfEs9otFAavi3kCg28Yt4+UKq9bN7BdMTRZOZpFGMqOUYMNmXFMp+ITSDWG6W48z5efv4TLw6x83TBQs7dYq4VU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=zoqV4ddp; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=6j7XmLkw; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=zoqV4ddp; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=6j7XmLkw; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7314F22053;
	Fri, 16 Feb 2024 08:45:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708073139; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yTXpAiEpJ8wDgeOJl+hhqk7EFIqi9rB5Yokta6R/OiA=;
	b=zoqV4ddpP9CWbGZYDQSBiCaO8S7n4uNm61O9cmscp48+rcZzQYPMcTcHEAAmHnb4Lja/6K
	F9820rQfcOv9C81+ZPoZaf2BXn4NvFIha+Vglbd97I++3pUP/nzmcs8XktPdxJGWZmKPSN
	k3J1Uku8+213u2qgdFy92r1N5knKysI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708073139;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yTXpAiEpJ8wDgeOJl+hhqk7EFIqi9rB5Yokta6R/OiA=;
	b=6j7XmLkwCvYgb8hH3ErKDUKpdntt4lhCjycCJGEP5N9m6XzjvysF/b8G7dFSHqGbH8AvUR
	tyZJhWALpfJ37PBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708073139; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yTXpAiEpJ8wDgeOJl+hhqk7EFIqi9rB5Yokta6R/OiA=;
	b=zoqV4ddpP9CWbGZYDQSBiCaO8S7n4uNm61O9cmscp48+rcZzQYPMcTcHEAAmHnb4Lja/6K
	F9820rQfcOv9C81+ZPoZaf2BXn4NvFIha+Vglbd97I++3pUP/nzmcs8XktPdxJGWZmKPSN
	k3J1Uku8+213u2qgdFy92r1N5knKysI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708073139;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yTXpAiEpJ8wDgeOJl+hhqk7EFIqi9rB5Yokta6R/OiA=;
	b=6j7XmLkwCvYgb8hH3ErKDUKpdntt4lhCjycCJGEP5N9m6XzjvysF/b8G7dFSHqGbH8AvUR
	tyZJhWALpfJ37PBA==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 5F0CE13343;
	Fri, 16 Feb 2024 08:45:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id +TnBFbMgz2WYcwAAn2gu4w
	(envelope-from <dwagner@suse.de>); Fri, 16 Feb 2024 08:45:39 +0000
From: Daniel Wagner <dwagner@suse.de>
To: James Smart <james.smart@broadcom.com>
Cc: Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Hannes Reinecke <hare@suse.de>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH v0 1/6] nvme-fabrics: introduce connect_sync option
Date: Fri, 16 Feb 2024 09:45:21 +0100
Message-ID: <20240216084526.14133-2-dwagner@suse.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240216084526.14133-1-dwagner@suse.de>
References: <20240216084526.14133-1-dwagner@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=zoqV4ddp;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=6j7XmLkw
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-1.51 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[8];
	 MID_CONTAINS_FROM(1.00)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Score: -1.51
X-Rspamd-Queue-Id: 7314F22053
X-Spam-Flag: NO

The TCP and RDMA transport are doing a synchronous connect, meaning the
syscal returns with the final result, that is. it either failed or
succeeded.

This isn't the case for FC. This transport just setups and triggers
the connect and returns without waiting on the result. Introduce a flag
to allow user space to control the behavior, wait or don't wait.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 drivers/nvme/host/fabrics.c | 6 +++++-
 drivers/nvme/host/fabrics.h | 3 +++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index 3499acbf6a82..7d33f0f5824f 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -678,6 +678,7 @@ static const match_table_t opt_tokens = {
 #ifdef CONFIG_NVME_TCP_TLS
 	{ NVMF_OPT_TLS,			"tls"			},
 #endif
+	{ NVMF_OPT_CONNECT_SYNC,	"connect_sync"		},
 	{ NVMF_OPT_ERR,			NULL			}
 };
 
@@ -1024,6 +1025,9 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
 			}
 			opts->tls = true;
 			break;
+		case NVMF_OPT_CONNECT_SYNC:
+			opts->connect_sync = true;
+			break;
 		default:
 			pr_warn("unknown parameter or missing value '%s' in ctrl creation request\n",
 				p);
@@ -1245,7 +1249,7 @@ EXPORT_SYMBOL_GPL(nvmf_free_options);
 				 NVMF_OPT_HOST_ID | NVMF_OPT_DUP_CONNECT |\
 				 NVMF_OPT_DISABLE_SQFLOW | NVMF_OPT_DISCOVERY |\
 				 NVMF_OPT_FAIL_FAST_TMO | NVMF_OPT_DHCHAP_SECRET |\
-				 NVMF_OPT_DHCHAP_CTRL_SECRET)
+				 NVMF_OPT_DHCHAP_CTRL_SECRET | NVMF_OPT_CONNECT_SYNC)
 
 static struct nvme_ctrl *
 nvmf_create_ctrl(struct device *dev, const char *buf)
diff --git a/drivers/nvme/host/fabrics.h b/drivers/nvme/host/fabrics.h
index 06cc54851b1b..01d3ef545f14 100644
--- a/drivers/nvme/host/fabrics.h
+++ b/drivers/nvme/host/fabrics.h
@@ -73,6 +73,7 @@ enum {
 	NVMF_OPT_TLS		= 1 << 25,
 	NVMF_OPT_KEYRING	= 1 << 26,
 	NVMF_OPT_TLS_KEY	= 1 << 27,
+	NVMF_OPT_CONNECT_SYNC	= 1 << 28,
 };
 
 /**
@@ -115,6 +116,7 @@ enum {
  * @nr_poll_queues: number of queues for polling I/O
  * @tos: type of service
  * @fast_io_fail_tmo: Fast I/O fail timeout in seconds
+ * @connect_sync: wait for connect attempt(s) to succeed or fail
  */
 struct nvmf_ctrl_options {
 	unsigned		mask;
@@ -144,6 +146,7 @@ struct nvmf_ctrl_options {
 	unsigned int		nr_poll_queues;
 	int			tos;
 	int			fast_io_fail_tmo;
+	bool			connect_sync;
 };
 
 /*
-- 
2.43.0


