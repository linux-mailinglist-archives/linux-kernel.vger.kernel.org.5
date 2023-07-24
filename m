Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C4EA75E91B
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 03:47:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232486AbjGXBrS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 21:47:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232400AbjGXBqh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 21:46:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A066F5FED;
        Sun, 23 Jul 2023 18:39:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 26E2261043;
        Mon, 24 Jul 2023 01:34:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6C94C433C8;
        Mon, 24 Jul 2023 01:34:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690162471;
        bh=ouwAIhhoUHBNeBZAlOnHU3B7rAI4w54M5FyWp2jM8dE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Z31RR/82+y8OqYpVOXuO03VvSnmSlJcLSHmDb4AMG9voEYl3z/X6hlv7HGsFNZbLN
         +9piAdFOh6uxEvO4Q4xALWj3UrD/+19wBSVInVxKSjsM/PXbXOVK3c2KVQs3cEqPDh
         ZHa1q11z8ZSGuPHulacEg6Otzkspw+PZC1SJLE2xFSFKA313KWOsiHfrRi80MTrSWb
         qyeNa6ciOpTXOL9FD3uaMgQ4RNcFS42w35palgszbqsUvW1aMBn/m3MCkBJ+dzoPts
         xaGhtfiu+xJ0f5DaOQkSvV7m0jx+SDzctsytVQhKzLyUjaGfIlmcT8fmt8+Qh006Q3
         arJitJuqWwxRQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Mathias Nyman <mathias.nyman@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>, mathias.nyman@intel.com,
        linux-usb@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 03/12] xhci: Don't require a valid get_quirks() function pointer during xhci setup
Date:   Sun, 23 Jul 2023 21:34:16 -0400
Message-Id: <20230724013426.2333833-3-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230724013426.2333833-1-sashal@kernel.org>
References: <20230724013426.2333833-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.249
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
index eb78091d1b35e..8c276c29a29f6 100644
--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -5285,7 +5285,8 @@ int xhci_gen_setup(struct usb_hcd *hcd, xhci_get_quirks_t get_quirks)
 
 	xhci->quirks |= quirks;
 
-	get_quirks(dev, xhci);
+	if (get_quirks)
+		get_quirks(dev, xhci);
 
 	/* In xhci controllers which follow xhci 1.0 spec gives a spurious
 	 * success event after a short transfer. This quirk will ignore such
-- 
2.39.2

