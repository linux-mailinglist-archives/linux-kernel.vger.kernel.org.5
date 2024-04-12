Return-Path: <linux-kernel+bounces-142425-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 860468A2B6C
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 11:42:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 273AB1F22F5F
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 09:42:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 329EE51C54;
	Fri, 12 Apr 2024 09:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="IWTIrlwY"
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ACD850A9D
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 09:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712914957; cv=none; b=MFdqXWrgYj0OcxVyqPCYCldDXV6bl0S3/5BtSzvE1Q8+Xy54NBOxf/biS8oQJjKDmlKhCbOUjX++S+p88sbxSY6Aod59PDMO34uZ+mSxXAnrWWZPaEQJs+99b8xz+Chprxh46OBb31pvhozR3XaisSzfyHZBIVMyaUJM8S0cn8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712914957; c=relaxed/simple;
	bh=ze1DWENhxjeSOlCRPZPYtxubM7dRkcTEXeXj/CC5r3A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E9nNunqkMtSnJZi7GpI7Zmozl4mkeTv7jz5quLIzMBujFV9Zl37M12v3rzg0scA4cLSNTiUKpsBcPzObsxfP84oJlWQgxDbugqslwAe3lIPtNiZkOPKrG2AehLOi20OhKzWN0gCLS/EI5crIGXwtwTzDInVO6461MST7o5gVD4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=IWTIrlwY; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-23333dddd8aso485665fac.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 02:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1712914955; x=1713519755; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ze1DWENhxjeSOlCRPZPYtxubM7dRkcTEXeXj/CC5r3A=;
        b=IWTIrlwYJ4ebmbn5rm/qdkw/s+/ZIu6L5dHoC/3auUKZAO56T9x4tRxDDyCYaupbKt
         B9Iwu3j1SUy4yRSyZ8exefJsfNwRc9ne+0DMwA1YipgQ9LNDzAtegh/J3SNmkgS+g1a8
         p28Me2LWBqf0zfTn09fpoYwRxpsBVPvNwGKsBKZTFR+QONTglsw4+GvumZN/f4SaYA9i
         W1Iz9taRP5nfNzQw1a1xr2TmKClggCRRAW3tXNBET1zpIAjlSZjqa1PzJOq2lsy8EHpi
         5AoIAljxA6SIsqoNh3YV3FLdOoVxkqYWFVrP6z6AioH3tzJIcFwjrGfCQ2jyE/IjQMlU
         tJlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712914955; x=1713519755;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ze1DWENhxjeSOlCRPZPYtxubM7dRkcTEXeXj/CC5r3A=;
        b=swJkpYN6WEDkXdsUbdyCNPimi1c1O5QPeOKcTzAYhcCHBfEPQIrjiJKEerkG7AiukK
         sY4qi8st8M1UkccgZXxWAyKKxOtfHqxHtcqIMfzpKlIcEPxpeCnPnlb4iE3qROW8va4x
         n6a+1Wdvwk4eo/3vWpM/uFoTJALWBaIDMGrGXVtScH0tmYyMoz5cLTqpLECJYYKaPLXN
         zKVB5SFqnQfLyc14/K+/1g7w4Qvb2EY4TRQfCkMWwZncu1mtOeJchpypaSPBe1erbdN5
         BLu5trVhgIqrOCUI7DT2rArJOeTzLLn9hP0Xvu5W8O58QRdjpb0/NcaEfFxlQ0DOnREY
         kJ2w==
X-Forwarded-Encrypted: i=1; AJvYcCXFKCdUwhKDfNqSfgg6v172qmfitbzVCNJAXyGGZg/av3QR1J1I4pfKc6MLY6T2xXyIFsA1pdx9SPCFRBXIP4aGsRQheJ/RJrsMFSJ6
X-Gm-Message-State: AOJu0Yx/QOd0SE0HyRoT3GhrF7gIBGExWByDElriA8fs0Qw1TI+ZQUNU
	e146ZeyKSZOxt8XYPPJsoxlFH+xbevXekKnyAzaNcElktPupORrMq4aTANPp/sLxNO6ZroLAdOf
	ort+zjuE2X7wVvddJAuDyCJdjpFFyOMo8GdJ5kQ==
X-Google-Smtp-Source: AGHT+IH/sAzC/4m+8OjoiblQKBrR8gWNhfHFXTBCOEtjXxsaKNwMpXmrJzZaRa5j0HjVtDAPxdFhGnqZozPIYpPkLcA=
X-Received: by 2002:a05:6871:5a05:b0:21e:b4d0:9961 with SMTP id
 on5-20020a0568715a0500b0021eb4d09961mr1977670oac.55.1712914954014; Fri, 12
 Apr 2024 02:42:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240407123829.36474-1-cuiyunhui@bytedance.com>
 <ZhetojJewygmTf6N@bogus> <CAEEQ3wkfHvH4jXNO5NRDf0Fc3xUkY64hp7BDBmgNVdcsmYy-kA@mail.gmail.com>
 <Zhj-4C7xlklG1m5B@bogus>
In-Reply-To: <Zhj-4C7xlklG1m5B@bogus>
From: yunhui cui <cuiyunhui@bytedance.com>
Date: Fri, 12 Apr 2024 17:42:22 +0800
Message-ID: <CAEEQ3wkO4WPaY+bPidg-fDqV5MrQwh8ESbSv-+q8Odhat9XDrQ@mail.gmail.com>
Subject: Re: [External] Re: [PATCH 1/2] ACPI: PPTT: Populate cacheinfo
 entirely with PPTT
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: rafael@kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, paul.walmsley@sifive.com, palmer@dabbelt.com, 
	aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Sudeep,

On Fri, Apr 12, 2024 at 5:29=E2=80=AFPM Sudeep Holla <sudeep.holla@arm.com>=
 wrote:
>
> On Fri, Apr 12, 2024 at 10:10:05AM +0800, yunhui cui wrote:
> > Hi Sudeep,
> >
> > On Thu, Apr 11, 2024 at 5:30=E2=80=AFPM Sudeep Holla <sudeep.holla@arm.=
com> wrote:
> > >
> > > On Sun, Apr 07, 2024 at 08:38:28PM +0800, Yunhui Cui wrote:
> > > > When the type and level information of this_leaf cannot be obtained
> > > > from arch, cacheinfo is completely filled in with the content of PP=
TT.
> > > >
> > >
> > > Which platform is this ? Is this arm64 based or something else like R=
ISC-V
> > > based ? That would help to understand some context here.
> > >
> >
> > Thanks for your response, RISC-V currently has this requirement.
> > Please see: https://patchwork.kernel.org/project/linux-riscv/patch/2024=
0407123829.36474-2-cuiyunhui@bytedance.com/
> >
>
> It would be helpful for the review if you have such information in the
> commit message.

Okay, I will update it in the commit message in v2. Do you have some
comments on the content of the patch?

Thanks,
Yunhui

