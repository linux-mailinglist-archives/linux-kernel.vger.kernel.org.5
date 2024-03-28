Return-Path: <linux-kernel+bounces-123028-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D296D890133
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 15:08:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F8031C21F40
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 14:08:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D86E8612E;
	Thu, 28 Mar 2024 14:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="S6Qm71Xq"
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D051581737
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 14:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711634876; cv=none; b=RtoSNBhWZ9qB2WSvkWroiiJ+wInu8mgxMKNyFQ8iwvSZiHmaODI9omn8EnrN5kziNF7Wl26rWGGMOHeZSJC2A+BL/cfRBK1Q+qU+jtd5KWSjwLEyAcbtDIHHZ25torrU84DgLIzRHjjC7xZYxTy0m5Ly7gBGzK02pEu6hCgVknk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711634876; c=relaxed/simple;
	bh=DfH+3aoUof0sIpFInK30HYT3MVpH58jL9JiOI4p2scM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U0vTS1rrKkB96eLzn44Zar/dsB1zedeD10JrSUSnf6gCF2N2IaPMz3j2t5H28CoZIIhDencWnuIHtClyRs4hDfJBVZfNexR78KY1MjvrgkPj/mhj2O7Mj+0cBG4OjqGQhvObR0hrJ3U+JfiUDe44nWHiUnoWVCGgU2Jk7KEBits=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=S6Qm71Xq; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3bbbc6e51d0so605217b6e.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 07:07:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711634874; x=1712239674; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yFmOaQNA1YO66RkVLT7+CKmbcZlTvokprFnN8slsZBs=;
        b=S6Qm71Xq/J3a7S1tRj5XTLGZHc+VLgj0Rb/v/hkIrf0JlK1Zza19WJdB2XSz1hvIPF
         8x6ivtlDj5DU7AMyjc5ub8l5hrbsfFbw1OTIJ/D/jSDhQ+8ZUDofX2D59aeqHe2yFdoD
         c3dXCU7NOUTgvlsLnCszHFKv7rN3B785GES7npKe6nHiWpDiJtEZ90fnue9xw5SoRsdd
         UCh06e/vUyVJaNLbPcc6cuW457CdFy57XqE/CUO2hmSHqjQQMj5nt6SxKNtwIrj16/aR
         NXRnV/SPMGnkJ6HGzmndAFr0V++2zZRalbTLBwDtBhiEW/21EAjWPnAPDlA0wNdAMaPE
         SdIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711634874; x=1712239674;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yFmOaQNA1YO66RkVLT7+CKmbcZlTvokprFnN8slsZBs=;
        b=r0gXe4jPJCSTaPGjojSNPQV7J8O1RY4iL5eGh/EceuvFqZCCeYcqXOG6boYfMs7BQ4
         ncauciX5rwv37f+EPqONKWOwqcZKN+JybJLQjbWJJ53vpc3551dBRLDkbr+/qd7ramfi
         c41AmzBbyr9vpsTNUmNvE9td4XTdsOz49JpxL06p83aBB6wIXjWPI18GAWK0Kf/fFJo8
         pyIqPB1YnJjHEpRE+4981oFtDZ2Go4BpUkOcV0F4aozsyPRdDLm0JX8QhUsb1qtcQnGU
         WH02TcmFJlehB0rfhTKasiSdlT8ik1xpwa4hGVEjN1OzqFKMmT7PiSEKnXOBejMSgfrK
         O+rw==
X-Gm-Message-State: AOJu0Ywar07zoSg3uYvFlAyYU1mL3rC+0vSjrfsGwq/EJHiYUzt6KRsu
	bpdNrUuXFjLEAWTLKPiiV8PifsOnwkBP4WASi5vjAADkbIv2toJo1Sz3VLATBwYVgr7vFFlzK77
	ezeCVAo9r/Bjz3YDwrpdH5cSyJn4M8QdqGkB9qoW3tyYUV6Z2lns=
X-Google-Smtp-Source: AGHT+IGSHcrTNSo0TiF91FUIBOkfs+BnWX5uYwTCLEUQrIvu9e6qPQDoGHSDQR8cPK0FW6/kkHzHQhMS7Y0zn//rEl4=
X-Received: by 2002:a05:6808:2124:b0:3c3:dd65:bdaa with SMTP id
 r36-20020a056808212400b003c3dd65bdaamr3292330oiw.6.1711634873746; Thu, 28 Mar
 2024 07:07:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240325115854.1764898-1-sashal@kernel.org> <CA+G9fYttAJcRBq2F-TfOvfsWJQuCKW9SAo_3C1nv5ok43j4Aeg@mail.gmail.com>
In-Reply-To: <CA+G9fYttAJcRBq2F-TfOvfsWJQuCKW9SAo_3C1nv5ok43j4Aeg@mail.gmail.com>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Thu, 28 Mar 2024 19:37:42 +0530
Message-ID: <CA+G9fYuNsVNtWr9mLvgPnjRPr0Eq45eH9cSdEc6tbbDpXzFrNQ@mail.gmail.com>
Subject: Re: [PATCH 4.19 000/147] 4.19.311-rc2 review
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	torvalds@linux-foundation.org, akpm@linux-foundation.org, linux@roeck-us.net, 
	shuah@kernel.org, patches@kernelci.org, lkft-triage@lists.linaro.org, 
	florian.fainelli@broadcom.com, pavel@denx.de
Content-Type: text/plain; charset="UTF-8"

On Tue, 26 Mar 2024 at 18:07, Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
>
> On Mon, 25 Mar 2024 at 17:29, Sasha Levin <sashal@kernel.org> wrote:
> >
> >
> > This is the start of the stable review cycle for the 4.19.311 release.
> > There are 147 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> >
> > Responses should be made by Wed Mar 27 11:58:33 AM UTC 2024.
> > Anything received after that time might be too late.
> >
> > The whole patch series can be found in one patch at:
> >         https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/patch/?id=linux-4.19.y&id2=v4.19.310
> > or in the git tree and branch at:
> >         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.19.y
> > and the diffstat can be found below.
> >
> > Thanks,
> > Sasha
>
> One more important update from Linaro LKFT testing,
>
> LTP syscalls fallocate06 fails on qemu-arm64 and juno-r2 devices.
>
> fallocate06.c:155: TFAIL: fallocate(FALLOC_FL_PUNCH_HOLE |
> FALLOC_FL_KEEP_SIZE) failed unexpectedly: ENOSPC (28)
>
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
>
> We are running bisections on this issue and get back to you.

This is to confirm that the reported issue is not a kernel regression.
The reason is due to updates on userspace tools regarding the btrfs.

- Naresh

