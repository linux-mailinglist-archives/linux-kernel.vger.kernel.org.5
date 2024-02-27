Return-Path: <linux-kernel+bounces-83593-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C79CD869C03
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 17:25:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 690D31F22829
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 16:25:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76DE01487FE;
	Tue, 27 Feb 2024 16:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="muR8M2/P"
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com [209.85.222.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A5EC1487D1
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 16:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709051139; cv=none; b=Fs1xX6mRILcGBkRY2ZrIwD46an1f75kJVoJWzTocF1F80VBsGdAMhM2R9oIKevP6lreCB89Z0K2xDVzaXZj7x2inkjfoy3EeKpt9R2h3UsRNAh/eknQ167/K1wMvFbAgyOiSdo/WdXW/ZRxryKwX2wMLe0K2B+PXVxLlsR9O30c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709051139; c=relaxed/simple;
	bh=pkZ/Ma+F35kpsJXp5Oo5SAPDn31tbUEPaH0ALeTfOao=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pCbds8boe4w3Mbr7ExSA3F8qRgr2ili8aOUJZY4Ujq91ODS5EQzREfPForqDq6YIpDWe5FeOUb5Q0IZAU/tFChrEwcH3DEAKVusOHVcFIEyFBIcF6YOnx5CAQYdtuYQitok1puXmScseM2Z/hSJUdqXV1DJBhh4fiJTT8EL4yBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=muR8M2/P; arc=none smtp.client-ip=209.85.222.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-7d5bfdd2366so2314964241.3
        for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 08:25:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709051137; x=1709655937; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pkZ/Ma+F35kpsJXp5Oo5SAPDn31tbUEPaH0ALeTfOao=;
        b=muR8M2/P+xoE3ENrcveGlKFUDLvK1cpFGjYG4A5BMicJFgRuZ8BiygwdLDf6guf3/P
         z3Mcs6ixIVRu5w4KHlZW+pPGqEASi8+JdhikrHzds+/rYxEia+6Bz/MaQIcCGeh9gAtH
         ZN3w2QN+Unhl/qEsQ7A0enUZGx0QKo84jVHEEmniFQmOt6LfPaa3m9lNo7YEVlZA0X81
         bCr8ylPgHjgOQEcf33wL/4n9+LQzEwSsnPlfUvh5f4KTrai/pYJussJfOdePn+g++pdI
         3cy6xdpRommElqtUXgYcBfuKfoI2k0bN1/DzolF6RnFTXFRWdwoiF0IQN/b6NJuIdfR/
         XrcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709051137; x=1709655937;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pkZ/Ma+F35kpsJXp5Oo5SAPDn31tbUEPaH0ALeTfOao=;
        b=sIEJyAzuR1ICvuc7JrZrqiHDSRgKGFUuDhyeE17LxUAbtzCwmWr193DtGsC7EF9Gqk
         1E50A4WHckm2WApQ1qoBQuq0xgSCjnMdyX4ykSQrovVInpb6XFZatVCe7VKUsanZgmm9
         N6dqGj8sGLCSz5ftddpc4mGe4dsweVRE6tVuCGzuxNwf16VigEVP/zHgYVTl2Nt3nSgU
         6YL3gpB4p3KVyBgtX1lQveJL8KCla89pYfo6PhuwvIXfbisV+a8tac00gFI3kmZL9Sbb
         voLsoOa1s6LWBEYqfXjDnSwTQuk/HCzIM01Ank6behRl28ZrafWOOLZQum3ays+NbPPs
         jwLg==
X-Forwarded-Encrypted: i=1; AJvYcCXSAdD0XFc+VP32Vo3/RtV8Y9iV2cX0M/RC2LoPk7z+4s3PTZuUhV9Z0WI9pIBQBInSW0wF7nT2ZKpRq+A2pG0oewMX2V2yMGHwFtCs
X-Gm-Message-State: AOJu0Yzw1qOFqn0p9ujOST41DSiZTOtWukGDndoHDovQwdcxCNRZ8FTG
	dVPLLRQ8oGVg0To89PD48BPrMQY8V/X+g41MBS2xVlwoO0kNpJyZTvAjdh2OwN6rJdKv239XXUS
	9r5nqOIOIj9v3jDBdCXKX6PivGhvn6ZVuMqoMnQ==
X-Google-Smtp-Source: AGHT+IHIiOUa0KuY6detsdQWZ3j3zaeaOiBoMcz4YliWAIChJzD7EWH2q+D4ztPSG1obNLA6ao+7kAFn0lpTjtkv/xE=
X-Received: by 2002:a05:6102:1158:b0:470:7af5:7973 with SMTP id
 j24-20020a056102115800b004707af57973mr6655661vsg.29.1709051137000; Tue, 27
 Feb 2024 08:25:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240227080943.13032-1-michaelharriscode@gmail.com> <da4ff70d-6c64-40b6-aae4-3aab87da2a1c@moroto.mountain>
In-Reply-To: <da4ff70d-6c64-40b6-aae4-3aab87da2a1c@moroto.mountain>
From: Michael Harris <michaelharriscode@gmail.com>
Date: Tue, 27 Feb 2024 08:25:25 -0800
Message-ID: <CAHXWO3Rm+Vn=Jzb6=mcCbUhE36KveaNfusBBGz6bWVcu3WturA@mail.gmail.com>
Subject: Re: [PATCH] Staging: rtl8723bs: hal_btcoex: fixed styling issues
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: gregkh@linuxfoundation.org, hdegoede@redhat.com, Larry.Finger@lwfinger.net, 
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 27, 2024 at 12:55=E2=80=AFAM Dan Carpenter <dan.carpenter@linar=
o.org> wrote:
>
> On Tue, Feb 27, 2024 at 12:09:43AM -0800, Michael Harris wrote:
> > Fixed various checkpatch.pl styling issues: spaces before tabs, constan=
ts being on left side of comparisons, unnecessary braces, etc.
> >
> > Signed-off-by: Michael Harris <michaelharriscode@gmail.com>
>
> Please run checkpatch.pl on your patches.
>
> WARNING: Prefer a maximum 75 chars per line (possible unwrapped commit de=
scription?)
> #12:
> Fixed various checkpatch.pl styling issues: spaces before tabs, constants=
 being on left side of comparisons, unnecessary braces, etc.
>
> regards,
> dan carpenter
>

Thank you for letting me know.

I will break down my patch into a sequence of patches and run checkpatch.pl
on it before resubmitting.

Thanks,
Michael Harris

