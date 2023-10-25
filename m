Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A210E7D7352
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 20:33:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233233AbjJYSdx convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 25 Oct 2023 14:33:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjJYSdv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 14:33:51 -0400
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A80CFDC;
        Wed, 25 Oct 2023 11:33:49 -0700 (PDT)
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-1ea1742c1a5so3742fac.0;
        Wed, 25 Oct 2023 11:33:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698258829; x=1698863629;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lS7dc6OeEagjVnOXqO7ndPxuPeYtv6s3DDu32hsvyZo=;
        b=EyMebHsnQSqqipkJMvdOvcWP9rZAOsfQvUnIbcDE3MSkeBNDpQ2OO9gnKGFiSfPTD4
         /nb7TeZIWdPNfUBEgQ3SCnv9ajvwapDzuIlIXjdbDSsVhiNzZlFxUbs5dXQ/ZJ3Qr3ex
         IJkH2TILovmO/fM5i1wzsL8pPYE8u+DX/YvntrSDwpRK3NxfrSN+zhmXAAr7gQW1c9+z
         4BHPhcXMg4J1qjVTazfiEN7soAwcSHUa+TJUFW3lbj5Z+0/pj/fALRTIAANHGaRMedJE
         JhB6MjbiTKePw2VVmHKjY0QaUwU4Js3rTfZt49r7M1aAi24EEniqCHT8PeG8ocYhDpxz
         nxww==
X-Gm-Message-State: AOJu0YzwBTgHD/bKyrGjLWRAx2aTaEW8dOJc1OqK1yFGWlOL8xRihvKS
        ifw6F4P5jkvXjOsnWxhcUqqJYtuIuYEzK4OQkJGliugno9E=
X-Google-Smtp-Source: AGHT+IGvOnfAlquQB4nxlxu/kS+7sHxNr5PLcWMwUNaRIF5Ci5hC2ktLAwVk9WM2JlIAH6NyRq60sK6OxQvi/Pz7ei0=
X-Received: by 2002:a05:6870:f60b:b0:1d0:e372:6cf8 with SMTP id
 ek11-20020a056870f60b00b001d0e3726cf8mr16666905oab.2.1698258828862; Wed, 25
 Oct 2023 11:33:48 -0700 (PDT)
MIME-Version: 1.0
References: <20231025053833.16014-1-raag.jadav@intel.com> <20231025055345.GI3208943@black.fi.intel.com>
 <CAJZ5v0iYA3Qh=KQm_+XGm=jvLO=ZN-AyYx7DW=-EiqkE5LS19Q@mail.gmail.com> <ZTlcmA0VpE2jsbUQ@black.fi.intel.com>
In-Reply-To: <ZTlcmA0VpE2jsbUQ@black.fi.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 25 Oct 2023 20:33:37 +0200
Message-ID: <CAJZ5v0j0qfzjikB1Pi-9mKX0rG3Hpw_cQuF421_ahFW9jjgJtA@mail.gmail.com>
Subject: Re: [PATCH v1] ACPI: LPSS: use acpi_dev_uid_match() for matching _UID
To:     Raag Jadav <raag.jadav@intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        len.brown@intel.com, andriy.shevchenko@linux.intel.com,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
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

On Wed, Oct 25, 2023 at 8:21 PM Raag Jadav <raag.jadav@intel.com> wrote:
>
> On Wed, Oct 25, 2023 at 08:04:44PM +0200, Rafael J. Wysocki wrote:
> > On Wed, Oct 25, 2023 at 7:53 AM Mika Westerberg
> > <mika.westerberg@linux.intel.com> wrote:
> > >
> > > On Wed, Oct 25, 2023 at 11:08:33AM +0530, Raag Jadav wrote:
> > > > Use acpi_dev_uid_match() for matching _UID instead of treating it
> > > > as an integer.
> > > >
> > > > Signed-off-by: Raag Jadav <raag.jadav@intel.com>
> > >
> > > Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> >
> > I was about to apply this, but then I realized that it might change
> > the behavior in a subtle way, because what if the _UID string is
> > something like "01"?
>
> I checked the git history and found below.
>
> commit 2a036e489eb1571810126d6fa47bd8af1e237c08
> Author: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Date:   Tue Sep 13 19:31:41 2022 +0300
>
>     ACPI: LPSS: Refactor _UID handling to use acpi_dev_uid_to_integer()
>
>     ACPI utils provide acpi_dev_uid_to_integer() helper to extract _UID as
>     an integer. Use it instead of custom approach.
>
>     Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>     Reviewed-by: Hans de Goede <hdegoede@redhat.com>
>     Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> diff --git a/drivers/acpi/acpi_lpss.c b/drivers/acpi/acpi_lpss.c
> index c4d4d21391d7..4d415e210c32 100644
> --- a/drivers/acpi/acpi_lpss.c
> +++ b/drivers/acpi/acpi_lpss.c
> @@ -167,10 +167,10 @@ static struct pwm_lookup byt_pwm_lookup[] = {
>
>  static void byt_pwm_setup(struct lpss_private_data *pdata)
>  {
> -       struct acpi_device *adev = pdata->adev;
> +       u64 uid;
>
>         /* Only call pwm_add_table for the first PWM controller */
> -       if (!adev->pnp.unique_id || strcmp(adev->pnp.unique_id, "1"))
> +       if (acpi_dev_uid_to_integer(pdata->adev, &uid) || uid != 1)
>                 return;
>
>         pwm_add_table(byt_pwm_lookup, ARRAY_SIZE(byt_pwm_lookup));
>
> So if we consider the original logic with strcmp, which is more inline
> with acpi_dev_uid_match(), "01" should not be the case here in my opinion.
>
> Thanks for sharing your concern though.

Well, this means that what the patch really does is to effectively
revert commit 2a036e489eb1571810126d6fa47bd8af1e237c08 and use the new
helper instead of the open-coded check that was there before, so all
of this information should be present in the changelog.
