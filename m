Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A764D7DDF3E
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 11:17:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233397AbjKAKRZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 06:17:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235008AbjKAKRV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 06:17:21 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2859C101
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 03:17:19 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d9cb4de3bf0so7185104276.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 Nov 2023 03:17:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698833838; x=1699438638; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=eYwnCg3MzOCxaL6syOpApDs7eXE4N92NMNfKk1723ok=;
        b=iiubIDLj9+fiCVO4MRpbpNiWATQLYfZHiBCO35SoWgZagmwID+7ufEeHiRa4+HlAkN
         sP0sY+7jA9UEd9dB/nWZLLxUnc/XHy3xiXnsWWd7Wu6V3eTm2SjcRw3lcjf24d1lqaLP
         2Due5leqljuEQc1plzedg+EhOxIMvpeAER0lnd+zngCkG4t3N4iWIsa05+oqyszpXG66
         v3K/FismcNKh1F/jqiWKQ/p+mHqd2f56cBTz4Dv8h85sufn5JUPiGjMyCDw/glZIBUWI
         Hsj3eEbSAy/NV2qcZ2KwyZjkdqswRkm6Cdqfiep/afgFQKz9guD+Ve4azVqRkl0TeP/t
         PdGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698833838; x=1699438638;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eYwnCg3MzOCxaL6syOpApDs7eXE4N92NMNfKk1723ok=;
        b=nB/apvvXt7XKLwbyCOc9joKyKCWLLQfWkI1MpoPruXx8Ti6hy+l1jOJVaeNu8zYvpi
         kxHogYLYV6e8I5TGeou6p/0yGbPLbCV1m6m6a3Slp6j7cJjvdjFmeQ0dQ7j7MmrEue7L
         /n3No6+2bR5PEv41JLq7WOWUMq0F5B3S7PrN+bHDYjqQ0ZnonXAv5zIei2/+zCnJXB7p
         ekPK4MuPMTc8JQB/+mN37DrYM69osNCPcYfmZTKq82ltdyd0ek1ckZhd1IL1I/DfvhSh
         sVUaGn1UZYcu9ImsNDS3R2RfGt91HY6bqtxHohPSiJHyX6Nl3ZGiEYBPWABiboD1sNYa
         3ugg==
X-Gm-Message-State: AOJu0Yy0qCuPmO1x9lQVbA54zWOxgXJEiC0GPkOPQzwC88Fk/KqZiV8Y
        j096OsDPfzBPtUPsOUc7BiAUBhVNcGX9
X-Google-Smtp-Source: AGHT+IHinYRwD8fj0nrrNZJpNGMVcxTbcgPusqm9nKng4RFXsyc4EKTfTVPgJ98yc1drhyuZAcOYzZfbiOsN
X-Received: from mnkumar0.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:313a])
 (user=mnkumar job=sendgmr) by 2002:a25:bc52:0:b0:d9a:3d02:b55 with SMTP id
 d18-20020a25bc52000000b00d9a3d020b55mr296671ybk.0.1698833838374; Wed, 01 Nov
 2023 03:17:18 -0700 (PDT)
Date:   Wed,  1 Nov 2023 10:16:24 +0000
In-Reply-To: <20231101101625.4151442-1-mnkumar@google.com>
Mime-Version: 1.0
References: <20231101101625.4151442-1-mnkumar@google.com>
X-Mailer: git-send-email 2.42.0.820.g83a721a137-goog
Message-ID: <20231101101625.4151442-2-mnkumar@google.com>
Subject: [PATCH RESEND 1/2] usb: host: xhci-plat: Add quirk-no-64-bit-support
From:   Naveen Kumar <mnkumar@google.com>
To:     Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        royluo@google.com, devicetree@vger.kernel.org,
        Naveen Kumar M <mnkumar@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
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

