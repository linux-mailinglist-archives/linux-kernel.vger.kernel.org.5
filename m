Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34A4D75E86D
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 03:41:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231918AbjGXBlI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 21:41:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232053AbjGXBkh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 21:40:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E3624688;
        Sun, 23 Jul 2023 18:36:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1D9B560FD6;
        Mon, 24 Jul 2023 01:32:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA682C433C8;
        Mon, 24 Jul 2023 01:32:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690162371;
        bh=KejieLHZwlkNimzzg+V660/Io7TODUQySTVA1WFfW7U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BR8oYOoUa8c59l6KJTARvhjAbKroHV9wI26GIazTWOv1Jp1pK3wOKl6tXERy1ZqKS
         B/B7ZcEYAGuQj7JjTnVBDRC1VVBODFtsirnXE0GHcaGyL6HP5c2d5PZND2SyhQFcu5
         5h+08iqhqQ++ghF3Ew2EanKaTvyY5hNfjbEHCQZEFy8OBfuEdhQMAzrarEB5vCdkQ+
         Pb/cQpGo3Vk6SGEeVxBSDZ9BrHiRPY602KA+mWyphWQPVXGRIWqGFJTS3w2hSTMf3m
         1cq4tlN+opo3biIdG3fvxgaLqrEsrPTxh44yBb1DGYKfWie49yvjEnXm6eAqQsFeUN
         x2672/sRR/O+Q==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Mathias Nyman <mathias.nyman@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>, mathias.nyman@intel.com,
        linux-usb@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 09/34] xhci: Don't require a valid get_quirks() function pointer during xhci setup
Date:   Sun, 23 Jul 2023 21:32:12 -0400
Message-Id: <20230724013238.2329166-9-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230724013238.2329166-1-sashal@kernel.org>
References: <20230724013238.2329166-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.40
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
index c02ad4f76bb3c..5792d859e3f3e 100644
--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -5341,7 +5341,8 @@ int xhci_gen_setup(struct usb_hcd *hcd, xhci_get_quirks_t get_quirks)
 
 	xhci->quirks |= quirks;
 
-	get_quirks(dev, xhci);
+	if (get_quirks)
+		get_quirks(dev, xhci);
 
 	/* In xhci controllers which follow xhci 1.0 spec gives a spurious
 	 * success event after a short transfer. This quirk will ignore such
-- 
2.39.2

