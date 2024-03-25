Return-Path: <linux-kernel+bounces-117152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E330E88A7EB
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 16:58:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12ADC1C60ECF
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 15:58:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B04D126F17;
	Mon, 25 Mar 2024 13:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lnAARSOF"
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E1CC55C33
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 13:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711373666; cv=none; b=nN6/YZLJcLQZ2LGbp/hfDmBJXbK54YEnTdja/qvXxAvGQH49ezZX0vDQzE7M0x+1DCW/yTE/nzanlBvlXgMefQJedeWz25nlnN1HrWLA0eheCsyFn9CXN6to7fNV4z9aEV4e3w3ojEw5E+AFMlsB0NEIvGp1vpva21u0XdB2Nk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711373666; c=relaxed/simple;
	bh=U8S5xHgu1M1P3ABOpjoG8UEpFEvNAqSI8jHcJvmVJ24=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=afvA/8bN4PqMKTiUmlxvUZjXpsxDWHL/Ow4m4BO5JgneyE0d0qQhkj+wTMG5iqnzqWHNGcGvWrl6+oCl5vpIvtUfdb62yXatgVjhvvl9NNgPt6IXsN3CzAlSLS13pAG1LhCasImjcFr213P6+eDzHIYDTTMHtH/tbe34Phm2s7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lnAARSOF; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-dcd9e34430cso4417003276.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 06:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711373664; x=1711978464; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JG8wnrlFMeZwWAB6TB0PCQOCN+02Du45xpH27xy/Kbw=;
        b=lnAARSOFUe1MBb/2u24EAH/0NiWCj82Lq0D2Xvnw4LAITiEQODcS2SyCoEL9vo2Quu
         Bozb09dvLjNsdtZEQi7rt7IFsKEhIvMFoqMSazfiELvADlKvxII4uxdI9tgK2mTx6x3/
         kD8PofCxevVIsk3oDUbO37NPnut6wCpVuQOuvRZcsnFfomAO5/wi0mVcmi6hpzVZ0EaE
         Gr1EDN2fauaog9woJrGArM5A8D13Pd1/GXoST76Bk27lGVTgbmW6PHzK6MGNcwPYBlkJ
         J8b7RtM6Srzxb6+qwYi6exh89+WvhOiO1FtTNsYqDo6WpcDeEE9n77ztN5MQkO8gcbFL
         oxog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711373664; x=1711978464;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JG8wnrlFMeZwWAB6TB0PCQOCN+02Du45xpH27xy/Kbw=;
        b=nD5iwH3l78enOEl5+bjgU3vYG8ij+Vy4MNU+/wG5Zi5I46YuBU9YxgIro5giRm2QJq
         epRdDBNZ2nFJFKe1ZrB2L+Tz+MNkE8dpMplwzP1FFrR0j2j5RweYKq1HTYGG3lkzB+vk
         b1kJfs6OmyT/n0/OVgk/xCSjvQBPLFOIg18HB1Y1ceRm7IFuz94zA+X4/eXe4Nap60Ug
         WNIR55oBlpz/AGE3svhc20/AM7aHBNswp0UMSlXSRtmElb8SzTbhsg5TwGulVGZiXoDZ
         cutb2sgTd6MB6UDx212oovrvY5unQfLGacqVBIyGb3GmJ7786GHVYF3sSQ6bOy5drUCG
         Vbog==
X-Forwarded-Encrypted: i=1; AJvYcCWH6NrJWPJk0Q1cKKw1vKfpl7HyGxVcODrrpllvyoQIYM0fcJYCoG6w4leHcptBGBlYkNFOP4qGm26MtS/OSF/a0XQ4pVMHrgOJIg1N
X-Gm-Message-State: AOJu0YwURUjGkl8hDRYHrXYnwTx01XXQUIjOA6doZ9Aa0E1Md9Y9waQJ
	t9pbWN05+tL9LZdNUg4Q5X7HEsCCvHO6umY1ZafI/TenTArxR6OsupznW6NCLVdf1sKx2qbL5hd
	tGNDF+WXb2+owN+wb0ro5qEE4KP7RSnaqHUPSufGzu7UBs2IyNEM=
