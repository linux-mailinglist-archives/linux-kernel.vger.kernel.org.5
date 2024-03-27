Return-Path: <linux-kernel+bounces-120317-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CDB788D59D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 05:54:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A45D01F2A08A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 04:54:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA2A55234;
	Wed, 27 Mar 2024 04:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XIIWHO8d"
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D063210D;
	Wed, 27 Mar 2024 04:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711515277; cv=none; b=TB/OLxPm2KDaGtKljJ9gWC3fjP0TtrWVxEDNsgvmou509HrcheVfjCQxCJki/HyUxzs5o7Uv5Hwz3xXzOVkHEYIK/xcmczfc2lIn77UAYulCLh2wv8c4I5JN7IR5LgkYXliJzGi49TpxAjG54Z7g7KEoF54fCFVjGY0ZAhmmvpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711515277; c=relaxed/simple;
	bh=EMle/GF5/9JsCU4aK91tXkHvB74fC/ooG94Ascw5rWI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xa/WWsy3gtWMUu77gBAVOhoOqz5RvaagpUvYu8otjjQd1FwxTRmM4i5JT0GQJ/02LNinSMQvtW/u9n38hZLf8s19OrAg4+i/iQVkTfxY6hczFVkjDMpn///Va4afseVhSakROoUX6QM2Fgoy0z0T/7/S4K/LDGDa0HmIXxr1UtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XIIWHO8d; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-5a4d3b82e53so203958eaf.0;
        Tue, 26 Mar 2024 21:54:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711515274; x=1712120074; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a8jDOm3TD9dGm9HAqJyZfkPzbtOTTI0os5r85YFqvWk=;
        b=XIIWHO8d+nln0FdnMdpjk0PPGgR5+0fnN6E8Dmg7AeSe13vam8hlsvQiOeNZ7T3GL9
         G2qq/7swUJV1CsUdoMOi7hJ8LPVzqMyUlGjplrAH8A6l8w4MmmVqykO3RhkjW3l1DDcC
         s8mVUEKrBugCICGoU3mgfoLn7hOCo1cV+pxb4MwObO+7bISFw2sizmJv0J5sTBLwmR8g
         QcQmn6leZecWxmHEmPqzQ90p/bblXHIM8cH367v1cMB3BWIA/kjYw5sbjFC5/fRW782T
         Mn1/j8FsSQOTzuhqRH8i+eOxotmeReJmK/owBd+Ys7MEO7qGDFHeWySv/UI5m7kxlhCp
         QPtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711515274; x=1712120074;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a8jDOm3TD9dGm9HAqJyZfkPzbtOTTI0os5r85YFqvWk=;
        b=NkcZWk0iiS2hnaHuMCmuYQ5i0QuD7oURpTvv8KmaicdMonu1V7MAJ5jreG+L0XLDbS
         g9SaXx9L6zVen1CbxSsavDsINk/OYHj17DIdX8mfR8rbdp4EwOKLdX9hwRZ+AhjgPFPj
         +4argyvOzhG7yvNkrSGRq+3Oa7sdllWsp4gMvxtCSgB5DL/bstL60McCEFcEuJSFrGIk
         Dt3NS1H8yutJUdwFCY6Ty7GbMAzCjrZvEjQ8As0MmsstBJJpMRzh/86vTt98CYrdiy7T
         mSspCFg8PuudRiPRS6M09dtoNcuj/jGBlaZLRD23K/EqcL608KXy6mySC2qK6b6YJiOH
         8ktw==
X-Forwarded-Encrypted: i=1; AJvYcCV4a/YWS1It9C0qKzTUHxtBifjy+12ShuLQWWkdbkrCrZKI6NcidOu2XTeBh84oBPZPnbER+PjK+COwLDI3TcBCrGicRVYsNLSxDhvBf64hMkTyVlS4L9N+jRrVr1pmNazO+HmxjN9VBUbc6U5Xdbq7xg5mQ1Mu6j9GSRdKalRJeqg6rQ==
X-Gm-Message-State: AOJu0Yy5qSpKjrkI/akU16S92CXPse8QskLojzEikgMMNn1ZjD7Xea/8
	gNvodVXd8Z4rBk//5ClwN2Ts98c2wLvyEaZAm4jnJ97BJNT0OxcyWYvgSpJyGfDLcpZKji7Lxe2
	2Q5OAvRuhFhNXT0p+CcN5BYmhSPCwKoxI4GcgpqqY
