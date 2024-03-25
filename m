Return-Path: <linux-kernel+bounces-116371-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E22568898CB
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:50:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6EE2A1F2BFB9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:50:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E689128374;
	Mon, 25 Mar 2024 05:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jZtDyWln"
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BED711292EC
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 01:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711329971; cv=none; b=ebDM+4bM+pnXQUbYsEA22akB+od53Ch50dJJWNz4yP3tgS/pRvG5DuCylEYASnw/Y4XnZQPw/kyt/cHtl+05WH6Gi9Gm1J70ZHCefpohGeN694Bdwcv5fbnt6E0N3F6Mmrg5CCr4xnLaM+voHipofwmcLxs5uR3woLOBYJyEtbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711329971; c=relaxed/simple;
	bh=TkNgras5ZUpGkbxWjPcva7sUuxVdARVYD58kLBCBPgU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X6XpRJD+As1t8zjWEp6JerYmtUawxEtflf3chirV+l4so/Iiqdqh1QFNc0diQDH0ejcHXLIkTuMsnj3knj59qQ4qX7SwzQIhCpM5XUXDy0N4ZDuSsBt7u8fQt12w/6Ms/OTHdO8TzT7VPF9SIdc4RQiJsa1dWVez+K4HVfE4GZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=jZtDyWln; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-690bd329df2so22407906d6.2
        for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2024 18:26:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1711329969; x=1711934769; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Y0Dbx4/AQEaK3b87iVLlgcHWjdXiKW8/SKBtYSvJ4l8=;
        b=jZtDyWlnLVFhljDgXn57ijKmJOY8U7jwzYweh8AoMPEAKBpiqplKxUPA4XSGABxpn2
         wYej31r7gngsrvHP/vY2z6UWuYiWEMsyGehYMN4WC4upfMqyBrkjDIflumiV0q0dhMRQ
         69GV4Cd+Tzyr4r0ZMPuY6W8BHOT/pngFwwU+s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711329969; x=1711934769;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y0Dbx4/AQEaK3b87iVLlgcHWjdXiKW8/SKBtYSvJ4l8=;
        b=ivB43hdg4k7zplR+Y3gdb0XpuuNCJHA7P2dEMrsCx8q+T5I45Qtb/V82IUT93hO+uf
         i+eiqXCQBmlsdzLUG/0DtmI3sXWciDoySSM0Q04PMbvD7lOCAO52g9J0tRAyNUHSFXxJ
         JZv9N6RlQmIzrnn2pQwjE5lMP+dokZJUQP8Cg+3RrOoxWa/WC6W0AktcKD6SX2iLAcXW
         /mToOhUURhWotiVYceSQRY9PTOYFmPA8mpJgCsYL+gKx8srb3b7WLtyleQKxMM88PeH1
         /73L3EvYoRjZVBMO/vt/hWZxHUtdQXQ6ZpB//DFLJxmg1mjxDWN6z0nFCECA5q+1OB1X
         Aabw==
X-Forwarded-Encrypted: i=1; AJvYcCWbykStVz/FcOjkkNc2nnrREhikkT+sEppRQpAXg32bO8339why9GVP8au8wnwofmhJLPcsslz2upguhcc6wmF6DpI9jgIDuGScqnA1
X-Gm-Message-State: AOJu0YxUMOohegSiLGb3DlyymdQ7yTpak7ZOanAjr2YM3ewAbLv4KSbK
	erkbD4BTayYK9K9dRZHiAx/MMDg/PHFgba5e3UKTmQqS2m3pBfXX8S2qCAeDnh+9BfTnb9eaSNm
	/bL0MyOlRL6dE9RBYEcL1Fh8dGtQ7f74IAQnq
