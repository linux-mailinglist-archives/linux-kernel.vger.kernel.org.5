Return-Path: <linux-kernel+bounces-132397-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 92E9C899403
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 06:05:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23F4C28C459
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 04:05:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E2C01BDDB;
	Fri,  5 Apr 2024 04:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I0ASJ46Y"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 500D01862A
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 04:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712289933; cv=none; b=mnYjzXBA4NhqJrpiZ3+f2L+zi6ZoUBNxBNrr3DNaU3zKxPL1Z9ln8ff/HcCAw+cb4ynhoHNCHj+8pZrizDMfhoSXC+xJPDwTAyzfzBDtXn2di9Bpq4g0exFDpP5VBb6RaJuFSHQfKe4+ypmX6vahyp6WpQL9gvFum+Gh9T6N2SM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712289933; c=relaxed/simple;
	bh=gqyjj/Eo1Vtsk483fwioEQIV2oUH44+3JDu8URIsiSs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kbXu836JvvvAZx8x+jgjFoTzFL1JlLk7Rc65viq+5OUNjpuvE/N/FSm29J8Q8yg3m8rqeuGar8ZIG/HNHSU6KyNScm8u+VB5IieG6EKc+Gl6GUt4BBYn5/6ka4RJgGRdwqsR99mcqJudYcNdj8GGnClpn8VS0dXY4sIVJJH/n5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=I0ASJ46Y; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712289931;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZGrPB/H9yPWmIzqqGBy0eAcd5YhV6gPBs+sOvrfSvPY=;
	b=I0ASJ46YqdnOGtz/Q7MJUFJ53QvA+HpRO7e0+4vGYIU1KcSwgwQG7uS44EJcPwp0UEh6QR
	2FUt5nWvM6K7KT6gFNt7cxGUPa6sWjOukLwiZFi/10zjN/12sa/fZ6S6AOwj8CTRiyN73H
	jdFOmFltmo/LQJ1zf5U33oCuewJEiPE=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-498-__3qfnlJMha28BRQJKW_yA-1; Fri, 05 Apr 2024 00:05:27 -0400
X-MC-Unique: __3qfnlJMha28BRQJKW_yA-1
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-6ea81b74262so1302205b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2024 21:05:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712289926; x=1712894726;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZGrPB/H9yPWmIzqqGBy0eAcd5YhV6gPBs+sOvrfSvPY=;
        b=frwakWRPKIPURhTGvLMGXn8A5mQgkl9SLlr1KEIDHGevL0sBhgRjWn5lrzGiisyRnK
         Yz9RyXpSqDYHpbFBMMXo/Kqc9He9fdvxJaMOPLRTJGyTv+i7/cqso1ISGT/H1QxLK+wy
         B5xhBWKFM7ljqEumf1vSDQp1Muj+sILGZOGyz6tLvu47Fx1vQCaTjca0OVba4Pc3ft8I
         Y9HQAC0Fzqsxmubp5A1cSohZmsxEBUJ+BDYksn8Clpi0w4UhVfsUXcneeNvU2HT3Mnck
         Y+EoPksDzh+w/8MC69xYYHVA1TJIckxXga325jcOI2sJHx+9AHr0dao+a1ROub3ZJRfE
         8WTA==
X-Forwarded-Encrypted: i=1; AJvYcCWHmS2FnxzlyhFba0zqjCvCqGvd1TzxPL/D1Vf4Go1dI9OPJa/MnQ2KbWLH9hVM3OmOf6CX04Vop+L+pIJOk8qfT7D3vL0OSavHOpj3
X-Gm-Message-State: AOJu0Ywhm0o5gPQ+no7P02xUNqrPZzksW/0JO3F6acRKR1vz8P67P2zR
	CChpEq0jRBrBanhDh7CYDVLCOXvC6ZXpO9jdDA3Lkm56G5KLGjKGOSEDqEe2gZSNXD7KyrgUH7J
	ROSlKM8fI9kSuzS8ewaFak/pIVdyNU0gv5T18TZ7z+3VeOUmvbwjnMG0D82KqOQ==
X-Received: by 2002:a05:6a00:1951:b0:6ea:df65:ff7d with SMTP id s17-20020a056a00195100b006eadf65ff7dmr466287pfk.10.1712289926615;
        Thu, 04 Apr 2024 21:05:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFf/hfJGnBmdG96vjXdTOouaBzcWwgcp8BZJu/B1ue87UC4xkFN5J2cKfHnAX1AMqnIipueiA==
X-Received: by 2002:a05:6a00:1951:b0:6ea:df65:ff7d with SMTP id s17-20020a056a00195100b006eadf65ff7dmr466270pfk.10.1712289926276;
        Thu, 04 Apr 2024 21:05:26 -0700 (PDT)
Received: from [192.168.68.51] ([43.252.115.31])
        by smtp.gmail.com with ESMTPSA id r6-20020a056a00216600b006e724ccdc3esm474322pff.55.2024.04.04.21.05.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Apr 2024 21:05:25 -0700 (PDT)
Message-ID: <d3a22c89-cab5-45be-af8b-e65c1a244524@redhat.com>
Date: Fri, 5 Apr 2024 14:05:18 +1000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] arm64: tlb: Fix TLBI RANGE operand
Content-Language: en-US
To: Marc Zyngier <maz@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 catalin.marinas@arm.com, will@kernel.org, akpm@linux-foundation.org,
 oliver.upton@linux.dev, mark.rutland@arm.com, ryan.roberts@arm.com,
 apopple@nvidia.com, rananta@google.com, yangyicong@hisilicon.com,
 v-songbaohua@oppo.com, yezhenyu2@huawei.com, yihyu@redhat.com,
 shan.gavin@gmail.com
References: <20240404053624.1485237-1-gshan@redhat.com>
 <87il0xsdc0.wl-maz@kernel.org>
 <d0b2f9d0-228f-488d-94b8-79f01f17e4e8@redhat.com>
 <87frw1rq1v.wl-maz@kernel.org>
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <87frw1rq1v.wl-maz@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/5/24 03:33, Marc Zyngier wrote:
> On Thu, 04 Apr 2024 11:26:20 +0100,
> Gavin Shan <gshan@redhat.com> wrote:
>>
>> In summary, we need 3 patches but the one fixing __TLBI_RANGE_NUM needs to be
>> PATCH[1/3] so that it can be easily picked by stable kernel. PATCH[2/3] would
>> be to improve __TLBI_VADDR_RANGE with masks. PATCH[3/3] will allow __flush_tlb_range_nosync()
>> to do range-based TLB flush for MAX_TLBI_RANGE_PAGES.
> 
> That's about it indeed.
> 

Thanks Marc. v3 was posted for further review.

https://lists.infradead.org/pipermail/linux-arm-kernel/2024-April/917700.html

Thanks,
Gavin
  


