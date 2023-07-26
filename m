Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 358407636B2
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 14:47:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231389AbjGZMrX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 08:47:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234059AbjGZMrE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 08:47:04 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15EE71BF2;
        Wed, 26 Jul 2023 05:47:02 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id CB23F1F88D;
        Wed, 26 Jul 2023 12:46:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1690375615; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mG6IRZ9q40lCvRAwlcOpEAtXBD4DfqCDrz6tzkiMxmU=;
        b=0mxz+Oh42o0ca8PzjXdxoKTvYr8JWIamI1cAgic6YksfGleh8FzoRV9RkzVZL0PrvFNGjC
        2n2/ZcZwSY+MBnmy5mjWU76mbkIQawQ61glKiTHYNRR/QS8r0CgJuUJuX9gIJRo/Cn4A1t
        /wK0N4Hc2bqYc66dvyuLxOHfMP8L7u8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1690375615;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mG6IRZ9q40lCvRAwlcOpEAtXBD4DfqCDrz6tzkiMxmU=;
        b=EIO/Hg/nFrhVT5p38hiYOV79s4MmUcLfvpZI2tWlTu+KRYsNYZodI+KwktBbmwaJdAyy/8
        VJrHOfqjVDuQ7xCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BB1F3139BD;
        Wed, 26 Jul 2023 12:46:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id PxWvLb8VwWQvUAAAMHmgww
        (envelope-from <dwagner@suse.de>); Wed, 26 Jul 2023 12:46:55 +0000
From:   Daniel Wagner <dwagner@suse.de>
To:     linux-nvme@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        Max Gurtovoy <mgurtovoy@nvidia.com>,
        Hannes Reinecke <hare@suse.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        James Smart <jsmart2021@gmail.com>,
        Daniel Wagner <dwagner@suse.de>
Subject: [PATCH blktests v1 06/11] nvme/rc: Add common file_path name define
Date:   Wed, 26 Jul 2023 14:46:39 +0200
Message-ID: <20230726124644.12619-7-dwagner@suse.de>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230726124644.12619-1-dwagner@suse.de>
References: <20230726124644.12619-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add common file_path name as global definition so that we can reuse it.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 tests/nvme/rc | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/nvme/rc b/tests/nvme/rc
index c11848b59c49..9c802ddc872d 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -17,6 +17,7 @@ def_local_wwpn="0x20001100aa000002"
 def_hostid="0f01fb42-9f7f-4856-b0b3-51e60b8de349"
 def_hostnqn="nqn.2014-08.org.nvmexpress:uuid:${def_hostid}"
 def_subsysnqn="blktests-subsystem-1"
+def_file_path="${TMPDIR}/img"
 nvme_trtype=${nvme_trtype:-"loop"}
 nvme_img_size=${nvme_img_size:-"1G"}
 nvme_num_iter=${nvme_num_iter:-"1000"}
-- 
2.41.0

