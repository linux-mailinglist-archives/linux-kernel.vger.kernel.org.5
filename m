Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10FB078DE65
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 21:04:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241202AbjH3TCQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 15:02:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242685AbjH3JUF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 05:20:05 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38840CCB;
        Wed, 30 Aug 2023 02:20:03 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id E2B901F461;
        Wed, 30 Aug 2023 09:20:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1693387201; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7T8WXxDeZsY/B6brMdbgJxU7QShVwAoIfbowQiFdZps=;
        b=smCh9qXtNED5P8DnjS3NCjIoHR9jeyMMcn9EGQjrevZbUnIFk7r+NUrycUgFl/0XtF8S5F
        uUfGL3caqM63suJQFP+ARikv9btQvsjg+TRPTG0hbrSMoue0QlADjelWFby4RIWnUGFTQq
        CvbtNrMDEIjmVWNr1h5+WmD1AFNuVfY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1693387201;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7T8WXxDeZsY/B6brMdbgJxU7QShVwAoIfbowQiFdZps=;
        b=HGC3SoGnUKECJ1ul1GXIdtW/Cogoy6uf61u8hoQd9pt1kVx+ggrVSKeQx7UFEJ+OxtPsRG
        Wi5G4uDnM6ubN/Cg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D3E8E13441;
        Wed, 30 Aug 2023 09:20:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id inysM8EJ72RmGQAAMHmgww
        (envelope-from <dwagner@suse.de>); Wed, 30 Aug 2023 09:20:01 +0000
From:   Daniel Wagner <dwagner@suse.de>
To:     linux-nvme@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        Hannes Reinecke <hare@suse.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Bart Van Assche <bvanassche@acm.org>,
        Daniel Wagner <dwagner@suse.de>
Subject: [PATCH blktests v4 1/3] nvme/{033,034,035,036}: use default subsysnqn variable directly
Date:   Wed, 30 Aug 2023 11:20:17 +0200
Message-ID: <20230830092019.9846-2-dwagner@suse.de>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230830092019.9846-1-dwagner@suse.de>
References: <20230830092019.9846-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no need to introduce an extra local variable when it
uses the default subsysnqn anyway.

Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 tests/nvme/033 |  9 ++++-----
 tests/nvme/034 |  9 ++++-----
 tests/nvme/035 |  9 ++++-----
 tests/nvme/036 | 11 +++++------
 4 files changed, 17 insertions(+), 21 deletions(-)

diff --git a/tests/nvme/033 b/tests/nvme/033
index 46a520ae01fa..d924883460c2 100755
--- a/tests/nvme/033
+++ b/tests/nvme/033
@@ -49,18 +49,17 @@ test_device() {
 
 	_setup_nvmet
 
-	local subsys="${def_subsysnqn}"
 	local nsdev
 	local port
 
-	port=$(_nvmet_passthru_target_setup "${subsys}")
+	port=$(_nvmet_passthru_target_setup "${def_subsysnqn}")
 
-	nsdev=$(_nvmet_passthru_target_connect "${nvme_trtype}" "${subsys}")
+	nsdev=$(_nvmet_passthru_target_connect "${nvme_trtype}" "${def_subsysnqn}")
 
 	compare_dev_info "${nsdev}"
 
-	_nvme_disconnect_subsys "${subsys}"
-	_nvmet_passthru_target_cleanup "${port}" "${subsys}"
+	_nvme_disconnect_subsys "${def_subsysnqn}"
+	_nvmet_passthru_target_cleanup "${port}" "${def_subsysnqn}"
 
 	echo "Test complete"
 }
diff --git a/tests/nvme/034 b/tests/nvme/034
index 3c65d92cbaea..e79eef5e756d 100755
--- a/tests/nvme/034
+++ b/tests/nvme/034
@@ -19,18 +19,17 @@ test_device() {
 
 	_setup_nvmet
 
-	local subsys="${def_subsysnqn}"
 	local ctrldev
 	local nsdev
 	local port
 
-	port=$(_nvmet_passthru_target_setup "${subsys}")
-	nsdev=$(_nvmet_passthru_target_connect "${nvme_trtype}" "${subsys}")
+	port=$(_nvmet_passthru_target_setup "${def_subsysnqn}")
+	nsdev=$(_nvmet_passthru_target_connect "${nvme_trtype}" "${def_subsysnqn}")
 
 	_run_fio_verify_io --size="${nvme_img_size}" --filename="${nsdev}"
 
-	_nvme_disconnect_subsys "${subsys}"
-	_nvmet_passthru_target_cleanup "${port}" "${subsys}"
+	_nvme_disconnect_subsys "${def_subsysnqn}"
+	_nvmet_passthru_target_cleanup "${port}" "${def_subsysnqn}"
 
 	echo "Test complete"
 }
diff --git a/tests/nvme/035 b/tests/nvme/035
index c705d9cf25a4..f0dfc92ceeea 100755
--- a/tests/nvme/035
+++ b/tests/nvme/035
@@ -25,18 +25,17 @@ test_device() {
 
 	_setup_nvmet
 
-	local subsys="${def_subsysnqn}"
 	local ctrldev
 	local nsdev
 	local port
 
-	port=$(_nvmet_passthru_target_setup "${subsys}")
-	nsdev=$(_nvmet_passthru_target_connect "${nvme_trtype}" "${subsys}")
+	port=$(_nvmet_passthru_target_setup "${def_subsysnqn}")
+	nsdev=$(_nvmet_passthru_target_connect "${nvme_trtype}" "${def_subsysnqn}")
 
 	_xfs_run_fio_verify_io "${nsdev}" "${nvme_img_size}"
 
-	_nvme_disconnect_subsys "${subsys}"
-	_nvmet_passthru_target_cleanup "${port}" "${subsys}"
+	_nvme_disconnect_subsys "${def_subsysnqn}"
+	_nvmet_passthru_target_cleanup "${port}" "${def_subsysnqn}"
 
 	echo "Test complete"
 }
diff --git a/tests/nvme/036 b/tests/nvme/036
index 2e933cc41928..61b9e2309da7 100755
--- a/tests/nvme/036
+++ b/tests/nvme/036
@@ -18,21 +18,20 @@ test_device() {
 
 	_setup_nvmet
 
-	local subsys="${def_subsysnqn}"
 	local ctrldev
 	local port
 
-	port=$(_nvmet_passthru_target_setup "${subsys}")
-	nsdev=$(_nvmet_passthru_target_connect "${nvme_trtype}" "${subsys}")
+	port=$(_nvmet_passthru_target_setup "${def_subsysnqn}")
+	nsdev=$(_nvmet_passthru_target_connect "${nvme_trtype}" "${def_subsysnqn}")
 
-	ctrldev=$(_find_nvme_dev "${subsys}")
+	ctrldev=$(_find_nvme_dev "${def_subsysnqn}")
 
 	if ! nvme reset "/dev/${ctrldev}" >> "$FULL" 2>&1; then
 		echo "ERROR: reset failed"
 	fi
 
-	_nvme_disconnect_subsys "${subsys}"
-	_nvmet_passthru_target_cleanup "${port}" "${subsys}"
+	_nvme_disconnect_subsys "${def_subsysnqn}"
+	_nvmet_passthru_target_cleanup "${port}" "${def_subsysnqn}"
 
 	echo "Test complete"
 }
-- 
2.41.0

