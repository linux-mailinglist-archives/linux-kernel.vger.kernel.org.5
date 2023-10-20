Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C06E7D1498
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 19:12:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377710AbjJTRMI convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 20 Oct 2023 13:12:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229889AbjJTRMH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 13:12:07 -0400
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6363ECA;
        Fri, 20 Oct 2023 10:12:05 -0700 (PDT)
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-584081ad442so95303eaf.0;
        Fri, 20 Oct 2023 10:12:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697821924; x=1698426724;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XSf0OWPH0GXx7qZCyOJ1mhypJ8iy5vrrvnjabt+66lE=;
        b=HgKu8rd7GkyNqDeaWEZvYOLXB6g15tTy2rkkoWjoR+9YOMTcFfRnp3tdmHcz/HPnM6
         CFTURVKfj3LNur2oaDKW49Z9V8BLEONMwoECUOTUK3UEt5KJbqQ+YjmX+JG2nlMqWtuf
         fpcMmMmWToYPCHzZFQ6pxrtIKTTxyL6cu1H23wEvl+OEd+ekbmN+/RfiebKXRaMkytGH
         oV/lJZ4BxMm6BRj4x1TpWvciwLiAhgGdwxWArnC8IyEhgPc7skh944NjGne6b63Or0H9
         b10QJcM3m6kqvXusqeAReujkVCrzfd4npYx+PMOMeAgvz0IfygzUD9GFFICP2ykuMF35
         HhyQ==
X-Gm-Message-State: AOJu0YztE7wsV1BDrJhd5CiwisbKr0L7CqNVyTQMaEXepmAjs/6Js0Mr
        s3+qU1DDLuwvEF4iqD2AG/U4Ox9DjrD00e0ejx4=
X-Google-Smtp-Source: AGHT+IHz95bXMdbA0rsyGICD4nQDIXUlkPK1i4VtFqbmPJqzrw3lQedFI/CTB5Bsh07Da/AeNeIUE1IbFvfJL21La/U=
X-Received: by 2002:a4a:e7d1:0:b0:583:ec88:e0 with SMTP id y17-20020a4ae7d1000000b00583ec8800e0mr2723050oov.0.1697821924575;
 Fri, 20 Oct 2023 10:12:04 -0700 (PDT)
MIME-Version: 1.0
References: <20231020084732.17130-1-raag.jadav@intel.com> <20231020084732.17130-5-raag.jadav@intel.com>
 <ZTJYK02w8HZg26eI@smile.fi.intel.com> <ZTJmnv6CsZUt0pIS@black.fi.intel.com>
In-Reply-To: <ZTJmnv6CsZUt0pIS@black.fi.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 20 Oct 2023 19:11:53 +0200
Message-ID: <CAJZ5v0jvAeibnXSq92CBd1uXUgRnvsP0kEqfL8Du552=LT1dog@mail.gmail.com>
Subject: Re: [PATCH v1 4/8] ACPI: utils: use acpi_dev_uid_match() for matching _UID
To:     Raag Jadav <raag.jadav@intel.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        rafael@kernel.org, len.brown@intel.com, robert.moore@intel.com,
        mika.westerberg@linux.intel.com, mark.rutland@arm.com,
        will@kernel.org, linux@roeck-us.net, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        acpica-devel@lists.linuxfoundation.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-hwmon@vger.kernel.org,
        mallikarjunappa.sangannavar@intel.com, bala.senthil@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 20, 2023 at 1:38 PM Raag Jadav <raag.jadav@intel.com> wrote:
>
> On Fri, Oct 20, 2023 at 01:36:27PM +0300, Andy Shevchenko wrote:
> > On Fri, Oct 20, 2023 at 02:17:28PM +0530, Raag Jadav wrote:
> > > Convert manual _UID references to use standard ACPI helpers.
> >
> > Yes, while not so obvious this is the correct replacement.
> > Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>
> I think this is the only case which would suffer from the more obvious
> behaviour, i.e.
>
> bool acpi_dev_uid_match(struct acpi_device *adev, const char *uid2)
> {
>         const char *uid1 = acpi_device_uid(adev);
>
>         return uid1 && uid2 && !strcmp(uid1, uid2);
> }
>
> That said, we can't be particularly sure about it's potential future users,
> especially when the usage will not be limited to just ACPI core since we're
> exporting it.

I actually agree with this, so please switch over to the above.

The above is straightforward and easy to understand and if somebody
wants to treat uid2 == NULL as a match, let them check that explicitly
before calling this function.
