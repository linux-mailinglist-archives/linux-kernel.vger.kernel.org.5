Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28C9E7DC169
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 21:50:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229975AbjJ3Uuj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 16:50:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjJ3Uuh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 16:50:37 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ED08ED
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 13:50:35 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5afc00161daso31274797b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 13:50:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698699034; x=1699303834; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tlU8k+5W0N+VIEb7C9PJmPm8rehaU2/fXsyGUQ0B3ko=;
        b=A34YrAd76+qhHyy9uiOgHUuH/CTgPIGycq8tKxijRfEDXHGv5YjTFDkoZpjqQAGvPT
         H8IKT/UXokr8W1WGFPDRyt51GDdbrSHFkDGl9iOBySlhgG68tbFgKvtaPawvmmgG0A1H
         cgD0JmST8sXv3YjMHg8e+wUfYMSv7uocJImTt2zi22ATd+No04gWDghE5C7L7BAHI+sS
         YGO1BIKf+GllT6Rfn2EPRJhk1xEwxZAjymsX8UYmjsEGtmUJMqZaVbkfW5LnsXRs5F2C
         22eeoyBF+ltXDL1QkOUXnvsN9lY94qO/VoYOXFsItL4M3IetVU0GWjZlbd5s0WFh1zZB
         Sd8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698699034; x=1699303834;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tlU8k+5W0N+VIEb7C9PJmPm8rehaU2/fXsyGUQ0B3ko=;
        b=as6GsYHysyRA+nVDLY4f2LgxIDXGB+mABJemEnSTmTxz3GlJJ+Cn86ET9LLdtdlTOg
         vcqL+1BqqZHqmU4nAokp9s49e6al1i8MPx200aJfhtPk1n6fyCpdwFeGjPq3KVmccHUH
         C6xPH2LVGaARs0koKM/4curwX27Qh3WW31NjVra2PwfAh/LHQbmIg4VdH9G4JoaF4Zy+
         oeoe6/M7Y1UouxAoH1w2GX7Y1czXuG/WobHLERdE1xNa1teEYxMyd49Cxxd5r8iNvea2
         TGP2pxGqfyxhKJBYzChq9mpr0IEn3MtkgPX2RpXRoTeNcLjphzhB+28LeagXSQq4T4TJ
         ZXbQ==
X-Gm-Message-State: AOJu0Yyz/OjF+tLg1MrWU/kuAKTEdUOEOpqS8KsVsSUpAZsAr8INC9/t
        S5j9ZBsMSaXQNJW0M+zTQz+rzLQ=
X-Google-Smtp-Source: AGHT+IHy83zK8iZYXhUh94dM51N49/ljRVFPASmrjDiooMVdgIlRHr35Klf2swwmRqc9iUPy5UnbXE0=
X-Received: from ptf16.nyc.corp.google.com ([2620:0:1003:314:b293:ee7f:826f:b212])
 (user=ptf job=sendgmr) by 2002:a25:26cd:0:b0:d9a:3a26:fb56 with SMTP id
 m196-20020a2526cd000000b00d9a3a26fb56mr195591ybm.2.1698699034576; Mon, 30 Oct
 2023 13:50:34 -0700 (PDT)
Date:   Mon, 30 Oct 2023 16:50:14 -0400
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.820.g83a721a137-goog
Message-ID: <20231030205031.177855-1-ptf@google.com>
Subject: [PATCH v3] net: r8169: Disable multicast filter for RTL8168H and RTL8107E
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
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RTL8168H and RTL8107E ethernet adapters erroneously filter unicast
eapol packets unless allmulti is enabled. These devices correspond to
RTL_GIGA_MAC_VER_46 and VER_48. Add an exception for VER_46 and VER_48
in the same way that VER_35 has an exception.

Fixes: 6e1d0b898818 ("r8169:add support for RTL8168H and RTL8107E")
Signed-off-by: Patrick Thompson <ptf@google.com>
---

Changes in v3:
- disable mc filter for VER_48
- update description

Changes in v2:
- add Fixes tag
- add net annotation
- update description

 drivers/net/ethernet/realtek/r8169_main.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index 361b90007148b..c92286926a1b5 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -2584,7 +2584,9 @@ static void rtl_set_rx_mode(struct net_device *dev)
 		rx_mode |= AcceptAllPhys;
 	} else if (netdev_mc_count(dev) > MC_FILTER_LIMIT ||
 		   dev->flags & IFF_ALLMULTI ||
-		   tp->mac_version == RTL_GIGA_MAC_VER_35) {
+		   tp->mac_version == RTL_GIGA_MAC_VER_35 ||
+		   tp->mac_version == RTL_GIGA_MAC_VER_46 ||
+		   tp->mac_version == RTL_GIGA_MAC_VER_48) {
 		/* accept all multicasts */
 	} else if (netdev_mc_empty(dev)) {
 		rx_mode &= ~AcceptMulticast;
-- 
2.42.0.820.g83a721a137-goog

