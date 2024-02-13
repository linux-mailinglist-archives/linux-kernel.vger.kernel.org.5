Return-Path: <linux-kernel+bounces-64182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 48F95853B47
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 20:39:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0699E2883BE
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 19:39:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D008E60BB1;
	Tue, 13 Feb 2024 19:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Cv/dTmya"
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AF685812E
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 19:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707853096; cv=none; b=dUJzIqLCpUG1wIYrJKoek2LuENaLP50yCN7KaGsIdcsO/UZLZj2sOJ+2VKCGvPeC77DftYFggc2MYAApImXSGvfemqA26c4ufx4OB5RAlBpL3aB+G+QvItyONPtCTtMIJC4ZG6ga0l5p28sUnW0GG8X1AQBENEtDcrQEQzIyg6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707853096; c=relaxed/simple;
	bh=GjF/mMss2cis45pk3j/3jxQhna+tzPSvd6xll7mM5yc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YzboEt1oOw83oYodWdjmAdZs/YRiC9A4KFN7W8mtWa7efekwCW/mKjAC3tn/prW5NbC1yTcQLxo5Lzs3sa4SJoybOqCmbdsm+Dsbm0vUdF8sEFAXjFbI+DuAKffJ1Fgc3G9H583dQVDqbpm634jrb5OkX3NhO22TOzux+37zbwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Cv/dTmya; arc=none smtp.client-ip=209.85.217.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-46d29d26716so642165137.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 11:38:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707853093; x=1708457893; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7bxKZocdEiqoyhxdegqmhQihLPSri0Uq3BtRPxUJnFo=;
        b=Cv/dTmyaNFb8jSif9QpyVSEq4Qd1DKIYAVvfLGvWIQZpPf0sWicXdL8baS3sJsyyqK
         5tw3E78okRlaQkqt7vUjFGC+J8tHgFggZgrHU6oMZoPm5ro/x02Q92K0x36MhCWPf6Iq
         VJWQRZKyOXGQBOALn+0NXSpTrvvJvcIO1rStdcWuamE8vhXfOIc0fIEy3uupN3azUNvv
         MNtakWkpHy53RHwVMjOSpKMtdJPahpU8l89Ry/u6dhtvZuxGTK4GwXw9g8qshou48Otn
         BJjRJzsJVy8HfCrKzEzB2PoMR64mGZjhY6Xj5mGS5TV54P6zMZD/Ppamgg1miFsjjYuw
         rucA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707853093; x=1708457893;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7bxKZocdEiqoyhxdegqmhQihLPSri0Uq3BtRPxUJnFo=;
        b=ku0aXwvv/d8RB5g2opC5c082W15dYT49WnNASpYSvI8rd2ukv5+n8Iw4YWXzk73uOV
         no7itW4Gqf8mXGjLeiHWJPB91Ivsd9KknEVsiyYOZnKNj5pIKAR6kBt68K73HSEegAo6
         W84TDK1gVXhpAWlU4+gwqKFYLwzSCPfrlMbg7pko+wnx8pmEd2h5YdjO7ucBBL1KtuOE
         HCUP+F3K7XF1tVugyCNec8E4IX9fMCobeF5zA46SSZyWSX7MDZAJTAKGGGcSTnOBUWNq
         //5aXrczNG87YkYugvwguHDm6iA7wJJtD7ReSgiedx3TnKxGUjjReZ9geQ5pqFqHEqaR
         AaMg==
X-Forwarded-Encrypted: i=1; AJvYcCVq0HmMYQbiHlEfFeKiYT0ORuefz9qRw7+CzMhK0duLbvw1HKxhbxYaLBhpcR3LQaqAub3pjEeBpPuKeLHnpefJicWg9Fijj8AuoxXx
X-Gm-Message-State: AOJu0Yw0QMH7x0T2HEfj7fiqwyoDDXc9AyVapED6KXTQf+CxpwC/7co5
	2l7ZMEULoiLQIATsvJgAOeAMbzpuP8ju38UZWxD5Yef9w7dXUD1LLYQanMEtCIMhueg2SQDLMo/
	D6zcb5SsZOjMdw6BMMymEJ8/40pri6jZpL8UHVw==
X-Google-Smtp-Source: AGHT+IEdlfV6LUGLmxeJdIsOn87Xgz2StdXTzYIr3pkT+5iQVS9dR3Oaf/T6ltRAqvQ6qbHi8ala38CuM7GKA3GMx+U=
X-Received: by 2002:a05:6102:12da:b0:46e:c42c:e24a with SMTP id
 jd26-20020a05610212da00b0046ec42ce24amr465112vsb.14.1707853093237; Tue, 13
 Feb 2024 11:38:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+G9fYuVJ3DfmOR2GxbVmLqh_d=3y_wTXX-vQOUgp86uX-3oGg@mail.gmail.com>
 <87il2sw4tj.wl-maz@kernel.org>
In-Reply-To: <87il2sw4tj.wl-maz@kernel.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 14 Feb 2024 01:08:01 +0530
Message-ID: <CA+G9fYu-2x48SC6jYzuLVDsYt=FF8-9x9e0Nt0X2gb5G1PvdaA@mail.gmail.com>
Subject: Re: WARNING: arch/arm64/kernel/cpufeature.c:3369 this_cpu_has_cap
To: Marc Zyngier <maz@kernel.org>
Cc: Linux ARM <linux-arm-kernel@lists.infradead.org>, 
	Linux Regressions <regressions@lists.linux.dev>, open list <linux-kernel@vger.kernel.org>, 
	lkft-triage@lists.linaro.org, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Catalin Marinas <catalin.marinas@arm.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 14 Feb 2024 at 00:48, Marc Zyngier <maz@kernel.org> wrote:
>
> On Tue, 13 Feb 2024 18:21:23 +0000,
> Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
> >
> > Following kernel warning notices on all arm64 devices on today's Linux
> > next-20240213 tag.
> >
> > Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
>
> What is the sense of this tag, and even of this email, for an issue
> that has already been reported, as outlined below?

LKFT building and testing Linux next tree and found this warning on
today's Linux next-20240213. However it is been reported by someone
else.

You may ignore the tag.

>
> >
> > [    0.038524] SMP: Total of 6 processors activated.
> > [    0.038539] CPU: All CPU(s) started at EL2
> > [    0.038588] CPU features: detected: 32-bit EL0 Support
> > [    0.038602] CPU features: detected: 32-bit EL1 Support
> > [    0.038620] CPU features: detected: CRC32 instructions
> > [    0.038650] ------------[ cut here ]------------
> > [    0.038656] WARNING: CPU: 0 PID: 1 at
> > arch/arm64/kernel/cpufeature.c:3369 this_cpu_has_cap+0x1c/0x70
..
> >
> > This issue has been addressed in the relevant email thread,
> > https://lore.kernel.org/all/0593516b-2419-49b7-83aa-fe189ffad0c2@arm.com/

> Correct link:
>
> https://lore.kernel.org/all/86bk8k5ts3.wl-maz@kernel.org/

Thank you.

>
> > I will test the corresponding fix patch and get back to you.

I have tested your patch and the reported issue has been fixed.

- Naresh

