Return-Path: <linux-kernel+bounces-161003-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 678A48B45A4
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 12:56:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A0341C20F46
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 10:56:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD710482DB;
	Sat, 27 Apr 2024 10:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="M4KUxJ7U"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA287282F1
	for <linux-kernel@vger.kernel.org>; Sat, 27 Apr 2024 10:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714215364; cv=none; b=s5vQgkjPs+EhNlQ6ZZ1yeot3CC9U2p8ZEx3CHYd36fEEMV6UBe7Z0SNSvtEq4fv1MWxqBRywo2S8YDg+6n4p6yoWaUUwSD2cjhLpRE+FbqgtoHvRTUeQ60OVi8ieYru5spKp4rcEDWLGjFLA6Oi8x0WgmjXAzfdV9NcSDZ1NLpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714215364; c=relaxed/simple;
	bh=30Y0vDFTIC+GZ4kILAnfrxpQKyxIfE0SN088Unsl+Ao=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ot+GjfDavolumfLtzgdbTvE959SkhwCuc3CE8bW2FgjysOfxD5qJ3J/fgqaJ3j+ugNnDftKeRLmttOiCARnsl80EugCH/5Jk7zQEO0KYB23BXp2645vtS3swG3ms10+tcAgtJ/UOSqwwQiHH/otPXnv0YDtzdRDWOGvYhHVX+Gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=M4KUxJ7U; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2db13ca0363so46410171fa.3
        for <linux-kernel@vger.kernel.org>; Sat, 27 Apr 2024 03:55:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1714215357; x=1714820157; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:date:from:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AVy+Y3fQ+ZL5eTtoRlGJR4TNBIR1UBCGRhefmZftvMw=;
        b=M4KUxJ7UOZz4VX2NoiS+se6iptl8tDexJH5RdwaGrt9ANLLx+HwZ7ECBLS8UdKGbL3
         mdFVDsXRI6Unub6iyvenM5bt0lnOKrzQCl21RPGMmrUgC7xJeljhZhCYsHkAVntbRkTd
         01o3ncEnSLrlZLxROFkYSpSo8JdCMKBepg3O+Zd3aoFuLrhW2M6MWMROh28/HuSTTj5f
         OlAPQNV4XrzxKM9uhyd4VsmF1ItZHbiH+AyraT9twOAyFa31Xlmm+wdQuP+i65IwAxKz
         CU5AtVkDxBgMVX4DcNlxmNo1EkxBJrwiM4hidscO2IXdeQF6avCBuA1ivjeJlJSEf3Qw
         0X1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714215357; x=1714820157;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AVy+Y3fQ+ZL5eTtoRlGJR4TNBIR1UBCGRhefmZftvMw=;
        b=idTf7d9wJskxpvekRjOanT7nqBBhUswWsAU+mrwQ934QXu0dsgjl8LGpXWCYkzP5io
         nA2xB3zTucbUQ8xUgo9oEjvMmGE650ceT1jBy8muNf15KLeS35CJe4qz832bDzq7ScIS
         UNsBiv6gZcrg7styTxQ1szaqHgWcIdhwBzo9zaB3L3INMJy2kx2Ch5rZx58suPpnE4X2
         XSGKfNpxOLOEEKT+yaVc3ds7iDDmkJbC7tJPvA9H2Mif6CGMnXfN56mWvEXcUK4r8Fb2
         Yqnv0m/3tAulD9gNvJN1wjfOpLMT3ceOGf8PskT+MSWXjqEJSnZmHx5bwG5AQJkW4nFQ
         jw8w==
X-Forwarded-Encrypted: i=1; AJvYcCXMiw8RyM2f+0LXjSB8hOdUJa1wdru1CXCyMBu1IIQF+m/feuNywsMYsijWZI+WYLoVij/fM2ILVaBqonJuTgIGPUxteV9RYrQbMXY6
X-Gm-Message-State: AOJu0YwgZwwcuSrhbCuCnnGMxwLe55eqCy7NWVaOV9pMeYAUjyltvyub
	Tev7yKsv6Uw4WeyLMjVpNDiiQg3IWDTqovq450qEX7nQB2cEMw+EZx6OB2iLA40=
