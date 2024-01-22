Return-Path: <linux-kernel+bounces-34098-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12D9483736F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 21:02:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3734F1C2402C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 20:02:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF3C2405EA;
	Mon, 22 Jan 2024 20:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="elCw2513"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CD12405C0
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 20:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705953743; cv=none; b=QJM9MBfs3Ob3rYeRx8SFcWbvqSljn9u0lawdSuScpopKW3GWgFMDpA0CPcIbvhENhEiXWZKzbPWsRzHRZrQ2P65t2P1kMTZp7n4RPMUl3LrHmbbFh3C5ess+xoiq0uPks10fkMs0DD2oioXcrwDF1TS6rZ0MnLMqHVR9N6F82wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705953743; c=relaxed/simple;
	bh=VdkhAorzBPaH/4Q+W05lpm+qjGuxdMhhs5V7dPnuTyo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f2jqwSqtA1oL8xzoeSXVAKZ8yWXmrPXjZ1vmY99V+jaZONljWl+gVeMoatg/km+LgmWvvseiMGuIBABBVy7HBpErbIXkjsmp/aRGfuIr+x70x9/5BIEAQUWjkIczMozPWXrWWbBym7dmmdevigsaOrIYUHq5UaELuweGtQWry/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=elCw2513; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-339261a6ec2so2103666f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 12:02:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705953739; x=1706558539; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=S9XdGfwCaFqRS40nSS7oXOASpHTiWciWWg6+rB3mocA=;
        b=elCw25134BVwV6RfN8JXNOtKbmsUpYd9YOysB48fI+PXuloobbPgxSM/0B2C2aKpt9
         4LMN2D99w+NSPQ15mVlRQ4L+M1mz8FbFLmBELaBXgsUXnGmb+OQmrKB1tx1fhtUmu8/n
         6awumyw2WUuhsfW3OfTP+ZMEo//RzIwRiDw/lXxecpMsxNjrdUc0r22ZcOz4BVcWs4lf
         ALrgNZ9b7qbzZjOWA3zOM0kYjLKHNEu7Q6t7pTM+3gBkseXgdhetnRmgtdGdseVZF+C1
         K2YvF3du/hSW/FHbyaorOFTUcfnkbcjHV2zAkvC5QpYX2jjO6hAUb7ip5v3jc2jdYevt
         94BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705953739; x=1706558539;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S9XdGfwCaFqRS40nSS7oXOASpHTiWciWWg6+rB3mocA=;
        b=j2LmrYP27kVhnhQKPiM1VRuBa9efUqf5ttretgfmTAn51qeQ8pLN2kcR9mFDzHb6uq
         Ip0jv2idzWqyiMDrdqoGBpbrrvjoA3V5kNR0suEsY4N5UN921C+N3UggqdrDh27CbCzu
         VQ08+Q/q4K++wKPzag6VLGPcXllhIuFAhJPkZ+1G9qi2BnvgzssJ3XSiraDVXA5BEB2b
         WhkP1xgis2uXjCmCWypG3bsHkqteaih+hdcJkBh6Ce8oAqkTtNtebWbWbtg9DxJAR/UL
         Nb3N0pDbrSILIStkW5JT46SssH6OZHFkxz/UH9p/4Pa269Xge6+CJKOazqUwXWybq8dN
         gQFQ==
X-Gm-Message-State: AOJu0YymRRQIAfFXh32vCbyqmVMEIl6Gfc+NLiHQHzetE2TYAGMwnELK
	OnTEk2B2DW/bCpL/KWmbz6uDxgXxusTXUxlv/SroRwBQxFfzFo3PEmFg15Km34VoGlJsO0zz1RM
	aQf+QNpkEjCbAwrxeWXLTRpIWR4NDCb4iorAC+Q==
