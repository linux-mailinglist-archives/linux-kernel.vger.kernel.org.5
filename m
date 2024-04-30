Return-Path: <linux-kernel+bounces-164637-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DBB3C8B807D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 21:25:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A0226B2243F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 19:25:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08456199E84;
	Tue, 30 Apr 2024 19:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HV1wMxQk"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF45E7710B
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 19:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714505139; cv=none; b=NXH32bYd+axXnFjDZXKHVrpnr+gMKmZeRN9wcqKxJeD/HIfAAbKvoBFyTIBQ7U9Psh0mVBtu3vTo+kFEynvkNdDkvi0Sj8V283m0aTmqEVAzFSAfqXt9iihzfxyGvp1iJjJXpYyzjFkGqS6RG96WzAbfEiZh0rFQ9L3YldH2tu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714505139; c=relaxed/simple;
	bh=zmMxgervacDaHsVq7PofJWwKs+AoLNVMNCFfOexepAQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h46FcoyobVE5KJKkC2uUTtfuugaiIbv2muVbNh+gekk/TnZ4ohyyZ3G+hjza9PEJAnO3RsEjZYsZD62UjK8qR3wqgzf/2yugUoJvdAL7osULMsxvpBn+0/FXmCblQjdjIhEJTnc5aX7ikEaQv+t6JZAfFEm50M8sZ1Zx6VlovF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HV1wMxQk; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714505136;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Sml+apiELoPNP3CvzMuGtYw372bsozMO9mfooXuYDlk=;
	b=HV1wMxQkoMwMsbknI59XvgRNIC6Qv9Z48ENrbbxDQmD2QFXxfDQDyi2uEF6ro19YTNE7sF
	0XuxGJN5cA4ybhSfw0RCL7M0j4Cg4Cm4E8DKvXUKZ4aJs3XoJJ6S9gPQdB7POnGOeVsnh9
	W7x2Ixt4S5MI+mC/CJ/Mj/DdiFBrIwQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-209-qCBr_l8HN0-bXjRotkcyBg-1; Tue, 30 Apr 2024 15:25:35 -0400
X-MC-Unique: qCBr_l8HN0-bXjRotkcyBg-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-34dc7b83209so55573f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 12:25:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714505134; x=1715109934;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Sml+apiELoPNP3CvzMuGtYw372bsozMO9mfooXuYDlk=;
        b=Q/8sRd7zgg7db1xcWo0p6b0X3sv8flGy5dhfcMKlOTAMifR0cIJ2xvmXqmM26yO8bh
         VocRHo2uXXwy6X8xs02bmQ5k/PkoFXgBUlR2PyA2eBVCcMuRnSyJOLDlaVkcw2FQm/HF
         WpeImE7oJohHTJe9gJPWdR1nQy4wfJeVvL9ef/TgD698Ke8hFSwOUekW2tW8YmuxwK2l
         qvZkl6NwujKwhufYPvk7WWUipmbdolS55aqeQkAlRb4G5zwMX2aqd/qHRfCe0c48s4Sc
         GorJp/YZ13dy6Td0x8dKoIxsvWglheE2oK8wCbPy82mB6grX9tOSnONqcu+Wr3SC1/30
         T/Fw==
X-Forwarded-Encrypted: i=1; AJvYcCUfbbUjOPDeG1ACmSS1IrsQwTePJF+w+bWcX+9rU5+eHk95ACg6jVEhmvM9B9apOy20xoA3xY0iyGdvjPNxDrJda2BO4tWagSF3F5wn
X-Gm-Message-State: AOJu0Yzmj4kHQth9e/u7l2lX5Zkffdb4K/lxoIaU+6g5sUIHw+/t+kL0
	/fBIGkF7ia6etNdMN43g/yEWsuAbej5kr6npiMDZIZ7YWOD+RHUAh6ZXyorPGZhJoP3Q9uVlvOe
	JSHPI5Na06pUII47/DHAEo0neDFxYHKm3bEj3j2haxbfrLAWwPfnlTAxThcvPcg==
