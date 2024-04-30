Return-Path: <linux-kernel+bounces-163772-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BE2508B6FAD
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 12:31:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3C8D1C221C3
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 10:31:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB6A412BF32;
	Tue, 30 Apr 2024 10:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dcr7CkTh"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B1E726AEC
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 10:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714473071; cv=none; b=nrlaDAD1qIGVeeM9aPHno3QvBIKn7dZly6LzWMNGz3kAEo/g/LMhaxlM8yhlH9MhhcRgVd6DJauJ9FeJjqY2fAvWAvOjPemIRyk5Fz/A0tcNw0TELQbnEypSxqdh2qIqVG9ciRPkscMsXJEi/XUqIdJxOSz2/I1IbUL7PvNcn1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714473071; c=relaxed/simple;
	bh=fq9kl7HC1onkFs25GDO0h+u78xvNx/nppVe2nqgDwLM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qgq1qAfyJjV0F6E+AINigxSRG1H1GouJHyn9cbxXj7rLMkHEqh4G3LfKml7KXYPJg/vOrPbYg5IuqDJBsjjxrHFxqbuhDaVtYZti6QtPFJ4ftmIMXYoqQTGhBbyEbVhSBl8CWSV5PshX/btNEaSfuANu5rLHs5NjZsLYK+ROoLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dcr7CkTh; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5724736770cso8399a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 03:31:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714473068; x=1715077868; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DwW47iggG3BwAgDVmMpwtAGhvg781bYiNMy8bvB5pCk=;
        b=dcr7CkThygEnLlq8604zgf5GwMdRlHdAhl1rsv64KJXN+Spi3Jw6ErxO3JADwPKn50
         PFWUwyjiAbjXgkUDChzJGCBzqjIphKHpLRO0Dl0crirpO0tVHXuVsplL/H5GPfyEtBu1
         xjNAr+NVjIDQ+n12MmuTxZ47VLhBSrWiA8RoRcY7iMfZXB0geWyExibTYWTXMf8/d1nc
         mH+mwcA8jhcuFcl4DdxxtpGTxkJ/s+9GB/GJ9mHNXURnvrtVJSz+M+c21X6UNICArT+R
         hLJiU07hxhX1l1/d81vbWxC4VU9gL5VsP5ATqxWw2d1KWgRcUCY9IC0v1LQNvbyZF2ac
         wwCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714473068; x=1715077868;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DwW47iggG3BwAgDVmMpwtAGhvg781bYiNMy8bvB5pCk=;
        b=i/BNPpfA8CU3zHwt7XwuDzHwo/7NCVNlUFMKTJJ5o9W4+/TMj9u/jNxaX1/xweex3d
         iP42uHJ9BvPtDRS4ElnyNWEp40tiAv3Net1WzkgFhLfKqXqUmf3pjg0GG2AkdsNg0QpT
         XzmxrBqC9hjv/NNf5OJuGozDn0a94TwbjEn8o8xV17BcXyRUr4XunSnTSUFt/N1I550V
         +cc3fo33KsdNKego/qemoCIvLdaXRv3HshS4whx55iqjqHSMEPTZV+oJIgjb2/vbaqIr
         OONkcx2DBGa4o9jSlAM6tZWkrB6cHTypla1uJc31i+GTyPQiUFfKyw9USARiK15iba14
         Pv0A==
X-Forwarded-Encrypted: i=1; AJvYcCXaAQT02PHHpniVxGUHkJJzHuxLmd3NQwwVpMoHOmmI5Pb1HlsprqsSlndxemo+yR9QBfmrI5woVVKHCyRekmMvJCddIVq5LBZY9ngQ
X-Gm-Message-State: AOJu0YzJXrAA9uLkWmU0iQB4NMS7Rj6/ah2b2dpa1bbtNOIwAvJGt/57
	EzzNjuFrLsrzGedbb6je/ybwzTdRaYjxzLKSa6f47dmi29pvsopB7p52HDZrJySY+hQDuI5L0Uf
	LTcmZlOjhMkOARVYgt+kgGdwRkZcxTBLIFhPE
