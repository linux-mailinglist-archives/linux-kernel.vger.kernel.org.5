Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0EC5783FAF
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 13:38:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231933AbjHVLis (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 07:38:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235313AbjHVLiS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 07:38:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A91410D4;
        Tue, 22 Aug 2023 04:37:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E233365380;
        Tue, 22 Aug 2023 11:36:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C0BDC433C8;
        Tue, 22 Aug 2023 11:36:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692704192;
        bh=S7/4s+iDxNxtTNGeDtAq1MLwAPIHwlcpSk7B6Czqm+0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hpUoOup6zOnXsfCT88qiAw/e6bW5luJ2wb29EmwxTYoOSujt+Eoi51ugFRM6vGv/q
         w84luCgrLFi985SmEOwnn7+BrbaFw1jARyqH3ZYVXEsTNH4pJ4BlIAxH4LPH/3P3Cu
         W+OoQp8q9eaiobipIYFrDKvkcfSNmJiTDIa5PPH8pi53zCHkqSfX7dC1t2xfCXZx7z
         OyrI4U4bHn3hji0F5PDbJCgUPXrtrCBAhQbX/Izw/ab39MKI03AgFsgGrJDNSOYna2
         8YLhVoxoke08rkS4g2kGr/zXhSId5qrKzRvc0VrLke8cx1E4VWWU6gvF6CVCda+5Pc
         w61xcrL47ps0w==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Yang Li <yang.lee@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Sasha Levin <sashal@kernel.org>, Shyam-sundar.S-k@amd.com,
        markgross@kernel.org, platform-driver-x86@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 02/10] platform/x86/amd/pmf: Fix unsigned comparison with less than zero
Date:   Tue, 22 Aug 2023 07:36:20 -0400
Message-Id: <20230822113628.3551393-2-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230822113628.3551393-1-sashal@kernel.org>
References: <20230822113628.3551393-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.46
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yang Li <yang.lee@linux.alibaba.com>

[ Upstream commit 785c00993dc4c4bb2f7b0f3a3f29c03a6f7aab2e ]

The return value from the call to amd_pmf_get_pprof_modes() is int.
However, the return value is being assigned to an unsigned char
variable 'mode', so making 'mode' an int.

silence the warning:
./drivers/platform/x86/amd/pmf/sps.c:183:5-9: WARNING: Unsigned expression compared with zero: mode < 0

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=5995
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
Link: https://lore.kernel.org/r/20230727014315.51375-1-yang.lee@linux.alibaba.com
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/x86/amd/pmf/sps.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/x86/amd/pmf/sps.c b/drivers/platform/x86/amd/pmf/sps.c
index fd448844de206..b2cf62937227c 100644
--- a/drivers/platform/x86/amd/pmf/sps.c
+++ b/drivers/platform/x86/amd/pmf/sps.c
@@ -121,7 +121,8 @@ int amd_pmf_get_pprof_modes(struct amd_pmf_dev *pmf)
 
 int amd_pmf_power_slider_update_event(struct amd_pmf_dev *dev)
 {
-	u8 mode, flag = 0;
+	u8 flag = 0;
+	int mode;
 	int src;
 
 	mode = amd_pmf_get_pprof_modes(dev);
-- 
2.40.1

