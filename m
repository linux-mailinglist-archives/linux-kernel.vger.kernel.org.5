Return-Path: <linux-kernel+bounces-66122-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 12F2485574F
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 00:33:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B916728956D
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 23:33:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11C671420A7;
	Wed, 14 Feb 2024 23:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="JT9ibqn5"
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5223D141996
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 23:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707953601; cv=none; b=khGJMkBWj+JH8hHp6Kyu0bTN/HH/17x916kc7KZwGO7YEu68bdoJ+Gft43tXg8bebPLEfBcvcFuHvztOgWKCiYeMhscGxA9AZjnuw3uiI7WfiP+QWZFELl7YvJ48fMm945j0mxVwNzD0KiNw6orZhoV06pkD8AAcpGb684OL+ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707953601; c=relaxed/simple;
	bh=lNniGJRWqs5vkdggTeOdCVtP1zQiJDAGENzRNbCCrRQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ai8+Mblf2qefyIZQe9OOKD+3AO93Zvm0XNgl4wNamsWLqbE4rgk49oNv/vpcQcXoeCpygb2GBNBWXNehw8MO2u2zePH+zWYefcPNoAq/cZBh2PCjDD0rCXFFMz+unXarxjNU4Ni/tE46ro2MLJCIBdw6DFFkzHd4LpJ75mx6ZZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JT9ibqn5; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-42db1baff53so56261cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 15:33:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707953597; x=1708558397; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oWVOuj4rMvhSLFWAyEWK0L/EZU9RsmUUAUz5wQ+DXOg=;
        b=JT9ibqn53dRKfmOEdnKPGH2NnhgyEfSS2aQVKMgSqfgZLAhy0ws2l4S5e9gR+MuEso
         8VXT0OdaNXjtjFp1rv7vmu1/NPW3zNbvOwSXUwYatjR3wGgrTOgqHRhyj7OPspd7pXdS
         fJVRYl69wHV7p5UJaa5tcAC97HUtHpR4GhHd9wCD5eHgNuXXOAHWB001RDpFqsNEbLr5
         R8/nikApEf80NAAtvxzKN3qPK29TRtl2ak+z8Q4oFsAMFkXWQb8V/uXR7Cer39pcmFif
         SkcdlzKmr7PEojp1YxdRdoUA/eg/h6IIFN3tiTNK2MC5hT6mkBL1i2nGusmrZihL3jG+
         y+AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707953597; x=1708558397;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oWVOuj4rMvhSLFWAyEWK0L/EZU9RsmUUAUz5wQ+DXOg=;
        b=vrZTzzApv1oFYCN21K0Z7/Rp35kPgAI9OCcXeK2IczCsNmBMTw5E33rlK6HDDSj/j2
         lhj/KGcmWvrUP/cO2Rjm62Fqo0K+6Tyb4p0nff3URruo7Vn5k+iET7nr6EKMdoL5A97d
         oafkjKh2UNQRdJdakwDCdkTI4PC8RnmvyXd5B09nx/pfvea/REtPo46uU2yGfQpfumXE
         JKgG88vZYeqYbIZETxnj9qu3h+YRK58rhcZCgu79L+9vuCEbDArRyFQ37gsIbvnBI25S
         9YV9P+Mc7W7bo6jA91RlaU5gQVtsuVei+rmUJ+tuLUHIHqRgPhD29AV77pn8t0oUB0Ik
         LwMQ==
X-Forwarded-Encrypted: i=1; AJvYcCVCJJSyBDGkxb5+RhsUn9Zhzxa9XDGYDO5wUnnb8hnv+2oYRo91x6i6AvmdPIicfaI+hNcgdTeHPj3GFnY9jmjdciW7Rlv/gY1nRmVt
X-Gm-Message-State: AOJu0YzgBgx2Bgiow3u1nCH4t/cdZkrVp3vAmCVJemv2nlAtqHOkBbc/
	UrZNtjNQr+7cO7ARbhXrTrLMhkYGul2xjZMCQJMvnx1YHXrlMW/lqJkDB98IlOixv0Am0aI5UCl
	juf2NB08QsvstugWAw3a3S7SzVf8if4v6+fPT
X-Google-Smtp-Source: AGHT+IECnRFS3Tun1wI7WB58zzwXAljD8tU5Rk8kG3Biy3kLhdVu7WmMzEwtevTLy/jxlgfm7mjMfgk9rNK0K90YwDw=
X-Received: by 2002:ac8:5916:0:b0:42c:59b3:31d5 with SMTP id
 22-20020ac85916000000b0042c59b331d5mr515930qty.17.1707953596990; Wed, 14 Feb
 2024 15:33:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240212213147.489377-1-saravanak@google.com> <20240212213147.489377-4-saravanak@google.com>
 <20240214-stable-anytime-b51b898d87af@spud>
