Return-Path: <linux-kernel+bounces-43368-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2E448412C2
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 19:54:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 892FC286FD2
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 18:54:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CCAB2AD0F;
	Mon, 29 Jan 2024 18:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="de8JFTNe"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAD1B12E74
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 18:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706554443; cv=none; b=ut0ikcDBiGiigdxEB82coVME87kMDRw02Ga72lC5KhVtZJlnMz/yHigoC5A1g+LCCciPmn3zqjfp/1UjROfOL9s4s671KmRO5JUoRwoZCXIcOzeFxdvGAoc26ZvCtK+Nqh+jAv4kl0SX93moKwSha3lHz1LUD3z5pCFAuG6Mx0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706554443; c=relaxed/simple;
	bh=iORQqdsgAXU/6OLfQcR9INwEjc+sM0U03rlHuXCkIZw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PbXn1+zRUaHMQhFzgcg/dXqrkuf4YMzr74Oi0+w2u1rmHFFWvRQmpsHkUv4JmnaoqyQQnebLgsXg8tql5Yk1aNd+5kRfrgm7PIfKIQ64FOnndQroNc5htP8U7AEnz66+ut4tNbtQP6t0N9tF2lBpm7BBODCO2ABz2yIMX9Jx6s0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=de8JFTNe; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2d05551d07bso737011fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 10:54:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1706554439; x=1707159239; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v5pb/RdbVw3Kf4tzEOZ4aGKJHjbBHrewQL4TW3xzC3I=;
        b=de8JFTNeQD4DiRavNinHMdtkwsujEFowx6JTH0D+giVxNxSRzf/VhzLq33iRo5yFO1
         cUlgTAcMxYWYhNCQCxHzSbCpBrowLAv6w53cgweYMOW/EeR86HyEG/NDgyZU0lgGmTrZ
         mHIlcQSVSQO347pN6DvEsMjnLgRiP81FUaNnr24RKtxv8BOVmrcbo1c/rrWMfEBH6Ycj
         msElKlwBtTWG1VYmnKuv9zvXYKpggeYVBwqV01waynvTZRUxeetLnPJIvg4zw+Rfcw5c
         KzPOcbVkwJNuOklR2F1fjkGZVNRjPepTpufFMHUaelXMfmrA8U6M865aRab22HQwPn/d
         Kj/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706554439; x=1707159239;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v5pb/RdbVw3Kf4tzEOZ4aGKJHjbBHrewQL4TW3xzC3I=;
        b=Fyqv73T28lX7LyZql5VgVUNU4XU9AbMLr3ABzKEs3nRMT2wD6IgSMnQAxmXkcUFdwf
         VWZ/MmjjAs+E6T/6e5NiKITsvGhjO1sLoK6i8IVOFSWz4WD1CWiiV4KznF1S5DtTkaA3
         FJmWafelY0bdxf9S3pbXHNRPtWI3fWkqVeADYxQ1MMMZKy+6J/yRHmAmtYimbArYVK0v
         nBvV5tlfe3GdpDKDpCuzGiPLscips3rxcfiaSoQdbbqNBeVigripGKiGlp8kLxH7vQWb
         q+zGUpc2d+H6UKfanK6dN2DKCz6cfuHi30mtnSVwIPVAudSs4IrhKrSn23Nb1W1BwSFM
         x0LA==
X-Gm-Message-State: AOJu0Yw5JuBYsr4HmyTiCTpP6z+b30Imdf1fZJLmcIzbPs/aBhFu2R/Z
	ov66sV7Z/5l2CQKqdp1EHDONQ7bM00P50SRAEIsuL4i0Qms4kN3ZCj5v3Ila0jaTh5c2mu/sXXM
	33aAKzVCDYh0+LoOkoW5xZFMKgnClhZmyTHkYgQ==