X-Google-Smtp-Source: AGHT+IEP0LsFZ1DHoUGKiydzMLgHty4VJtBb5guXu8UbilwyiD38/IJiB6McSbbUFrxTg/eiRG2KWw2gTlp8GlSr0/A=
X-Received: by 2002:adf:e68b:0:b0:337:6e32:1811 with SMTP id
 r11-20020adfe68b000000b003376e321811mr2954342wrm.75.1705953739678; Mon, 22
 Jan 2024 12:02:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240105160103.183092-1-ulf.hansson@linaro.org>
 <20240105160103.183092-4-ulf.hansson@linaro.org> <87801f3e-b7ce-46ba-9856-1321635a11b5@nxp.com>
In-Reply-To: <87801f3e-b7ce-46ba-9856-1321635a11b5@nxp.com>
From: Mathieu Poirier <mathieu.poirier@linaro.org>
Date: Mon, 22 Jan 2024 13:02:08 -0700
Message-ID: <CANLsYkwtNa_-t0f5rhTh5mtF72urKNyqWk0_qfbBwSCQK_6eOg@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] remoteproc: imx_rproc: Convert to dev_pm_domain_attach|detach_list()
To: Iuliana Prodan <iuliana.prodan@nxp.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
	linux-pm@vger.kernel.org, Sudeep Holla <sudeep.holla@arm.com>, 
	Kevin Hilman <khilman@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Bjorn Andersson <andersson@kernel.org>, Nikunj Kela <nkela@quicinc.com>, 
	Prasad Sodagudi <psodagud@quicinc.com>, Stephan Gerhold <stephan@gerhold.net>, 
	Ben Horgan <Ben.Horgan@arm.com>, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-remoteproc@vger.kernel.org, 
	linux-media@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Daniel Baluta <daniel.baluta@nxp.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 22 Jan 2024 at 10:51, Iuliana Prodan <iuliana.prodan@nxp.com> wrote:
>
> On 1/5/2024 6:01 PM, Ulf Hansson wrote:
> > Let's avoid the boilerplate code to manage the multiple PM domain case, by
> > converting into using dev_pm_domain_attach|detach_list().
> >
> > Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> > Cc: Bjorn Andersson <andersson@kernel.org>
> > Cc: Shawn Guo <shawnguo@kernel.org>
> > Cc: Sascha Hauer <s.hauer@pengutronix.de>
> > Cc: Iuliana Prodan <iuliana.prodan@nxp.com>
> > Cc: Daniel Baluta <daniel.baluta@nxp.com>
> > Cc: <linux-remoteproc@vger.kernel.org>
> > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > ---
> >
> > Changes in v2:
> >       - None.
> >
> > Iuliana/Daniel I am ccing you to request help with test/review of this change.
> > Note that, you will need patch 1/5 in the series too, to be able to test this.
> >
> > Kind regards
> > Ulf Hansson
>
> Tested-by: Iuliana Prodan <iuliana.prodan@nxp.com>
> Reviewed-by: Iuliana Prodan <iuliana.prodan@nxp.com>
>

Thanks for the leg-work on this.  I'll pick this up in rc1 later this week.

