Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95B427DA27A
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 23:31:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346566AbjJ0VbF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 17:31:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232330AbjJ0VbE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 17:31:04 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CD83129
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 14:31:02 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id af79cd13be357-7789577b582so327192585a.0
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 14:31:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698442261; x=1699047061; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MI6bVykQDbdW2vz2XrrMq2PILwHbTFu4swv4LXOgVcU=;
        b=LPn2ZPffMCHMox3HmP/ORTuk/8Sxy5SmqjaZJ69oCfFDoN8BHzU7XUUKYHNeMQSImb
         Usg0TiCIDUv4fjlRepJ8yvfi+8zBUtbOSmFPnqBrMOOXVKIJApLwkxumREkQodbbLzbN
         ZkUqrOazlgfvCPvIiG3ReOdgFcWzKh7E/G8yJtiYd3q9K9FbdM68TnjlM8n4WT5mJLGN
         r0rs57Cw2ffstCeKWqBnfay54SGU14URJXJv//bpcOwBrY2PrJ2NHxBtpEmcJqUW3v5H
         CPPw0h7PwajUtZ/eJRClN9zBg1J/7EQPgwrToT+H30rdSuKa/T3PR6gGuEPE1i43ZFe2
         o8lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698442261; x=1699047061;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MI6bVykQDbdW2vz2XrrMq2PILwHbTFu4swv4LXOgVcU=;
        b=hocke+BtIbj+lOjzaTp2siU+uNPd0Ukxr0x27FJRdS0mcT/PjdbHhOKxA+lf13/M+U
         itihYPFnqcFGKiuaKnkcmSnJTNk+vbIbXbTizeeEdCjry+xT2WHUoo7l8qVWeuAfcrjk
         jeURpwDtR4IPQLIbstaPkOs15oQKyGVtsijAsl3TlwJNKZv7EuUn/hFUXpLzmujfVjwe
         pxbToZtcYOnCvKy0Txpm86PJOc6skejMRPEApblqAz1YC0VGXXXxPrN+xrAMLx6xG3ca
         PgjtDF80sA3aMq92bxOd1Yie+DFn8UjMdI/5wqipz2JIjqZKugJqfNDCyeVobA22yGrw
         1BJg==
X-Gm-Message-State: AOJu0YwymzxWGLqdPwTSXuNDqV5DvX0d24s+3VY6FWoWlB7cYmsHvJiO
        byo+TBj+UpA1oPHbxfbB0CxKr/Y=
X-Google-Smtp-Source: AGHT+IH+BodIS3bugVCcaCTLSCmmzfoQjCJIIIJk2spYzrwsSlmhh+RC/6RAolXSm+aXzaR1ikiI634=
X-Received: from ptf16.nyc.corp.google.com ([2620:0:1003:314:7908:dc2a:2e54:fd31])
 (user=ptf job=sendgmr) by 2002:ae9:e207:0:b0:777:f69:557 with SMTP id
 c7-20020ae9e207000000b007770f690557mr64327qkc.15.1698442261542; Fri, 27 Oct
 2023 14:31:01 -0700 (PDT)
Date:   Fri, 27 Oct 2023 17:30:55 -0400
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.820.g83a721a137-goog
Message-ID: <20231027213059.3550747-1-ptf@google.com>
Subject: [PATCH v2] net: r8169: Disable multicast filter for RTL_GIGA_MAC_VER_46
From:   Patrick Thompson <ptf@google.com>
To:     netdev@vger.kernel.org
Cc:     Patrick Thompson <ptf@google.com>, Chun-Hao Lin <hau@realtek.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org,
        nic_swsd@realtek.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MAC_VER_46 ethernet adapters fail to detect eapol packets unless
allmulti is enabled. Add exception for VER_46 in the same way VER_35
has an exception.

Fixes: 6e1d0b898818 ("r8169:add support for RTL8168H and RTL8107E")
Signed-off-by: Patrick Thompson <ptf@google.com>
---

Changes in v2:
- add Fixes tag
- add net annotation
- update description

 drivers/net/ethernet/realtek/r8169_main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index 361b90007148b..a775090650e3a 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -2584,7 +2584,8 @@ static void rtl_set_rx_mode(struct net_device *dev)
 		rx_mode |= AcceptAllPhys;
 	} else if (netdev_mc_count(dev) > MC_FILTER_LIMIT ||
 		   dev->flags & IFF_ALLMULTI ||
-		   tp->mac_version == RTL_GIGA_MAC_VER_35) {
+		   tp->mac_version == RTL_GIGA_MAC_VER_35 ||
+		   tp->mac_version == RTL_GIGA_MAC_VER_46) {
 		/* accept all multicasts */
 	} else if (netdev_mc_empty(dev)) {
 		rx_mode &= ~AcceptMulticast;
-- 
2.42.0.820.g83a721a137-goog

