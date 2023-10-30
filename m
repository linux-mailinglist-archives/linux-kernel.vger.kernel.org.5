Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1B357DBD39
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 16:59:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233756AbjJ3P7S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 11:59:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233311AbjJ3P7Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 11:59:16 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B597CE4
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 08:59:13 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 4B1DA210E7;
        Mon, 30 Oct 2023 15:59:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1698681552; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=ZeP5LZNPVgCOVDKGuBqMoGJSW7piHcySROsgnm697W0=;
        b=J44VmEqcZrDXMGx1wOc89obvtxfjsdVZFguVq7pP3N+MPb0pe0B/voCzU/h48z6UYLdqAd
        JrrwBBdSJ51wGxjcU52tTozeIPOTIeYO6K83LJsE13UrBkjW7gzzBTIHZuleo5PHBsWSPr
        mc4LXuvDuRtO7cv1vo31gEo+5jM37Wc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1698681552;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=ZeP5LZNPVgCOVDKGuBqMoGJSW7piHcySROsgnm697W0=;
        b=YL7UvprAyY6BY8MIOhFh0wB9Pj1IPK/1X6jXBIm7IGrFc6sByhq8KnPHL77tJtfMmX9QmM
        b2DtEclQYbF7nDCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3D9F3138EF;
        Mon, 30 Oct 2023 15:59:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id HV0FD9DSP2WufAAAMHmgww
        (envelope-from <dwagner@suse.de>); Mon, 30 Oct 2023 15:59:12 +0000
From:   Daniel Wagner <dwagner@suse.de>
To:     linux-nvme@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Niklas Cassel <Niklas.Cassel@wdc.com>,
        Daniel Wagner <dwagner@suse.de>,
        Kenji Tomonaga <tkenbo@gmail.com>
Subject: [PATCH v3] nvme: update firmware version after commit
Date:   Mon, 30 Oct 2023 17:00:44 +0100
Message-ID: <20231030160044.20355-1-dwagner@suse.de>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The firmware version sysfs entry needs to be updated after a successfully
firmware activation.

nvme-cli stopped issuing an Identify Controller command to list the
current firmware information and relies on sysfs showing the current
firmware version.

Reported-by: Kenji Tomonaga <tkenbo@gmail.com>
Signed-off-by: Daniel Wagner <dwagner@suse.de>
---

Only compile tested. Asked for testing.

changes:

v3:
  - use afi variable directly, no _to_cpu helper
  - fix bit mask size

v2:
  - use fw slot info instead issuing another identify controller command
  - https://lore.kernel.org/linux-nvme/20231013163420.3097-1-dwagner@suse.de

v1:
  - initial version
  - https://lore.kernel.org/linux-nvme/20231013062623.6745-1-dwagner@suse.de/


 drivers/nvme/host/core.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 37b6fa746662..e8511bff78d2 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4053,8 +4053,21 @@ static void nvme_get_fw_slot_info(struct nvme_ctrl *ctrl)
 		return;
 
 	if (nvme_get_log(ctrl, NVME_NSID_ALL, NVME_LOG_FW_SLOT, 0, NVME_CSI_NVM,
-			log, sizeof(*log), 0))
+			 log, sizeof(*log), 0)) {
 		dev_warn(ctrl->device, "Get FW SLOT INFO log error\n");
+		goto out_free_log;
+	}
+
+	if (log->afi & 0x70) {
+		dev_info(ctrl->device,
+			 "Firmware is activated after next Controller Level Reset\n");
+		goto out_free_log;
+	}
+
+	memcpy(ctrl->subsys->firmware_rev, &log->frs[log->afi & 0x7],
+		sizeof(ctrl->subsys->firmware_rev));
+
+out_free_log:
 	kfree(log);
 }
 
-- 
2.42.0

