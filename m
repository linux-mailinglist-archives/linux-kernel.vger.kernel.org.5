Return-Path: <linux-kernel+bounces-65196-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9E7E854946
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 13:35:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C8AF1F2427C
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 12:35:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E20EA524CF;
	Wed, 14 Feb 2024 12:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hg3G8MWx"
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6C1E524C2;
	Wed, 14 Feb 2024 12:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707914150; cv=none; b=jh5C2JD6JgNkoThEYHkjCgDxHOJScbqOr3q75wDVq3twqwlz4o6A8r7XEp/K75DEaFs4ih2dekBHmEH4i5k4tj3bJbifJMdv0AxfRAFcbhrb4CzrRL9jBJkbm4xiXTUka5KmUrX/myX2p6Wtx4Jcp6s1JI36jjNjdwrAJxKo+D4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707914150; c=relaxed/simple;
	bh=hPoElhL1cWn5imNJJY6Az5vPc9ieKDZyk2fjNSIhrkQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CPja8YR2qj5rt0jQlpVzD9Kms9KRteTb97tefATrhnCvOITpU3erCT00isn5SwBIjomEXyy5lMH8CDFwvWRy7jCs/VLlVNpNDRme5mJbNs2DxFknX4UzbABrYjP5+k7wEmz3gC5YGiFswffr2EgbCBnELDTaafwCmskyB513Tyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hg3G8MWx; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-5ca29c131ebso3858580a12.0;
        Wed, 14 Feb 2024 04:35:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707914148; x=1708518948; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KuQsJK3xx4vzJDNKSqqrpk7uzcrIY6fu81NCi7MHe2w=;
        b=hg3G8MWxQQ1pdPt57ecuCzR/d9OSaeRjNNKF0z1lNh8tr/Kp3uU3DDLuM9a3CGAMWh
         pIny7MEdPrOszfQcD8x2peUcM7l9wZXmDclvGP1cQQBesn9VlhlffR5CBnPoChr4uD8c
         tZP1sUvXiIJaAuWG2lbpWKLSvTpIywt61/qB5SswegCn7GgUULuyrOrYV2UOBMmzH1Le
         fbZ8bqWDER03MEs/O8qHC5FIdwSkKSNY+Bb91InejpWtxVDrpwYK4dlXMJ/JQlmHl1iv
         tvX6Dcgt7ogBm7X04kMMGfTzj5/1k0WDgJqfbuUpvcz3sp4RLP4/DHfCeAz49BVvc1MB
         9zjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707914148; x=1708518948;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KuQsJK3xx4vzJDNKSqqrpk7uzcrIY6fu81NCi7MHe2w=;
        b=s8OEw3w9haVTllmK1LPrPDFTDxFecNkzyMeL8A5MXh4lO39FDL5p/1Q6tYZ0cCEsT6
         KCOOqDJzPAe8crDsRka4PRjpHRziLe3pItojNODyGDu7gcIC1ljm3HyeFsahiUGfgQNY
         ruQ9bTLNzXuaO1POOilKrzkh8bbsltQqR9+H/tG6XB0jwa1lXD35NAGQWJd4Iko6Tsiv
         fkfsCiKac46yCuMmVn+2CFcJguhWQAHy30t8WtusURaUAZk3o5YzZefeCw4gOO0/mD7N
         YHoRH4WBzr86Dk82I+IXOyvZchEq7ja+FkzHUQBEiNhIIT+5EHPHu8VP0TxUBjdUql1O
         Ualg==
X-Forwarded-Encrypted: i=1; AJvYcCUaQw52kWuF82VbaukUR2sxp7dkJcD3pWx6eDMo8m3NyyWneAy3W4KOheHKnnMuLq7YRNl+k/hwzZQslW7qnPK7gpDDwE98cvJEkiQRdRKb99ooeMb335uz7twpODLswJxGgiub/BeKbw==
X-Gm-Message-State: AOJu0Ywj0YE9BDTLIHURsOHpQjbd0lYPambvJA0P2rzwVtEz2kHnW+ZA
	COLRO7s9r9GjoYLJ74YTac9F8ZxodGMa2h3JFE8ihr4DFPb0jtSLtwAk+XmCw3+l0GWJUjy6gyl
	ljbVnSZ7Av10QXYaPqvCl2eqVSz1aUUmsE62Rcg==
