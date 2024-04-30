Return-Path: <linux-kernel+bounces-163756-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 016908B6F73
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 12:18:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81B092848BD
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 10:18:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 316AD1422A6;
	Tue, 30 Apr 2024 10:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ujiw2/sQ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C577213D2B3
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 10:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714472278; cv=none; b=n2zSJHxASu48zZrj/ffUu1OS1F0Y6P5EjP1GKjpleP7Ec+9YqfcGGgutvry/NGef69PpWayJIM2r47RuBbFIhImAN7sj6AZN3aHELmb1mx+X+eg5/YlXreBa8nU272c+ULcVtte0x8F3npnYQ2iI9XIY5JemkKEdRD+R1OBxRpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714472278; c=relaxed/simple;
	bh=DxCBfW2ZX60itdmD+i2ZLg8FWHGDeeOaWCry5xKcra0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rES6PwPwQiO9g7LNL3bpHnB9Yxx9UHLBTn4rHJV4OAHbZt9J53Kgq0LbqsLel4mVTiAuTjTrIBUlitOVdd9JN7G77okVxRQwk8IxX8KAvbMmQpYL7HoqgfXEl5L5xiym6odiaEBj6faDG+71tlz0cJymbfEEbh0zBKOy40wW9z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ujiw2/sQ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714472275;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2WgfcDzbL6BdRnbQ/LMHjtoVFL3IiamXBZRn2Dk0E7Y=;
	b=Ujiw2/sQhjh+EbZy4TR39jWD5+NwqeMdhfkKbOa/OrMp4zhhhQh/EddZ3JFxyOkWX4R2YA
	bBkHOTwXnxoqpOxEvzWWBIvNm0BBHZQrYWUSlKJ1Iligbp9udvhNhbTzbkb4XAMoKBkpRl
	MzuBKqxJ3Jv8Vb05vKShetFOdo3ArYU=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-55-jcYydcosNPO3wtcrLuFzvA-1; Tue, 30 Apr 2024 06:17:53 -0400
X-MC-Unique: jcYydcosNPO3wtcrLuFzvA-1
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2ae8013ac66so6797354a91.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 03:17:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714472273; x=1715077073;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2WgfcDzbL6BdRnbQ/LMHjtoVFL3IiamXBZRn2Dk0E7Y=;
        b=TB+vxYw9tMR8pPZCDD0kMQ6FWoe65ZX8UGy/n2Ov1v3FkDoi49LitJcc5ng6QphF5M
         QKcQYR1NJk3UhlIANQhtemfgMjCPtWtvnYSPOjHwrHwTmJxJDjztB5Dct76bNaX4YsWC
         snnlZ70Nn515fPtRClxZdUcJMXAfZCABIlNk+5sTWgcGjDG8cfFQ6aawOq8MDawGE1LX
         iqj6M07rFyuClJ9G4XB9OIwz3+2D39DXpOE+MIAok4s45LG2zo6yFI8u32em62uKn8nc
         wdS9U9dYUDYk9xQ2ml45GcXSQnV31ncdDrk2Aq5gvYuDBhB0RiGlrZY52G9F3qnlJUe4
         +7tg==
X-Forwarded-Encrypted: i=1; AJvYcCWNIstxV3G/jspktInDXDmTGAx4zaUHgRbdN42MZ0VKnA0ke+fQX4W430p8wRURxXYFNq5ArRdH4bMTzcvNzSUvwDeRMm4Oc3jsCuT5
X-Gm-Message-State: AOJu0Ywsc5RLF0+V5AxNOyBKbtEtyPzUwO7/alfLmJTJOLEFhuQy99Zl
	8U6XaRx+hzkkCQS/MLbG7cxnxN1/NLLwySOoxgEOZrIx2mekX+RN+h+770rkIKjxKqwKjzuvZtb
	aeX3TKBpQjhZZH91K0rjbxsYd4YzZNLsM5X1S1qrcyDBQtLxH7SHnqnv0abbLeX/TElxuTIlwL5
	6JQFRoQI9nx7BxNWOgxt+/dyMkv59VOpDUFBm5
X-Received: by 2002:a17:90b:3d86:b0:2af:4f4e:79a7 with SMTP id pq6-20020a17090b3d8600b002af4f4e79a7mr12470161pjb.30.1714472272807;
        Tue, 30 Apr 2024 03:17:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFWSpkNXoLaxHPhUhC5NZ72tcHc7cFhFDuXAR7cTPWqMf81MdK6/Q7OPe/FNtSys3J7tuhnJJXuDUF4sBjb72Q=
X-Received: by 2002:a17:90b:3d86:b0:2af:4f4e:79a7 with SMTP id
 pq6-20020a17090b3d8600b002af4f4e79a7mr12470138pjb.30.1714472272243; Tue, 30
 Apr 2024 03:17:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240429221706.1492418-1-naresh.kamboju@linaro.org>
In-Reply-To: <20240429221706.1492418-1-naresh.kamboju@linaro.org>
From: Davide Caratti <dcaratti@redhat.com>
Date: Tue, 30 Apr 2024 12:17:41 +0200
Message-ID: <CAKa-r6vJjeYqGZERRr=B4ykLf-efPRY3h=HU3y3QxazwZ_cMAg@mail.gmail.com>
Subject: Re: selftests: tc-testing: tdc.sh: WARNING: at kernel/locking/lockdep.c:1226
 lockdep_register_key
To: Naresh Kamboju <naresh.kamboju@linaro.org>
Cc: lkft-triage@lists.linaro.org, regressions@lists.linux.dev, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, jhs@mojatatu.com, 
	xiyou.wangcong@gmail.com, jiri@resnulli.us, cpaasch@apple.com, 
	pabeni@redhat.com, xmu@redhat.com, maxim@isovalent.com, edumazet@google.com, 
	anders.roxell@linaro.org, dan.carpenter@linaro.org, arnd@arndb.de, 
	Linux Kernel Functional Testing <lkft@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

hello,

On Tue, Apr 30, 2024 at 12:17=E2=80=AFAM Naresh Kamboju
<naresh.kamboju@linaro.org> wrote:
>
> While running selftests: tc-testing: tdc.sh the following kernel warnings=
,
> kernel Bug, kernel oops and kernel panic noticed with Linux next-20240429
> tag kernel as per the available data.
>
> This build config is from kselftest merge config[1].
>
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
>
> selftests: tc-testing: tdc.sh log and crash log

the problem is created by [1]. I think that at least we need to guard
against failures to allocate sch->cpu_bstats and sch->cpu_qstats,
otherwise the dynamic key is registered but never unregistered (though
the key is freed  in the error path of of qdisc_alloc() ). But there
might be also something else; however, I can reproduce some similar
splat, will follow-up on the list.

sorry for the noise,
--=20
davide

[1] https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/com=
mit/?id=3Daf0cb3fa3f9ed258d14abab0152e28a0f9593084


