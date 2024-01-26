Return-Path: <linux-kernel+bounces-40134-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 93A4A83DAFC
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 14:35:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9AB3A1C222A5
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 13:35:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 104C81B599;
	Fri, 26 Jan 2024 13:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="N9o5eV6m";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="flbvpouR";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="N9o5eV6m";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="flbvpouR"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BAC71B940
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 13:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706276093; cv=none; b=BUUk9l69MenIyQkARVWU4riE82S2Dy9yBfKz7HH+70QkcW4A7vLoJ5tA8TH+HsQBMcSi10VuPWgvO+0h9TzEoR0cvCaA+YuFD1HWVmlJuFdLcT5Sy+DHLrVtAEFGtmxP97G95ocCx4zuLKgKQdn+de8vRjxyajDmDheYsz6FTmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706276093; c=relaxed/simple;
	bh=SXW7lbZNDt9+OBY/kl/kDaQemXbieJQFK+PfERW5Oio=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lRW3UE1sUMH+P6fphGGY2nRrDo9NVykW5pgHxe5HPxgnEhKbUNYq2bwffTHp5g53kkj5pd2MLl3ra5uZgzaVtGCxFBuuuW/wPv/nlKG+aPnok8RY3a7CNsietpWsbdQMbrf8kM9aVdFSrKfYhjrN8t55uJTWluO1asN917n2CXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=N9o5eV6m; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=flbvpouR; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=N9o5eV6m; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=flbvpouR; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 087EC1FB86;
	Fri, 26 Jan 2024 13:28:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706275721; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=lOk2BIcfzAusKFaGCivdX0uaXpJqguldERnjAnE9s14=;
	b=N9o5eV6mcPjcpsshbfL1XNF14fshtlf/pxqlKGOC5c08/IwvDLHzoCyvPaR0PCh9IXfvvj
	knGnhc1UDDfcLC3YyYKOLjaLmJQS4zUaO/e3FbhKJiuUU8BjECbuXtsvtH7j0IVLdqtbOq
	Rv+AH0N+MZ8MLRoxWrmms4Zc1rI4qN4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706275721;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=lOk2BIcfzAusKFaGCivdX0uaXpJqguldERnjAnE9s14=;
	b=flbvpouR5kNVeW/lqTw+/eeiz2fopMFr1G9Gvj2cQCGgH50wMis8u29Ft7pCjtvt0pNuTd
	IeHGpj0tIsug+WDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706275721; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=lOk2BIcfzAusKFaGCivdX0uaXpJqguldERnjAnE9s14=;
	b=N9o5eV6mcPjcpsshbfL1XNF14fshtlf/pxqlKGOC5c08/IwvDLHzoCyvPaR0PCh9IXfvvj
	knGnhc1UDDfcLC3YyYKOLjaLmJQS4zUaO/e3FbhKJiuUU8BjECbuXtsvtH7j0IVLdqtbOq
	Rv+AH0N+MZ8MLRoxWrmms4Zc1rI4qN4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706275721;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=lOk2BIcfzAusKFaGCivdX0uaXpJqguldERnjAnE9s14=;
	b=flbvpouR5kNVeW/lqTw+/eeiz2fopMFr1G9Gvj2cQCGgH50wMis8u29Ft7pCjtvt0pNuTd
	IeHGpj0tIsug+WDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EB1EA134C3;
	Fri, 26 Jan 2024 13:28:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Ei/5N4izs2W9XQAAD6G6ig
	(envelope-from <dwagner@suse.de>); Fri, 26 Jan 2024 13:28:40 +0000