X-Google-Smtp-Source: AGHT+IF8k6IEgNL4Ml3wABhG3s1RLLEjzUk0aITApXvBMpCMHfkjVmDSrsKoCpsIrVx5U2+VbKSHOEy12MRmxPAYxkg=
X-Received: by 2002:a05:6214:410:b0:690:a576:2a2c with SMTP id
 z16-20020a056214041000b00690a5762a2cmr6745531qvx.32.1711329968724; Sun, 24
 Mar 2024 18:26:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240320052449.175786-1-sjg@chromium.org> <20240320052449.175786-2-sjg@chromium.org>
 <20240321134917.GA1625959-robh@kernel.org>
In-Reply-To: <20240321134917.GA1625959-robh@kernel.org>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 25 Mar 2024 14:25:57 +1300
Message-ID: <CAFLszThbC7PDnJk8pXS2bNN9ebntoOJ-7xxkFU_LCm4Jg-km4w@mail.gmail.com>
Subject: Re: [PATCH v9 2/2] dt-bindings: mtd: fixed-partition: Add binman compatibles
To: Rob Herring <robh@kernel.org>
Cc: devicetree@vger.kernel.org, linux-mtd@lists.infradead.org, 
	Michael Walle <mwalle@kernel.org>, Miquel Raynal <miquel.raynal@bootlin.com>, 
	Conor Dooley <conor+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>, 
	Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Rob,

On Fri, 22 Mar 2024 at 02:49, Rob Herring <robh@kernel.org> wrote:
>
> On Wed, Mar 20, 2024 at 06:24:49PM +1300, Simon Glass wrote:
> > Add two compatibles for binman entries, as a starting point for the
> > schema.
> >
> > Note that, after discussion on v2, we decided to keep the existing
> > meaning of label so as not to require changes to existing userspace
> > software when moving to use binman nodes to specify the firmware
> > layout.
> >
> > Note also that, after discussion on v6, we decided to use the same
> > 'fixed-partition' schema for the binman features, so this version
> > adds a new 'binman.yaml' file providing the new compatibles to the
> > existing partition.yaml binding.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> > (no changes since v8)
> >
> > Changes in v8:
> > - Switch the patch ordering so the partition change comes first
> >
> > Changes in v7:
> > - Adjust MAINTAINERS entry
> > - Put compatible strings into the 'fixed-partition' binding
> >
> > Changes in v5:
> > - Add mention of why 'binman' is the vendor
> > - Drop  'select: false'
> > - Tidy up the compatible setings
> > - Use 'tfa-bl31' instead of 'atf-bl31'
> >
> > Changes in v4:
> > - Correct selection of multiple compatible strings
> >
> > Changes in v3:
> > - Drop fixed-partitions from the example
> > - Use compatible instead of label
> >
> > Changes in v2:
> > - Use plain partition@xxx for the node name
> >
> >  .../bindings/mtd/partitions/binman.yaml       | 49 +++++++++++++++++++
> >  .../bindings/mtd/partitions/partition.yaml    | 21 ++++++++
> >  MAINTAINERS                                   |  5 ++
> >  3 files changed, 75 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/mtd/partitions/binman.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/mtd/partitions/binman.yaml b/Documentation/devicetree/bindings/mtd/partitions/binman.yaml
> > new file mode 100644
> > index 000000000000..83417ad5cee9
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/mtd/partitions/binman.yaml
> > @@ -0,0 +1,49 @@
> > +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/mtd/partitions/binman.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Binman entries
> > +
> > +description: |
> > +  TBD
>
> ?

Oh yes, I forgot to put that back when I reworked all these again.

>
> > +
> > +maintainers:
> > +  - Simon Glass <sjg@chromium.org>
> > +
> > +allOf:
> > +  - $ref: /schemas/mtd/partitions/partition.yaml#
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - binman,entry # generic binman entry
>
> As-is, 'binman' would need to be added to vendor-prefixes.yaml.
>
> However, I think just 'binman' would provide just as much information.
> But really, does it provide anything? What would be the difference
> between this and no compatible?

In Binman this is the base class ('entry') for all entry types that it
understands. I don't expect we would actually use this since it does
not define what the contents are.

So I can remove this line.

Regards,
Simon

