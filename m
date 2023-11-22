Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAE547F452E
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 12:55:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343930AbjKVLz6 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 22 Nov 2023 06:55:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343577AbjKVLzz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 06:55:55 -0500
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A87591;
        Wed, 22 Nov 2023 03:55:51 -0800 (PST)
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-6d7e89d48efso185584a34.1;
        Wed, 22 Nov 2023 03:55:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700654150; x=1701258950;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WnzgeFjuBItEyIVZYQBtxAG5TnFPC1Nz+dshenAaKC4=;
        b=lzt82JqMXjDrjKJqHRcWEA/7DdYOKdCXfv0OjcAjDCUtyn8f46u/eWRV60hAIwjiWG
         /nrhSAz8uO1D5UjpYAGUeT2+uJzkORhbjr+nItSuOWLD5Y2TGrEyaD01ho0ytOPweSkP
         ICtSwB+wetkNHSk90lPb6DmC43BaOVClPHHtQf9hDZ6gHqE5ybP4ziSwSBAszRKhSwnU
         iIZyNxeQFl6bzMAdWrfJNYPakW/d5IrowTHv14o5JZwZq1RpT6WXPWBNMNPuPFehvhXj
         VCp/ovpyUodYf9yxr9DYK/cDBZ346SUJ04QpB4OGmkT1Zf5WCuyggt2WbL+JhEBUD0Ec
         Z+UA==
X-Gm-Message-State: AOJu0YyTItu35it00JXMIxLLi35OvFJu8qFYWQKurg2/B1siWKEtLXbm
        0aExfWNgqrE4MN7Rybx1omCzK3YV3pbAM/MgNso=
X-Google-Smtp-Source: AGHT+IFxwoExJhSMBRxQTHXgD/nLHO3yL8dtRUR3JO04lud2KKUHrAdJ364xYPIIbgEneIKFFci7Dqs2zGd+NVIwZF0=
X-Received: by 2002:a05:6870:a924:b0:1f4:d544:2490 with SMTP id
 eq36-20020a056870a92400b001f4d5442490mr2623563oab.4.1700654150597; Wed, 22
 Nov 2023 03:55:50 -0800 (PST)
MIME-Version: 1.0
References: <20231121103829.10027-1-raag.jadav@intel.com> <20231121103829.10027-3-raag.jadav@intel.com>
 <CAJZ5v0jmaRQWfO_mM4GZ8mEFftuSNgt36=tJ5vC2Uw7MAcpYJg@mail.gmail.com> <ZV2KYqah4FHH4tnz@black.fi.intel.com>
In-Reply-To: <ZV2KYqah4FHH4tnz@black.fi.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 22 Nov 2023 12:55:39 +0100
Message-ID: <CAJZ5v0gyuk-1vfpaRWO1wniYHwMp==Nx9KLVS42=39yXmqKq6Q@mail.gmail.com>
Subject: Re: [PATCH v2 2/6] ACPI: bus: update acpi_dev_uid_match() to support
 multiple types
To:     Raag Jadav <raag.jadav@intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        mika.westerberg@linux.intel.com, andriy.shevchenko@linux.intel.com,
        lenb@kernel.org, robert.moore@intel.com, ardb@kernel.org,
        will@kernel.org, mark.rutland@arm.com, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        acpica-devel@lists.linuxfoundation.org, linux-efi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        mallikarjunappa.sangannavar@intel.com, bala.senthil@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 22, 2023 at 5:58 AM Raag Jadav <raag.jadav@intel.com> wrote:
>
> On Tue, Nov 21, 2023 at 08:25:20PM +0100, Rafael J. Wysocki wrote:
> > On Tue, Nov 21, 2023 at 11:38 AM Raag Jadav <raag.jadav@intel.com> wrote:
> > >
> > > According to ACPI specification, a _UID object can evaluate to either
> > > a numeric value or a string. Update acpi_dev_uid_match() helper to
> > > support _UID matching for both integer and string types.
> > >
> > > Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > > Suggested-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> > > Suggested-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > You need to be careful with using this.  There are some things below
> > that go beyond what I have suggested.
>
> I think we all suggested some bits and pieces so I included everyone.
> We can drop if there are any objections.

There are, from me and from Andy.

[cut]

> > Up to this point it is all fine IMV.
> >
> > > +/**
> > > + * acpi_dev_uid_match - Match device by supplied UID
> > > + * @adev: ACPI device to match.
> > > + * @uid2: Unique ID of the device.
> > > + *
> > > + * Matches UID in @adev with given @uid2.
> > > + *
> > > + * Returns: %true if matches, %false otherwise.
> > > + */
> > > +
> > > +/* Treat uid as a string for array and pointer types, treat as an integer otherwise */
> > > +#define get_uid_type(x) \
> > > +       (__builtin_choose_expr(is_array_or_pointer_type(x), (const char *)0, (u64)0))
> >
> > But I wouldn't use the above.
> >
> > It is far more elaborate than needed for this use case and may not
> > actually work as expected.  For instance, why would a pointer to a
> > random struct type be a good candidate for a string?
>
> Such case will not compile, since its data type will not match with
> acpi_str_uid_match() prototype. The compiler does a very good job of
> qualifing only the compatible string types here, which is exactly what
> we want.
>
> error: passing argument 2 of 'acpi_str_uid_match' from incompatible pointer type [-Werror=incompatible-pointer-types]
>     if (acpi_dev_uid_match(adev, adev)) {
>                                  ^
> ./include/acpi/acpi_bus.h:870:20: note: expected 'const char *' but argument is of type 'struct acpi_device *'
>  static inline bool acpi_str_uid_match(struct acpi_device *adev, const char *uid2)

You are right, it won't compile, but that's not my point.  Why would
it be matched with acpi_str_uid_match() in the first place?

> > > +
> > > +#define acpi_dev_uid_match(adev, uid2)                         \
> > > +       _Generic(get_uid_type(uid2),                            \
> > > +                const char *: acpi_str_uid_match,              \
> > > +                u64: acpi_int_uid_match)(adev, uid2)
> > > +
> >
> > Personally, I would just do something like the following
> >
> > #define acpi_dev_uid_match(adev, uid2) \
> >         _Generic((uid2), \
> >                 const char *: acpi_str_uid_match, \
> >                 char *: acpi_str_uid_match, \
> >                 const void *: acpi_str_uid_match, \
> >                 void *: acpi_str_uid_match, \
> >                 default: acpi_int_uid_match)(adev, uid2)
> >
> > which doesn't require compiler.h to be fiddled with and is rather
> > straightforward to follow.
> >
> > If I'm to apply the patches, this is about the level of complexity you
> > need to target.
>
> Understood, however this will limit the type support to only a handful
> of types,

Indeed.

> and will not satisfy a few of the existing users, which, for
> example are passing signed or unsigned pointer or an array of u8.

Fair enough, so those types would need to be added to the list.

> Listing every possible type manually for _Generic() looks a bit verbose
> for something that can be simply achieved by __builtin functions in my
> opinion.

But then you don't even need _Generic(), do you?

Wouldn't something like the below work?

#define acpi_dev_uid_match(adev, uid2) \
        (__builtin_choose_expr(is_array_or_pointer_type((uid2)),acpi_str_uid_match(adev,
uid2), acpi_int_uid_match(adev, uid2))

In any case, I'm not particularly convinced about the
is_array_or_pointer_type() thing and so I'm not going to apply the
series as is.
