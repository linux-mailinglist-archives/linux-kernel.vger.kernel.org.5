Return-Path: <linux-kernel+bounces-66979-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E6B3C85645C
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 14:29:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 856CE1F229F6
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 13:29:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA0CB12FF88;
	Thu, 15 Feb 2024 13:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fIi2kKdx"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1BDE130AD3
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 13:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708003750; cv=none; b=GLziREP125nAHoB45ma1l7xYJzeqpQHvkVWowJmvJwiK8jEIs4kVmWggNRvE/ok/GSd2C9JPAkBpfLnD/8JpfmpzxQInSMfpwodA1P6iAAIhPQRiQPhFMwhAbptHn2qfcRfO8H3GWUnQ/6jcRsyNMwPg1I2l25tYOMetzAliBWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708003750; c=relaxed/simple;
	bh=5eeVkjyvudX/pKW1hZPYEgCAdxgDwkfCTULdfvhHo34=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XZUiRrvS2rw4LZWl4AOcl7OsEVcPsFtX+Id7Twxrg3cPsnom89g6WNwTV33jfLqBslH6/6vhQDmuSSBaUDVzQPSnYNwaXNWm5pnhHW1uz3ZxS736nbis+xSkiYDBlr16Lz4lEcm5DYyyVg1EDrzO+v0YOM8PS20uLWMb1/IKnRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fIi2kKdx; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708003747;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5eeVkjyvudX/pKW1hZPYEgCAdxgDwkfCTULdfvhHo34=;
	b=fIi2kKdxi6c/z2Gze5kvSwiUpHLV/+S9QQMNDg2AlLKsU7MhInBbwm0CH0iy18lD667IB2
	teiScUIRzzJdTo+CHSrwvC9Yeb3Sfl3dSguWg76oiYopwdNmcIw+N3pPylK4VbbKsuFmoL
	GPpVWfZHiMP+FLdn+rdkiTQsrF6ZHcc=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-207-guwUvk8nN-yG5PPP6LDCyg-1; Thu, 15 Feb 2024 08:29:06 -0500
X-MC-Unique: guwUvk8nN-yG5PPP6LDCyg-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a2bc664528fso61754666b.3
        for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 05:29:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708003745; x=1708608545;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5eeVkjyvudX/pKW1hZPYEgCAdxgDwkfCTULdfvhHo34=;
        b=Q8xl9SLiH76w7CeR8E4yBAnRb85HbVVfIRnv+Ox0zX6XwSRDAIxHDnqK79U4wVKwMs
         08jBNo4hHmeUEKfK5UKk4L1iCLwS5gi5iLcoLtbnZfYWDzQsNqNdJ1XfcB2zl6juJqZP
         oJ0M8WLwU9nf5rDq2BOHYBk9eOl6/eoFAAorLdqplE6IxhH0foqDd5jbuzhrKDXWuzSx
         6gyHRRw55uvp/pSOqsfohmLbCa//RpyFYAoYXez5RuqgJWD3otuMR93HoZIr2ZfaXkeY
         uqPW9jD5uuAoizs2wCZ6cq2G8N9w01zZS64fI4pGv4Vm9q1tOUOa31tp3HIsVUm4ZZVN
         ooGA==
X-Forwarded-Encrypted: i=1; AJvYcCV0M/3jtR6m6OY7bm8Nho7uDLKIQjFkqkct5dUUfKQAhGwPy5bvGfZZg11Ctsrx43Xfe1uJEOC5SUqsgAdSLvrOD1zNNS4gik/OPF+4
X-Gm-Message-State: AOJu0Yy37Bjhu7/hham2ByXdDAuM5BLZEm0opuuF1N9FwMwamc+31jBa
	jdt3MoJbCX6mWDh35N8kD2rTv8PRxdXpAQo6i+f85GKdm0ISbfcm520b7l3zm6Vr46Sg034VVbG
	zfQ9Z1X6yyTZ/s7Q59jF2SQs1PFs2/+WpBHiKXDgis5TvnYCkJBQgLFh0V07vkQ==
X-Received: by 2002:a17:906:24d7:b0:a3d:3781:6edc with SMTP id f23-20020a17090624d700b00a3d37816edcmr1280806ejb.55.1708003745155;
        Thu, 15 Feb 2024 05:29:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHenfB7DY75o/58zvNxuONlHdNOgFk3aJKOzSO8iJ3lT0l6WsgAs9wbABWWtdZ7pihKzcwGfA==
X-Received: by 2002:a17:906:24d7:b0:a3d:3781:6edc with SMTP id f23-20020a17090624d700b00a3d37816edcmr1280785ejb.55.1708003744827;
        Thu, 15 Feb 2024 05:29:04 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id vh2-20020a170907d38200b00a3d784f1daesm539293ejc.132.2024.02.15.05.29.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Feb 2024 05:29:04 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id EC50910F59BF; Thu, 15 Feb 2024 14:29:03 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Alexander Lobakin <aleksander.lobakin@intel.com>, Lorenzo Bianconi
 <lorenzo@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] page_pool: disable direct recycling based on
 pool->cpuid on destroy
In-Reply-To: <8aa809c0-585f-4750-98d4-e19165c6ff73@intel.com>
References: <20240215113905.96817-1-aleksander.lobakin@intel.com>
 <87v86qc4qd.fsf@toke.dk> <8aa809c0-585f-4750-98d4-e19165c6ff73@intel.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Thu, 15 Feb 2024 14:29:03 +0100
Message-ID: <87plwxdffk.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Alexander Lobakin <aleksander.lobakin@intel.com> writes:

> From: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
> Date: Thu, 15 Feb 2024 13:05:30 +0100
>
>> Alexander Lobakin <aleksander.lobakin@intel.com> writes:
>>=20
>>> Now that direct recycling is performed basing on pool->cpuid when set,
>>> memory leaks are possible:
>>>
>>> 1. A pool is destroyed.
>>> 2. Alloc cache is emptied (it's done only once).
>>> 3. pool->cpuid is still set.
>>> 4. napi_pp_put_page() does direct recycling basing on pool->cpuid.
>>> 5. Now alloc cache is not empty, but it won't ever be freed.
>>=20
>> Did you actually manage to trigger this? pool->cpuid is only set for the
>> system page pool instance which is never destroyed; so this seems a very
>> theoretical concern?
>
> To both Lorenzo and Toke:
>
> Yes, system page pools are never destroyed, but we might latter use
> cpuid in non-persistent PPs. Then there will be memory leaks.
> I was able to trigger this by creating bpf/test_run page_pools with the
> cpuid set to test direct recycling of live frames.
>
>>=20
>> I guess we could still do this in case we find other uses for setting
>> the cpuid; I don't think the addition of the READ_ONCE() will have any
>> measurable overhead on the common arches?
>
> READ_ONCE() is cheap, but I thought it's worth mentioning in the
> commitmsg anyway :)

Right. I'm OK with changing this as a form of future-proofing if we end
up finding other uses for setting the cpuid field, so:

Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>