X-Google-Smtp-Source: AGHT+IER90ym3bDK7JudSoNNudRE0z+M1P+V1ivLZu6NX3UJfAamDs2NQ97Mj+3rkSkXqNsZ2saJSmewlkm0u0vVcRk=
X-Received: by 2002:a17:90a:5d08:b0:298:a9a5:48ba with SMTP id
 s8-20020a17090a5d0800b00298a9a548bamr2462478pji.20.1707914147948; Wed, 14 Feb
 2024 04:35:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240210204606.11944-1-aford173@gmail.com> <20240210204606.11944-3-aford173@gmail.com>
 <20240214121448.451e2e1c@booty>
In-Reply-To: <20240214121448.451e2e1c@booty>
From: Adam Ford <aford173@gmail.com>
Date: Wed, 14 Feb 2024 06:35:36 -0600
Message-ID: <CAHCN7xKa3svzoRiQZ=KO-zwpmXL7Dw7hOp7B0MF-2EQCQ=f-eA@mail.gmail.com>
Subject: Re: [PATCH V4 2/6] phy: freescale: add Samsung HDMI PHY
To: Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: linux-arm-kernel@lists.infradead.org, marex@denx.de, 
	aford@beaconembedded.com, Lucas Stach <l.stach@pengutronix.de>, 
	Richard Leitner <richard.leitner@skidata.com>, Marco Felsch <m.felsch@pengutronix.de>, 
	Alexander Stein <alexander.stein@ew.tq-group.com>, 
	Frieder Schrempf <frieder.schrempf@kontron.de>, Vinod Koul <vkoul@kernel.org>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, 
	NXP Linux Team <linux-imx@nxp.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, linux-phy@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 14, 2024 at 5:14=E2=80=AFAM Luca Ceresoli <luca.ceresoli@bootli=
n.com> wrote:
>
> On Sat, 10 Feb 2024 14:45:58 -0600
> Adam Ford <aford173@gmail.com> wrote:
>
> > From: Lucas Stach <l.stach@pengutronix.de>
> >
> > This adds the driver for the Samsung HDMI PHY found on the
> > i.MX8MP SoC. Based on downstream implementation from
> > Sandor Yu <Sandor.yu@nxp.com>.  According to the TRM, the PHY
> > receives parallel data from the link and serializes it.  It
> > also sets the PLL clock needed for the TX serializer.
> >
> > Tested-by: Luca Ceresoli <luca.ceresoli@bootlin.com> (v2)
> > Tested-by: Richard Leitner <richard.leitner@skidata.com> (v2)
> > Co-developed-by: Marco Felsch <m.felsch@pengutronix.de>
> > Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
> > Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> > Tested-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> > Tested-by: Frieder Schrempf <frieder.schrempf@kontron.de> # Kontron BL
> > Tested-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
> > Signed-off-by: Adam Ford <aford173@gmail.com>
>
> [...]
>
> > +static int phy_clk_register(struct fsl_samsung_hdmi_phy *phy)
> > +{
> > +     struct device *dev =3D phy->dev;
> > +     struct device_node *np =3D dev->of_node;
> > +     struct clk_init_data init;
> > +     const char *parent_name;
> > +     struct clk *phyclk;
> > +     int ret;
> > +
> > +     parent_name =3D __clk_get_name(phy->refclk);
> > +
> > +     init.parent_names =3D &parent_name;
> > +     init.num_parents =3D 1;
> > +     init.flags =3D 0;
> > +     init.name =3D "hdmi_pclk";
> > +     init.ops =3D &phy_clk_ops;
> > +
> > +     phy->hw.init =3D &init;
> > +
> > +     phyclk =3D devm_clk_register(dev, &phy->hw);
> > +     if (IS_ERR(phyclk))
> > +             return dev_err_probe(dev, PTR_ERR(phyclk),
> > +                                  "failed to register clock\n");
> > +
> > +     ret =3D of_clk_add_provider(np, of_clk_src_simple_get, phyclk);
>
> As per my v8 review, this function is deprecated:
> https://elixir.bootlin.com/linux/v6.8-rc4/source/drivers/clk/clk.c#L4881
>

When I found out that the entire driver I pulled was the wrong
starting point, and noticed that this version had very little in
common with the previous one, I didn't review the feedback knowing tha
tI would have thrown away any of the tags from it since it was such a
drastic change.  I should have caught it, but I missed it, so
apologies for that.  I will be sure to include this feedback in the
next attempt.


> However:
>
> [Tested using Avnet MSC SM2S-IMX8PLUS SoM on Avnet MSC SM2-MB-EP1]
> Tested-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

Thanks for testing.

adam
>
> Luca
>
> --
> Luca Ceresoli, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com