> Iulia
>
> > ---
> >   drivers/remoteproc/imx_rproc.c | 73 +++++-----------------------------
> >   1 file changed, 9 insertions(+), 64 deletions(-)
> >
> > diff --git a/drivers/remoteproc/imx_rproc.c b/drivers/remoteproc/imx_rproc.c
> > index 8bb293b9f327..3161f14442bc 100644
> > --- a/drivers/remoteproc/imx_rproc.c
> > +++ b/drivers/remoteproc/imx_rproc.c
> > @@ -92,7 +92,6 @@ struct imx_rproc_mem {
> >
> >   static int imx_rproc_xtr_mbox_init(struct rproc *rproc);
> >   static void imx_rproc_free_mbox(struct rproc *rproc);
> > -static int imx_rproc_detach_pd(struct rproc *rproc);
> >
> >   struct imx_rproc {
> >       struct device                   *dev;
> > @@ -113,10 +112,8 @@ struct imx_rproc {
> >       u32                             rproc_pt;       /* partition id */
> >       u32                             rsrc_id;        /* resource id */
> >       u32                             entry;          /* cpu start address */
> > -     int                             num_pd;
> >       u32                             core_index;
> > -     struct device                   **pd_dev;
> > -     struct device_link              **pd_dev_link;
> > +     struct dev_pm_domain_list       *pd_list;
> >   };
> >
> >   static const struct imx_rproc_att imx_rproc_att_imx93[] = {
> > @@ -853,7 +850,7 @@ static void imx_rproc_put_scu(struct rproc *rproc)
> >               return;
> >
> >       if (imx_sc_rm_is_resource_owned(priv->ipc_handle, priv->rsrc_id)) {
> > -             imx_rproc_detach_pd(rproc);
> > +             dev_pm_domain_detach_list(priv->pd_list);
> >               return;
> >       }
> >
> > @@ -880,72 +877,20 @@ static int imx_rproc_partition_notify(struct notifier_block *nb,
> >   static int imx_rproc_attach_pd(struct imx_rproc *priv)
> >   {
> >       struct device *dev = priv->dev;
> > -     int ret, i;
> > -
> > -     /*
> > -      * If there is only one power-domain entry, the platform driver framework
> > -      * will handle it, no need handle it in this driver.
> > -      */
> > -     priv->num_pd = of_count_phandle_with_args(dev->of_node, "power-domains",
> > -                                               "#power-domain-cells");
> > -     if (priv->num_pd <= 1)
> > -             return 0;
> > -
> > -     priv->pd_dev = devm_kmalloc_array(dev, priv->num_pd, sizeof(*priv->pd_dev), GFP_KERNEL);
> > -     if (!priv->pd_dev)
> > -             return -ENOMEM;
> > -
> > -     priv->pd_dev_link = devm_kmalloc_array(dev, priv->num_pd, sizeof(*priv->pd_dev_link),
> > -                                            GFP_KERNEL);
> > -
> > -     if (!priv->pd_dev_link)
> > -             return -ENOMEM;
> > -
> > -     for (i = 0; i < priv->num_pd; i++) {
> > -             priv->pd_dev[i] = dev_pm_domain_attach_by_id(dev, i);
> > -             if (IS_ERR(priv->pd_dev[i])) {
> > -                     ret = PTR_ERR(priv->pd_dev[i]);
> > -                     goto detach_pd;
> > -             }
> > -
> > -             priv->pd_dev_link[i] = device_link_add(dev, priv->pd_dev[i], DL_FLAG_STATELESS |
> > -                                                    DL_FLAG_PM_RUNTIME | DL_FLAG_RPM_ACTIVE);
> > -             if (!priv->pd_dev_link[i]) {
> > -                     dev_pm_domain_detach(priv->pd_dev[i], false);
> > -                     ret = -EINVAL;
> > -                     goto detach_pd;
> > -             }
> > -     }
> > -
> > -     return 0;
> > -
> > -detach_pd:
> > -     while (--i >= 0) {
> > -             device_link_del(priv->pd_dev_link[i]);
> > -             dev_pm_domain_detach(priv->pd_dev[i], false);
> > -     }
> > -
> > -     return ret;
> > -}
> > -
> > -static int imx_rproc_detach_pd(struct rproc *rproc)
> > -{
> > -     struct imx_rproc *priv = rproc->priv;
> > -     int i;
> > +     int ret;
> > +     struct dev_pm_domain_attach_data pd_data = {
> > +             .pd_flags = PD_FLAG_DEV_LINK_ON,
> > +     };
> >
> >       /*
> >        * If there is only one power-domain entry, the platform driver framework
> >        * will handle it, no need handle it in this driver.
> >        */
> > -     if (priv->num_pd <= 1)
> > +     if (dev->pm_domain)
> >               return 0;
> >
> > -     for (i = 0; i < priv->num_pd; i++) {
> > -             device_link_del(priv->pd_dev_link[i]);
> > -             dev_pm_domain_detach(priv->pd_dev[i], false);
> > -     }
> > -
> > -     return 0;
> > +     ret = dev_pm_domain_attach_list(dev, &pd_data, &priv->pd_list);
> > +     return ret < 0 ? ret : 0;
> >   }
> >
> >   static int imx_rproc_detect_mode(struct imx_rproc *priv)

