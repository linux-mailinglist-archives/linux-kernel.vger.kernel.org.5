Return-Path: <linux-kernel+bounces-31428-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A7E8A832E3A
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 18:35:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40BD01F23BE5
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 17:35:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C56255E73;
	Fri, 19 Jan 2024 17:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cPREiBN0"
Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C81E5577D
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 17:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705685727; cv=none; b=EXOwDz6heYyxPq5LB3/pDfgS8wQzVqLcP0zKjijexiNkDjB7RnhXe/SK0yjIiIQ184h/NpIKPo6ub0XbA4oeaBNBfcJYHS1AKfiArcMHKET/df2wv33I3VpKnV/buI1UUPE6znUtNDFUF/xLOCfHMhx4wARQbdl2f6YRdZjO+jY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705685727; c=relaxed/simple;
	bh=YYJtFFrWyFN07iC2Pnj71je0b557cDdHcxt6rp4uPyg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WgEBe6VvL+PbVtw6WIMHDoikQRSKH1ZshjbMgxtNMpIm4DBbmwerI3U/vhYjXt6XAQe14MLpB4021BMWdi9sEK4+fqetKyFwF4hrgZtE/OSM27qAFjJi9kujzPUIGY3ys13XjcRdtYGal9EHlwEKddIHlAZio2llyka7CC7O+1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cPREiBN0; arc=none smtp.client-ip=209.85.221.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-4b724272f50so276397e0c.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 09:35:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705685724; x=1706290524; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nij5MJXPr1Ekua+uc/RF5x/wvNKaJmQ8aEq49qT0/oo=;
        b=cPREiBN0JPv8AiIkJgpFbip7b3RzArt3OqzqcStudK1l/OY/LaIz2rh0+A5FVoQw+6
         DMU8AHmYIOQmVqDHU5xwXvWscUkujzQvX3P1TI8FTnxG/3KyEZKcorRJ7RWLF5cLyks+
         IGcFS6GRUYVJHScgIXy0X7qbg9Umtp7C8EMSNn14lvIYPH475W6jowS/4IiN4EO839Yo
         81RTE2YHqY3eOJbMwBKh9dKia8TotIKR85ttdSQkaWxQOw80lhPB/MXYRcqJOVwJOqIq
         y/8ahu5sRn3PVgAlkqq7S/7Mrdn1RDrUT13RnLXetYhv5aW90HTN2aDH8AIYmImsnfNA
         dWHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705685724; x=1706290524;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nij5MJXPr1Ekua+uc/RF5x/wvNKaJmQ8aEq49qT0/oo=;
        b=IvyOZWfjKDrDIH3Iw7eSkye7mwtFBgPEIt7k91qbhD8voC7OuwXpCPqze3KFnv9p7j
         5c9f65EHKbnC4w/64KyE0+VqWZQA1zcHFopkLuedxoW+5KXjlemJTT6KZgdWlBYbKXMG
         Dty5tAm17O+WvDrQTbRSpJa5CWFLUDcCd49a1W5kEmrCHlWW1WPbpQj6kuhZH+jkXEIx
         rxKSFwcEPcWDxVsJoyh5W/EmRtLzepuzIb2lkibk0ukLrMPP8nN/ve+sSvuv8Qb3kI7q
         M3C8sdtXxeuhB/E/5+iRd+qQBUiA+5a1KAzqkZ9baAP6kx1Da6AjM4vt2GbSvkzKuUku
         XYFA==
X-Gm-Message-State: AOJu0Yzc2Kh+zlQ82gvJR5iHqhxCjl1WcaFa0tWlmY3yK5KtHFopaCMd
	DiAGbudu/4/gSGLQ1Jfk4ogO7zf3wVemfLIJyZzBTcwLehDUcDE46iv4DQnRtaxrmzWccDSABQs
	dhn+uEUV7f6L7KVuaSHAVyrbt/5Q2M1gUNVdo/w==
X-Google-Smtp-Source: AGHT+IG5Dkka/sL/bUHyUu1DFKr5XJwN5zLeHhnPzHMX+6g1NXFOSn93OMgjK9uC5DUpUSsoEJIHIlvpsa9TcitWnnA=
X-Received: by 2002:a05:6122:9aa:b0:4b7:3986:de56 with SMTP id
 g42-20020a05612209aa00b004b73986de56mr87335vkd.11.1705685724319; Fri, 19 Jan
 2024 09:35:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240118104301.249503558@linuxfoundation.org> <CA+G9fYv4PdOsuFmd2BGoq57omiXWuvnSpJJ1HuLYT0rJ_h9xEw@mail.gmail.com>
 <2024011935-pushchair-affected-e2f0@gregkh>
In-Reply-To: <2024011935-pushchair-affected-e2f0@gregkh>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Fri, 19 Jan 2024 23:05:12 +0530
Message-ID: <CA+G9fYuPpL13P-5Zm8agOrGKEzAc2kB5yQ_MvWs0AYRKMkNKwQ@mail.gmail.com>
Subject: Re: [PATCH 6.7 00/28] 6.7.1-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 19 Jan 2024 at 21:31, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Fri, Jan 19, 2024 at 09:18:29PM +0530, Naresh Kamboju wrote:
> > On Thu, 18 Jan 2024 at 16:20, Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > >
> > > This is the start of the stable review cycle for the 6.7.1 release.
> > > There are 28 patches in this series, all will be posted as a response
> > > to this one.  If anyone has any issues with these being applied, plea=
se
> > > let me know.
> > >
> > > Responses should be made by Sat, 20 Jan 2024 10:42:49 +0000.
> > > Anything received after that time might be too late.
> > >
> > > The whole patch series can be found in one patch at:
> > >         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/pa=
tch-6.7.1-rc1.gz
> > > or in the git tree and branch at:
> > >         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git linux-6.7.y
> > > and the diffstat can be found below.
> > >
> > > thanks,
> > >
> > > greg k-h
> >
> > Results from Linaro=E2=80=99s test farm.
> > The arm allmodconfig clang-17 build failed on 6.7.y, Linux next and mai=
nline.
>
> So 6.7.0 is also broken?

Yes.

- Naresh