X-Google-Smtp-Source: AGHT+IGDrtBesenMUxcY0EwcM7mlUo84BaFWZqUfs8JCnj5zk7Y+VfTElhPl9WOSvx4WWNiGY3bbT71jU/Y3K8IzYNg=
X-Received: by 2002:a05:6870:7007:b0:229:e4ef:b7dc with SMTP id
 u7-20020a056870700700b00229e4efb7dcmr1451051oae.26.1711515274445; Tue, 26 Mar
 2024 21:54:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240326121735.11994-1-animeshagarwal28@gmail.com> <7567a9b5-fd6d-4729-964e-14c4e129bcd7@kernel.org>
In-Reply-To: <7567a9b5-fd6d-4729-964e-14c4e129bcd7@kernel.org>
From: Animesh Agarwal <animeshagarwal28@gmail.com>
Date: Wed, 27 Mar 2024 10:24:23 +0530
Message-ID: <CAE3Oz83njHf3ZuOq_cVfLTH93H9Y-qBDokAneLmkJ1OLFvE1og@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: ata: ahci-da850: Convert to dtschema
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-ide@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Sorry for the typo, I'll add it.

On Tue, Mar 26, 2024 at 5:55=E2=80=AFPM Damien Le Moal <dlemoal@kernel.org>=
 wrote:
>
> On 3/26/24 21:17, Animesh Agarwal wrote:
> > Convert the ahci-da850 bindings to DT schema
>
> Missing a period at the end of the sentence.
>
> >
> > Signed-off-by: Animesh Agarwal <animeshagarwal28@gmail.com>
> > ---
> >  .../devicetree/bindings/ata/ahci-da850.txt    | 18 ----------
> >  .../bindings/ata/ti,da850-ahci.yaml           | 36 +++++++++++++++++++
> >  2 files changed, 36 insertions(+), 18 deletions(-)
> >  delete mode 100644 Documentation/devicetree/bindings/ata/ahci-da850.tx=
t
> >  create mode 100644 Documentation/devicetree/bindings/ata/ti,da850-ahci=
yaml
> >
> > diff --git a/Documentation/devicetree/bindings/ata/ahci-da850.txt b/Doc=
umentation/devicetree/bindings/ata/ahci-da850.txt
> > deleted file mode 100644
> > index 5f8193417725..000000000000
> > --- a/Documentation/devicetree/bindings/ata/ahci-da850.txt
> > +++ /dev/null
> > @@ -1,18 +0,0 @@
> > -Device tree binding for the TI DA850 AHCI SATA Controller
> > ----------------------------------------------------------
> > -
> > -Required properties:
> > -  - compatible: must be "ti,da850-ahci"
> > -  - reg: physical base addresses and sizes of the two register regions
> > -         used by the controller: the register map as defined by the
> > -         AHCI 1.1 standard and the Power Down Control Register (PWRDN)
> > -         for enabling/disabling the SATA clock receiver
> > -  - interrupts: interrupt specifier (refer to the interrupt binding)
> > -
> > -Example:
> > -
> > -     sata: sata@218000 {
> > -             compatible =3D "ti,da850-ahci";
> > -             reg =3D <0x218000 0x2000>, <0x22c018 0x4>;
> > -             interrupts =3D <67>;
> > -     };
> > diff --git a/Documentation/devicetree/bindings/ata/ti,da850-ahci.yaml b=
/Documentation/devicetree/bindings/ata/ti,da850-ahci.yaml
> > new file mode 100644
> > index 000000000000..d54f58c12e78
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/ata/ti,da850-ahci.yaml
> > @@ -0,0 +1,36 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/ata/ti,da850-ahci.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: TI DA850 AHCI SATA Controller
> > +
> > +maintainers:
> > +  - Animesh Agarwal <animeshagarwal28@gmail.com>
> > +
> > +properties:
> > +  compatible:
> > +    const: ti,da850-ahci
> > +
> > +  reg:
> > +    minItems: 2
> > +    maxItems: 2
> > +
> > +  interrupts:
> > +    maxItems: 1
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - interrupts
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    sata@218000 {
> > +        compatible =3D "ti,da850-ahci";
> > +        reg =3D <0x218000 0x2000>, <0x22c018 0x4>;
> > +        interrupts =3D <67>;
> > +    };
>
> --
> Damien Le Moal
> Western Digital Research
>