In-Reply-To: <20240214-stable-anytime-b51b898d87af@spud>
From: Saravana Kannan <saravanak@google.com>
Date: Wed, 14 Feb 2024 15:32:31 -0800
Message-ID: <CAGETcx-tBjfaLQqmGW=ap2N5FLK_gvTzxskA6sVsr_SUEpvomA@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] dt-bindings: Add post-init-supplier property
To: Conor Dooley <conor@kernel.org>
Cc: Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Ard Biesheuvel <ardb@kernel.org>, Frank Rowand <frowand.list@gmail.com>, Len Brown <lenb@kernel.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Daniel Scally <djrscally@gmail.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-efi@vger.kernel.org, linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Conon,

On Wed, Feb 14, 2024 at 10:49=E2=80=AFAM Conor Dooley <conor@kernel.org> wr=
ote:
>
> On Mon, Feb 12, 2024 at 01:31:44PM -0800, Saravana Kannan wrote:
> > The post-init-supplier property can be used to break a dependency cycle=
 by
> > marking some supplier(s) as a post device initialization supplier(s). T=
his
> > allows an OS to do a better job at ordering initialization and
> > suspend/resume of the devices in a dependency cycle.
> >
> > Signed-off-by: Saravana Kannan <saravanak@google.com>
> > ---
> >  .../bindings/post-init-supplier.yaml          | 101 ++++++++++++++++++
> >  MAINTAINERS                                   |  13 +--
> >  2 files changed, 108 insertions(+), 6 deletions(-)
> >  create mode 100644 Documentation/devicetree/bindings/post-init-supplie=
r.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/post-init-supplier.yaml =
b/Documentation/devicetree/bindings/post-init-supplier.yaml
> > new file mode 100644
> > index 000000000000..aab75b667259
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/post-init-supplier.yaml
> > @@ -0,0 +1,101 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +# Copyright (c) 2020, Google LLC. All rights reserved.
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/post-init-supplier.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Post device initialization supplier
> > +
> > +maintainers:
> > +  - Saravana Kannan <saravanak@google.com>
> > +
> > +description: |
> > +  This property is used to indicate that the device(s) pointed to by t=
he
> > +  property are not needed for the initialization of the device that li=
sts this
> > +  property.
>
> > This property is meaningful only when pointing to direct suppliers
> > +  of a device that are pointed to by other properties in the device.
>
> I don't think this sentence makes sense, or at least it is not easy to
> parse. It implies that it can "point to" other properties too

