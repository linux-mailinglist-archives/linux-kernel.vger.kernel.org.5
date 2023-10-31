Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAC6A7DC587
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 05:49:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234337AbjJaEt5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 00:49:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236846AbjJaEkq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 00:40:46 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC8E7F1
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 21:40:44 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d9a541b720aso5225665276.0
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 21:40:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698727244; x=1699332044; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=eYwnCg3MzOCxaL6syOpApDs7eXE4N92NMNfKk1723ok=;
        b=K8NPu7dq9Wrw4mgKePz0ZSQ5gLDyRZgC7oA32z/4lY34GcKiiuAAGt8DCuQHY6avEy
         hfuxxihnVr2n71/V7J3jnvBAaOYTfUtLvYmrjzdiDr4P84Uoz5pXXJQlZEDxqpCSbTWa
         C2ZqUBHyzoL9gDkplmwUv1IjokAMshlLW9ml6uAmkGBqjWpLcN2tuLsRDJhOA5/pl5Px
         Ps/XcfJF5oPGFQ+xt2gERTr+uG+poRkTyxnrXRLocFnCm5zT6aRelvb6VVF97gSoR7ox
         YnnVQxAUBjh8uifbME1DzfZbIiq5aS2X86mM6/Rv20TmgUqiIMGXdV41niL9vmYEjiMr
         7s5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698727244; x=1699332044;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eYwnCg3MzOCxaL6syOpApDs7eXE4N92NMNfKk1723ok=;
        b=Dx4Aoi9rGGr5cbvyCkXvJdT38zOzFegqYOBPnoyHJRNhnNXlMOWOuOPkncNeFWjfY5
         J0v8vIBS1zuy+EaS1s7Zv9MLw6C9denxEQpze5dq7jFn8xQ/ddNBbWiiIG40JOfRmxOI
         o+c79OOQSyHJpMD3EOas1xzJE6Xa8pbYhIguXjr+2fWgtldxxuJyXMt5zSLVjDQwc6KS
         90uCkJw6v5COt6AgKx8l0HzANWLpGYRRwgkoDERUcYCFzsnjbMaltjjwb5R14+BOLG2F
         dG9PpnPU5OP4w6dmdiAcvA5ZjHzx+WOUXH6Szjvs9SrVHYZzTkjg1IzDBZTqtPiejdLA
         zNTg==
X-Gm-Message-State: AOJu0YwrsSymfugGtVS+8wqMhOYgrITr8CIr2DUNSdP345OOcWZyMD7t
        sR35cL6XqJ5QFvJd3l+TSxzznlZR3vY4
X-Google-Smtp-Source: AGHT+IF1blIGUiwwYOg1/mXFkKE0MNTH6FvFkl8I66ichTIVYu+k5T3UQy8MezeW8HkSb6f9gfoFH86xoxvQ
X-Received: from mnkumar0.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:313a])
 (user=mnkumar job=sendgmr) by 2002:a25:d754:0:b0:d9c:66d1:9597 with SMTP id
 o81-20020a25d754000000b00d9c66d19597mr211255ybg.13.1698727243860; Mon, 30 Oct
 2023 21:40:43 -0700 (PDT)
Date:   Tue, 31 Oct 2023 04:40:20 +0000
In-Reply-To: <20231031044021.1162403-1-mnkumar@google.com>
Mime-Version: 1.0
References: <20231031044021.1162403-1-mnkumar@google.com>
X-Mailer: git-send-email 2.42.0.820.g83a721a137-goog
Message-ID: <20231031044021.1162403-2-mnkumar@google.com>
Subject: [PATCH 1/2] usb: host: xhci-plat: Add quirk-no-64-bit-support
From:   Naveen Kumar <mnkumar@google.com>
To:     Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        royluo@google.com, Naveen Kumar M <mnkumar@google.com>
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

From: Naveen Kumar M <mnkumar@google.com>

This patch exposes the existing quirk XHCI_NO_64BIT_SUPPORT so that dwc3
clients can also use this flag. Despite HCCPARAMS1 being set to 1 some
clients may not support 64 bit addressing.

Signed-off-by: Naveen Kumar M <mnkumar@google.com>
---
 drivers/usb/host/xhci-plat.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/usb/host/xhci-plat.c b/drivers/usb/host/xhci-plat.c
index b93161374293..d5f37decb7da 100644
--- a/drivers/usb/host/xhci-plat.c
+++ b/drivers/usb/host/xhci-plat.c
@@ -249,6 +249,9 @@ int xhci_plat_probe(struct platform_device *pdev, struct device *sysdev, const s
 		if (device_property_read_bool(tmpdev, "quirk-broken-port-ped"))
 			xhci->quirks |= XHCI_BROKEN_PORT_PED;
 
+		if (device_property_read_bool(tmpdev, "quirk-no-64-bit-support"))
+			xhci->quirks |= XHCI_NO_64BIT_SUPPORT;
+
 		device_property_read_u32(tmpdev, "imod-interval-ns",
 					 &xhci->imod_interval);
 	}
-- 
2.42.0.820.g83a721a137-goog

