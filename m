Return-Path: <linux-kernel+bounces-46759-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A6AF8443AC
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 17:07:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB13928EB9B
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 16:07:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4078C12AAE1;
	Wed, 31 Jan 2024 16:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g0YXe+W7"
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 051B367C51;
	Wed, 31 Jan 2024 16:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706717224; cv=none; b=cMxpHw82AVqW9ZVjMDChvdLMHWelWjvB5Tq6XHoWvPsiuXzcPLzn96o/qb04KbNLsXiKytoJtCGWi1WBj2mOKiY+eKSo5gBodwEhbbpHUQR9yg9bNcZEywLwFYJXVnvui0PG6578uimIkCoF3j+FRhdm/48Y9CtHQbgNQs/LCTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706717224; c=relaxed/simple;
	bh=YgWP6jiKaSN4OrAHXGMRjg7oRS1uufNMAcNybJf4yrg=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=Hd/FxcSup71o8yPpfgUCm30yx+SoAdvpjlrROis63HSvCDIrFTRyMVPQr9EGt5oGor+c3qC9JffNuh/jxVOkOaL/0C/2OwXUEeOl9A5OF2+oWZ3RoHRGg9Kgv9df9tS6TXA9LDUD75eEorxDLN4HQvVekx9KPputUIpVJyeY3L0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g0YXe+W7; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-68c44100327so23597016d6.2;
        Wed, 31 Jan 2024 08:07:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706717222; x=1707322022; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=F7dx0TBYoOHj5aKbGigZsrAJsJysNxXysSt64kCOnrc=;
        b=g0YXe+W7icrbLvPfgzDl3pCAeQqfTOicgLvyJNVBSrb2RRpNZWTH9ruA7o5iq/4J+D
         zb7zlbAg3AL3wnqegXO2TgEfT4TsTWW1RyfNH/HgXOt9vFVhboJpL8LY3rEmbbOiD7tP
         JccQ4HbmLG6Vjj/9M/AIaL6xBwyvh539C1RlmYfgqr1TZgvTnvg68/5gGTcemXKTT6Q2
         waDvMSqufib8TAIDPyr7AEoJ7bTLvbb8Strypo4njTFSFViWtfC4lQEVh61hDfkRNrRY
         CUiB9yshqUkdGQcCY5UjUJsqVdzDg4LexdZJwPc6yJK8hwAZJlQq3tbuVIu4SgQfagdO
         z03Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706717222; x=1707322022;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=F7dx0TBYoOHj5aKbGigZsrAJsJysNxXysSt64kCOnrc=;
        b=CQYsIPa1l/iLRBrKpR7ccfEO1y0VL+tROlnzYvxyBMY1/NjSKO94NFOfGDp9moXxfK
         VbUOnTnTjMdzN9GEM01JM8RZYbZsBbWsh0+Hx6Sz50WHHMDoaGIcdMHrQa2/UoDA4XJ8
         IVJ8bUKjXp1iyQh4F6R5eKFYb6y3EnZLx2HxTTdg0pvG2Eaq+n/3NA8EnrDYbM8NVFJO
         puBIwXe11d1jsFuil3TlYjg5SQzS9DJdm3qvgaVhf4aLSb92runMTVoJHOOW9d7lziL3
         JINMvwCpUF5oSQK+v6m1xkgAbks3jkM3NnYv6/qmUBtUKxn40e6ZYPUOJSF3T6o6ol/I
         AyZg==
X-Gm-Message-State: AOJu0Yy4/D1memK6gXOfXe3YSQyHi9e9HuA+ogncHC3k5N2UhHlkMxod
	e7OB1Hzk8GQn1TXauQqo1CVf8DXionBrprdmigh7YG/Ftt2nU2xC
X-Google-Smtp-Source: AGHT+IGepzXb9AgVM0GY1YzmPFbsL+PbZrLq/OgUIrBrn35PREEnC4beHJu+zrj89AREBd3eeJx0lg==
X-Received: by 2002:a05:6214:1d28:b0:68c:5cd9:8d85 with SMTP id f8-20020a0562141d2800b0068c5cd98d85mr2123780qvd.63.1706717221676;
        Wed, 31 Jan 2024 08:07:01 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCX8+he5ws8xDLFEKfW2VlE+JvkFSd0M8JDbr0aQpwSMTmbo74egzY2xhREViRPEOO7QZOhgW2CkTKKLF3Nvss57GKZWfL1UQZ7EyYryuR38zHLJXA38cV9QHtxkpNDHovaLU8MAw1NE26yuQ3K/aTrVb4MCOa93RSJHWEZsPphul05kXIqZrOEYHWI5KpsyZeiisQKDERTZRA1FUZ5C5v3bTWRbeUJk3Np3Utu+IScEFuoLUq68PunZ/tHAZ1Ov2wG2Tpj432zH78Xi+p7ca4mOxWlXINzzGq7EH9GJ1R2ppOPpKL73+okFC3HXcfrAogyulF+ORjZNrcF1Kk944SiD2Xh1zXzbYEL49NifiDoSfvxFiLE3IVNtTITIqRGOSqmz8U/KWUFCwr0=
