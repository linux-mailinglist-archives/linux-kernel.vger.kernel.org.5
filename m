Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B9D17B6AE9
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 15:51:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237393AbjJCNvb convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 3 Oct 2023 09:51:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232068AbjJCNva (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 09:51:30 -0400
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AECE5A6
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 06:51:27 -0700 (PDT)
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-6bc57401cb9so202176a34.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Oct 2023 06:51:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696341087; x=1696945887;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4HUgt17OFEhb9rcSXf7tWTR4CCIRUcfN3jzW9uvMrWE=;
        b=kB5OEuOSDSt9mCJxQ2VJoMTGN5zbPrKMoGOnH0LtSys9tO9MMp3EEAUoB7dinm9AYK
         almicQp8mDJdAy0OWDGDn/6V2atTvFHRg3Ap729Lsbjw8jijm3D1WVOe5Xtbt6nPpTa1
         YV9QIE2OFvpzQiZiRk7/EXQX4CyCjjN4le2/RVP1AAHTPSJQUflX1TcDZWdBv4jtC4Ib
         P9jyLWdZQv98hS/2wBYwySoxD+6nJq06Qs7Mkype6NLeQHIsyJlqNmJANHjyQdx2YmwW
         49GKXtPcuXfZIRG8ftrXWKoLk2E8VIDJR+wLFBzlmipnHJa0xUucMWPhDcSoXD5Y9+ff
         +RzQ==
X-Gm-Message-State: AOJu0YyagzhQqFL0XC5p6PwZyOd+ku8zjPaC4MiTtMm9EmY3gHw668hF
        Ju2WQuux7pjpT5hKxVRrkn5Ih6qxhADVVP/uVkMg3gx+
X-Google-Smtp-Source: AGHT+IG84rISyrfnp/k89hhLUxJUWr1q8TmM0AGEwUyw/oUxT9NWecgoQPvGyjVs1L3Grnpk3yexW6Eow9Bbj58FZoU=
X-Received: by 2002:a05:6808:2029:b0:3a9:e85d:b689 with SMTP id
 q41-20020a056808202900b003a9e85db689mr16958494oiw.0.1696341086920; Tue, 03
 Oct 2023 06:51:26 -0700 (PDT)
MIME-Version: 1.0
References: <20231002135218.2602969-1-andriy.shevchenko@linux.intel.com> <29d92a79-cfc5-41f1-b930-8789ad17fdda@amd.com>
In-Reply-To: <29d92a79-cfc5-41f1-b930-8789ad17fdda@amd.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 3 Oct 2023 15:51:15 +0200
Message-ID: <CAJZ5v0hULhbDwziVfCt4rc-TO74zaB2H3a928RGgJmA=qfK63w@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] ACPI: x86: s2idle: Switch to use acpi_evaluate_dsm_typed()
To:     Mario Limonciello <mario.limonciello@amd.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, Len Brown <lenb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 2, 2023 at 4:05 PM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> On 10/2/2023 08:52, Andy Shevchenko wrote:
> > The acpi_evaluate_dsm_typed() provides a way to check the type of the
> > object evaluated by _DSM call. Use it instead of open coded variant.
> >
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>
> Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>

Applied as 6.7 material, thanks!

> > ---
> >   drivers/acpi/x86/s2idle.c | 5 ++---
> >   1 file changed, 2 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/acpi/x86/s2idle.c b/drivers/acpi/x86/s2idle.c
> > index 08f7c6708206..7d64e655f1b8 100644
> > --- a/drivers/acpi/x86/s2idle.c
> > +++ b/drivers/acpi/x86/s2idle.c
> > @@ -417,11 +417,10 @@ static int validate_dsm(acpi_handle handle, const char *uuid, int rev, guid_t *d
> >       int ret = -EINVAL;
> >
> >       guid_parse(uuid, dsm_guid);
> > -     obj = acpi_evaluate_dsm(handle, dsm_guid, rev, 0, NULL);
> >
> >       /* Check if the _DSM is present and as expected. */
> > -     if (!obj || obj->type != ACPI_TYPE_BUFFER || obj->buffer.length == 0 ||
> > -         obj->buffer.length > sizeof(u32)) {
> > +     obj = acpi_evaluate_dsm_typed(handle, dsm_guid, rev, 0, NULL, ACPI_TYPE_BUFFER);
> > +     if (!obj || obj->buffer.length == 0 || obj->buffer.length > sizeof(u32)) {
> >               acpi_handle_debug(handle,
> >                               "_DSM UUID %s rev %d function 0 evaluation failed\n", uuid, rev);
> >               goto out;
>
