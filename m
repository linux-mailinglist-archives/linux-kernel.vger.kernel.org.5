Return-Path: <linux-kernel+bounces-44839-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 654FB842805
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 16:26:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C948282033
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 15:26:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE20985C61;
	Tue, 30 Jan 2024 15:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="cVlpZwFC"
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CB3E82D99
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 15:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706628375; cv=none; b=W0GOot6571CjKmohuuoaPd67su/FT8MuTpcQ4p0wn+wjVFxRY/XRzhlccZg3tCRJrE4B03wYxmC7o6ujsLfe0Cd30oEkkoLxPrjpMeTxCsFmyeYoo3TLSeYX7utLY/+/tpc1jr6WW6CQYz4kQuF2+mWtMebKusHAqc2y0mZfwIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706628375; c=relaxed/simple;
	bh=GHF4NqZwHNH3Y3ly+JA8/+ebgBt+hbUmLRmHoNhqTcw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JLk15BaOw2WkZnF25bh+ZT+M71GH6MsFmK+YIK6UkyH4Mrjq50+whtWwSRNUH0zz1lmC3ZOM+zjy+v3gIZU2pAMfsqXYFUIns2YIBbdEDRFH5JBmNgEClDcme0AAN7MR5RXW8gipa0T923tzgcpPEgHDgrdOn4PjXgELhEihsOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=cVlpZwFC; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-6e12db57fedso698410a34.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 07:26:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1706628373; x=1707233173; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=95YNzZjCqGewVDFVw5GKEmL/AtttRslbuWoSQwc+WxQ=;
        b=cVlpZwFCq1bnyE/vyrFfJEQTC3gWS2TvfdscqutSGeSBANETT/xy51spPYcM/OKlHJ
         b8NlJuDqYsWMkvcLtqMH6GI4Y+MtS7yyTCJ+0bJ+FNwuI2npcBYzbXtQAeNgzhyRCtA1
         M5ANbxaG2YQ5pC7w+D/H8VTc+RD5q+1iTTLU0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706628373; x=1707233173;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=95YNzZjCqGewVDFVw5GKEmL/AtttRslbuWoSQwc+WxQ=;
        b=VTTHnL5oRQh/8M+j0KDwv/oV0pTGLPK3ZF+wF66MaqTZUDF6RMMHvILgoN2uWHSo3c
         onAhHBOvaMrTpzOwIsgBnWxAiElVVYJ3kjnldoSBwaJhQ0DYp1PpFjSGEg7RBPPhlzJp
         TYKVMRosQdI7HqGMOhIwASooNrOgQ8NDg0P8A/7irfGIsqYGaBwY9mxBx1bFV9A42wSr
         MZXefQsdqnc1tcOYs/GC15+EovytALc55FwQ8x9bOGoGNhvzxzrctr+rYUqrzmnl6wr5
         QCFNEC9wE3xHNV6Vo7AKRxsyUqZslU88Xy+YCrDttKRoMwqL3p83IK9PWcUheacP9Miu
         E6bw==
X-Gm-Message-State: AOJu0Yx6FjIb9mD/IzDhDFeJ/Qrz9j2H9WIGbv6yvwR3v0F9iPMexJ7t
	uxLtVuWmiuN9fhMjIhG4DLLIKCgAyYLYOXoNu1myLRckAIzcBROJD5efzR/24maSQ4IaHMSLP03
	LQYQ+FlnAdsB/9G26ycZZ89+DPaCOCRQsY4m9
X-Google-Smtp-Source: AGHT+IGxupdNP2xsZcONaEVK9pBDWAZoEpyT4Mf6wBGn0beMJ4mbFUcYnLGv1oPi93SgfM34G5xlbX33j7bnRaqzaDQ=
X-Received: by 2002:a05:6830:3141:b0:6dc:6a8f:df1 with SMTP id
 c1-20020a056830314100b006dc6a8f0df1mr522768ots.13.1706628372905; Tue, 30 Jan
 2024 07:26:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240124030458.98408-1-dregan@broadcom.com> <20240124030458.98408-11-dregan@broadcom.com>
 <20240124184027.712b1e47@xps-13> <CAA_RMS42FaiN+Za1iY12o0YUANH9rJarBTBa=9jNn8x6_g-Fng@mail.gmail.com>
 <20240126071913.699c3795@xps-13> <CAA_RMS5gX88v_Qt1csgSL_ffMNsqo2G8B164EB_Hg=hXd620eg@mail.gmail.com>
 <20240129115228.06dc2292@xps-13> <2a3edcf5-7afc-410c-a402-3d8cd3feb1da@broadcom.com>
 <20240130120155.3cb6feed@xps-13>
