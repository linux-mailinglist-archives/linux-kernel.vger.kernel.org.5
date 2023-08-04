Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E76DE76F883
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 05:51:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232651AbjHDDv3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 23:51:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231978AbjHDDv0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 23:51:26 -0400
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com [IPv6:2607:f8b0:4864:20::c36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 842263A90
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 20:51:25 -0700 (PDT)
Received: by mail-oo1-xc36.google.com with SMTP id 006d021491bc7-56c7f47ec42so1168483eaf.2
        for <linux-kernel@vger.kernel.org>; Thu, 03 Aug 2023 20:51:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1691121085; x=1691725885;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JSzyS/8QDxaBmoh6cg105AeIeBXiO4nIyKUfP9vsFzc=;
        b=WQbJIThImMarcyGQlEN/8FtuordeVU6E9ErnK4vjh4FXdX5CRjpvu95MQed50dNH3G
         aLqGjdw0aPaMrkfFQv6w8ani7pu6gr4YnIprqlCw7b1yG701PdS99MgGWDmCAcALVIod
         DiEt7vj2BOkoYWb3Eao7aoW9fQSKZn5peeZ0w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691121085; x=1691725885;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JSzyS/8QDxaBmoh6cg105AeIeBXiO4nIyKUfP9vsFzc=;
        b=KM2qWJhRbxfb8Q0KwJHjwF9ZSWPEAvUt9yCXYf5a6YeO9keJWua+rqgoz1/k2EPDI4
         kT4f+UlJj85y0JpnFIYMzDi78UhQWSmXIJ0TmKSBc7S1vjLkRBlhR3bP1XW6gmd34rYw
         Meqq439dLSU/kCXWHagkr4GMocHysPk3HiKhumaXg9gF9yHtjCJpKm378Xv2iBn0p5+m
         t56zwZ25fO/Dth11y8yGgpLSSA3uU0TL2EVQ0Mv0oTBVocs6o4bE+FzuyjpGAf3qHpWM
         x3+fpxt1VZdgMqyZvpEuNpQ5mpaGDtIQszWwjb8+nFP0WwNMGA5cudgImhql9Hu8GmzZ
         5t2Q==
X-Gm-Message-State: AOJu0YzKlsg2gQ+tIyfw7lh17UaXYmNr2OuTaFyjGmt0vkOGD6JSiPPO
        lVCPyUzJXIAmqwCebZ+rmD6RSkdTyD0le77fGmhhnw==
X-Google-Smtp-Source: AGHT+IGd9sgF9re2L4SQZEvHLIkMXuQPNpn5tp3DuVzgyWCFx+ihM07cpiK5TnUZd1jGswMvgi1MuX+04tuKTBkKoLc=
X-Received: by 2002:a05:6358:e49a:b0:132:d517:2409 with SMTP id
 by26-20020a056358e49a00b00132d5172409mr616130rwb.9.1691121084739; Thu, 03 Aug
 2023 20:51:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230714081408.274567-1-wenst@chromium.org> <76c7a68f-a448-cda1-ef4f-81a4ddf36dc1@gmail.com>
In-Reply-To: <76c7a68f-a448-cda1-ef4f-81a4ddf36dc1@gmail.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Fri, 4 Aug 2023 11:51:13 +0800
Message-ID: <CAGXv+5GawbwA4OVf33vGv3wt-RSQwBEb7E3Jsm=6H5owq2Hyxw@mail.gmail.com>
Subject: Re: [PATCH v3] regulator: Use bitfield values for range selectors
To:     Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Cristian Ciocaltea <cristian.ciocaltea@gmail.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        David Laight <David.Laight@aculab.com>,
        linux-actions@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 2, 2023 at 2:50=E2=80=AFPM Matti Vaittinen <mazziesaccount@gmai=
l.com> wrote:
>
> On 7/14/23 11:14, Chen-Yu Tsai wrote:
> > Right now the regulator helpers expect raw register values for the rang=
e
> > selectors. This is different from the voltage selectors, which are
> > normalized as bitfield values. This leads to a bit of confusion. Also,
> > raw values are harder to copy from datasheets or match up with them,
> > as datasheets will typically have bitfield values.
> >
> > Make the helpers expect bitfield values, and convert existing users. Th=
e
> > field in regulator_desc is renamed to |linear_range_selectors_bitfield|=
.
> > This is intended to cause drivers added in the same merge window and
> > out-of-tree drivers using the incorrect variable and values to break,
> > preventing incorrect values being used on actual hardware and potential=
ly
> > producing magic smoke.
> >
> > Also include bitops.h explicitly for ffs(), and reorder the header incl=
ude
> > statements. While at it, also replace module.h with export.h, since the
> > only use is EXPORT_SYMBOL_GPL.
> >
> > Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> > ---
> > Changes since v2:
> > - Changed .linear_range_selectors to .linear_range_selectors_bitfield,
> >    as suggested by David
> > - Dropped Matti's Reviewed-by due to this intrusive change
>
> Sorry for late reply, I assume this is already merged... I was mostly
> offline for a month or so - I can recommend, works wonders ;)

I'm sure it does, but I dread the part of coming back afterwards and
having to catch up with a month's worth of mail and development :S

> Just wanted to say (and in case this is not yet merged) - still looks
> good to me (helpers and bd718x7 parts).

Thanks!
