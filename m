Return-Path: <linux-kernel+bounces-119603-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B53288CAF9
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 18:33:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9B9E2E164A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 17:32:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2313E1D543;
	Tue, 26 Mar 2024 17:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NO6RgJQb"
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 057F31CD3F;
	Tue, 26 Mar 2024 17:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711474370; cv=none; b=AT8DU/HfG5aHo9zKeADaatglbzCmnGxyMEsdXoLr/Sof66ntyZKfrIbQtHtISZg45cm30QYex484GR93BRydZkeQ4QZndL+Cu/903/o1RqxRCuGBegQqhJhQv3LWFnhr4gsKtXjAxio8tsf5yP7RmXsTN/7jAzyIKDsCdbLtipk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711474370; c=relaxed/simple;
	bh=2WxwL5HzmgKunPlikOV/EN/ipnW5U6Nmd6bDqTnpTOQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u0YmlDy9hKFViNOI6TG+EEl+BZfC3W/Uj43ZqFX6RoHw9EZGTeS1jl0PD6hzv0mzqmkBBxg1vr0Efpt38ZzHdhIjQVGhIY2rmijn8GQ/PrYOIB3m+r9BF9UbGNR0NBSzxen/EazOTmn+hOKbJhOOfo/oRPtLlSkFcpbQ6+rTHzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NO6RgJQb; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-6e6a1d24770so3333727a34.0;
        Tue, 26 Mar 2024 10:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711474368; x=1712079168; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VVDA+32rMLdFw4O/cOMy466iqo+UkQCw9ATNyEyDe30=;
        b=NO6RgJQb7PtasLO3L3KNK3bM0PkVpfubMIZ6TPZdYOzuw7nlkaV9qUQ7D5wjaDD1sn
         8zCPeShkGLmQp9hnAYEd6iPVjqGrPcYPT4yPjiKENMOMVA+fWam4tSvbu3+wWILZTNCK
         GO7tbhqTlq6FkVBqSyvZBkmUpjObpihxtw4en/l9zNpt2XxxokiuUh8muNkauooPbFcx
         5BOyRoPCBLBDqBXFYIJ9f3yEhD/h+AeUtGIx4H+z1mUpaB8MdVaGA8lt42PdDI9Hnr3i
         I9trC4fgLMPEk1lwBgVlL3dtL1qijZyMcKSp398vQZTguXw8HIq8S/w53NFEZYs62bIh
         oKFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711474368; x=1712079168;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VVDA+32rMLdFw4O/cOMy466iqo+UkQCw9ATNyEyDe30=;
        b=MzXCdxPuA/4ikEGvP8yr57ffwPbhn32uAp37XUr6vaIEyZ/GQSBJ9pBu5Uv6NkPlkO
         8pu4EnFy5bpEoLdsqSP0ZbKB99rdNK6w3TdhN94SvvYMh8zSm0GY3aLMYW7ZUBvMw92U
         KIUIrxe9D4/xoMu0fBnl0OMWJCAbFykFNeYgpRgMGNEbbEn/c2oSlp0Q+38x55AHH3Ax
         EAvS9PxmiaoaMCa16rb8uf7tkDirWnyqkZ/V10dK/yIabQ49IvJ/o+mekzH4rDZGsnnj
         6TtzAExX4mRLhb+NJdA4JatEEDBzI+VDnAwbA1uBQ821Vqa645FjgfIHiNNjybXdN4fi
         jQkQ==
X-Forwarded-Encrypted: i=1; AJvYcCWaPHARGI7ynHVWJDjO9q3Hru6ivotyGwWrSEO4eQSF0BTGoRkmUGR8sls3hrpAHU0VtctdWen3r8xPgwQ/Tl0fl/a6KltYDGmMzRfclLd7kNR/E0h7pKZEQuAjZ6T//+xGqhaQquwlgQ==
X-Gm-Message-State: AOJu0Yz0f7OiMY3B7abXZKCXgkm8r6Zo9XPLhIVM3HDcMvyNfmG26iNb
	mRepNkvzMJHeSLW1PZT9L0H4jeIHc1kpkgeQImHCjY5pF+D3ezNg3nN1jiZ2bX9TtmPCjzSNtWG
	rKB0a2gGIhYhjHhgayJtDcMwzrNU=
X-Google-Smtp-Source: AGHT+IFUtNEJraYpHw9pOZBsWMNCGOXN0v96AA64kioTRERW+zbel2owsSSseGb0t3juLykLovzBvNrckVxaDe4RvzE=
X-Received: by 2002:a05:6830:3d0a:b0:6e6:8b5a:814d with SMTP id
 eu10-20020a0568303d0a00b006e68b5a814dmr283931otb.13.1711474368056; Tue, 26
 Mar 2024 10:32:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240325210045.153827-1-afd@ti.com> <2024032631-excursion-opposing-be36@gregkh>
 <CAOCHtYjauA+BAxZJBMTaxxaMGcvipP9=ZPeWe4FiNFs_jpq6dg@mail.gmail.com>
 <c2125144-659e-42f2-af1f-ffef7ec3d157@ti.com> <2024032658-chosen-salaried-4702@gregkh>
In-Reply-To: <2024032658-chosen-salaried-4702@gregkh>
From: Robert Nelson <robertcnelson@gmail.com>
Date: Tue, 26 Mar 2024 12:32:21 -0500
Message-ID: <CAOCHtYjj0RfFyOfzjyU8XeivNmmLO0YnNf+376Uqg9gnVvJ3PA@mail.gmail.com>
Subject: Re: [PATCH] uio: pruss: Deprecate use of this driver
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Andrew Davis <afd@ti.com>, Jason Kridner <jkridner@beagleboard.org>, 
	Matthijs van Duin <matthijsvanduin@gmail.com>, Drew Fustini <drew@beagleboard.org>, 
	Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> > These users rely on out-of-tree patches to make this driver usable[0].
> > In its current state upstream, this driver is not used/usable. Since you
> > have to make update patches anyway, why not simply carry the whole driver
> > as an out-of-tree patch?
> >
> > That is why I was thinking of just marking it deprecated for a cycle
> > or two, just to give one last hint that it will be going away soon
> > (or you cancarry the driver out-of-tree for however long you want).
>
> No one notices "deprecated" stuff, they only notice if the code is
> removed.  So removing it is the only way to pay attention.
>
> But why are out-of-tree changes needed?  If they are needed, why are
> they not submitted for us to take so that it is usable by everyone?  Or
> is the out-of-tree patches also not supposed to be used?

I saw Matthijs, did chime in, I'll wait for his full reply, we've been
utilizing his knowledge on the pru subsystem to keep the uio driver
alive with our out of tree patches. (and extending it to even newer
TI am57xx devices, which TI didn't want us to do..)

Looking at lore, Matt Porter originally had am335x support in the
initial drop of uio when adding it to the DA850 family.

https://lore.kernel.org/lkml/20121003150058.GB11180@beef/

I'll dig for his v3 to find the real reason on why it was later dropped.

But at some point the remoteproc framework became the preferred
method, so uio patches were not allowed.. (one IP block, two drivers..
Community vs TI/Mainline)


Regards,

--
Robert Nelson
https://rcn-ee.com/

