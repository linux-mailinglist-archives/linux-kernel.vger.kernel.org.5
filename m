Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 219EB75E835
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 03:38:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232029AbjGXBiu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 21:38:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232157AbjGXBiM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 21:38:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BCAD30D3;
        Sun, 23 Jul 2023 18:34:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A927760EF9;
        Mon, 24 Jul 2023 01:31:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61BA5C433CA;
        Mon, 24 Jul 2023 01:31:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690162314;
        bh=X/kRmcNGJ1d670NJAA2QlucT4XVIeOz5VIdZCa1CxwA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=soQA5WAGVL3YaTCYIwdhybxdCQgAyoczc3zg2XUFHOABuqXR2fe5OxQzT0O2ljbKK
         38GP9giW+DVyUnKQB2bZAcvQ+rYKKtTurrPnx3F0XErDalfLTkX6rWcPDbWTQmwTBS
         Vww+j4LRHb028q97o088dPc9fp2sldOWbiQcd1rE4d800Lp7CaRoH9QwsXCkvBgsHU
         1nxWDfhGSJAEXmWXRBZxz/43GDjlZFJSxzoEH0iOe9wF/N7kDAR1+hGBeJa696BMRi
         LK2bQbmWRiE3mboc5INmlr+neXvT/PiMIfPqXFE3SVXtju+WSnlCfA9Tv57/J/0fIZ
         4Ixe3LyOLoKUA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Mathias Nyman <mathias.nyman@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>, mathias.nyman@intel.com,
        linux-usb@vger.kernel.org
Subject: [PATCH AUTOSEL 6.4 09/40] xhci: Don't require a valid get_quirks() function pointer during xhci setup
Date:   Sun, 23 Jul 2023 21:31:09 -0400
Message-Id: <20230724013140.2327815-9-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230724013140.2327815-1-sashal@kernel.org>
References: <20230724013140.2327815-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.4.5
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

From: Mathias Nyman <mathias.nyman@linux.intel.com>

[ Upstream commit 9b907c91aa94522ae14bf155ce7b9ccb10a0903c ]

Not all platforms drivers need to set up custom quirks during the xhci
generic setup. Allow them to pass NULL as the function pointer when
calling xhci_gen_setup()

Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
Message-ID: <20230602144009.1225632-4-mathias.nyman@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/host/xhci.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
index 78790dc13c5f1..a1e5f3bd883cc 100644
--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -5180,7 +5180,8 @@ int xhci_gen_setup(struct usb_hcd *hcd, xhci_get_quirks_t get_quirks)
 
 	xhci->quirks |= quirks;
 
-	get_quirks(dev, xhci);
+	if (get_quirks)
+		get_quirks(dev, xhci);
 
 	/* In xhci controllers which follow xhci 1.0 spec gives a spurious
 	 * success event after a short transfer. This quirk will ignore such
-- 
2.39.2