X-Google-Smtp-Source: AGHT+IGfhI/FKaP/vJxjajLoeoWQ3ywZehmg6nQTrqGI/xnHsJsWVAFgZ+QGcB7hS3fGdtG9CnRhob8AktveIdgNdQA=
X-Received: by 2002:a2e:744:0:b0:2cf:1325:342 with SMTP id i4-20020a2e0744000000b002cf13250342mr4989500ljd.4.1706554438728;
 Mon, 29 Jan 2024 10:53:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240116193542.711482-1-tmenninger@purestorage.com>
 <04d22048-737a-4281-a43f-b125ebe0c896@lunn.ch> <CAO-L_44YVi0HDk4gC9QijMZrYNGoKtfH7qsXOwtDwM4VrFRDHw@mail.gmail.com>
 <da87ce82-7337-4be4-a2af-bd2136626c56@lunn.ch> <CAO-L_46kqBrDdYP7p3He0cBF1OP7TJKnhYK1NR_gMZf2n_928A@mail.gmail.com>
 <20240122123349.cxx2i2kzrhuqnasp@skbuf> <1aab2398-2fe9-40b6-aa5b-34dde946668a@lunn.ch>
 <20240122151251.sl6fzxmfi2f6tokf@skbuf> <CAO-L_45_nZ24pvycdahEy0OP2tZjxCw40_o6HE-_C4jmsX3b8g@mail.gmail.com>
 <20240123152751.gejixrmyet7bsc3j@skbuf>
In-Reply-To: <20240123152751.gejixrmyet7bsc3j@skbuf>
From: Tim Menninger <tmenninger@purestorage.com>
Date: Mon, 29 Jan 2024 10:53:47 -0800
Message-ID: <CAO-L_47uktW8onKHG7fQk1gka2zFWHZb4D6ZBgcKULr8QVfvaQ@mail.gmail.com>
Subject: Re: [PATCH] net: dsa: mv88e6xxx: Make *_c45 callbacks agree with
 phy_*_c45 callbacks
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, f.fainelli@gmail.com, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 23, 2024 at 7:27=E2=80=AFAM Vladimir Oltean <olteanv@gmail.com>=
 wrote:
