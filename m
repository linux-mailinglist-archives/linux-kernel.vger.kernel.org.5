Return-Path: <linux-kernel+bounces-102589-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A60FB87B451
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 23:26:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30093286ADA
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 22:26:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBE7C59B6C;
	Wed, 13 Mar 2024 22:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b7MgKrCo"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 947A059B4D
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 22:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710368797; cv=none; b=NvIvDGFHOOY400NL1bXILbuXoHcjmQcoTfByz7Y0gkdifNcnCADk/DybaTOWjbpowvnFLD6hTlLhuc7oIl4EXpRV5D/CTz/g2QXC0xLyzjZUzr5Mnx3ttu9BwFdqy6YvqZqpFkORL7IKjgJQd6QZqhs7fuFHL5A/I4qqzNEk/iM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710368797; c=relaxed/simple;
	bh=9l4GN0ED0DK/GGygB+LgC/xsWQauGR6CXlrGH+hem84=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=XxfWrOjlxOZzUZ3Vdcihw8z+mJDfoSbeNNleFdwtPBlIEIaAcxB5Qb6YSBAFTTUCeJpS7Ylld8fb3RBL/H9OJFFzNVdIfyta3E5aD70EqzRsYzYmuNZ7bIGvvKsQzl7xNNx2xnau0ypNWpSZy3bpQ7/qN5NetzaEZK+SKhR9bBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=b7MgKrCo; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710368794;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=TEVDwJXX84y5L0n1tmhtEPizUS9bA6evHI5uoMWVQCQ=;
	b=b7MgKrCoDs3LADle1LCK3MRvvTGCq85ZkJ0iek55M6xTG7SUPAtu8Xg1oRpPYfXHAqqhuk
	CVA+eGteNHM3C7ERd51XkVHiHpfeMDKAwKjn4Y2flakn34TBIb60C07nQThl0D0U12jhiU
	XvPyNxSECFr8smzYvGjXgTlyQucmOvY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-655-OZsQCkfcNG-eHL8D7NYlEA-1; Wed, 13 Mar 2024 18:26:25 -0400
X-MC-Unique: OZsQCkfcNG-eHL8D7NYlEA-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-33d51bb9353so98771f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 15:26:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710368784; x=1710973584;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:from:content-language:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=TEVDwJXX84y5L0n1tmhtEPizUS9bA6evHI5uoMWVQCQ=;
        b=PlbD5eqlrQlzotZqMAb1XIM1MpVQxgCPTpbuwbUDuwlzjZEIX1hqON5KBKIl008dFk
         4ELVih0poH+v7YdEnwKNvMllKNCKGPWoaiTF0P7faQwIL2aqhpcOuQhhU87WSgmoCCnm
         a6dVj5+31Cmhf8wwBgxMb/oSlckH0da2tV4dMW7RYd7LEs9mhiHpJH40Crl7LzvI569V
         TCoYIOnAgpsjD6MxgbzKhpgkJeuWfn9Vpg3svQUiy2wZAQb94oVlQtmGafitPVniuLqo
         o8pb7RnF0O02X9N7bTKtmjdh8c1k0m2b8dpLcm1oKfCvtiDyiy8yr8dmwGoV9B8V610b
         +0yw==
X-Forwarded-Encrypted: i=1; AJvYcCVS8owclOqOGohiSGcDCdexYpwCg59KMO89hqmSp+Pz4UNgfu43XCVDE1p26kNSYrtbO2/+gJbfq9qhiCAFTlP2cADT/rXV6oUjbLGK
X-Gm-Message-State: AOJu0YzOrdcKKfHiAWyhpoSP1hEj+Id3a6Or3G8o/asUy3k/SxrZj4wS
	aWkMVtZwPS5HIuJZ5M4x7seAzRVChcLg7FybgY+13IJQ4mbS5YBCSqFV+5fYrqRhO9WCU8vNM8c
	W+y2bxtd5LzpTaG2SWMX6aa+H1tw1HDUtfS5jWvuuoLeA/yKeMq3eqY85oSQQlg==
X-Received: by 2002:a5d:6101:0:b0:33e:6056:6b84 with SMTP id v1-20020a5d6101000000b0033e60566b84mr2622589wrt.2.1710368783993;
        Wed, 13 Mar 2024 15:26:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGo18HcMBQyZG2Or6jsxJRYvakM9UTXNeyDpb4irgy9JX7554u1opD+jxQfgyJUaFcDT55W4Q==
X-Received: by 2002:a5d:6101:0:b0:33e:6056:6b84 with SMTP id v1-20020a5d6101000000b0033e60566b84mr2622582wrt.2.1710368783578;
        Wed, 13 Mar 2024 15:26:23 -0700 (PDT)
Received: from ?IPV6:2003:cb:c70e:2600:cd60:7701:f644:b131? (p200300cbc70e2600cd607701f644b131.dip0.t-ipconnect.de. [2003:cb:c70e:2600:cd60:7701:f644:b131])
        by smtp.gmail.com with ESMTPSA id iv14-20020a05600c548e00b00412ee7d65a6sm400743wmb.6.2024.03.13.15.26.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Mar 2024 15:26:23 -0700 (PDT)
Message-ID: <ce552774-d02a-4408-b0f3-2ad94ff36e42@redhat.com>
Date: Wed, 13 Mar 2024 23:26:22 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/memory: Fix missing pte marker for !page on pte zaps
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
To: peterx@redhat.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Muhammad Usama Anjum <usama.anjum@collabora.com>
References: <20240313213107.235067-1-peterx@redhat.com>
 <c04c81bc-dfc1-4dd6-972c-23c2eb8a5d0d@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <c04c81bc-dfc1-4dd6-972c-23c2eb8a5d0d@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 13.03.24 23:03, David Hildenbrand wrote:
> On 13.03.24 22:31, peterx@redhat.com wrote:
>> From: Peter Xu <peterx@redhat.com>
>>
>> Commit 0cf18e839f64 of large folio zap work broke uffd-wp.  Now mm's uffd
>> unit test "wp-unpopulated" will trigger this WARN_ON_ONCE().
> 
> Good that I added the WARN_ON_ONCE() :)
> 
>>
>> The WARN_ON_ONCE() asserts that an VMA cannot be registered with
>> userfaultfd-wp if it contains a !normal page, but it's actually possible.
>> One example is an anonymous vma, register with uffd-wp, read anything will
>> install a zero page.  Then when zap on it, this should trigger.
> 
> Are you sure? zap_install_uffd_wp_if_needed() contains right at the start:
> 
> 	/* Zap on anonymous always means dropping everything */
> 	if (vma_is_anonymous(vma))
> 		return;
> 
> So if that's the case the unit test triggers, I'm confused.


Ah, got it. It's not that we have to place a marker, just that it can 
happen. Of course it can. All makes sense.

Thanks!

-- 
Cheers,

David / dhildenb


