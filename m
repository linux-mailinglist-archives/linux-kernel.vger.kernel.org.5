Return-Path: <linux-kernel+bounces-134213-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEDD089AF04
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 09:12:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F01491C22764
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 07:12:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2298DD304;
	Sun,  7 Apr 2024 07:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QlOPRVkC"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C51C23DE;
	Sun,  7 Apr 2024 07:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712473922; cv=none; b=Xr/tZ7HfpHsWw/q2ekQPgZoG74bH7w3QnPVa/WOHOqCmnAdShREwvApakpODnwbnL6YYE2hrsfLsn6tieLXiER9aVdQa0IkY4H1LUGXZa95GmeHChUpcMo5cpdEnCstGSASafyfkexvR/Av05H7raqNtlqLHFffV31aBiUhcbE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712473922; c=relaxed/simple;
	bh=5d1LQr2ols/vrPnip9BNyBhkMrVi9GLh0XpRSV9G9Us=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RLbsGdGYV3VZhkHixy4edfF/mlyIyDfeKCor+upTB23WN+0E3HS2ozUvVDL8lKnolm0BvqfaYS4KFegRf7NYlXduVv2WS7Ro2903Rc86hiQVPX0hxvNQRNJ9dJ4gkbRVaRH8GOoPWZrxVjWz1/ksyQGq9/8Le2JIPrYxfwWckaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QlOPRVkC; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2d8863d8a6eso3786951fa.3;
        Sun, 07 Apr 2024 00:12:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712473918; x=1713078718; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wze2zDvYj+5Q17idSSBI3LjCflEuIEPWKjyY3qcROT0=;
        b=QlOPRVkCGa827dkBT/zCPI9UdtnFrkvxdk+Brsqe4bfE1z8Udu1B/gpFmz72a/Kher
         TL+RECqW0hUy49H5/0n1QxzaHQSQ2Hikw88uLPTtEd1iS68TvSqAIQqcVaRQgClxZVTy
         /xIjX5ML/Ux7D86OzqwYy4b2JkSkiS53jn+r+bCwhVczi4qcDsteeCon84piBRWz3ZMR
         ZdjojOEAHHKZLrpbgWVJm8olm/tAvpaP4ZTl6fySsVD8MaRF9gkjD++oEESUr03vNRtX
         K+nQWijzFQiCVpMFgIgBLAnVQXmbKUn8FWmSkTGnJQ4SwuLgFgTuQRyqzIvYYUv7nlBG
         rp1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712473918; x=1713078718;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wze2zDvYj+5Q17idSSBI3LjCflEuIEPWKjyY3qcROT0=;
        b=QFTPFTDzJ2OxSYPpCw1O3exwBIWFOTVnwtK11GO3E5oc11R41tFWnST4YbHBfH0CR7
         jx04OuaVucJcgJQzz3F9mgdgEda32u+vkseFovj0EA/lBFKc+lIKRuj9kABfpY04EPXz
         A7qhct2wqbcJXN2KDQSJz1cVyhPo9dCkoPApN2T3mr1qM2NoxmpvBXoyzXX+FsGMykoB
         g/meV65QJ5ctKZGuKETypN+AyDk9G9B0Trq7IH7vu6sL607N5ajhyuaO4Qk7JJ7xhPDC
         qMj8s2nFhkqylVls7Xn4YqayAUOknHx5gSrHvFB9CaWLYPBMEfYl38gjOtp7pWIEc/pa
         SnBA==
X-Forwarded-Encrypted: i=1; AJvYcCXFWKSYhlkEo0hTBiVCgY5WHTMvsdUfTKaUuLR2tForbNz5isDmRKPNdaVGHiVTHg9NcZaVy5cZy+TI6ODI4xXp5FBfAVlh3f3Lp5AWDQfYIoZ70+S8QacRx3pvh6ZF8RcexVlViNd6Eg==
X-Gm-Message-State: AOJu0Yz0lbH4ThCcS9ZY/DyABQ7YorSbTU6zl9PoW1j9+tDY7k32Nu7y
	3NO3MEPDsy38PSSYwBGup/chzDXkt9/9Yy0igJu8S/53Q7oZDk4E03OC4z6pGkigxk5xV+GWVHs
	U+N27zrQromMIouNWEhzRle3OwGuPSItzdTnsjg==