X-Google-Smtp-Source: AGHT+IHBJjUnGklU1fweRaCB/g3yNMrgwPCd8m9s5AAsClA8L/cpIFuidJLIEuiXEpkpe3mpNODch4y5b5TDXu0pt8Q=
X-Received: by 2002:a25:2646:0:b0:dcb:e82c:f7f with SMTP id
 m67-20020a252646000000b00dcbe82c0f7fmr5340785ybm.12.1711373664074; Mon, 25
 Mar 2024 06:34:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240227153132.2611499-1-jens.wiklander@linaro.org>
 <20240227153132.2611499-2-jens.wiklander@linaro.org> <CAPDyKFp5j+L=oE1uVyUdu7rVLxRcueWwP0XcNTTMMrFQgmeZiw@mail.gmail.com>
 <DM6PR04MB65755A95AA492565F7576D10FC362@DM6PR04MB6575.namprd04.prod.outlook.com>
 <PH7PR11MB76054BC0C863E5947C7B2DAFE5362@PH7PR11MB7605.namprd11.prod.outlook.com>
In-Reply-To: <PH7PR11MB76054BC0C863E5947C7B2DAFE5362@PH7PR11MB7605.namprd11.prod.outlook.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 25 Mar 2024 14:33:48 +0100
Message-ID: <CAPDyKFqzy9Tz9rC0gLbY5zyaGtLX6F_Le4bNzMb3=BhCoexGvg@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] rpmb: add Replay Protected Memory Block (RPMB) subsystem
To: "Winkler, Tomas" <tomas.winkler@intel.com>
Cc: Avri Altman <Avri.Altman@wdc.com>, Jens Wiklander <jens.wiklander@linaro.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, 
	"op-tee@lists.trustedfirmware.org" <op-tee@lists.trustedfirmware.org>, 
	Shyam Saini <shyamsaini@linux.microsoft.com>, 
	Jerome Forissier <jerome.forissier@linaro.org>, Sumit Garg <sumit.garg@linaro.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Bart Van Assche <bvanassche@acm.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Ard Biesheuvel <ardb@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 25 Mar 2024 at 09:23, Winkler, Tomas <tomas.winkler@intel.com> wrote:
>
>
> > > > +struct rpmb_frame {
> > > > +       u8     stuff[196];
> > > > +       u8     key_mac[32];
> > > > +       u8     data[256];
> > > > +       u8     nonce[16];
> > > > +       __be32 write_counter;
> > > > +       __be16 addr;
> > > > +       __be16 block_count;
> > > > +       __be16 result;
> > > > +       __be16 req_resp;
> > > > +} __packed;
> > >
> > > I haven't looked at the NVME or the UFS spec in detail. Although, I
> > > assume the above frame makes sense for those types of
> > interfaces/protocols too?
> > The rpmb implementation in ufs, has drifted apart from eMMC. E.g. in
> > UFS4.0:
> >  -  the frame is different - see struct ufs_arpmb_meta in
> > include/uapi/scsi/scsi_bsg_ufs.h,
> >  - Additional extended header was added,
> >  - the frame size is no longer 512Bytes (256Bytes meta info + 256Bytes data)
> > but 4k,
> >  - there are 9 rpmb operations instead of 7,
> >  - The atomicity requirement of the command sequence was waved, And
> > probably more differences that I forgot.
> > This is why it is better to designated this as an eMMC-only implementation?
>
> As  I wrote previously the original implementation has already resolved protocol differences
>  (NVMe have also different byte ordering) for closed usecase of storing data (not the configuration)
> I believe the whole point here is to let TEE driver to store the data, regardless of the technology.

Yes, I also agree. It makes sense to have a generic way to manage RPMB
partitions, even if there are some specific parts that must be managed
differently based on the underlying technology.

That said, I tend to think that we actually want the UFS and NVMe
implementation being included in the $subject series too. To get the
complete picture. Otherwise, we may just end up having to redesign a
lot of things, if we just start with eMMC.

>  In addition I might be wrong but I don't see much value in eMMC as the UFS and NVMe are currently leading technologies.

Even if UFS and NVMe have been taking over some of the earlier eMMC
product segments, I think it's too soon to declare eMMC dead. :-)

Moreover, we also have older platforms that we want to get supported
upstream and allowing them to move away from downstream-hacks, is also
a very good reason to add eMMC support.

> Thanks
> Tomas
>

Kind regards
Uffe

