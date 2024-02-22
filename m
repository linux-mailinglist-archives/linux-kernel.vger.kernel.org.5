Return-Path: <linux-kernel+bounces-75866-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BA6185F002
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 04:42:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B6D39B2426F
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 03:42:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD47817998;
	Thu, 22 Feb 2024 03:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RGsjpPZ8"
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A10441757D
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 03:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708573316; cv=none; b=qXK7MwgD5O1sNfvpAiRWViR1eFZ55jurTW9BXtE9Ur90IWPreoRpo6KQvvJ8DDDsaQdmcufDaEbNHfPXjrJZJMhYKFSJ8RNqi66UtML4lyA9sATH6+GSgAov0vIWzQaIzXy2vOb+cNuY9r+cj4EKza1OT1awGlZoLl3qD3cPGYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708573316; c=relaxed/simple;
	bh=CFleHBNrQpRDBWB+bPrY3lACjfd7SpfoVKRa4Rm7usE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GbwHUu7OO6fx4SYr26gA1aP7NDXsHIrAC12SWPxFa+DsbMIWgW02XY6ic7S5vsLClyk2T+KgaR0rBeyqypoLQY2cs3oxjbhU847uatXHK3VRE6CNiL1z57MmGsBVImQeDdTtCthfnwti73Xb4o8qrpyRYQ30qkWTHQDnJcPmOy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RGsjpPZ8; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-42e2507c6e1so105361cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 19:41:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708573313; x=1709178113; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tkWn2p2KoktTF74iyosyAqtgPvGQax193IdDSSf0wdk=;
        b=RGsjpPZ8fpxN3eTzLGz1eZxxOFjwO+7HrSuwUmiE71lFb5IKrVyulevIhya7ZmALez
         jy3xk7BjCpG+f4jVyAE+HC+lKJkomau5gSM9vbveLWZ1M7Z8R8BrVC8f8suFidwPwR5/
         ykd3fNXw5Yd+rQxp0dcNmjgxxeeJN9oZP7cXrP9j3NJOoN2lN5H4yTsluwawdw9Rm+zJ
         GXPa0qDPtDVGyDUO7x7R+Kt2qFQ0VE69V64RNtiHnyMgn29ob7gN9uBlqTAWzhe1GAue
         6cMzqGkOVyEgBzIyC91gL8Fjl27zIXLb7mb4l+4dqYdDpT5qPYnoLy4dWw75H1bp9uV5
         p+IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708573313; x=1709178113;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tkWn2p2KoktTF74iyosyAqtgPvGQax193IdDSSf0wdk=;
        b=rPxG8asNufBehTtId7BTfMDfOvudUZd3m9x0uamLPaQFkx4UaXa6nyODR8szPFAavZ
         Z0K587k0mD+F8Am0OtCnQGvOA3WCoievkkHky6E1w+XLyL8R7F+yyHujk5ck7K0xiZVI
         ZNj6RY7WuanYxaj0RsVeSjaxggvyiRSwKQ2z/VEmPD95gLiyVkQPKjyCBoXNG2TV62Hk
         8/EJqW5u08ayX/tJqQc+c/2fuXkGut+FgatLyztFifOfyjfsTJQu2sZgjsUJ8NMDDTB3
         LTs8PR5S5ZInFP3HxapoikbFalPbfuk674QBwPyY5JQ3vV1dUOLV7+Qs3e4v17QJse3/
         mE1Q==
X-Forwarded-Encrypted: i=1; AJvYcCVngzxJ8C6rUH3XchrKJEhj3+aLAusy4pceANERoKAJf6cRLWwNKvtwWTesupWzVhJdj9px0AtrMR/hJccbNrEnSfhBpBonxeH5GlsP
X-Gm-Message-State: AOJu0YzhRcbYyTUh/n3udPJovWDXEYg3WlyOr4fQa/qqHSqvVbR8c0lG
	WMw+i55rWNfsyKS5CDXUN9foTuA87Dn/020SLazWrrrotYV3YZY2HV9JdR90GMqdOn3Mq7XDPJS
	sfDEEJ28akTVJWZW5Qha5hDTzhWcS/RjslJUq