From: Daniel Wagner <dwagner@suse.de>
To: James Smart <james.smart@broadcom.com>
Cc: Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Hannes Reinecke <hare@suse.de>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH v4] nvme-fc: do not wait in vain when unloading module
Date: Fri, 26 Jan 2024 14:28:28 +0100
Message-ID: <20240126132828.15315-1-dwagner@suse.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [1.90 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 RCPT_COUNT_SEVEN(0.00)[7];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Level: *
X-Spam-Score: 1.90
X-Spam-Flag: NO

The module exit path has race between deleting all controllers and
freeing 'left over IDs'. To prevent double free a synchronization
between nvme_delete_ctrl and ida_destroy has been added by the initial
commit.

There is some logic around trying to prevent from hanging forever in
wait_for_completion, though it does not handling all cases. E.g.
blktests is able to reproduce the situation where the module unload
hangs forever.

If we completely rely on the cleanup code executed from the
nvme_delete_ctrl path, all IDs will be freed eventually. This makes
calling ida_destroy unnecessary. We only have to ensure that all
nvme_delete_ctrl code has been executed before we leave
nvme_fc_exit_module. This is done by flushing the nvme_delete_wq
workqueue.

While at it, remove the unused nvme_fc_wq workqueue too.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---

I've splitted this patch out of the 'enable nvmet-fc for blktests' series.
The series needs a bit more thinking and this patch seems ready to me.

https://lore.kernel.org/linux-nvme/20231218153105.12717-1-dwagner@suse.de/

changes:
v4:
 - replace sync logic with a simple workqueue flush


 drivers/nvme/host/fc.c | 47 ++++++------------------------------------
 1 file changed, 6 insertions(+), 41 deletions(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index e2308119f8f0..7006f4caac2f 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -221,11 +221,6 @@ static LIST_HEAD(nvme_fc_lport_list);
 static DEFINE_IDA(nvme_fc_local_port_cnt);
 static DEFINE_IDA(nvme_fc_ctrl_cnt);
 
-static struct workqueue_struct *nvme_fc_wq;
-
-static bool nvme_fc_waiting_to_unload;
-static DECLARE_COMPLETION(nvme_fc_unload_proceed);
-
 /*
  * These items are short-term. They will eventually be moved into
  * a generic FC class. See comments in module init.
@@ -255,8 +250,6 @@ nvme_fc_free_lport(struct kref *ref)
 	/* remove from transport list */
 	spin_lock_irqsave(&nvme_fc_lock, flags);
 	list_del(&lport->port_list);
-	if (nvme_fc_waiting_to_unload && list_empty(&nvme_fc_lport_list))
-		complete(&nvme_fc_unload_proceed);
 	spin_unlock_irqrestore(&nvme_fc_lock, flags);
 
 	ida_free(&nvme_fc_local_port_cnt, lport->localport.port_num);
@@ -3894,10 +3887,6 @@ static int __init nvme_fc_init_module(void)
 {
 	int ret;
 
-	nvme_fc_wq = alloc_workqueue("nvme_fc_wq", WQ_MEM_RECLAIM, 0);
-	if (!nvme_fc_wq)
-		return -ENOMEM;
-
 	/*
 	 * NOTE:
 	 * It is expected that in the future the kernel will combine
@@ -3915,7 +3904,7 @@ static int __init nvme_fc_init_module(void)
 	ret = class_register(&fc_class);
 	if (ret) {
 		pr_err("couldn't register class fc\n");
-		goto out_destroy_wq;
+		return ret;
 	}
 
 	/*
@@ -3939,8 +3928,6 @@ static int __init nvme_fc_init_module(void)
 	device_destroy(&fc_class, MKDEV(0, 0));
 out_destroy_class:
 	class_unregister(&fc_class);
-out_destroy_wq:
-	destroy_workqueue(nvme_fc_wq);
 
 	return ret;
 }
@@ -3960,45 +3947,23 @@ nvme_fc_delete_controllers(struct nvme_fc_rport *rport)
 	spin_unlock(&rport->lock);
 }
 
-static void
-nvme_fc_cleanup_for_unload(void)
+static void __exit nvme_fc_exit_module(void)
 {
 	struct nvme_fc_lport *lport;
 	struct nvme_fc_rport *rport;
-
-	list_for_each_entry(lport, &nvme_fc_lport_list, port_list) {
-		list_for_each_entry(rport, &lport->endp_list, endp_list) {
-			nvme_fc_delete_controllers(rport);
-		}
-	}
-}
-
-static void __exit nvme_fc_exit_module(void)
-{
 	unsigned long flags;
-	bool need_cleanup = false;
 
 	spin_lock_irqsave(&nvme_fc_lock, flags);
-	nvme_fc_waiting_to_unload = true;
-	if (!list_empty(&nvme_fc_lport_list)) {
-		need_cleanup = true;
-		nvme_fc_cleanup_for_unload();
-	}
+	list_for_each_entry(lport, &nvme_fc_lport_list, port_list)
+		list_for_each_entry(rport, &lport->endp_list, endp_list)
+			nvme_fc_delete_controllers(rport);
 	spin_unlock_irqrestore(&nvme_fc_lock, flags);
-	if (need_cleanup) {
-		pr_info("%s: waiting for ctlr deletes\n", __func__);
-		wait_for_completion(&nvme_fc_unload_proceed);
-		pr_info("%s: ctrl deletes complete\n", __func__);
-	}
+	flush_workqueue(nvme_delete_wq);
 
 	nvmf_unregister_transport(&nvme_fc_transport);
 
-	ida_destroy(&nvme_fc_local_port_cnt);
-	ida_destroy(&nvme_fc_ctrl_cnt);
-
 	device_destroy(&fc_class, MKDEV(0, 0));
 	class_unregister(&fc_class);
-	destroy_workqueue(nvme_fc_wq);
 }
 
 module_init(nvme_fc_init_module);
-- 
2.43.0


