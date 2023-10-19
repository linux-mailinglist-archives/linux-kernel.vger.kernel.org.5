Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8C3A7D03D4
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 23:23:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346653AbjJSVXE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 17:23:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235605AbjJSVWl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 17:22:41 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B40210FD
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 14:21:58 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1c9bca1d96cso831285ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 14:21:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1697750517; x=1698355317; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Eh9gNdfF4X/gCkqak/1kHTLkL80QPwsWChwAwIX/vCk=;
        b=EXZ6pO8Ls3k9/TPQuHkGd8uiw8tNdHMdRF2ncSLiUqL69wK1K9f/p/HGPNUBwacQg+
         UhqCe50ZNV8+/MqwSEO46rfgmT9teuutVTEfLgHax96H/Oo6V23IfQAj5cFNB/1qJuEf
         GDQUEWdg6wWsrGU/kHwOvI2NpMy41vABaizzM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697750517; x=1698355317;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Eh9gNdfF4X/gCkqak/1kHTLkL80QPwsWChwAwIX/vCk=;
        b=hvDKF/oAM7M6MtV/G4ZcoZOF5f+R6ErNiKmLLlr01fceAOmIK7rKgSRbPUER9J8DJm
         xjJVCJ8SW25HFkb/W3s+Jw0b/EhzI4GEeFXDcphZ4MC8ERlfb+Zf70BfEYA3goruuWVK
         gK6Bd6oPEgej+9bnoPROzcUomD3dxI5EQHGnoLeW/UUUtQ5b2ookzwEnEpYD5n0hPJuT
         vpAF8tY+YrMmPzT0GR9RbES7Ip0yk9hkUyg9CNkhvfyBtoWM9M11X1W+DLI4ln0Hkq/H
         4cGNU9DHc3GZITfRyQQxYu4KqoM6Rpnkktm9BgK/avEYuAJBMCLgkxTDLdp8+ijvirrL
         P3rg==
X-Gm-Message-State: AOJu0YwrHC821vewx0ZTsiijlNxSVznKuuq47Rmr5b1/zHguzvQASai9
        53PO7pmV6zbTDx67VUVm0k2Jdg==
X-Google-Smtp-Source: AGHT+IFhaCrYRptQT2G1Mdon7Ns/UVfgU3ItPHb4YZENLzX8Rgdh+/NrkPOTBSofuDTZaHCwWkG/Vg==
X-Received: by 2002:a17:903:23c2:b0:1ca:6abe:cb37 with SMTP id o2-20020a17090323c200b001ca6abecb37mr126905plh.9.1697750517343;
        Thu, 19 Oct 2023 14:21:57 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:a6da:6f08:412:e04b])
        by smtp.gmail.com with ESMTPSA id l2-20020a170902d34200b001bbdd44bbb6sm154100plk.136.2023.10.19.14.21.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Oct 2023 14:21:56 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Jakub Kicinski <kuba@kernel.org>,
        Hayes Wang <hayeswang@realtek.com>,
        "David S . Miller" <davem@davemloft.net>
Cc:     Grant Grundler <grundler@chromium.org>,
        Edward Hill <ecgh@chromium.org>, linux-usb@vger.kernel.org,
        Simon Horman <horms@kernel.org>,
        Laura Nao <laura.nao@collabora.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Douglas Anderson <dianders@chromium.org>,
        =?UTF-8?q?Bj=C3=B8rn=20Mork?= <bjorn@mork.no>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Subject: [PATCH v4 2/5] r8152: Check for unplug in rtl_phy_patch_request()
Date:   Thu, 19 Oct 2023 14:20:21 -0700
Message-ID: <20231019142019.v4.2.I300ed6c3269c77756bdd10dd0d6f97db85470186@changeid>
X-Mailer: git-send-email 2.42.0.758.gaed0368e0e-goog
In-Reply-To: <20231019212130.3146151-1-dianders@chromium.org>
References: <20231019212130.3146151-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the adapter is unplugged while we're looping in
rtl_phy_patch_request() we could end up looping for 10 seconds (2 ms *
5000 loops). Add code similar to what's done in other places in the
driver to check for unplug and bail.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

(no changes since v2)

Changes in v2:
- ("Check for unplug in rtl_phy_patch_request()") new for v2.

 drivers/net/usb/r8152.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
index 482957beae66..fff2f9e67b5f 100644
--- a/drivers/net/usb/r8152.c
+++ b/drivers/net/usb/r8152.c
@@ -4046,6 +4046,9 @@ static int rtl_phy_patch_request(struct r8152 *tp, bool request, bool wait)
 	for (i = 0; wait && i < 5000; i++) {
 		u32 ocp_data;
 
+		if (test_bit(RTL8152_UNPLUG, &tp->flags))
+			break;
+
 		usleep_range(1000, 2000);
 		ocp_data = ocp_reg_read(tp, OCP_PHY_PATCH_STAT);
 		if ((ocp_data & PATCH_READY) ^ check)
-- 
2.42.0.758.gaed0368e0e-goog

