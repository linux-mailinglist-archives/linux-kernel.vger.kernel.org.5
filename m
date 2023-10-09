Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 430BC7BDACC
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 14:11:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346529AbjJIMLn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 08:11:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346508AbjJIMLL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 08:11:11 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF0B5101
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 05:11:09 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 635CDC433D9
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 12:11:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696853469;
        bh=O5Eyu+7ebS6ij1JeR18kMtBx+5nptFV99l+SE3oEw2M=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=H3gaGX49GSdZbinakE1A9jdt1T5xkva9Ny7nBfzQxKkrEAXgf+JA1eVH2LEns0xhL
         qZt1AAtctUlghWVP2VSwoN2aFaY+ms3g+pz53qdmCPv2UJ9tdR1ejv5FybTsHG/8Bu
         nC6IhLLHZjs1uwiCrvWBWP/xELDaYktpet/ZsoXLzOu9huUNx2QSNr/DN1+gv0cFVt
         g/TpaB4VcBYX0e7v8/F7KIZNKWQJVyT03K8wKtVGzNZxsxAqPtGllnKQjyL5ISQcI4
         B21HcVK9jsyye6JtkLGzkMRCAZD+EwKADMu3ukLUCMfevbA4YBDMSwfeTT2zdgX4+X
         H1qppOwWT4DRA==
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5042bfb4fe9so5344243e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Oct 2023 05:11:09 -0700 (PDT)
X-Gm-Message-State: AOJu0YxfHAa6R7591Bnv7zTESh6gvZ1SFMf+7L2xuT4oU1QlkYzvNsFs
        orSS/W5UCoG91FbaZkO+U2dy8kF2c+INroEovw==
X-Google-Smtp-Source: AGHT+IH65m+BXpoocmeysWEfasBVdgZ+bt7f8dAcShRFtlENg6x6XNsJlPtF3QacZODMnThA3w2qWMAEliwgEjciR2Q=
X-Received: by 2002:a05:6512:68a:b0:505:73e7:b478 with SMTP id
 t10-20020a056512068a00b0050573e7b478mr15683718lfe.16.1696853467481; Mon, 09
 Oct 2023 05:11:07 -0700 (PDT)
MIME-Version: 1.0
References: <20231006224402.442078-1-robh@kernel.org> <aaf40c3c-a7cc-4556-bb80-f9149327bb7a@linaro.org>
In-Reply-To: <aaf40c3c-a7cc-4556-bb80-f9149327bb7a@linaro.org>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 9 Oct 2023 07:10:54 -0500
X-Gmail-Original-Message-ID: <CAL_JsqK_69+4ZXrg78xf2apvvt_VRHquR2ThjOGkyQZKz655gg@mail.gmail.com>
Message-ID: <CAL_JsqK_69+4ZXrg78xf2apvvt_VRHquR2ThjOGkyQZKz655gg@mail.gmail.com>
Subject: Re: [PATCH] memory: Use device_get_match_data()
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@tuxon.dev>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 8, 2023 at 6:33=E2=80=AFAM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 07/10/2023 00:44, Rob Herring wrote:
> > Use preferred device_get_match_data() instead of of_match_device() to
> > get the driver match data. With this, adjust the includes to explicitly
> > include the correct headers.
> >
> > Signed-off-by: Rob Herring <robh@kernel.org>
> > ---
>
> ...
>
> >  enum ccf_version {
> >       CCF1,
> > @@ -172,14 +170,9 @@ static irqreturn_t ccf_irq(int irq, void *dev_id)
> >  static int ccf_probe(struct platform_device *pdev)
> >  {
> >       struct ccf_private *ccf;
> > -     const struct of_device_id *match;
> >       u32 errinten;
> >       int ret, irq;
> >
> > -     match =3D of_match_device(ccf_matches, &pdev->dev);
> > -     if (WARN_ON(!match))
> > -             return -ENODEV;
> > -
> >       ccf =3D devm_kzalloc(&pdev->dev, sizeof(*ccf), GFP_KERNEL);
> >       if (!ccf)
> >               return -ENOMEM;
> > @@ -189,7 +182,7 @@ static int ccf_probe(struct platform_device *pdev)
> >               return PTR_ERR(ccf->regs);
> >
> >       ccf->dev =3D &pdev->dev;
> > -     ccf->info =3D match->data;
> > +     ccf->info =3D device_get_match_data(&pdev->dev);
>
> This part is no equivalent. You miss here if (WARN_ON(!ccf->info)).

Checking for match failed was pointless. We already matched in order
to probe and DT is the only way we match.

Rob
