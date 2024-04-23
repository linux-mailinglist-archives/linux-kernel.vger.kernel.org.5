Return-Path: <linux-kernel+bounces-154355-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 098688ADB28
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 02:32:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DBC8EB233BC
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 00:32:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FA76F505;
	Tue, 23 Apr 2024 00:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XetfoTC2"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94F10184
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 00:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713832352; cv=none; b=AdMVGWL9wHvVuidgJWrOYn1pgBkjh6tf/yEUqSw100AiebO/3W4ysQQcCMzBzDaVmGtAVZxgyytj2VsKXRHXPvFwJLtiZR5KhYmYw+YboEjagZG23VP6V4hLq7wNlhoXmI8fqPgpQzq+N/qfx9D65KHsdR1WdccK0em1VVrTwxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713832352; c=relaxed/simple;
	bh=itx3ppvDXT8VS6nX8kv0qHKwC99CrFUC/qNlwzxzXlA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rOOyQ6V6oGJ9XrzEKQNspSx2Rq4mMmfdvxEB4n0Qw+ytEeI/DroP7v888w+92rYkcbNicPd0pd9opg/aNUwjvX9T4kpDGYI29BW7sS6FhX2C0m1kl2vBfIHJoMEG7RnSbdQ4ej99OLarkYN5QcBk2hLRAf899YfrgH88fmhfRPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XetfoTC2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713832350;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tCmzYdZTWhVBI3ziUJNs2kwLaL5ADy/aO28Jy0SKLfQ=;
	b=XetfoTC20wybfc9UtETB55zJSVJAHcvwjqdMgHOsvoDaF733k8qocemNvJv/msS+ctU5QR
	FbXfi3qGHqbn2TW7tLc1atA7BxLmqGboxZov0nmA1sR301o6Y8CePTinEwR7U8MQYPJyFB
	6tNUup9TpfmzaC0eS8dClyWKUn89x4A=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-522-ihDPbIvFP6C_tORFJHJoQg-1; Mon, 22 Apr 2024 20:32:29 -0400
X-MC-Unique: ihDPbIvFP6C_tORFJHJoQg-1
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-601fef07eaeso964869a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 17:32:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713832348; x=1714437148;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tCmzYdZTWhVBI3ziUJNs2kwLaL5ADy/aO28Jy0SKLfQ=;
        b=r8+h3W5BFoSDSy9lfnxSYAgyA6/Gyot6xWs+J0YbIOeaBkx9b+GG2989mrKXocl2Wj
         l6zFfz7VDPLiMbX1cWncOmb6V/EgdGS7eaXamW2Z56NB1wtCHvnjaFGW05IibPR/du74
         O1Og6X0kAzwiFwqcUW0BwMTGVCXT6JQe/IqLr8ALCRr29xVEMtFMy6+tEytxu8kqPFz7
         eumgEzE5P3W5w9NxJwfxDdn8cfY27S03dVDEI4WEXjrNyt1D/0gm+JWiJ0djfholpuUZ
         nXuCsJmiuOGWpfqTnc9jh0ALWq9AtVqVvyNULerylSnzvuKRMc53RVSmTgAp7CWLXfOm
         Zu0g==
X-Forwarded-Encrypted: i=1; AJvYcCUI8JLFGGvljG4AVSMT3deNrNwcwOLUnvmpCzFuioSMtVxwjysK7gFThJC/FjcGCq54Z/Pk9yJ8jj7KUQG/zdq9SOhf29fDiXFabKho
X-Gm-Message-State: AOJu0Yw2ZfNknSawbIHB12kuabM9N5rXAqc23AzYnIBqMBIIDnKDtwLC
	DBMW3rKzrJ1EdgYifR/G62PSdFgmie5bNEo3a/92KdLj9ltJCDB1oXYZUDIUYqztGhvQkEf768L
	L911bxOprvwO8JhGz6D0GzWNFdFAj2ITwkgYbz6aWBWorMczOFU3kyAr/K2W4Iw==
X-Received: by 2002:a05:6a20:9186:b0:1a9:40a1:a4e9 with SMTP id v6-20020a056a20918600b001a940a1a4e9mr17459127pzd.3.1713832347986;
        Mon, 22 Apr 2024 17:32:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGPFwlEkwtEe4z6JKUzvuIirWRzKBneJXlYzK+sGhH29LKwk/1srLPP9PxHQTHpNiXcEPgqhA==
X-Received: by 2002:a05:6a20:9186:b0:1a9:40a1:a4e9 with SMTP id v6-20020a056a20918600b001a940a1a4e9mr17459104pzd.3.1713832347621;
        Mon, 22 Apr 2024 17:32:27 -0700 (PDT)
Received: from [10.72.116.3] ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id ge3-20020a056a00838300b006ecfc3a5f2dsm8414894pfb.46.2024.04.22.17.32.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Apr 2024 17:32:27 -0700 (PDT)
Message-ID: <ef670902-edf0-43a3-9409-e0719514ba68@redhat.com>
Date: Tue, 23 Apr 2024 08:32:21 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/8] ceph: drop usage of page_index
To: Kairui Song <ryncsn@gmail.com>
Cc: Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
 Andrew Morton <akpm@linux-foundation.org>, "Huang, Ying"
 <ying.huang@intel.com>, Chris Li <chrisl@kernel.org>,
 Barry Song <v-songbaohua@oppo.com>, Ryan Roberts <ryan.roberts@arm.com>,
 Neil Brown <neilb@suse.de>, Minchan Kim <minchan@kernel.org>,
 Hugh Dickins <hughd@google.com>, David Hildenbrand <david@redhat.com>,
 Yosry Ahmed <yosryahmed@google.com>, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, Ilya Dryomov <idryomov@gmail.com>,
 Jeff Layton <jlayton@kernel.org>, ceph-devel@vger.kernel.org
References: <20240417160842.76665-1-ryncsn@gmail.com>
 <20240417160842.76665-5-ryncsn@gmail.com>
 <fc89e5b9-cfc4-4303-b3ff-81f00a891488@redhat.com>
 <ZiB3rp6m4oWCdszj@casper.infradead.org>
 <e5b9172c-3123-4926-bd1d-1c1c93f610bb@redhat.com>
 <CAMgjq7AKwxBkw+tP0GhmLh8aRqXA81i1QOgoqyJ2LP5xqeeJWA@mail.gmail.com>
Content-Language: en-US
From: Xiubo Li <xiubli@redhat.com>
In-Reply-To: <CAMgjq7AKwxBkw+tP0GhmLh8aRqXA81i1QOgoqyJ2LP5xqeeJWA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 4/22/24 23:34, Kairui Song wrote:
> On Thu, Apr 18, 2024 at 9:40 AM Xiubo Li <xiubli@redhat.com> wrote:
>> On 4/18/24 09:30, Matthew Wilcox wrote:
>>> On Thu, Apr 18, 2024 at 08:28:22AM +0800, Xiubo Li wrote:
>>>> Thanks for you patch and will it be doable to switch to folio_index()
>>>> instead ?
>>> No.  Just use folio->index.  You only need folio_index() if the folio
>>> might belong to the swapcache instead of a file.
>>>
>> Hmm, Okay.
>>
>> Thanks
>>
>> - Xiubo
>>
> Hi Xiubo
>
> Thanks for the comment,
>
> As Matthew mentioned there is no need to use folio_index unless you
> are access swapcache. And I found that ceph is not using folios
> internally yet, needs a lot of conversions. So I think I'll just keep
> using page->index here, later conversions may change it to
> folio->index.
>
Sounds good to me and thanks for explaining.

Cheers

- Xiubo


