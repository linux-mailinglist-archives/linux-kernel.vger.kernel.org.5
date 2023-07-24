Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 424BE75E94A
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 03:50:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232759AbjGXBug (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 21:50:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232717AbjGXBt3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 21:49:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87FCA7688;
        Sun, 23 Jul 2023 18:41:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9A11F60FAA;
        Mon, 24 Jul 2023 01:36:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56307C433C7;
        Mon, 24 Jul 2023 01:36:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690162562;
        bh=QX2F22rWVgDJ9+K9IXIDEd2W8NQ4zBENPl8i5OKt4y0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Hz8hfcHSHoXAos9vlsXoYBvex/E2tW0dq1UU7VRinQqcwJuYmCyx0kg5xgMuUV/0L
         LMAzQRgavTGJ/cdSlI5rsXVs8mN4Vq3555j1+3/finlO3HKstLwEEr9GBxaZvPQEy9
         Sfi85gMwigQUPA1t7NeKdfQD0z8SRRCBmlSmN9OO8Pkp+sIuDNKRn1fXnGGcJA0fVG
         KmeJpDyQmRfxUme+WhLqE5EqMY1+L9y786yqbd07fcVMQtIC6HR3QEG75zDnfrKagM
         SJ0/L76fcw6bBazPANwgqjeTeU/vQpI2Hs/IDbtnFIuV1Q+qtMwRdFqWcyf+heJikN
         f0ZtgzJKwXGZQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Mathias Nyman <mathias.nyman@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>, mathias.nyman@intel.com,
        linux-usb@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 3/9] xhci: Don't require a valid get_quirks() function pointer during xhci setup
Date:   Sun, 23 Jul 2023 21:35:45 -0400
Message-Id: <20230724013554.2334965-3-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230724013554.2334965-1-sashal@kernel.org>
References: <20230724013554.2334965-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.14.320
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
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
index 0f2b67f38d2ea..3feee0419fdd9 100644
--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -4975,7 +4975,8 @@ int xhci_gen_setup(struct usb_hcd *hcd, xhci_get_quirks_t get_quirks)
 
 	xhci->quirks |= quirks;
 
-	get_quirks(dev, xhci);
+	if (get_quirks)
+		get_quirks(dev, xhci);
 
 	/* In xhci controllers which follow xhci 1.0 spec gives a spurious
 	 * success event after a short transfer. This quirk will ignore such
-- 
2.39.2