In-Reply-To: <20240130120155.3cb6feed@xps-13>
From: David Regan <dregan@broadcom.com>
Date: Tue, 30 Jan 2024 07:26:02 -0800
Message-ID: <CAA_RMS577vw=QWN9_NHfmWqt+_cDG22tA01aU019CPNjAgHqJQ@mail.gmail.com>
Subject: Re: [PATCH v3 10/10] mtd: rawnand: brcmnand: allow for on-die ecc
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: William Zhang <william.zhang@broadcom.com>, David Regan <dregan@broadcom.com>, dregan@mail.com, 
	Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, robh+dt@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
	computersforpeace@gmail.com, kdasu.kdev@gmail.com, 
	linux-mtd@lists.infradead.org, devicetree@vger.kernel.org, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Joel Peshkin <joel.peshkin@broadcom.com>, 
	Tomer Yacoby <tomer.yacoby@broadcom.com>, Dan Beygelman <dan.beygelman@broadcom.com>, 
	Anand Gore <anand.gore@broadcom.com>, Kursad Oney <kursad.oney@broadcom.com>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, rafal@milecki.pl, 
	bcm-kernel-feedback-list@broadcom.com, andre.przywara@arm.com, 
	baruch@tkos.co.il, linux-arm-kernel@lists.infradead.org, 
	Dan Carpenter <dan.carpenter@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Miquel,

On Tue, Jan 30, 2024 at 3:01=E2=80=AFAM Miquel Raynal <miquel.raynal@bootli=
n.com> wrote:
>
> Hi William,
>
> william.zhang@broadcom.com wrote on Tue, 30 Jan 2024 00:11:32 -0800:
>
> > Hi Miquel,
> >
> > On 1/29/24 02:52, Miquel Raynal wrote:
> > > Hi David,
> > >
> > > dregan@broadcom.com wrote on Fri, 26 Jan 2024 11:57:39 -0800:
> > >
> > >> Hi Miqu=C3=A8l,
> > >>
> > >> On Thu, Jan 25, 2024 at 10:19=E2=80=AFPM Miquel Raynal
> > >> <miquel.raynal@bootlin.com> wrote:
> > >>>
> > >>> Hi David,
> > >>>
> > >>> dregan@broadcom.com wrote on Thu, 25 Jan 2024 11:47:46 -0800:
> > >>>   >>>> Hi Miqu=C3=A8l,
> > >>>>
> > >>>> On Wed, Jan 24, 2024 at 9:40=E2=80=AFAM Miquel Raynal <miquel.rayn=
al@bootlin.com> wrote:
> > >>>>>
> > >>>>> Hi David,
> > >>>>>
> > >>>>> dregan@broadcom.com wrote on Tue, 23 Jan 2024 19:04:58 -0800:
> > >>>>>   >>>>>> Allow settings for on-die ecc such that if on-die ECC is=
 selected
