Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD0DF7B0A21
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 18:29:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230107AbjI0Q3k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 12:29:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231391AbjI0Q3g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 12:29:36 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98AF595
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 09:29:34 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-4053c6f0db8so108586585e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 09:29:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695832173; x=1696436973; darn=vger.kernel.org;
        h=mime-version:message-id:cc:to:subject:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=QDCfzaeGWcIi7AD4z9zDOVfBWix11jNGiL4ta6mok7Q=;
        b=DUqSp+CztUhchE/EUDqVJhdHFYgEV/+ea/az8UC1tWdSRJ6gK9AynzOpcUDvvg8MkI
         WZtzA8fAc9CrhW1Toap0CXs3uRO/0HJFboOE6KJPnPYo7s7KIPrDdTw2bd3+5Am5ROAd
         B29WGe2Q23Bi9BCI0uIELfZv8G2mQkWOijNQ4GKR5ihU1bZnsQpt54Lyezch4xw/VTR4
         HasBkS2nWL3jCXM6fveTfVgX1yIFN2yStdBUdLn5Q5+U7Vjy3p95/id8VIZNFzSjeWqd
         /Nt5RzCK70GITwtxLotbik0+VFzm1xH5Giuov+7J/VjaX3yNAQWwX3nb2nGOikAdwT+G
         Zpgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695832173; x=1696436973;
        h=mime-version:message-id:cc:to:subject:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QDCfzaeGWcIi7AD4z9zDOVfBWix11jNGiL4ta6mok7Q=;
        b=OVcaYuCMZxW2F5HtQr/Y3+uY2pG7r8qRY5yC5ZoIUcMNWLb9swCu8Mh217Mhv43ZtE
         cS9Vrw5vrgiTRU8x4KmWQn4vwfyPSXQqB+CquuyYzDg7QPAJnaoM7DP0ZSkozPRURd4O
         LSUS2GqsHuC/umQLsSzTPEl6yGIpfxRhKYMSmSs6FeiJ6FwIDn7os0/UyQg8OnxZJOk3
         ORaAbRMT3P21f4t5PFkha4OwFe547qZIh+FjfW/9SyCNH21Q2a4Nan0/4xTPjNeSQIL4
         B7Hm0RZtlVK8J/Alpe1KIj9cfrtr2j3FkTWY+88rUHmJUA8Iu5VfErq8jFejVzVzkuX2
         B/mA==
X-Gm-Message-State: AOJu0YxMaEO47zbWzZjrFyrs3yGUhRAw4+n0musVVrlgKiyt2j+4iHY6
        BBsJ+1Li76cxMwBMeahnMEE=
X-Google-Smtp-Source: AGHT+IHZ14obC9/XSaCfdC7bhMAaNzWl5pFem971kF4c1AI/TMOUFYjMimOzF5kR/Wyx/g+tjXrfzw==
X-Received: by 2002:a05:600c:244:b0:3fe:1232:93fa with SMTP id 4-20020a05600c024400b003fe123293famr2392386wmj.22.1695832172753;
        Wed, 27 Sep 2023 09:29:32 -0700 (PDT)
Received: from yoga ([2001:638:904:ffe5:5742:c50f:bd0:6aa6])
        by smtp.gmail.com with ESMTPSA id z9-20020a05600c114900b004058e6379d8sm9334215wmz.23.2023.09.27.09.29.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Sep 2023 09:29:30 -0700 (PDT)
Date:   Wed, 27 Sep 2023 18:22:39 +0200
From:   Sven Frotscher <sven.frotscher@gmail.com>
Subject: [PATCH] ASoC: amd: yc: Fix non-functional mic on Lenovo 82YM
To:     broonie@kernel.org
Cc:     git@augustwikerfors.se, alsa-devel@alsa-project.org,
        lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
        mario.limonciello@amd.com, regressions@lists.linux.dev
Message-Id: <R5KN1S.18M6QDS4T9PY1@gmail.com>
X-Mailer: geary/44.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Like the Lenovo 82TL, 82V2, 82QF and 82UG, the 82YM (Yoga 7 14ARP8)
requires an entry in the quirk list to enable the internal microphone.
The latter two received similar fixes in commit 1263cc0f, see
https://lore.kernel.org/r/20230911213409.6106-1-git@augustwikerfors.se.

Signed-off-by: Sven Frotscher <sven.frotscher@gmail.com>
---
 sound/soc/amd/yc/acp6x-mach.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/soc/amd/yc/acp6x-mach.c 
b/sound/soc/amd/yc/acp6x-mach.c
index 3d8a51351e29..e3d2b9d01552 100644
--- a/sound/soc/amd/yc/acp6x-mach.c
+++ b/sound/soc/amd/yc/acp6x-mach.c
@@ -241,6 +241,13 @@ static const struct dmi_system_id 
yc_acp_quirk_table[] = {
 >..>...>...DMI_MATCH(DMI_PRODUCT_NAME, "82V2"),
 >..>...}
 >..},
+>..{
+>..>....driver_data = &acp6x_card,
+>..>....matches = {
+>..>...>...DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
+>..>...>...DMI_MATCH(DMI_PRODUCT_NAME, "82YM"),
+>..>...}
+>..},
 >..{
 >..>....driver_data = &acp6x_card,
 >..>....matches = {
--
2.42.0