X-Google-Smtp-Source: AGHT+IECkVB2ejmKLRzAYSu/bpt95HY9NGBzyzWpXw0MNO2BKj2tO+28C3FXFOwKzHJZrv12YBLZM3JWoyd5mni2jbE=
X-Received: by 2002:a05:6402:174c:b0:572:7d63:d7ee with SMTP id
 v12-20020a056402174c00b005727d63d7eemr153109edx.4.1714473067350; Tue, 30 Apr
 2024 03:31:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240429221706.1492418-1-naresh.kamboju@linaro.org> <CAKa-r6vJjeYqGZERRr=B4ykLf-efPRY3h=HU3y3QxazwZ_cMAg@mail.gmail.com>
In-Reply-To: <CAKa-r6vJjeYqGZERRr=B4ykLf-efPRY3h=HU3y3QxazwZ_cMAg@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 30 Apr 2024 12:30:56 +0200
Message-ID: <CANn89iJ4go0oXSjRaxkdxsUFPCK8kcb8YPt+0d7isK9ZsFrpww@mail.gmail.com>
Subject: Re: selftests: tc-testing: tdc.sh: WARNING: at kernel/locking/lockdep.c:1226
 lockdep_register_key
To: Davide Caratti <dcaratti@redhat.com>
Cc: Naresh Kamboju <naresh.kamboju@linaro.org>, lkft-triage@lists.linaro.org, 
	regressions@lists.linux.dev, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, jhs@mojatatu.com, xiyou.wangcong@gmail.com, 
	jiri@resnulli.us, cpaasch@apple.com, pabeni@redhat.com, xmu@redhat.com, 
	maxim@isovalent.com, anders.roxell@linaro.org, dan.carpenter@linaro.org, 
	arnd@arndb.de, Linux Kernel Functional Testing <lkft@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 30, 2024 at 12:17=E2=80=AFPM Davide Caratti <dcaratti@redhat.co=
m> wrote:
>
> hello,
>
> On Tue, Apr 30, 2024 at 12:17=E2=80=AFAM Naresh Kamboju
> <naresh.kamboju@linaro.org> wrote:
> >
> > While running selftests: tc-testing: tdc.sh the following kernel warnin=
gs,
> > kernel Bug, kernel oops and kernel panic noticed with Linux next-202404=
29
> > tag kernel as per the available data.
> >
> > This build config is from kselftest merge config[1].
> >
> > Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> >
> > selftests: tc-testing: tdc.sh log and crash log
>
> the problem is created by [1]. I think that at least we need to guard
> against failures to allocate sch->cpu_bstats and sch->cpu_qstats,
> otherwise the dynamic key is registered but never unregistered (though
> the key is freed  in the error path of of qdisc_alloc() ). But there
> might be also something else; however, I can reproduce some similar
> splat, will follow-up on the list.
>
> sorry for the noise,
> --
> davide
>
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/c=
ommit/?id=3Daf0cb3fa3f9ed258d14abab0152e28a0f9593084
>

I just had  5 or 6 syzbot reports about this issue.

I tested the following fix.

diff --git a/net/sched/sch_generic.c b/net/sched/sch_generic.c
index 31dfd6c7405b01e22fe1b8c80944e2bed7d30ddc..d3f6006b563ccd8827b7af362ce=
9dceaa78f8841
100644
--- a/net/sched/sch_generic.c
+++ b/net/sched/sch_generic.c
@@ -982,6 +982,7 @@ struct Qdisc *qdisc_alloc(struct netdev_queue *dev_queu=
e,

        return sch;
 errout1:
+       lockdep_unregister_key(&sch->root_lock_key);
        kfree(sch);
 errout:
        return ERR_PTR(err);