Received: from [127.0.0.1] ([46.211.116.2])
        by smtp.gmail.com with ESMTPSA id om7-20020a0562143d8700b0068692ea038esm1026721qvb.91.2024.01.31.08.07.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Jan 2024 08:07:01 -0800 (PST)
Date: Wed, 31 Jan 2024 18:06:58 +0200
From: Svyatoslav <clamor95@gmail.com>
To: Conor Dooley <conor@kernel.org>
CC: Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Thierry Reding <thierry.reding@gmail.com>,
 Jonathan Hunter <jonathanh@nvidia.com>, Kees Cook <keescook@chromium.org>,
 Maxim Schwalm <maxim.schwalm@gmail.com>, devicetree@vger.kernel.org,
 linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v1_1/4=5D_dt-bindings=3A_vendor-p?= =?US-ASCII?Q?refixes=3A_add_LG_Electronics=2C_Inc=2E_prefix?=
User-Agent: K-9 Mail for Android
In-Reply-To: <20240131-tractor-roundish-f6f90b5bd640@spud>
References: <20240131105153.8070-1-clamor95@gmail.com> <20240131105153.8070-2-clamor95@gmail.com> <20240131-elderly-passover-341b89f65189@spud> <656FDD69-D7B1-4910-B848-108CB985AAAC@gmail.com> <20240131-tractor-roundish-f6f90b5bd640@spud>
Message-ID: <BCBF1994-C5AE-4D2B-B645-C3C67BE19000@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



31 =D1=81=D1=96=D1=87=D0=BD=D1=8F 2024=E2=80=AF=D1=80=2E 18:02:31 GMT+02:0=
0, Conor Dooley <conor@kernel=2Eorg> =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=
=D0=B2(-=D0=BB=D0=B0):
>On Wed, Jan 31, 2024 at 05:30:58PM +0200, Svyatoslav wrote:
>>=20
>>=20
>> 31 =D1=81=D1=96=D1=87=D0=BD=D1=8F 2024=E2=80=AF=D1=80=2E 17:28:49 GMT+0=
2:00, Conor Dooley <conor@kernel=2Eorg> =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=
=B0=D0=B2(-=D0=BB=D0=B0):
>> >On Wed, Jan 31, 2024 at 12:51:50PM +0200, Svyatoslav Ryhel wrote:
>> >> Add missing LG Electronics, Inc=2E prefix used by some older devices=
=2E
>> >
>> >Is it? You're only adding these devices now as far as I can see=2E
>> >
>>=20
>> Hammerhead (LG Nexus 5)
>
>I have absolutely no idea what this means=2E Please link me the in-tree
>devicetree of the user (or the patchset adding it)=2E
>
>Thanks,
>Conor
>

Sure, here you go
<https://git=2Ekernel=2Eorg/pub/scm/linux/kernel/git/stable/linux=2Egit/tr=
ee/arch/arm/boot/dts/qcom-msm8974-lge-nexus5-hammerhead=2Edts?h=3Dlinux-6=
=2E4=2Ey#n11>

So devices I have sent are not the first=2E

>>=20
>> >>=20
>> >> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail=2Ecom>
>> >> ---
>> >>  Documentation/devicetree/bindings/vendor-prefixes=2Eyaml | 2 ++
>> >>  1 file changed, 2 insertions(+)
>> >>=20
>> >> diff --git a/Documentation/devicetree/bindings/vendor-prefixes=2Eyam=
l b/Documentation/devicetree/bindings/vendor-prefixes=2Eyaml
>> >> index 309b94c328c8=2E=2Eb94ac977acb5 100644
>> >> --- a/Documentation/devicetree/bindings/vendor-prefixes=2Eyaml
>> >> +++ b/Documentation/devicetree/bindings/vendor-prefixes=2Eyaml
>> >> @@ -767,6 +767,8 @@ patternProperties:
>> >>      description: LG Corporation
>> >>    "^lgphilips,=2E*":
>> >>      description: LG Display
>> >> +  "^lge,=2E*":
>> >> +    description: LG Electronics, Inc=2E
>> >>    "^libretech,=2E*":
>> >>      description: Shenzhen Libre Technology Co=2E, Ltd
>> >>    "^licheepi,=2E*":
>> >> --=20
>> >> 2=2E40=2E1
>> >>=20