>
> On Mon, Jan 22, 2024 at 07:46:06AM -0800, Tim Menninger wrote:
> > Andrew, would you feel differently if I added to the patch the same
> > logic for C22 ops? Perhaps that symmetry should have existed
> > in the initial patch, e.g.
> >
> >     bus->read =3D chip->info->ops->phy_read
> >         ? mv88e6xxx_mdio_read : NULL;
> >     bus->write =3D chip->info->ops->phy_write
> >         ? mv88e6xxx_mdio_write : NULL;
> >     bus->read_c45 =3D chip->info->ops->phy_read_c45
> >         ? mv88e6xxx_mdio_read_c45 : NULL;
> >     bus->write_c45 =3D chip->info->ops->phy_write_c45
> >         ? mv88e6xxx_mdio_write_c45 : NULL;
>
> Here it's me who would disagree, for the simple fact that it's not
> needed, and we shouldn't complicate the code with things that are not
> needed (and also, bug fixes should not make more logical changes than
> strictly necessary). All mv88e6xxx_ops structure provide the C22
> phy_read() and phy_write(). As listed below, in order:
>
> static const struct mv88e6xxx_ops mv88e6085_ops =3D {
>         .phy_read =3D mv88e6185_phy_ppu_read,
>         .phy_write =3D mv88e6185_phy_ppu_write,
> };
>
> static const struct mv88e6xxx_ops mv88e6095_ops =3D {
>         .phy_read =3D mv88e6185_phy_ppu_read,
>         .phy_write =3D mv88e6185_phy_ppu_write,
> };
>
> static const struct mv88e6xxx_ops mv88e6097_ops =3D {
>         .phy_read =3D mv88e6xxx_g2_smi_phy_read_c22,
>         .phy_write =3D mv88e6xxx_g2_smi_phy_write_c22,
>         .phy_read_c45 =3D mv88e6xxx_g2_smi_phy_read_c45,
>         .phy_write_c45 =3D mv88e6xxx_g2_smi_phy_write_c45,
> };
>
> static const struct mv88e6xxx_ops mv88e6123_ops =3D {
>         .phy_read =3D mv88e6xxx_g2_smi_phy_read_c22,
>         .phy_write =3D mv88e6xxx_g2_smi_phy_write_c22,
>         .phy_read_c45 =3D mv88e6xxx_g2_smi_phy_read_c45,
>         .phy_write_c45 =3D mv88e6xxx_g2_smi_phy_write_c45,
> };
>
> static const struct mv88e6xxx_ops mv88e6131_ops =3D {
>         .phy_read =3D mv88e6185_phy_ppu_read,
>         .phy_write =3D mv88e6185_phy_ppu_write,
> };
>
> static const struct mv88e6xxx_ops mv88e6141_ops =3D {
>         .phy_read =3D mv88e6xxx_g2_smi_phy_read_c22,
>         .phy_write =3D mv88e6xxx_g2_smi_phy_write_c22,
>         .phy_read_c45 =3D mv88e6xxx_g2_smi_phy_read_c45,
>         .phy_write_c45 =3D mv88e6xxx_g2_smi_phy_write_c45,
> };
>
> static const struct mv88e6xxx_ops mv88e6161_ops =3D {
>         .phy_read =3D mv88e6xxx_g2_smi_phy_read_c22,
>         .phy_write =3D mv88e6xxx_g2_smi_phy_write_c22,
>         .phy_read_c45 =3D mv88e6xxx_g2_smi_phy_read_c45,
>         .phy_write_c45 =3D mv88e6xxx_g2_smi_phy_write_c45,
> };
>
> static const struct mv88e6xxx_ops mv88e6165_ops =3D {
>         .phy_read =3D mv88e6165_phy_read,
>         .phy_write =3D mv88e6165_phy_write,
> };
>
> static const struct mv88e6xxx_ops mv88e6171_ops =3D {
>         .phy_read =3D mv88e6xxx_g2_smi_phy_read_c22,
>         .phy_write =3D mv88e6xxx_g2_smi_phy_write_c22,
>         .phy_read_c45 =3D mv88e6xxx_g2_smi_phy_read_c45,
>         .phy_write_c45 =3D mv88e6xxx_g2_smi_phy_write_c45,
> };
>
> static const struct mv88e6xxx_ops mv88e6172_ops =3D {
>         .phy_read =3D mv88e6xxx_g2_smi_phy_read_c22,
>         .phy_write =3D mv88e6xxx_g2_smi_phy_write_c22,
>         .phy_read_c45 =3D mv88e6xxx_g2_smi_phy_read_c45,
>         .phy_write_c45 =3D mv88e6xxx_g2_smi_phy_write_c45,
> };
>
> static const struct mv88e6xxx_ops mv88e6175_ops =3D {
>         .phy_read =3D mv88e6xxx_g2_smi_phy_read_c22,
>         .phy_write =3D mv88e6xxx_g2_smi_phy_write_c22,
>         .phy_read_c45 =3D mv88e6xxx_g2_smi_phy_read_c45,
>         .phy_write_c45 =3D mv88e6xxx_g2_smi_phy_write_c45,
> };
>
> static const struct mv88e6xxx_ops mv88e6176_ops =3D {
>         .phy_read =3D mv88e6xxx_g2_smi_phy_read_c22,
>         .phy_write =3D mv88e6xxx_g2_smi_phy_write_c22,
>         .phy_read_c45 =3D mv88e6xxx_g2_smi_phy_read_c45,
>         .phy_write_c45 =3D mv88e6xxx_g2_smi_phy_write_c45,
> };
>
> static const struct mv88e6xxx_ops mv88e6185_ops =3D {
>         .phy_read =3D mv88e6185_phy_ppu_read,
>         .phy_write =3D mv88e6185_phy_ppu_write,
> };
>
> static const struct mv88e6xxx_ops mv88e6190_ops =3D {
>         .phy_read =3D mv88e6xxx_g2_smi_phy_read_c22,
>         .phy_write =3D mv88e6xxx_g2_smi_phy_write_c22,
>         .phy_read_c45 =3D mv88e6xxx_g2_smi_phy_read_c45,
>         .phy_write_c45 =3D mv88e6xxx_g2_smi_phy_write_c45,
> };
>
> static const struct mv88e6xxx_ops mv88e6190x_ops =3D {
>         .phy_read =3D mv88e6xxx_g2_smi_phy_read_c22,
>         .phy_write =3D mv88e6xxx_g2_smi_phy_write_c22,
>         .phy_read_c45 =3D mv88e6xxx_g2_smi_phy_read_c45,
>         .phy_write_c45 =3D mv88e6xxx_g2_smi_phy_write_c45,
> };
>
> static const struct mv88e6xxx_ops mv88e6191_ops =3D {
>         .phy_read =3D mv88e6xxx_g2_smi_phy_read_c22,
>         .phy_write =3D mv88e6xxx_g2_smi_phy_write_c22,
>         .phy_read_c45 =3D mv88e6xxx_g2_smi_phy_read_c45,
>         .phy_write_c45 =3D mv88e6xxx_g2_smi_phy_write_c45,
> };
>
> static const struct mv88e6xxx_ops mv88e6240_ops =3D {
>         .phy_read =3D mv88e6xxx_g2_smi_phy_read_c22,
>         .phy_write =3D mv88e6xxx_g2_smi_phy_write_c22,
>         .phy_read_c45 =3D mv88e6xxx_g2_smi_phy_read_c45,
>         .phy_write_c45 =3D mv88e6xxx_g2_smi_phy_write_c45,
> };
>
> static const struct mv88e6xxx_ops mv88e6250_ops =3D {
>         .phy_read =3D mv88e6xxx_g2_smi_phy_read_c22,
>         .phy_write =3D mv88e6xxx_g2_smi_phy_write_c22,
>         .phy_read_c45 =3D mv88e6xxx_g2_smi_phy_read_c45,
>         .phy_write_c45 =3D mv88e6xxx_g2_smi_phy_write_c45,
> };
>
> static const struct mv88e6xxx_ops mv88e6290_ops =3D {
>         .phy_read =3D mv88e6xxx_g2_smi_phy_read_c22,
>         .phy_write =3D mv88e6xxx_g2_smi_phy_write_c22,
>         .phy_read_c45 =3D mv88e6xxx_g2_smi_phy_read_c45,
>         .phy_write_c45 =3D mv88e6xxx_g2_smi_phy_write_c45,
> };
>
> static const struct mv88e6xxx_ops mv88e6320_ops =3D {
>         .phy_read =3D mv88e6xxx_g2_smi_phy_read_c22,
>         .phy_write =3D mv88e6xxx_g2_smi_phy_write_c22,
>         .phy_read_c45 =3D mv88e6xxx_g2_smi_phy_read_c45,
>         .phy_write_c45 =3D mv88e6xxx_g2_smi_phy_write_c45,
> };
>
> static const struct mv88e6xxx_ops mv88e6321_ops =3D {
>         .phy_read =3D mv88e6xxx_g2_smi_phy_read_c22,
>         .phy_write =3D mv88e6xxx_g2_smi_phy_write_c22,
>         .phy_read_c45 =3D mv88e6xxx_g2_smi_phy_read_c45,
>         .phy_write_c45 =3D mv88e6xxx_g2_smi_phy_write_c45,
> };
>
> static const struct mv88e6xxx_ops mv88e6341_ops =3D {
>         .phy_read =3D mv88e6xxx_g2_smi_phy_read_c22,
>         .phy_write =3D mv88e6xxx_g2_smi_phy_write_c22,
>         .phy_read_c45 =3D mv88e6xxx_g2_smi_phy_read_c45,
>         .phy_write_c45 =3D mv88e6xxx_g2_smi_phy_write_c45,
> };
>
> static const struct mv88e6xxx_ops mv88e6350_ops =3D {
>         .phy_read =3D mv88e6xxx_g2_smi_phy_read_c22,
>         .phy_write =3D mv88e6xxx_g2_smi_phy_write_c22,
>         .phy_read_c45 =3D mv88e6xxx_g2_smi_phy_read_c45,
>         .phy_write_c45 =3D mv88e6xxx_g2_smi_phy_write_c45,
> };
>
> static const struct mv88e6xxx_ops mv88e6351_ops =3D {
>         .phy_read =3D mv88e6xxx_g2_smi_phy_read_c22,
>         .phy_write =3D mv88e6xxx_g2_smi_phy_write_c22,
>         .phy_read_c45 =3D mv88e6xxx_g2_smi_phy_read_c45,
>         .phy_write_c45 =3D mv88e6xxx_g2_smi_phy_write_c45,
> };
>
> static const struct mv88e6xxx_ops mv88e6352_ops =3D {
>         .phy_read =3D mv88e6xxx_g2_smi_phy_read_c22,
>         .phy_write =3D mv88e6xxx_g2_smi_phy_write_c22,
>         .phy_read_c45 =3D mv88e6xxx_g2_smi_phy_read_c45,
>         .phy_write_c45 =3D mv88e6xxx_g2_smi_phy_write_c45,
> };
>
> static const struct mv88e6xxx_ops mv88e6390_ops =3D {
>         .phy_read =3D mv88e6xxx_g2_smi_phy_read_c22,
>         .phy_write =3D mv88e6xxx_g2_smi_phy_write_c22,
>         .phy_read_c45 =3D mv88e6xxx_g2_smi_phy_read_c45,
>         .phy_write_c45 =3D mv88e6xxx_g2_smi_phy_write_c45,
> };
>
> static const struct mv88e6xxx_ops mv88e6390x_ops =3D {
>         .phy_read =3D mv88e6xxx_g2_smi_phy_read_c22,
>         .phy_write =3D mv88e6xxx_g2_smi_phy_write_c22,
>         .phy_read_c45 =3D mv88e6xxx_g2_smi_phy_read_c45,
>         .phy_write_c45 =3D mv88e6xxx_g2_smi_phy_write_c45,
> };
>
> static const struct mv88e6xxx_ops mv88e6393x_ops =3D {
>         .phy_read =3D mv88e6xxx_g2_smi_phy_read_c22,
>         .phy_write =3D mv88e6xxx_g2_smi_phy_write_c22,
>         .phy_read_c45 =3D mv88e6xxx_g2_smi_phy_read_c45,
>         .phy_write_c45 =3D mv88e6xxx_g2_smi_phy_write_c45,
> };
>
> > Vladimir, as far as style I have no objections moving to straightlined
> > if's. I most prefer to follow the convention the rest of the code follo=
ws
> > and can change my patch accordingly.
>
> Yes, so my objections have to do with code style and with the structure
> of the commit message.
>
> It should have been a more linear description of: user impact of the
> problem -> identify the cause -> why the existing mechanism to prevent
> the issue does not work -> what can be done to resolve the problem ->
> see if this is consistent with what is done elsewhere -> why the
> proposed change does not break other things -> optionally consider
> alternative solutions and explain why this one is better.
>
> Basically be as preemptive as possible w.r.t. questions that might be
> crossing readers' minds as they read the commit. You should view any
> clarification question you receive during review as a potential
> improvement you could make to the commit message or comments.
>
> Also, the commit title should focus on what is being fixed from a user
> impact perspective. And the Fixes: tag should normally be a single one,
> which coincides with what 'git blame' finds (corollary: bugs which have
> no user visible impact are not treated like bugs, and are fixed as part
> of the "net-next" tree).
>
> Also, there should be no blank lines between the Fixes: and Signed-off-by=
:
> tags. And the next patch revision should be generated with git
> format-patch --subject-prefix "PATCH net v2" to clarify it is targeted
> to the https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git
> tree for fixes. See the warning here (Target tree name not specified in
> the subject).
> https://patchwork.kernel.org/project/netdevbpf/patch/20240116193542.71148=
2-1-tmenninger@purestorage.com/
>
> The space beneath the "---" line in the formatted patch is not processed
> by git when applying the patch. You can use it for extra info such as
> change log compared to v1, and a link to v1 on lore.kernel.org.

Thank you for all the feedback.

Since there's the other thread, am I to follow through with this patch?

If so, I'll clean it up and resubmit (should it be the same thread or
a new one?).