X-Google-Smtp-Source: AGHT+IGvjS/JsDjKLRtFXUpHvTnqcMileQ3GCikt+aLAGrSc25d+ufjOgPr0Fh2MCXQbYqWszHyGfO3vfuuMY/hfPQk=
X-Received: by 2002:a05:622a:68c9:b0:42d:be0f:e30a with SMTP id
 ic9-20020a05622a68c900b0042dbe0fe30amr384702qtb.23.1708573313369; Wed, 21 Feb
 2024 19:41:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240221233026.2915061-1-saravanak@google.com>
 <20240221233026.2915061-4-saravanak@google.com> <170856138383.540970.12743608676098316685.robh@kernel.org>
In-Reply-To: <170856138383.540970.12743608676098316685.robh@kernel.org>
From: Saravana Kannan <saravanak@google.com>
Date: Wed, 21 Feb 2024 19:41:16 -0800
Message-ID: <CAGETcx9v_NHhC4EwKDQ1UQMQQB=B2e1nQSqJZAwc7VwEWztp8g@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] dt-bindings: Add post-init-providers property
To: Rob Herring <robh@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-kernel@vger.kernel.org, 
	Ard Biesheuvel <ardb@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
	Daniel Scally <djrscally@gmail.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	kernel-team@android.com, linux-efi@vger.kernel.org, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Len Brown <lenb@kernel.org>, devicetree@vger.kernel.org, 
	Frank Rowand <frowand.list@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	linux-acpi@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 21, 2024 at 4:23=E2=80=AFPM Rob Herring <robh@kernel.org> wrote=
:
>
>
> On Wed, 21 Feb 2024 15:30:23 -0800, Saravana Kannan wrote:
> > The post-init-providers property can be used to break a dependency cycl=
e by
> > marking some provider(s) as a post device initialization provider(s). T=
his
> > allows an OS to do a better job at ordering initialization and
> > suspend/resume of the devices in a dependency cycle.
> >
> > Signed-off-by: Saravana Kannan <saravanak@google.com>
> > ---
> >  .../bindings/post-init-providers.yaml         | 105 ++++++++++++++++++
> >  MAINTAINERS                                   |  13 ++-
> >  2 files changed, 112 insertions(+), 6 deletions(-)
> >  create mode 100644 Documentation/devicetree/bindings/post-init-provide=
rs.yaml
> >
>
> My bot found errors running 'make DT_CHECKER_FLAGS=3D-m dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
>
> yamllint warnings/errors:
>
> dtschema/dtc warnings/errors:
> Documentation/devicetree/bindings/post-init-providers.example.dtb: /examp=
le-0/clock-controller@1000: failed to match any schema with compatible: ['v=
endor,soc4-gcc', 'vendor,soc1-gcc']
> Documentation/devicetree/bindings/post-init-providers.example.dtb: /examp=
le-0/clock-controller@1000: failed to match any schema with compatible: ['v=
endor,soc4-gcc', 'vendor,soc1-gcc']
> Documentation/devicetree/bindings/post-init-providers.example.dtb: /examp=
le-0/clock-controller@2000: failed to match any schema with compatible: ['v=
endor,soc4-dispcc', 'vendor,soc1-dispcc']
> Documentation/devicetree/bindings/post-init-providers.example.dtb: /examp=
le-0/clock-controller@2000: failed to match any schema with compatible: ['v=
endor,soc4-dispcc', 'vendor,soc1-dispcc']

I'm assuming it's okay to ignore these warnings about made up
compatible string names.

> doc reference errors (make refcheckdocs):
> Warning: MAINTAINERS references a file that doesn't exist: Documentation/=
devicetree/bindings/post-init-supplier.yaml
> MAINTAINERS: Documentation/devicetree/bindings/post-init-supplier.yaml

Will fix this and send out v4. Ignore the v3 series please.

-Saravana

>
> See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/202402=
21233026.2915061-4-saravanak@google.com
>
> The base for the series is generally the latest rc1. A different dependen=
cy
> should be noted in *this* patch.
>
> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure 'yamllint' is installed and dt-schema is up to
> date:
>
> pip3 install dtschema --upgrade
>
> Please check and re-submit after running the above command yourself. Note
> that DT_SCHEMA_FILES can be set to your schema file to speed up checking
> your schema. However, it must be unset to test all examples with your sch=
ema.
>