X-Google-Smtp-Source: AGHT+IFr3DAF/ZHxqTA10E30kgXbr3ygefhEOzLY8sJnVAP+j+hZVrmoHcd8uRM24o06OHumfbTTUzUs4WSF/PxFtCE=
X-Received: by 2002:a05:651c:201c:b0:2d8:60b9:1d74 with SMTP id
 s28-20020a05651c201c00b002d860b91d74mr3638110ljo.18.1712473918256; Sun, 07
 Apr 2024 00:11:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240404160649.967-1-bavishimithil@gmail.com> <78091796-fd0a-42dd-a4da-f7bed3025bf9@linaro.org>
 <CAGzNGRnuG_gLUrH1N57WvpKbpiNtFrcsG6nJcacQNJB_yMYNrA@mail.gmail.com>
 <ec7f77a7-2cf1-4ea6-b9c4-d4fe8a1673ab@linaro.org> <CAGzNGRktm5gMj=bhtX2RAzcn1v5ref+nV-HV3Fct56FzAzxjWA@mail.gmail.com>
 <c9084453-65f1-43b0-88df-5b73052ccb72@linaro.org> <CAGzNGR=2-us8GRB3RNi4_24QZ9rNBC7Lx0PFsWwbvxuRKk5ngw@mail.gmail.com>
 <352672fc-b6e1-458e-b4f9-840a8ba07c7e@linaro.org>
In-Reply-To: <352672fc-b6e1-458e-b4f9-840a8ba07c7e@linaro.org>
From: Mithil <bavishimithil@gmail.com>
Date: Sun, 7 Apr 2024 12:41:46 +0530
Message-ID: <CAGzNGRnjCydMMJS6Cqht7zT1GvhbVtKAe1hu8oaf8YwRfA=hZg@mail.gmail.com>
Subject: Re: [PATCH v2] dt-bindings: omap-mcpdm: Convert to DT schema
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	alsa-devel@alsa-project.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 5, 2024 at 11:49=E2=80=AFPM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 05/04/2024 19:21, Mithil wrote:
> > On Fri, Apr 5, 2024 at 10:38=E2=80=AFPM Krzysztof Kozlowski
> > <krzysztof.kozlowski@linaro.org> wrote:
> >>
> >> On 05/04/2024 18:29, Mithil wrote:
> >>> On Fri, Apr 5, 2024 at 9:27=E2=80=AFPM Krzysztof Kozlowski
> >>> <krzysztof.kozlowski@linaro.org> wrote:
> >>>>
> >>>> On 05/04/2024 16:48, Mithil wrote:
> >>>>> So sorry about the 2nd patch being sent as a new mail, here is a ne=
w
> >>>>> patch with the changes as suggested
> >>>>>
> >>>>>> Please use subject prefixes matching the subsystem
> >>>>> Changed the patch name to match the folder history.
> >>>>
> >>>> Nothing improved. What the history tells you?
> >>>>
> >>>
> >>> Referred to "ASoC: dt-bindings: rt1015: Convert to dtschema"
> >>> Not really sure what else I should change.
> >>
> >> But the subject you wrote here is "dt-bindings: omap-mcpdm: Convert to
> >> DT schema"?
> >>
> >> Where is the ASoC?
> >>
> > I did change it, will send the patch again.
> >
> >>
> >> reg is not correct. Please point me to files doing that way, so I can
> >> fix them.
> >>
> >> You need items with description.
> >>
> > Documentation/devicetree/bindings/sound/fsl,imx-asrc.yaml
> > I referred here for the description, but will add items for the 2 regs
>
> I don't see at all the code you are using. It's entirely different!
> Where in this file is that type of "reg" property?
>

Changed it to use items and description. Was not aware about this
format apologies.

> >
> >>> Interrupts and hwmods use maxItems now.
> >>
> >> hwmods lost description, why?
> > Seems self explanatory.
>
> Really? Not to me. I have no clue what this is. Also, you need
> description for (almost) every non-standard, vendor property.
>

Re-added it as it was previously.

> >
> >>> Changed nodename to be generic in example as well.
> >>
> >> "mcpdm" does not feel generic. What is mcpdm? Google finds nothing.
> >> Maybe just "pdm"?
> >>
> > Multichannel PDM Controller. Kept it like that since the node is also
>
> You said you "changed nodename". So from what did you change to what?
>
> > called as mcpdm in the devicetree. Calling it pdm might cause
>
> Poor DTS is not the example...
>
> > confusion.
>
> So far I am confused. Often name of SoC block is specific, not generic.
> Anyway, that's not important part, so if you claim mcpdm is generic name
> of a class of devices, I am fine.
>