> > >>>>>> don't error out but require ECC strap setting of zero
> > >>>>>>
> > >>>>>> Signed-off-by: David Regan <dregan@broadcom.com>
> > >>>>>> Reviewed-by: William Zhang <william.zhang@broadcom.com>
> > >>>>>> ---
> > >>>>>> Changes in v3: None
> > >>>>>> ---
> > >>>>>> Changes in v2:
> > >>>>>> - Added to patch series
> > >>>>>> ---
> > >>>>>>   drivers/mtd/nand/raw/brcmnand/brcmnand.c | 14 ++++++++++----
> > >>>>>>   1 file changed, 10 insertions(+), 4 deletions(-)
> > >>>>>>
> > >>>>>> diff --git a/drivers/mtd/nand/raw/brcmnand/brcmnand.c b/drivers/=
mtd/nand/raw/brcmnand/brcmnand.c
> > >>>>>> index a4e311b6798c..42526f3250c9 100644
> > >>>>>> --- a/drivers/mtd/nand/raw/brcmnand/brcmnand.c
> > >>>>>> +++ b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
> > >>>>>> @@ -2727,9 +2727,11 @@ static int brcmnand_setup_dev(struct brcm=
nand_host *host)
> > >>>>>>        cfg->blk_adr_bytes =3D get_blk_adr_bytes(mtd->size, mtd->=
writesize);
> > >>>>>>
> > >>>>>>        if (chip->ecc.engine_type !=3D NAND_ECC_ENGINE_TYPE_ON_HO=
ST) {
> > >>>>>> -             dev_err(ctrl->dev, "only HW ECC supported; selecte=
d: %d\n",
> > >>>>>> -                     chip->ecc.engine_type);
> > >>>>>> -             return -EINVAL;
> > >>>>>> +             if (chip->ecc.strength) {
> > >>>>>> +                     dev_err(ctrl->dev, "ERROR!!! HW ECC must b=
e set to zero for non-hardware ECC; selected: %d\n",
> > >>>>>> +                             chip->ecc.strength);
> > >>>>>
> > >>>>> Can you use a more formal string? Also clarify it because I don't
> > >>>>> really understand what it leads to.
> > >>>>
> > >>>> How about:
> > >>>>
> > >>>> dev_err(ctrl->dev, "HW ECC set to %d, must be zero for on-die ECC\=
n",
> > >>>
> > >>> Actually I am wondering how legitimate this is. Just don't enable t=
he
> > >>> on host ECC engine if it's not in use. No need to check the core's
> > >>> choice.
> > >>
> > >> Our chip ECC engine will either be on if it's needed or off if it's =
not.
> > >> Either I can do that in one place or put checks in before each
> > >> read/write to turn on/off the ECC engine, which seems a lot more
> > >> work and changes and possible issues/problems.
> > >> Turning it on/off as needed has not been explicitly tested and
> > >> could cause unforeseen consequences. This
> > >> is a minimal change which should have minimal impact.
> > >>
> > >>>   >>>>   >>>>>   >>>>>> +                     return -EINVAL;
> > >>>>>> +             }
> > >>>>>>        }
> > >>>>>>
> > >>>>>>        if (chip->ecc.algo =3D=3D NAND_ECC_ALGO_UNKNOWN) {
> > >>>>>> @@ -2797,7 +2799,11 @@ static int brcmnand_setup_dev(struct brcm=
nand_host *host)
> > >>>>>>        if (ret)
> > >>>>>>                return ret;
> > >>>>>>
> > >>>>>> -     brcmnand_set_ecc_enabled(host, 1);
> > >>>>>> +     if (chip->ecc.engine_type =3D=3D NAND_ECC_ENGINE_TYPE_ON_D=
IE) {
> > >>>>>> +             dev_dbg(ctrl->dev, "Disable HW ECC for on-die ECC\=
n");
> > >>>>>
> > >>>>> Not needed.
> > >>>>
> > >>>> Will remove.
> > >>>>   >>>>>   >>>>>> +             brcmnand_set_ecc_enabled(host, 0);
> > >>>>>> +     } else
> > >>>>>> +             brcmnand_set_ecc_enabled(host, 1);
> > >>>>>
> > >>>>> Style is wrong, but otherwise I think ECC should be kept disabled=
 while
> > >>>>> not in active use, so I am a bit surprised by this line.
> > >>>>
> > >>>> This is a double check to turn on/off our hardware ECC.
> > >>>
> > >>> I expect the engine to be always disabled. Enable it only when you
> > >>> need (may require an additional patch before this one).
> > >>
> > >> We are already turning on the ECC enable at this point,
> > >> this is just adding the option to turn it off if the NAND chip
> > >> itself will be doing the ECC instead of our controller.
> > >
> > > Sorry if I have not been clear.
> > >
> > > This sequence:
> > > - init
> > > - enable hw ECC engine
> > > Is broken.
> > >
> > ECC engine is not enabled for all the cases. Here we only intended to e=
nable it for the nand chip that is set to use NAND_ECC_ENGINE_TYPE_ON_HOST.=
 The logic here should better change to:
> > if (chip->ecc.engine_type =3D=3D NAND_ECC_ENGINE_TYPE_ON_HOST)
> >      brcmnand_set_ecc_enabled(host, 1);
> > else
> >      brcmnand_set_ecc_enabled(host, 0);
> >
> > > It *cannot* work as any operation going through exec_op now may
> > > perform page reads which should be unmodified by the ECC engine. You =
> driver *must* follow the following sequence:
> > > - init and disable (or keep disabled) the hw ECC engine
> > > - when you perform a page operation with correction you need to
> > >     - enable the engine
> > >     - perform the operation
> > >     - disable the engine
> > > Maybe I am missing something here but are you saying the exec_op can =
have different ecc type for page read/write at run time on the same nand ch=
ip? I don't see the op instr structure has the ecc type field and thought i=
t is only bind to the nand chip and won't change at run time. So looks to m=
e the init time setting to the engine based on ecc.engine_type should be su=
fficient.
> >
> > What you described here can work for the hw.ecc read path (ecc.read_pag=
e =3D brcmnand_read_page) which always assumes ecc is enabled. Although it =
is probably not too bad with these two extra operation, it would be better =
if we don't have to add anything as our current code does. For the brcmnand=
_read_page_raw,  we currently disable the engine and then re-enable it(but =
we need to fix it to only enable it with hw ecc engine type).  So it is jus=
t opposite of you logic but works the same with no impact on the most perfo=
rmance critical path.
>
> This is not "my" logic, this is the "core's" logic. I am saying: your
> approach is broken because that is not how the API is supposed to work,
> but it mostly works in the standard case.

In the interest of minimizing register writes, would it be acceptable to
enable/disable ECC at the beginning of a standard
path transfer but not, after the transfer, turn off the ECC? This should no=
t
affect other standard path operations nor affect the exec_op path as those
are low level transfers which our ECC engine would not touch and the NAND
device driver should be responsible for turning on/off its own ECC.

>
> Thanks,
> Miqu=C3=A8l

Thanks!

-Dave

