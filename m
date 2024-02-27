Return-Path: <linux-kernel+bounces-82941-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C916868C06
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 10:18:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6BF52887A7
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 09:18:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 077AD13665C;
	Tue, 27 Feb 2024 09:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F7VUfwPz"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A936654F95
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 09:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709025493; cv=none; b=G0TIaIwsSqE9A/GapGxe7QE0xeq86NWRBd3H3X8iiJXd7gJDBT749r2CgK0A0J6bOx9EOffjN0tclFrZx10qqsiYylgSII0vi4C0CwfvgEuSZFpSa1DyoMNggK0wBMSvoyc+ew5+q7pr2Ui0PFBToy8szsqvVAdArmVb0U20I9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709025493; c=relaxed/simple;
	bh=icw9hDzczG6NRSI9i+UHINfj7g3hqqlgLsarV3VBat8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U3/ctkmVMZksGOU3cQRKN+gH3nqcNpkT5i4IYTi5EYCEebTiseskTd7tcRi3ZvgcFtbD6mWsgXQzH8evakGHXaLyGN4r5mBJ2OHn4UWuXY7fhSw49ToAgC/6QTYgEmJzKzQX6ksRzjDiRaVu1PPPW4bBzMcLky2tsUh4eo2v9E4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=F7VUfwPz; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709025489;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=o6dYvXHudHEuAAoRhDLi1kJCGzItpw+TxOdgKckxHfs=;
	b=F7VUfwPzQAdXqbC9M/oyXs/f6ibBJ0AGt9OsbDQLd5H+Wb1cDIyPL5O7LgLi7rmHIJdvsr
	UuC/ah1LYEpQqUHIncIbWkkoTLVu4IEYRWMYKOhlOPa49bS21B0RXoPJlt1SvGq9ZxloY7
	zxyC7lAdsP0/J+Ryd7DDchJBoigcvKw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-694-2bZuXZUZMdy8bea47pq_5A-1; Tue, 27 Feb 2024 04:18:07 -0500
X-MC-Unique: 2bZuXZUZMdy8bea47pq_5A-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-41294023627so20008155e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 01:18:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709025486; x=1709630286;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o6dYvXHudHEuAAoRhDLi1kJCGzItpw+TxOdgKckxHfs=;
        b=q0P6d2tR3FKUr5EB/bE5vRu9bKNjLA/i3XUCIbKncboQ897maRfvDBjX3FEF5XepU3
         WELzGZul+7TB/x3QLCNlGLamWtovpqot33qWKFxATmVKdHFXH/d82PAaGpX1If3xe8C2
         2LK02g06/4CL/+cRmj+rhfnv8Y6AMcXGCKI+PRlFVPJnlBfgBw5TUPPTJquT+S6O87fu
         e8AlmKQMElO0XcJ+SDwQwFP5JhBSOynEvi0HjOwOu+WfIGqe4CJQ+i5DG+2CwrHJHXPY
         ErnqaK0PP9qXdQvJYcNtE2n7yWYDQQExHuGeDhheKgaQyrU1iTTbt0sPBb4f1xXreGIO
         JjOA==
X-Gm-Message-State: AOJu0YzhQ3XUzPJLkui+0+7VT3Ybx17JtWXgfaHAiu5kJB+yDie9B+En
	cNA4f1SLnt85gF7FJxnxLkaqZ/rPkJXASazdYnd2GxlQZisX6FINgeVJ4B0nYH3FK4pdX6anzvu
	yK91HzNOWvxSBaGXXM3eAmhcz1ZmDXYMXzJiEtctmH0jRrbYWKoj1sPkw+D7d7A==
X-Received: by 2002:a05:600c:4ed3:b0:412:9228:d999 with SMTP id g19-20020a05600c4ed300b004129228d999mr5923512wmq.39.1709025485936;
        Tue, 27 Feb 2024 01:18:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFioeNT3rRZcbrYAX2d47M8BooowmSFbCesyH/cANQsWAhY8pubM3cDogh7JLmk/QEC47YJmw==
X-Received: by 2002:a05:600c:4ed3:b0:412:9228:d999 with SMTP id g19-20020a05600c4ed300b004129228d999mr5923497wmq.39.1709025485563;
        Tue, 27 Feb 2024 01:18:05 -0800 (PST)
Received: from ?IPV6:2003:cb:c707:7600:5c18:5a7d:c5b7:e7a9? (p200300cbc70776005c185a7dc5b7e7a9.dip0.t-ipconnect.de. [2003:cb:c707:7600:5c18:5a7d:c5b7:e7a9])
        by smtp.gmail.com with ESMTPSA id p37-20020a05600c1da500b00412b011458fsm23765wms.30.2024.02.27.01.18.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Feb 2024 01:18:05 -0800 (PST)
Message-ID: <7fda8dac-6590-46da-a3ad-8e463196aa85@redhat.com>
Date: Tue, 27 Feb 2024 10:18:04 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: export folio_pte_batch as a couple of modules might
 need it
Content-Language: en-US
To: Barry Song <21cnbao@gmail.com>, akpm@linux-foundation.org,
 linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org, Barry Song <v-songbaohua@oppo.com>,
 Lance Yang <ioworker0@gmail.com>, Ryan Roberts <ryan.roberts@arm.com>,
 Yin Fengwei <fengwei.yin@intel.com>
References: <20240227024050.244567-1-21cnbao@gmail.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240227024050.244567-1-21cnbao@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 27.02.24 03:40, Barry Song wrote:
> From: Barry Song <v-songbaohua@oppo.com>
> 

Nit: "mm: make folio_pte_batch available outside of mm/memory.c"

> madvise and some others might need folio_pte_batch to check if a range
> of PTEs are completely mapped to a large folio with contiguous physcial

s/physcial/physical/

> addresses. Let's export it for others to use.
> 

Nit: "Let's make it available in mm/internal.h"

(talking about exporting and modules sounds like EXPORT_SYMBOL)

> Cc: Lance Yang <ioworker0@gmail.com>
> Cc: Ryan Roberts <ryan.roberts@arm.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Yin Fengwei <fengwei.yin@intel.com>
> Signed-off-by: Barry Song <v-songbaohua@oppo.com>


-- 
Cheers,

David / dhildenb


