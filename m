Return-Path: <linux-kernel+bounces-154723-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 321058AE02A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 10:45:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C65AC1F21BA9
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 08:45:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85A265647F;
	Tue, 23 Apr 2024 08:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hQJGEq7I"
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 962D855C22
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 08:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713861870; cv=none; b=My2Ucqn9FNohIhCml6pELF+fiAN/y1okN3vhh5NycTpncR+atgS6dYLoMbgJoIXasXiRfEU6Zt1Tle/68is2lUW8BRAHn4X1ySz0hOdFvCFoWnLTx0aQFEqbsRTSe4A6mEVMCRJWTOrmyO+1LUQNH6vvf4aklw2oEftdNdj+Goo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713861870; c=relaxed/simple;
	bh=+My4GXa+K/9fAwH9uLEaNISiSAPjuktHxHqtmFm83Z8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pFoPCSOEVJRh+ScR9woPorWDWwlkPrUe2gOsNO1B+/rABTNPuLinAt7GrJncEYn7jcO8VV6PFSUZ4TZfPrsLu6A/2bKjqFqfSt8SAFPUSqyjTyWvgwsihA4pcDiEZ4ulCrewfm+r2flw/WFtLuDbc2t2aCGdnXYaYHEXVXO/DKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hQJGEq7I; arc=none smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-5af03aa8814so1497555eaf.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 01:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713861868; x=1714466668; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+My4GXa+K/9fAwH9uLEaNISiSAPjuktHxHqtmFm83Z8=;
        b=hQJGEq7IsWwCB7iF4VeKMS847bcIldwI3S7bVETDCnfKecxRXh2gR7mkDHKHQxHn/2
         BiSOQd8QivUYKLoPPNkYdeDODxb3gVSHoVqhsYEPWB3LznKYlCn4E/E+DVaB9oqLVyjd
         LI/3y0tTvNrXgmOt6bQE4/BVtvhKmT0gVFDujxb+WfkGxipYs0/Y9PwfR8GWkDrIAGGZ
         AVifceaPuCAvYsYRLuiZsTA7XouKEbZsh9HSh2S5IxYcYAK1vAgwLpXd+I4GS7LDV/qk
         ddoGKDJKhPjn9uAG1F3hycx8h1Khdutox3R0KLg31Rv+uSWPoixXFEYs1UlOCoDDUHTH
         4bZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713861868; x=1714466668;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+My4GXa+K/9fAwH9uLEaNISiSAPjuktHxHqtmFm83Z8=;
        b=uBjD6mAtvXplu/GapzCKui6Fh6KKiEFFnXVEAtAmelpf/t7mHtS8LW9Rc+Tliq7nXu
         cB1wfRvrQs4/bN342Yc7pYP/IZ52UdZc8N8HsPtd1cOzx/O9GsHeapr6lCRlx+OOk7eD
         TbE1YJbD2Z2EvYTdl7FOa1lhkYQrneFA7MGoEOag9Lv9kzyhN2/H31gm/Q7s1O+kuVWb
         hkjLrsf8jMzvm3pUY56liwxrxPfVTicG301MFfEX+mwfkxtDfnALRNRv5p+EjaxMVbSg
         MquCB9mubmgQjD4J6ZqzjbL77O3EHx2RSIWmR8XWoDgVieZ1NkaDatt9WaL739VcofGe
         RKug==
X-Gm-Message-State: AOJu0YwQaIaSzT2GjhjAo6mS6iT1W+9NO9PZsfaxdns12IX5BOKIh/kj
	B6Ea9+rb6gWqCC5lLvbLMeKi6q8Cos7VmAu9WiFEyu+CqMi5WCxKybJBI7R29mzklD/iwRJ8qPG
	OHXdmCuMNblsENeAZtuebXD4RIFdVE/E/DJUT/Q+CMx695rfoyZg=
X-Google-Smtp-Source: AGHT+IFEcRtF3ozJTE91QFopLg/DHbUsdVS1rllN6J8pIs46+14oweUTXy2DLOtlj4wnVzIkPzBbxpUkhsFgI+2EqbA=
X-Received: by 2002:a4a:1484:0:b0:5af:36ef:27d0 with SMTP id
 126-20020a4a1484000000b005af36ef27d0mr814140ood.1.1713861867830; Tue, 23 Apr
 2024 01:44:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240422091936.3714381-1-jens.wiklander@linaro.org>
 <DM6PR04MB6575CE5A70F2C733DF40E54CFC112@DM6PR04MB6575.namprd04.prod.outlook.com>
 <CAHUa44EzMpRbhJ=-h4hJifgtrMsvDZj=Zt4C3JkDxjKE4gz=7A@mail.gmail.com> <DM6PR04MB6575E485C2CDB40CC79A3081FC112@DM6PR04MB6575.namprd04.prod.outlook.com>
In-Reply-To: <DM6PR04MB6575E485C2CDB40CC79A3081FC112@DM6PR04MB6575.namprd04.prod.outlook.com>
From: Jens Wiklander <jens.wiklander@linaro.org>
Date: Tue, 23 Apr 2024 10:44:09 +0200
Message-ID: <CAHUa44F8J6byatNpg9W6Y2yinJw_RKEtLBKBSDxGkz0yx4Zi3A@mail.gmail.com>
Subject: Re: [PATCH v5 0/3] Replay Protected Memory Block (RPMB) subsystem
To: Avri Altman <Avri.Altman@wdc.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, 
	"op-tee@lists.trustedfirmware.org" <op-tee@lists.trustedfirmware.org>, 
	Shyam Saini <shyamsaini@linux.microsoft.com>, Ulf Hansson <ulf.hansson@linaro.org>, 
	Linus Walleij <linus.walleij@linaro.org>, Jerome Forissier <jerome.forissier@linaro.org>, 
	Sumit Garg <sumit.garg@linaro.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
	Bart Van Assche <bvanassche@acm.org>, Randy Dunlap <rdunlap@infradead.org>, 
	Ard Biesheuvel <ardb@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 23, 2024 at 10:22=E2=80=AFAM Avri Altman <Avri.Altman@wdc.com> =
wrote:
>
> > On Tue, Apr 23, 2024 at 8:42=E2=80=AFAM Avri Altman <Avri.Altman@wdc.co=
m> wrote:
> > >
> > > > The OP-TEE driver finds the correct RPMB device to interact with by
> > > > iterating over available devices until one is found with a
> > > > programmed authentication matching the one OP-TEE is using. This
> > > > enables coexisting users of other RPMBs since the owner can be
> > > > determined by who knows the authentication key.
> > > Devices in plural?
> > > I am unaware of any board with multi eMMC devices soldered.
> > > Can you refer me to such a platform?
> >
> > I'm testing with a Hikey960 (HiSilicon Kirin 620)
> > https://www.96boards.org/product/hikey
> > It has one soldered eMMC and one removable eMMC.
> I used to have that board but with a UFS2.1 version, so I can't really te=
ll.
> https://github.com/96boards/documentation/blob/master/consumer/hikey/hike=
y620/hardware-docs/hardware-user-manual.md#storage
> indicating only a single eMMC device and a SD.

That's what I'm testing with, the kernel finds two RPMBs with
different CIDs. I'm running my tests with the removable one.

> Either way, AFAIK there are no production designs that make use of more t=
han a single embedded flash storage.
> This goes for both eMMC and UFS.

OK

Thanks,
Jens

