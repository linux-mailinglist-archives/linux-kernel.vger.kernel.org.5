Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F28B3774788
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 21:16:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233024AbjHHTP4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 15:15:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235764AbjHHTPW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 15:15:22 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E574047ED
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 09:38:11 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id CD944223FF;
        Tue,  8 Aug 2023 07:09:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1691478554; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=H/YLVCeWbOC5zGBWs9MF5sPBcfnhYRaJ1x4BlOnFxS4=;
        b=H4NZ7LtnOgJiK5ddlmJrLoNZSVL7aFBE6PT6hVKwRTOyoH6kgjQW5PDRYhRhJKToFK2s+L
        BnlnH1QTgJWTcu6cG2tA+VO6ErhNTRlpC2u7VuqtjGrEiu6JmXnGoNey7Hhfy06UxpOvcB
        Zvy9Jd6pTYvaG88JNLGMFxNz625jtQs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1691478554;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=H/YLVCeWbOC5zGBWs9MF5sPBcfnhYRaJ1x4BlOnFxS4=;
        b=GfdwtYY+4z9vNKfS4ZmQ3lWCstnHBH9VZ/RJrOH9ct/6oXyYz+c85qWgEKfkDR2Epl1KD3
        moV1z0LeV++M7GBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BFDFE13451;
        Tue,  8 Aug 2023 07:09:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id FUWULhrq0WRvVgAAMHmgww
        (envelope-from <dwagner@suse.de>); Tue, 08 Aug 2023 07:09:14 +0000
From:   Daniel Wagner <dwagner@suse.de>
To:     linux-nvme@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org,
        Caleb Sander <csander@purestorage.com>,
        Keith Busch <kbusch@kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Daniel Wagner <dwagner@suse.de>
Subject: [PATCH libnvme v2 2/2] fabrics: Do not pass disable_sqflow if not supported
Date:   Tue,  8 Aug 2023 09:09:07 +0200
Message-ID: <20230808070907.18834-3-dwagner@suse.de>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230808070907.18834-1-dwagner@suse.de>
References: <20230808070907.18834-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sagi Grimberg <sagi@grimberg.me>

Only retry a connect attempt with disable_sqflow if the kernel
actually supports this option.

Reported-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 src/nvme/fabrics.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/src/nvme/fabrics.c b/src/nvme/fabrics.c
index 9725eeb3cda8..f0e85d3b766d 100644
--- a/src/nvme/fabrics.c
+++ b/src/nvme/fabrics.c
@@ -1043,7 +1043,8 @@ nvme_ctrl_t nvmf_connect_disc_entry(nvme_host_t h,
 	if (!ret)
 		return c;
 
-	if (errno == EINVAL && c->cfg.disable_sqflow) {
+	if (errno == EINVAL && c->cfg.disable_sqflow &&
+	    nvmf_check_option(h->r, disable_sqflow)) {
 		errno = 0;
 		/* disable_sqflow is unrecognized option on older kernels */
 		nvme_msg(h->r, LOG_INFO, "failed to connect controller, "
-- 
2.41.0

