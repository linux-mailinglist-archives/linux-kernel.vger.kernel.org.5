Return-Path: <linux-kernel+bounces-98848-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 419AC878039
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 14:00:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F052A28494D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 13:00:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 142853D0C6;
	Mon, 11 Mar 2024 13:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WUlcf+++"
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA30A2C698;
	Mon, 11 Mar 2024 13:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710162020; cv=none; b=EJMDIxLMM/CUd6onBPd8iznaa9tnnZnS9GKaSwigtZL7re7ebgRkgSY1jjmlaG67UshaXFmyW2/45jL47VmKCB/yykKvMGvgU20sQP84+/0hHlJqKeNbeGKVzokRIRC1qjd8hDGQLcd91IcQNfUOrIQmmQ90QmOf6j5Nm68YDOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710162020; c=relaxed/simple;
	bh=y+V+z4GfofolxfNywtHLsGFGEJpi+qtkcHOaShAT4g4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PqU35WV1x6nb2ylAuNxjQPgSMzwivO0I8ZZaJG/fvgOuACZNSysVEJV6yO60Lya8GHZq8cXyKCgFLK3nf33GL4b1shj3tx9/tGAcwmwgigacV4CKNzPJ60bTMsUQb7TZqjiQ2bS3Rye9dIVDKCZNu1LbRlOQJgMzHfYqLIUIPSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WUlcf+++; arc=none smtp.client-ip=209.85.217.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-4725acb539cso710575137.3;
        Mon, 11 Mar 2024 06:00:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710162018; x=1710766818; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dNPdTSgihx6APB/qlGwE3GrdCHgKzF4oHFB8F2X6Bm8=;
        b=WUlcf+++fvZn9Eofpr9v82Fj78eW4WKdvsdM/mkoHy1ZE8ulWIpKCh1FnWPKdaWt+J
         NpMfd1kC9hP+vbko5zFtwfaLDT6ah9hzDnN8M+f1TSs9QiASQ1zXYWsT7jZF/HPgUe9C
         /YBbYzR9grUd994//NTNC6PJAks0cHta5+ZUjwjUxROiavkI1cLCVRfWkT7a6TViZX1p
         9/u7fE9mXYUSAsUN5/KoFdMwf0kkJgYR0Sp6tYgNgHAauzQPF6h1AInOBdbteRq2lEom
         bfdl5hQ59yf3N7VTWuvBw4YGstfRHli5xlKfjfFF9ApcdyxFIBR9l4NNrWSuSWcDZh6z
         BBqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710162018; x=1710766818;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dNPdTSgihx6APB/qlGwE3GrdCHgKzF4oHFB8F2X6Bm8=;
        b=B0o07V8ZY9Wb2G2oDqmhQj2KV5+tpEVPPjPlSmeC10U2sHwilfuydwt2bdKI5yXpcu
         SElf8RkNQcaHp2h75GCoAE5Yx/XQbHhwbEMYUb029kIco+OD31Q9wbzrsx+m6aX/hKi9
         MlEaKkdjaWm3GcVYJIlhaBPtbV19Ia+4uWdi6IAX+ygEyNfmk4bAlqnYzweeJvGq0Jez
         E5U2V0Q/tYO9c/z1K2x89y+PuDDOqqBzaEOlMZHyKR3P6rSpL/M8pAt1E0k2Zh/Y5O9v
         KeuM46j5NXvu7RaWhCkiiVeRYFxTtK17zvK9149xxdxApawbpGXwof3mXgKNa6MVlkEF
         FhWQ==
X-Forwarded-Encrypted: i=1; AJvYcCW61noYUXZcHDZ/LYzsyeZNS4zDyhvzc17Nd+4NW/HhzcghlRynw8LoS4EZS/+0c2IAdh3Dytw021wnBe0NSdbwhGRXsnBVKpsZE43Eem/AUfDlI+XYQ4Rr6E7vrVu7vKCT7K/EQBoWs+ZQM/5U+BY+F4/wZZamI2R5w52EIaZ7zuEfToxLmen2DQ9iRg==
X-Gm-Message-State: AOJu0Yx+YX0ZZqdnsGRU1NWFb6r9AjlEOvOH3EYQVxNxBKFB6PD0Rq7f
	whcYD9nLDup70c//6gOKRBnKyIVotx9aTXmRgEcXNZvjogaWhmcO4PeQ+mYRwZEbTJfWs9esaDY
	RS8wVPXdlkGaYdp3D1LgCq4GeYsk=
X-Google-Smtp-Source: AGHT+IGgljW5afs/Bd9m728X19XoFuAy7J1zC7s4GAdWqIMWMm3E1GTQvPc8yXfBh/BEEpRh3w5qDky2FEwjJ9baG2o=
X-Received: by 2002:a67:f885:0:b0:473:884:7854 with SMTP id
 h5-20020a67f885000000b0047308847854mr3603685vso.25.1710162017595; Mon, 11 Mar
 2024 06:00:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240307133601.103521-1-e.velu@criteo.com> <171015844082.2407.9314247833035238689.b4-ty@linux.intel.com>
In-Reply-To: <171015844082.2407.9314247833035238689.b4-ty@linux.intel.com>
From: Erwan Velu <erwanaliasr1@gmail.com>
Date: Mon, 11 Mar 2024 14:00:06 +0100
Message-ID: <CAL2JzuzSLnxNVqkZJzkmj7hhpSaVG1Odxy4H=sLO=fTXYBt6Dw@mail.gmail.com>
Subject: Re: [PATCH] doc/arch/x86/amd/hsmp: Updating urls
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Erwan Velu <e.velu@criteo.com>, 
	Naveen Krishna Chatradhi <naveenkrishna.chatradhi@amd.com>, Carlos Bilbao <carlos.bilbao@amd.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Jonathan Corbet <corbet@lwn.net>, platform-driver-x86@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> Thank you for your contribution, it has been applied to my local
> review-ilpo branch. Note it will show up in the public
> platform-drivers-x86/review-ilpo branch only once I've pushed my
> local branch there, which might take a while.
>
> The list of commits applied:
> [1/1] doc/arch/x86/amd/hsmp: Updating urls
>       commit: dfea6b10ed15aeec6456e704e08e45fc7c947a9d

Thx for the merge & happy to contribute a bit to this wonderful project ;)

