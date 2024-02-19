Return-Path: <linux-kernel+bounces-70759-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C96A2859BE7
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 07:11:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 845D52817A8
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 06:11:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9723C208D7;
	Mon, 19 Feb 2024 06:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="j6paZ+2Y"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7068620327
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 06:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708323065; cv=none; b=DBPhJ3zPQrIFo1+FLX6T3oJCQAt7/tzN85ABpUcdH6tf033tQklCv7/uqFZlIKrV6eP0F3WxisNtxcyifUuTvBVZ6N64DwuVKRNFDEUqMLVYIieps9cpZFNQmhegiaaz4JQaWy1P0crmlT6Dh653PWIT2Ft3uU/MF0Z3tlRcY8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708323065; c=relaxed/simple;
	bh=lxOGG+4OWOB971uu/bo1UcRBNuQBrqkpncTFtNkgoHA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=TLOF3JlDP43rEBgShMKoaSOvnp6ZZ9nAsbmEeHaywVofCHM28y7gaYMrP50udeNx6/r4TlxpIyJI3F9BCqAbM4YNY2x8mlGdgJGTx2PdUviJx6S7jnjrL4d5smzcdIqTlR/bh8z1JOgcBrzdcttAe3i7G+K/MekIPGtYF4Cfgvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--pumahsu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=j6paZ+2Y; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--pumahsu.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-607b3038b3fso32967997b3.2
        for <linux-kernel@vger.kernel.org>; Sun, 18 Feb 2024 22:11:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708323063; x=1708927863; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=P2Z+xe3h4KbB/pvzqkhCxeqNP+O4twM/ySXdqI4Gmss=;
        b=j6paZ+2Y30S5i49Mhz84c8itUAWG5ODq+5rb+zrQ83tUcHOLXp6++78aUK1sSSGeu8
         iKVdMaawTZD6og0gRm64b0Akdn1juR1JO44TDNm2d437DH8xR2MoiLQlv6yUFq9eqDKm
         U5OW1tO/OrzbRGOnCf8rA1PUbfjUM1RZ2MVAXO7wqMMJ9Z3oUcrXoUnDPNwxlPLj5jU6
         NuBJTEykxqV06LnMngWqLJ7sTMa2J6+Q1AY4atSiofOWUrOJljYJXwfUgVFiNJGZwFeI
         9nP03U5BSFjAt4V8D9jL3A+pc4llRg3ytlP5KMEKDSaj+jx8zth3CUDpsc0j52qPay+n
         UlWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708323063; x=1708927863;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P2Z+xe3h4KbB/pvzqkhCxeqNP+O4twM/ySXdqI4Gmss=;
        b=cVxfAQ9tXGShsszRIb9XmJ/bTjXmvbf4xzNQQhZMICygywbAudQtMdaeb/JiY1K2ro
         E9aMESjDqjcIAWb2MmzFOyb6C2/EPJi9Ud4EqbVw6HiFQGvYsZ0YtvnsEpxIwONGg0zp
         29Adknlc33un6wJ1XBDbmZOER5ZXAg3nWXAGsmETVLQoLZYVw8S+gJL25duX4zVKvbXC
         uV2dhwsWUenTlIo+tFU1yB2l1IimPO+lmNemNzxOZAWUpabdrhJWydFB6mikqqBHciRe
         sk2MXuYRUIhKlkiTC2ULUFKsysg1tOXOKsgq23CXl1CZulCvxemRDylrqSTK5WtQ9oYW
         q8RA==
X-Forwarded-Encrypted: i=1; AJvYcCWsWtBk8z2K55Pr4X3ovcVd+l6d6yKrQR89hdr71zeq2Km8pm/LrECt/AtKBumD+9ErxqvhAU5LVJoCNGHbCiUzS5tz6AeCyZdKJuqA
X-Gm-Message-State: AOJu0Yy6RrYRXTEIJZW1HHuBy28u8ksWXpLoIkYHlqRRVCvd4fkgOKpt
	Y62H867uLx1UtyNVpE2BjRpwOuALTIeHP/BILEdaggKSdLcm8RBVTk8FSTGWiBGv3IY+rZ500Ac
	fvTuNNw==
X-Google-Smtp-Source: AGHT+IFH7rVO2zxtJx2x+O2Qq9eBPmVSV4gsMAcWpUJDvG7Gyqh4Ad69lo/eeJhOFCXuyLuVzye25gs17DK5
X-Received: from pumahsu-p620linsp01.ntc.corp.google.com ([2401:fa00:fc:202:c8b2:b71:a506:971a])
 (user=pumahsu job=sendgmr) by 2002:a81:79cc:0:b0:607:7901:425b with SMTP id
 u195-20020a8179cc000000b006077901425bmr1921429ywc.0.1708323063589; Sun, 18
 Feb 2024 22:11:03 -0800 (PST)
Date: Mon, 19 Feb 2024 14:10:06 +0800
In-Reply-To: <20240219061008.1761102-1-pumahsu@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240219061008.1761102-1-pumahsu@google.com>
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
Message-ID: <20240219061008.1761102-2-pumahsu@google.com>
Subject: [PATCH 1/3] dt-bindings: usb: Add xhci glue driver support
From: Puma Hsu <pumahsu@google.com>
To: mathias.nyman@intel.com, gregkh@linuxfoundation.org, 
	Thinh.Nguyen@synopsys.com
Cc: badhri@google.com, royluo@google.com, howardyen@google.com, 
	albertccwang@google.com, raychi@google.com, linux-kernel@vger.kernel.org, 
	linux-usb@vger.kernel.org, Puma Hsu <pumahsu@google.com>
Content-Type: text/plain; charset="UTF-8"

Currently the dwc3 driver always probes xhci-plat driver
by hardcode in driver. Introduce a property to make this
flexible that a user can probe a xhci glue driver by the
generic dwc3 driver.

Signed-off-by: Puma Hsu <pumahsu@google.com>
---
 Documentation/devicetree/bindings/usb/usb-drd.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/usb-drd.yaml b/Documentation/devicetree/bindings/usb/usb-drd.yaml
index 114fb5dc0498..215fb7f70054 100644
--- a/Documentation/devicetree/bindings/usb/usb-drd.yaml
+++ b/Documentation/devicetree/bindings/usb/usb-drd.yaml
@@ -62,6 +62,12 @@ properties:
     enum: [host, peripheral]
     default: peripheral
 
+  xhci-glue:
+    description:
+      Tell dwc3 core driver what xhci specific platform driver we want to probe.
+      The string should match to the name of device_driver of platform_driver
+      in the xhci specific platform driver.
+
 additionalProperties: true
 
 examples:
@@ -76,4 +82,5 @@ examples:
         phy_type = "utmi_wide";
         otg-rev = <0x0200>;
         adp-disable;
+        xhci-glue = "xhci-hcd-plat";
     };
-- 
2.44.0.rc0.258.g7320e95886-goog


