Return-Path: <linux-kernel+bounces-92122-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CFD90871B61
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 11:35:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A3CD2824F9
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 10:35:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 365D65C8E9;
	Tue,  5 Mar 2024 10:21:47 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47F455C61B;
	Tue,  5 Mar 2024 10:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709634106; cv=none; b=tqyoebWnzLgmfkK3rQTk7DHik24Vfo4DkaSMSZUj1LT8TlRojAlIIV1zQzwDYstmO0juwdaPOL0uagmFMnZ2EvY87eTAsvva7tPNEgVlmtsa1vFhfZvYgiqKIuf8/8n0lMvVT0kqaz0UIE/WGGrlV1+9NPxwA5XFBuGwRlr2X6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709634106; c=relaxed/simple;
	bh=8S16sXtwAgHSHRMb86X0XL9T++tc3lWptZlKqW0nI1c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ksEHbaapA/S0v60a8524VLSmHcBMdkC4L1AzCUg74ifY0ADfJX6A12sMGWzEV2aw/jRXTo+feL+7xoi12Dp+4ZqCrFiUjKiY190s9ZCWPiSouw2lUV52OEskmM7P2szCxkxRcAIlB2mwet1V8XDXh3xj79QXFe7NPq1aryRjffQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 10EF51FB;
	Tue,  5 Mar 2024 02:22:21 -0800 (PST)
Received: from [10.57.11.67] (unknown [10.57.11.67])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7A2743F762;
	Tue,  5 Mar 2024 02:21:42 -0800 (PST)
From: Balint Dobszay <balint.dobszay@arm.com>
To: Sumit Garg <sumit.garg@linaro.org>
Cc: op-tee@lists.trustedfirmware.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 jens.wiklander@linaro.org, corbet@lwn.net, sudeep.holla@arm.com,
 rdunlap@infradead.org, krzk@kernel.org, gyorgy.szing@arm.com
Subject: Re: [PATCH v2 1/3] tee: optee: Move pool_op helper functions
Date: Tue, 05 Mar 2024 11:21:40 +0100
X-Mailer: MailMate (1.14r5937)
Message-ID: <ABE8D9AB-8F66-49F4-B442-F74EC2EF5C04@arm.com>
In-Reply-To: <CAFA6WYMocdcQXaqk8hS8dwnfwJLNWKWSEfMLO4wXyCQM=TQ8vQ@mail.gmail.com>
References: <20240223095133.109046-1-balint.dobszay@arm.com>
 <20240223095133.109046-2-balint.dobszay@arm.com>
 <CAFA6WYNW9-7gCZQSEaV=Gcr+GLdu25rQ8MpTg9yNpX7OwyZ0Tg@mail.gmail.com>
 <4E68610D-8F2B-4E27-AE5C-45CB59D7FEC0@arm.com>
 <CAFA6WYNz57v_S9CBQHUjvPdzcP9FWuDN0ciPNvgUZY_-m3JKRg@mail.gmail.com>
 <1A75CF74-D486-4A3B-9004-250F870D7330@arm.com>
 <CAFA6WYMocdcQXaqk8hS8dwnfwJLNWKWSEfMLO4wXyCQM=TQ8vQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable



On 5 Mar 2024, at 6:36, Sumit Garg wrote:

> On Mon, 4 Mar 2024 at 19:57, Balint Dobszay <balint.dobszay@arm.com> wr=
ote:
>>
>> On 4 Mar 2024, at 10:17, Sumit Garg wrote:
>>
>>> Hi Balint,
>>>
>>> On Mon, 4 Mar 2024 at 14:33, Balint Dobszay <balint.dobszay@arm.com> =
wrote:
>>>>
>>>> Hi Sumit,
>>>>
>>>
>>> [snip]
>>>
>>>>>> diff --git a/include/linux/tee_drv.h b/include/linux/tee_drv.h
>>>>>> index 911ddf92dcee..4cf402424e71 100644
>>>>>> --- a/include/linux/tee_drv.h
>>>>>> +++ b/include/linux/tee_drv.h
>>>>>> @@ -275,6 +275,17 @@ void *tee_get_drvdata(struct tee_device *teed=
ev);
>>>>>>  struct tee_shm *tee_shm_alloc_priv_buf(struct tee_context *ctx, s=
ize_t size);
>>>>>>  struct tee_shm *tee_shm_alloc_kernel_buf(struct tee_context *ctx,=
 size_t size);
>>>>>>
>>>>>> +int tee_shm_pool_op_alloc_helper(struct tee_shm_pool *pool, struc=
t tee_shm *shm,
>>>>>> +                                size_t size, size_t align,
>>>>>> +                                int (*shm_register)(struct tee_co=
ntext *ctx,
>>>>>> +                                                    struct tee_sh=
m *shm,
>>>>>> +                                                    struct page *=
*pages,
>>>>>> +                                                    size_t num_pa=
ges,
>>>>>> +                                                    unsigned long=
 start));
>>>>>> +void tee_shm_pool_op_free_helper(struct tee_shm_pool *pool, struc=
t tee_shm *shm,
>>>>>> +                                int (*shm_unregister)(struct tee_=
context *ctx,
>>>>>> +                                                      struct tee_=
shm *shm));
>>>>>> +
>>>>>
>>>>> These rather belong to drivers/tee/tee_private.h as we shouldn't
>>>>> expose them to other kernel client drivers.
>>>>
>>>> As per the discussion in the other thread I'll ignore this.
>>>>
>>>
>>> Then it will have conflicts with this [1] patch. If you are fine to
>>> incorporate [1] in your series then the right place for these functio=
n
>>> declarations should be include/linux/tee_core.h.
>>>
>>> [1] https://www.spinics.net/lists/kernel/msg5122983.html
>>
>> You're right, I'll rebase my patches on this.
>>
>> By incorporating your patch in my series, do you mean that I should ju=
st
>> add it as the first patch in the series for the next version?
>
> If you are happy to carry it then I would be in favour of this to take
> care of dependency.

Sure, I've added it to v3.

Regards,
Balint

>> Or keep my
>> series as is (do the rebase of course) and just mention that it's usin=
g
>> your patch as base?
>>
>> Regards,
>> Balint
>>
>>>>
>>>>>>  struct tee_shm *tee_shm_register_kernel_buf(struct tee_context *c=
tx,
>>>>>>                                             void *addr, size_t len=
gth);
>>>>>>
>>>>>> --
>>>>>> 2.34.1
>>>>>>