Changed to pdm.

Here's the patch,
From 9fb94e551da1ff06d489f60d52335001a9de9976 Mon Sep 17 00:00:00 2001
From: Mithil Bavishi <bavishimithil@gmail.com>
Date: Mon, 1 Apr 2024 21:10:15 +0530
Subject: [PATCH] ASoC: dt-bindings: omap-mcpdm: Convert to DT schema

Convert the OMAP4+ McPDM bindings to DT schema.

Signed-off-by: Mithil Bavishi <bavishimithil@gmail.com>
---
 .../devicetree/bindings/sound/omap-mcpdm.txt  | 30 ----------
 .../bindings/sound/ti,omap4-mcpdm.yaml        | 58 +++++++++++++++++++
 2 files changed, 58 insertions(+), 30 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/sound/omap-mcpdm.txt
 create mode 100644 Documentation/devicetree/bindings/sound/ti,omap4-mcpdm.=
yaml

diff --git a/Documentation/devicetree/bindings/sound/omap-mcpdm.txt
b/Documentation/devicetree/bindings/sound/omap-mcpdm.txt
deleted file mode 100644
index ff98a0cb5..000000000
--- a/Documentation/devicetree/bindings/sound/omap-mcpdm.txt
+++ /dev/null
@@ -1,30 +0,0 @@
-* Texas Instruments OMAP4+ McPDM
-
-Required properties:
-- compatible: "ti,omap4-mcpdm"
-- reg: Register location and size as an array:
-       <MPU access base address, size>,
-       <L3 interconnect address, size>;
-- interrupts: Interrupt number for McPDM
-- ti,hwmods: Name of the hwmod associated to the McPDM
-- clocks:  phandle for the pdmclk provider, likely <&twl6040>
-- clock-names: Must be "pdmclk"
-
-Example:
-
-mcpdm: mcpdm@40132000 {
-       compatible =3D "ti,omap4-mcpdm";
-       reg =3D <0x40132000 0x7f>, /* MPU private access */
-             <0x49032000 0x7f>; /* L3 Interconnect */
-       interrupts =3D <0 112 0x4>;
-       interrupt-parent =3D <&gic>;
-       ti,hwmods =3D "mcpdm";
-};
-
-In board DTS file the pdmclk needs to be added:
-
-&mcpdm {
-       clocks =3D <&twl6040>;
-       clock-names =3D "pdmclk";
-       status =3D "okay";
-};
diff --git a/Documentation/devicetree/bindings/sound/ti,omap4-mcpdm.yaml
b/Documentation/devicetree/bindings/sound/ti,omap4-mcpdm.yaml
new file mode 100644
index 000000000..73fcfaf6e
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/ti,omap4-mcpdm.yaml
@@ -0,0 +1,58 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/ti,omap4-mcpdm.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: OMAP McPDM
+
+maintainers:
+  - Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
+
+description:
+  OMAP ALSA SoC DAI driver using McPDM port used by TWL6040
+
+properties:
+  compatible:
+    const: ti,omap4-mcpdm
+
+  reg:
+    items:
+      - description: MPU access base address
+      - description: L3 interconnect address
+
+  interrupts:
+    maxItems: 1
+
+  ti,hwmods:
+    description: Name of the hwmod associated to the McPDM, likely "mcpdm"
+
+  clocks:
+    description: phandle for the pdmclk provider, likely <&twl6040>
+
+  clock-names:
+    description: Must be "pdmclk"
+
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - ti,hwmods
+  - clocks
+  - clock-names
+
+additionalProperties: false
+
+examples:
+  - |
+    pdm@0 {
+      compatible =3D "ti,omap4-mcpdm";
+      reg =3D <0x40132000 0x7f>, /* MPU private access */
+            <0x49032000 0x7f>; /* L3 Interconnect */
+      interrupts =3D <0 112 0x4>;
+      interrupt-parent =3D <&gic>;
+      ti,hwmods =3D "mcpdm";
+      clocks =3D <&twl6040>;
+      clock-names =3D "pdmclk";
+    };
--
2.34.1

Best regards,
Mithil

