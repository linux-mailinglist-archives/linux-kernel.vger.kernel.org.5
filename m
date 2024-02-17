Return-Path: <linux-kernel+bounces-69901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB0D485900B
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 15:17:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B8401F221FB
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 14:17:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FD6A7B3D2;
	Sat, 17 Feb 2024 14:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hK4/Wk4y"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C70042A96;
	Sat, 17 Feb 2024 14:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708179441; cv=none; b=WiwzUlL3m2iNZPHzfsdV3Og2TjxZDQXw1/15mAj6pMnlNuCkFjSYJknpDOHLRWgZJ0S/nQcYcpgPIaAMOCMxd8eCgARHlWubtXdrWpxuHbvW0dnVZs8IjDEjzOKRonRtx8lSKM8Gbi38D0/c5i4w+PXU5f9hpKnZYEFtuzBZMyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708179441; c=relaxed/simple;
	bh=QC/snNLOtK2/TODQBWhvrbwOrpE63XAAlN9VFodyWJY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=c5nQEMWjMrLXQWHHzuLLeuuvBpmrL8zlwDlBjR4MiYscDGUYos3Q2QeVfe3Z4s/tPC8eM/MmW+GbXhmwbdLMdncXBr7PriUpR3DoqYQMOd2MIvx++Ltt+qlt2uvJhR5W8pmJGPGONFq/9WlIvGFCL5/Q85PNm4+oeswB874KkOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hK4/Wk4y; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a3d82926ed2so208435366b.0;
        Sat, 17 Feb 2024 06:17:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708179438; x=1708784238; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IbbQSYFWBFju2UiFyUni3aoWXHVcCNdm6fOi7OWfvjI=;
        b=hK4/Wk4y3i3klOEbGNwSB9yYKLmYqHHB6a0XLumnCxupf6CeRXsC+oCznrhEvjcneM
         KmeA4dx5CjtqACLjQqWrgE0H5TkDaYlkACCkXzw/iCyl8MlrBqGMh/+pn8Hc0i3gVBEs
         5WBstOpse0+waTOo4YS1x+4takbzyu7Y2uFuvDPTYBZvFBa1vqy6ZQoEe3AEy5naYG79
         KR16JH9yVACqg5DoT0TY5+v+o2XxeA3bHemh71zGcWga1n+frTdIZBtnptzQrqfc8wes
         Hh1aHT1Anuwfdp5h+fvk4VAlO8QIIeEg7rtcGNg8cYkfkU+Xu79h7MYCpCQcSXmQMqmV
         9kFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708179438; x=1708784238;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IbbQSYFWBFju2UiFyUni3aoWXHVcCNdm6fOi7OWfvjI=;
        b=VeNs6T3CD9AuLhDzZF7Go0jqfWMcwebAZrMX6T9ktS2srM+B7nKjsWz2DFxDvsf0mU
         jxPyXgbOHkNtAjy9+29DhUtxE0/Vls63RbYEiCQxhwaXppu3Iadcz0fvVl0+UcUnSGzu
         fN6fpnTZqFWAjTowpd5uyENVwpiw5tFTW2v9lAn6cCh/k8US/kEHYUhbu6d7JN2V9iEu
         KbD3UXYB6FZzujy0fqWFgzT78lmgcvMzJUaDs+YZE4aHvpMgAX+XUIaQru5hL8LI22P/
         f+G+Ty0k0YMsNEcIsyWf53imxULV5JAV5x9xm4HLHGQtxVMiYrNpDY8waOU1kwrw9xrF
         m3Gg==
X-Forwarded-Encrypted: i=1; AJvYcCV9bXs0cX2btnrZsji8a/F9AR0Lq4iy8fqzMAWwV0exfTyMDp0bZpXXgTyMPDDBZmPz12ydYTAag3ztEh8rh7qdj1Y1qXP2OjBTU0J6i3CtA4ZtmEZh1vKHrDGDBB/CY1dnLGuC6QKVYDMut8+NGmxs32Yp7tKsXJCvTSaf4P9s84P7vSihoG6V
X-Gm-Message-State: AOJu0Yy5mlHA6KwaiucGJpJ8HTPAQE0nz2iNt2ihcFs50YtHNMrNqe9F
	+du1XumqsWVcRbYcWwDJk7h1TCgv6MmBQmgmhPVJQdv8nr7WELV2
X-Google-Smtp-Source: AGHT+IGGp5hkVCx8+/tZNKToJw/68aZxr2lMR8IRmEEN6OD66buWQKA9pdj0WKdaEPltwEmVeYh+lA==
X-Received: by 2002:a17:906:36c7:b0:a3d:d909:f57 with SMTP id b7-20020a17090636c700b00a3dd9090f57mr3384234ejc.41.1708179437539;
        Sat, 17 Feb 2024 06:17:17 -0800 (PST)
Received: from standask-GA-A55M-S2HP (lu-nat-113-247.ehs.sk. [188.123.113.247])
        by smtp.gmail.com with ESMTPSA id tj1-20020a170907c24100b00a3d1b3c5f1esm1012699ejc.77.2024.02.17.06.17.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Feb 2024 06:17:17 -0800 (PST)
Date: Sat, 17 Feb 2024 15:17:15 +0100
From: Stanislav Jakubek <stano.jakubek@gmail.com>
To: Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>
Cc: bcm-kernel-feedback-list@broadcom.com, linux-watchdog@vger.kernel.org,
	devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: watchdog: drop obsolete brcm,bcm2835-pm-wdt
 bindings
Message-ID: <ZdC/624d1c8O3NRG@standask-GA-A55M-S2HP>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

These bindings are already (better) described in soc/bcm/brcm,bcm2835-pm.
Drop these obsolete bindings.

Signed-off-by: Stanislav Jakubek <stano.jakubek@gmail.com>
---
 .../bindings/watchdog/brcm,bcm2835-pm-wdog.txt | 18 ------------------
 1 file changed, 18 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/watchdog/brcm,bcm2835-pm-wdog.txt

diff --git a/Documentation/devicetree/bindings/watchdog/brcm,bcm2835-pm-wdog.txt b/Documentation/devicetree/bindings/watchdog/brcm,bcm2835-pm-wdog.txt
deleted file mode 100644
index f801d71de1cd..000000000000
--- a/Documentation/devicetree/bindings/watchdog/brcm,bcm2835-pm-wdog.txt
+++ /dev/null
@@ -1,18 +0,0 @@
-BCM2835 Watchdog timer
-
-Required properties:
-
-- compatible : should be "brcm,bcm2835-pm-wdt"
-- reg : Specifies base physical address and size of the registers.
-
-Optional properties:
-
-- timeout-sec   : Contains the watchdog timeout in seconds
-
-Example:
-
-watchdog {
-	compatible = "brcm,bcm2835-pm-wdt";
-	reg = <0x7e100000 0x28>;
-	timeout-sec = <10>;
-};
-- 
2.34.1


