Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B93007E3F30
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 13:50:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229711AbjKGMuN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 07:50:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233877AbjKGM2b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 07:28:31 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36208262F5;
        Tue,  7 Nov 2023 04:19:43 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA7E1C43391;
        Tue,  7 Nov 2023 12:19:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699359569;
        bh=g22D1Atd4dAcFgs25qXekSdfdiW5ufji0kSmh6Hwzlc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VrkICrvKa0rBzvlI9YGovDbtvD/R0oDNlXe1LcLnLTdg8iBuodrDk8e5/6cDmklW4
         a/KRu0K3ER+aHfBao3yubAMU5f/Adzz8A3bwcXv1dsNnZjmGOV0cO4uVgY6JM8oeos
         fGPyFdFGH0B60+nrVR3K77/dfAVW80h3XFjkvrQ+K9aPOH4CATY514hFrqa8MIGJOX
         CPOWgC1Tr3abklRlMXbBhxEjBPmLfFPmtDd1RNGzOc1lG2JeLRUSNZCyprOjtW5ZX4
         SN2TOdICAW2YfA29EOYY3rsRO8QJqdsgtls0ttiizfoF5qitIp3ocUlT7WhfSfT/5w
         GN9JLN+F69fJg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Yu Kuai <yukuai3@huawei.com>, Song Liu <song@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-raid@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 08/40] md: don't rely on 'mddev->pers' to be set in mddev_suspend()
Date:   Tue,  7 Nov 2023 07:16:10 -0500
Message-ID: <20231107121837.3759358-8-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231107121837.3759358-1-sashal@kernel.org>
References: <20231107121837.3759358-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yu Kuai <yukuai3@huawei.com>

[ Upstream commit b721e7885eb242aa2459ee66bb42ceef1bcf0f0c ]

'active_io' used to be initialized while the array is running, and
'mddev->pers' is set while the array is running as well. Hence caller
must hold 'reconfig_mutex' and guarantee 'mddev->pers' is set before
calling mddev_suspend().

Now that 'active_io' is initialized when mddev is allocated, such
restriction doesn't exist anymore. In the meantime, follow up patches
will refactor mddev_suspend(), hence add checking for 'mddev->pers' to
prevent null-ptr-deref.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
Signed-off-by: Song Liu <song@kernel.org>
Link: https://lore.kernel.org/r/20230825030956.1527023-4-yukuai1@huaweicloud.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/md/md.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index a104a025084dc..9247e55c7eafc 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -449,7 +449,7 @@ void mddev_suspend(struct mddev *mddev)
 	set_bit(MD_ALLOW_SB_UPDATE, &mddev->flags);
 	percpu_ref_kill(&mddev->active_io);
 
-	if (mddev->pers->prepare_suspend)
+	if (mddev->pers && mddev->pers->prepare_suspend)
 		mddev->pers->prepare_suspend(mddev);
 
 	wait_event(mddev->sb_wait, percpu_ref_is_zero(&mddev->active_io));
-- 
2.42.0