X-Google-Smtp-Source: AGHT+IFbYDgaYUGXxbXGJ4orAbrnlEp+fN+SYD4kxVugbNaLRY0H7Dzfacf9J7Mf14vZwL/Y6Mmgew==
X-Received: by 2002:a05:6512:329c:b0:51c:778f:b569 with SMTP id p28-20020a056512329c00b0051c778fb569mr4049642lfe.29.1714215356833;
        Sat, 27 Apr 2024 03:55:56 -0700 (PDT)
Received: from localhost (host-87-1-234-99.retail.telecomitalia.it. [87.1.234.99])
        by smtp.gmail.com with ESMTPSA id i13-20020a170906090d00b00a588dab605dsm4285140ejd.88.2024.04.27.03.55.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Apr 2024 03:55:56 -0700 (PDT)
From: Andrea della Porta <andrea.porta@suse.com>
X-Google-Original-From: Andrea della Porta <aporta@suse.de>
Date: Sat, 27 Apr 2024 12:55:58 +0200
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: Andrea della Porta <andrea.porta@suse.com>,
	Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kamal Dasu <kamal.dasu@broadcom.com>,
	Al Cooper <alcooperx@gmail.com>, linux-mmc@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
	Jonathan Bell <jonathan@raspberrypi.com>,
	Phil Elwell <phil@raspberrypi.com>
Subject: Re: [PATCH 1/6] dt-bindings: pinctrl: Add support for BCM2712 pin
 controller
Message-ID: <ZizZvpv3yomm0L3i@apocalypse>
Mail-Followup-To: Florian Fainelli <florian.fainelli@broadcom.com>,
	Andrea della Porta <andrea.porta@suse.com>,
	Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kamal Dasu <kamal.dasu@broadcom.com>,
	Al Cooper <alcooperx@gmail.com>, linux-mmc@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
	Jonathan Bell <jonathan@raspberrypi.com>,
	Phil Elwell <phil@raspberrypi.com>
References: <cover.1713036964.git.andrea.porta@suse.com>
 <2d1272cad92ad618297a6683e9264e31b8f2df73.1713036964.git.andrea.porta@suse.com>
 <f6601f73-cb22-4ba3-88c5-241be8421fc3@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f6601f73-cb22-4ba3-88c5-241be8421fc3@broadcom.com>

On 08:45 Sun 14 Apr     , Florian Fainelli wrote:
> 
> 
> On 4/13/2024 3:14 PM, Andrea della Porta wrote:
> > Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
> > ---
> >   .../pinctrl/brcm,bcm2712-pinctrl.yaml         | 99 +++++++++++++++++++
> >   1 file changed, 99 insertions(+)
> >   create mode 100644 Documentation/devicetree/bindings/pinctrl/brcm,bcm2712-pinctrl.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/pinctrl/brcm,bcm2712-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/brcm,bcm2712-pinctrl.yaml
> > new file mode 100644
> > index 000000000000..2908dfe99f3e
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/pinctrl/brcm,bcm2712-pinctrl.yaml
> > @@ -0,0 +1,99 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/pinctrl/brcm,bcm2712-pinctrl.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Broadcom BCM2712 pin controller
> 
> This is not strictly speaking BCM2712 specific, the pin controller you
> describe is a Broadcom STB product line pin controller.
> 
> Please describe it as such as and make BCM2712 a specific instance of the
> chip using that pin controller, see more comments on patch #4.

Ack. It turned out that the pin controller is not strictly need for a bare minimum
support of sd card booting, so it will be drop in patchset V2. A future patchset 
will re-introduce it when needed.

Many thanks,
Andrea
 
> -- 
> Florian



