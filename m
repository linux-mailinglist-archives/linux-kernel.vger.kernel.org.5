Return-Path: <linux-kernel+bounces-56915-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3517E84D158
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 19:41:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B06471F22742
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 18:41:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1093A84037;
	Wed,  7 Feb 2024 18:41:47 +0000 (UTC)
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A0AE41C91;
	Wed,  7 Feb 2024 18:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707331306; cv=none; b=ZSCEUYRQk++JGzyvRyEtahKqaFL/LeDHiWH2DV4ll0AOVGCGt2+7OiGera8uDi2YqkrG8ewaZsbNr6XuqDC9Tgvj5SDCF0zL/rV2+d+zw9ft3Ibt7AtwELY5XUVaHfKtULfqdxVMCD77oXtJn+7xxjtOg73bjbepZqkstNoGMr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707331306; c=relaxed/simple;
	bh=LbVL5RmiqfFAGVDDrMbFn7+nEaeBOAF0DjlcOQRg/aA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UNZP6Ky26GJoyE7pBThcr0OHfhkETN9fdaUKPI9z+bel37cpL+yrkOYV3M6ZbVKwu1U6UEjfXbqaD/svr338IKxLhmscMNpTo4C1cy6XUeS39rQ/jHmBK8vkbdyjCm6eRDplarqmeKR1A2JQx52GhNHi9wrXsAENgEKsg0aIbc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-59cbf204d52so34157eaf.1;
        Wed, 07 Feb 2024 10:41:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707331304; x=1707936104;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7Gw4hg2CsAnVovJphC9v6Pju8JP+Q+4f7seH5ViqG7U=;
        b=UEdcMQ4Hx0yY/O07RvA4oAuwtJwCYoABQMyYqUEIphQP9vJ8QD90Jgds7yxiq7t5Y0
         2MikwJLcYglz7VbuynwWEfJDuXCP4NBiPAIw8CPtgUGIyk4Ed3t+96HmzOSU+Kf1bZdr
         KW5c+JBmumi7SUISSUOsbZ5BJOEs1GXjcKMYNV6WkkVa8rRo302nHQagy0cx6TRszh+F
         ylFAt51gw3i6dG9POlVDOtTFJ9+JFS87AfEHGBYaBcNj3wYblN3kVrDKQKDjsG5XZs/c
         HOAXxMWjk7U5SuFPdp2ri2cMzQj/aoI2xavWzCEDOLi9hcfdAfV+BfQxg94ShcekUr6h
         +cSA==
X-Forwarded-Encrypted: i=1; AJvYcCWZn1FA8kwUzEW8cvnvr8bi9LCgbPOlpG3GWNDCLBd3LOLFWFravFIUyJ0/ylHfgebfd9ggyPXg5YSoojMlcOrwGujKXW3vFoKQ6bWz/1p6/aWYDAnyvrDoiHciRQTMLZ9MmwOD9YI=
X-Gm-Message-State: AOJu0Yxa2bFBKFRpKODUyFjlGJRZbl/1eeHrxiY1tXpkHCeGpb4zVf+h
	pduC8NpsiOFCinGxQMbve0LcCLl9Ry5xYveaT0IpJ4X4cvs9ZWTMdVwXvj8xRAXWrMIgfn2zNj4
	x1iwVKIIYmZXODK+ckp/OZYeTotk=
X-Google-Smtp-Source: AGHT+IFCwoySUxsvCRaxKigTHi96KtA8b9mAsRTDbrXUSmgZ36sJ5gi2n+QduvJA4WYqJNfz3K+zYS3V6Cf99mXCIpA=
X-Received: by 2002:a05:6870:9110:b0:219:75d2:a39b with SMTP id
 o16-20020a056870911000b0021975d2a39bmr7211911oae.3.1707331304073; Wed, 07 Feb
 2024 10:41:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CGME20240207103144eucas1p16b601a73ff347d2542f8380b25921491@eucas1p1.samsung.com>
 <10423008.nUPlyArG6x@kreacher> <708a65cc-79ec-44a6-8454-a93d0f3114c3@samsung.com>
 <CAJZ5v0hn=KgaWn9pwtLsH2a8n61BNxzb1xrNoxUfEi3o9OAZGw@mail.gmail.com>
 <4a043533-009f-4db9-b107-c8374be28d2b@samsung.com> <CAJZ5v0hDmwaFEtLc8yDc4cXn2wODXAqATe0+_Hpm9QPODUPMQw@mail.gmail.com>
 <ZcOyW_Q1FC35oxob@slm.duckdns.org>
In-Reply-To: <ZcOyW_Q1FC35oxob@slm.duckdns.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 7 Feb 2024 19:41:32 +0100
Message-ID: <CAJZ5v0idXY3A=PydQHxA+SxbCnsaXv=6UBoXTeZuZr-Pxsmmiw@mail.gmail.com>
Subject: Re: [PATCH v1] PM: sleep: Restore asynchronous device resume optimization
To: Tejun Heo <tj@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Marek Szyprowski <m.szyprowski@samsung.com>, 
	"Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, 
	Ulf Hansson <ulf.hansson@linaro.org>, Nathan Chancellor <nathan@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	Naohiro.Aota@wdc.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 7, 2024 at 5:40=E2=80=AFPM Tejun Heo <tj@kernel.org> wrote:
>
> Hello,
>
> On Wed, Feb 07, 2024 at 12:25:46PM +0100, Rafael J. Wysocki wrote:
> > The other one is that what happens during async resume does not meet
> > the assumptions of commit 5797b1c18919 (for example, it can easily
> > produce a chain of interdependent work items longer than 8) and so it
> > breaks things.
>
> Ah, that's fascinating. But aren't CPUs all brought up online before devi=
ces
> are resumed?

They are.

> If so, the max_active should already be way higher than the
> WQ_DFL_MIN_ACTIVE. Also, are these multi node NUMA machines?

They aren't.

> Otherwise, it really shouldn't affect anything.

Well, it evidently makes a difference.  I'm wondering what difference
it can make in that case.

> One easy way to verify would be just bumping up WQ_DFL_MIN_ACTIVE and see=
 what happens.

Sure.