X-Received: by 2002:adf:ec4e:0:b0:34a:3f3d:bb14 with SMTP id w14-20020adfec4e000000b0034a3f3dbb14mr372792wrn.27.1714505133913;
        Tue, 30 Apr 2024 12:25:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG4uhEiExqEYYZxn/B7q0uI5d5m/WLmdfFl1SLcz2mLWdf0JRp3urAf+J6ZV+dZOqctYlmLZQ==
X-Received: by 2002:adf:ec4e:0:b0:34a:3f3d:bb14 with SMTP id w14-20020adfec4e000000b0034a3f3dbb14mr372783wrn.27.1714505133499;
        Tue, 30 Apr 2024 12:25:33 -0700 (PDT)
Received: from ?IPV6:2003:cb:c707:3d00:d57f:b4c9:850e:d0b8? (p200300cbc7073d00d57fb4c9850ed0b8.dip0.t-ipconnect.de. [2003:cb:c707:3d00:d57f:b4c9:850e:d0b8])
        by smtp.gmail.com with ESMTPSA id bl2-20020adfe242000000b0034c71090653sm11135935wrb.57.2024.04.30.12.25.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Apr 2024 12:25:33 -0700 (PDT)
Message-ID: <8a7b9e65-b073-4132-9680-efc2b3af6af0@redhat.com>
Date: Tue, 30 Apr 2024 21:25:32 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC][PATCH] uprobe: support for private hugetlb mappings
To: Guillaume Morin <guillaume@morinfr.org>
Cc: oleg@redhat.com, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, muchun.song@linux.dev
References: <ZiaoZlGc_8ZV3736@bender.morinfr.org>
 <22fcde31-16c4-42d0-ad99-568173ec4dd0@redhat.com>
 <ZibOQI9kwzE98n12@bender.morinfr.org>
 <8d5314ac-5afe-41d4-9d27-9512cd96d21c@redhat.com>
 <ZilvOi7ceSXmwkNq@bender.morinfr.org>
 <b1cf78f8-8480-4451-bbf8-78694ebd0438@redhat.com>
 <Zip0fEliGeL0qmID@bender.morinfr.org>
 <e84a82b8-b788-499c-be79-e6dcb64ac969@redhat.com>
 <Zirw0uINbP6GxFiK@bender.morinfr.org>
 <385d3516-95bb-4ff9-9d60-ac4e46104130@redhat.com>
 <ZiwGovSHiVCF7z6y@bender.morinfr.org>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <ZiwGovSHiVCF7z6y@bender.morinfr.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 26.04.24 21:55, Guillaume Morin wrote:
> On 26 Apr  9:19, David Hildenbrand wrote:
>> A couple of points:
>>
>> a) Don't use page_mapcount(). Either folio_mapcount(), but likely you want
>> to check PageAnonExclusive.
>>
>> b) If you're not following the can_follow_write_pte/_pmd model, you are
>> doing something wrong :)
>>
>> c) The code was heavily changed in mm/mm-unstable. It was merged with t
>> the common code.
>>
>> Likely, in mm/mm-unstable, the existing can_follow_write_pte and
>> can_follow_write_pmd checks will already cover what you want in most cases.
>>
>> We'd need a can_follow_write_pud() to cover follow_huge_pud() and
>> (unfortunately) something to handle follow_hugepd() as well similarly.
>>
>> Copy-pasting what we do in can_follow_write_pte() and adjusting for
>> different PTE types is the right thing to do. Maybe now it's time to factor
>> out the common checks into a separate helper.
> 
> I tried to get the hugepd stuff right but this was the first I heard
> about it :-) Afaict follow_huge_pmd and friends were already DTRT

I'll have to have a closer look at some details (the hugepd writability 
check looks a bit odd), but it's mostly what I would have expected!

-- 
Cheers,

David / dhildenb