I don't see how this sentence implies this. But open to suggestions on
how to reword it. I don't want to drop this line entirely though
because I'm trying to make it clear that this doesn't make a device
(that's not previously a supplier) into a supplier. It only down
grades an existing supplier to a post device initialization supplier.

> - but
> that's not the case. It is only valid to "point to" these suppliers.
> I'd drop this entirely.

>
> > +
> > +  A device can list its suppliers in devicetree using one or more of t=
he
> > +  standard devicetree bindings. By default, it would be safe to assume=
 the
> > +  supplier device can be initialized before the consumer device is ini=
tialized.
>
> "it would be safe to assume" seems odd wording to me - I feel like the
> default is stronger than "safe to assume". I'd just drop the "would be
> safe to assume and replace with "is assumed".

Sounds good.

>
> > +
> > +  However, that assumption cannot be made when there are cyclic depend=
encies
> > +  between devices. Since each device is a supplier (directly or indire=
ctly) of
> > +  the others in the cycle, there is no guaranteed safe order for initi=
alizing
> > +  the devices in a cycle. We can try to initialize them in an arbitrar=
y order
> > +  and eventually successfully initialize all of them, but that doesn't=
 always
> > +  work well.
> > +
> > +  For example, say,
> > +  * The device tree has the following cyclic dependency X -> Y -> Z ->=
 X (where
> > +    -> denotes "depends on").
> > +  * But X is not needed to fully initialize Z (X might be needed only =
when a
> > +    specific functionality is requested post initialization).
> > +
> > +  If all the other -> are mandatory initialization dependencies, then =
trying to
> > +  initialize the devices in a loop (or arbitrarily) will always eventu=
ally end
> > +  up with the devices being initialized in the order Z, Y and X.
> > +
> > +  However, if Y is an optional supplier for X (where X provides limite=
d
> > +  functionality when Y is not initialized and providing its services),=
 then
> > +  trying to initialize the devices in a loop (or arbitrarily) could en=
d up with
> > +  the devices being initialized in the following order:
> > +
> > +  * Z, Y and X - All devices provide full functionality
> > +  * Z, X and Y - X provides partial functionality
> > +  * X, Z and Y - X provides partial functionality
> > +
> > +  However, we always want to initialize the devices in the order Z, Y =
and X
> > +  since that provides the full functionality without interruptions.
> > +
> > +  One alternate option that might be suggested is to have the driver f=
or X
> > +  notice that Y became available at a later point and adjust the funct=
ionality
> > +  it provides. However, other userspace applications could have starte=
d using X
> > +  with the limited functionality before Y was available and it might n=
ot be
> > +  possible to transparently transition X or the users of X to full
> > +  functionality while X is in use.
> > +
> > +  Similarly, when it comes to suspend (resume) ordering, it's unclear =
which
> > +  device in a dependency cycle needs to be suspended/resumed first and=
 trying
> > +  arbitrary orders can result in system crashes or instability.
> > +
> > +  Explicitly calling out which link in a cycle needs to be broken when
> > +  determining the order, simplifies things a lot, improves efficiency,=
 makes
> > +  the behavior more deterministic and maximizes the functionality that=
 can be
> > +  provided without interruption.
> > +
> > +  This property is used to provide this additional information between=
 devices
> > +  in a cycle by telling which supplier(s) is not needed for initializi=
ng the
> > +  device that lists this property.
> > +
> > +  In the example above, Z would list X as a post-init-supplier and the
> > +  initialization dependency would become X -> Y -> Z -/-> X. So the be=
st order
> > +  to initialize them become clear: Z, Y and then X.
>
> Otherwise, I think this is a great description, describing the use case
> well :)

Thanks! I always spend more time writing documentation and commit text
than the time I spend writing code.

>
> > +
> > +select: true
> > +properties:
> > +  post-init-supplier:

[Merging your other email here]

> Also, this should likely be pluralised, to match "clocks" "resets"
> "interrupts" etc.

Good point. Done.

> > +    # One or more suppliers can be marked as post initialization suppl=
ier
> > +    description:
> > +      List of phandles to suppliers that are not needed for initializi=
ng or
> > +      resuming this device.
> > +    $ref: /schemas/types.yaml#/definitions/phandle-array
> > +      items:
> > +        maxItems: 1
>
> Rob's bot rightfully complains here about invalid syntax.

I added these two lines based on Rob's feedback. Is the indentation
that's wrong?

Yeah, I'm trying to run the dts checker, but I haven't be able to get
it to work on my end. See my email to Rob on the v1 series about this.

$ make DT_CHECKER_FLAGS=3D-m dt_binding_check

The best I could get out of it is a bunch of error reports on other
files and then:
..
<snip>/Documentation/devicetree/bindings/post-init-suppliers.yaml:
ignoring, error parsing file
..

I also tried to use DT_SCHEMA_FILES so I can only test this one file,
but that wasn't working either:

$ make DT_CHECKER_FLAGS=3D-m dt_binding_check
DT_SCHEMA_FILES=3DDocumentation/devicetree/bindings/post-init-suppliers.yam=
l
or
$ make DT_CHECKER_FLAGS=3D-m dt_binding_check DT_SCHEMA_FILES=3D<path to
the .patch file>

Results in this error early on in the output:
..
usage: yamllint [-h] [-] [-c CONFIG_FILE | -d CONFIG_DATA]
[--list-files] [-f {parsable,standard,colored,github,auto}] [-s]
[--no-warnings] [-v] [FILE_OR_DIR ...]
yamllint: error: one of the arguments FILE_OR_DIR - is required
..
/mnt/android/linus-tree/Documentation/devicetree/bindings/post-init-supplie=
rs.yaml:
ignoring, error parsing file
..

> What you
> actually want to enforce here is any number of device phandles, but
> these phandles all contain only the label and no indices etc, right?

Correct.

>
> > +
> > +examples:
> > +  - |
> > +    gcc: clock-controller@1000 {
> > +        compatible =3D "vendor,soc4-gcc", "vendor,soc1-gcc";
> > +        reg =3D <0x1000 0x80>;
> > +        clocks =3D <&dispcc 0x1>
>
> This clearly was never tested, Rob's bot warnings aside. You're missing
> a ; at EOL here and with the other clock below.

Yup. I'm unable to get the test to run.

Thanks,
Saravana

