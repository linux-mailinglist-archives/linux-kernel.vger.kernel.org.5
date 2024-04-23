Return-Path: <linux-kernel+bounces-154781-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 554AF8AE0E9
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 11:22:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF1241F228BE
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 09:22:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 512DB56451;
	Tue, 23 Apr 2024 09:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="LKu3vxab"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0398056B65
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 09:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713864115; cv=none; b=CUeiq/S+7YxjZxkAkZdVzru/1ZoSp3cQW8zpKSWmii+jL/C8vVNgTAiALiVWKLkIXQOrtW6EfBiukAKBxA2VuF4prLTtv98Vie0PeytMj3YTJ/I4rOg6oYN2Wi36H72ol99hZRAPV1Jzpsrhuu1FWYTQ7XFzvw36S4avm+kHN9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713864115; c=relaxed/simple;
	bh=DdkrLe1RT9id5XgPQKF0YRBkxxjwVH7gEzkXmC6vFnk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DpGPkrV1sc2hNcW3KTYTzKsyb6lBpmlVJIWnDQ1T6F5mbANA+PHt+hBYiw7W/oyzCa06kOgKEWHSMP8Lw0nkgAoLlLA9KJJV8jYbFfwFgAyutQHKscxmalfbDXB2W7OuEsdH2WF3jYK2duiu1CcDPjLBtAsNkHTnSOTEMeZUKlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=LKu3vxab; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1e3ff14f249so38864725ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 02:21:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1713864113; x=1714468913; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2HQB5x5/Geh4QesSHMQ6J5Oee4AS8dKYNPWzhQc0IWE=;
        b=LKu3vxab4c9LM5B7qgMQZQeYJW+biUowjfP1G4A36SVw6mykQRcLDCgX9YBv1+Cm0z
         h4fRrjT9delL06LdPi6HpvHgdsqSHiTwkkHnHlrHukQ6vVnQsLwu+MSdqEX6Y5vjMhiU
         jQP2aOJqAeXSbCd7xtKOMGEqheCxoduPQLHYny1B04nrBrV7cTTDfsLFBJfC3geN2Cb+
         7cHaqlQ0uF+CNpOQWoeWb95qVnto5H84GuDJBr9DRpBAliUV6M4GQcXIKlPKx5zwmqte
         9foSH+1Hrw4/Cg795gyI0FZF14EXerM7/bpqODr/qwSwFNenDfhtE7Lm6cr7RRoyDvf5
         36kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713864113; x=1714468913;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2HQB5x5/Geh4QesSHMQ6J5Oee4AS8dKYNPWzhQc0IWE=;
        b=SxSfBtWMPt76omVmd+gOSgFeERjna7qtM0xEKZGSePZA9xzOMYtLa1wHcA3yWVQ/UK
         5yflY6TU7+J3s46vM5+a/0/X2rgTy/tFm4XZR1A2iKfD2//EweClzuvM6LeIb8Ewzaa8
         IgGaCRCuWiXUdmN5LlC9xfUhE2GXvhuOGsQaCDUCf0JOHx46myyqN2lRgqdgljNN0NT7
         Mp3Q0NWD/mjzgZatiD/TIsHA+y9Tfi+j0WVMyuXjoBWEjB/Xjxb7cFC0cQsrC1qwpNr7
         jCgDU0xUL+qCS4fwX2mbAfnrfjnAO3QWD3JgwABnjO0vrqo9VF4AJ1HwRiVZGqPKahZZ
         kfCg==
X-Gm-Message-State: AOJu0YwCBgMgsMOiDvMfRQpJGd0S233C2ZWucqZKo3pilgIfaVxqgNVi
	C0Dh2jxmtLq7Kz7UGwkzSOtvI8OAkJshslnztyQsIsY4eSY/2feuy7btIZ+QXnE=
X-Google-Smtp-Source: AGHT+IGNbPUgoPFYpHt28v7DULAEOmvD5VLEYjWmHxgKiyi3KxYYlHK+lL1oHrJ3+ZdleSTJCgMaQA==
X-Received: by 2002:a17:903:1206:b0:1e4:53b6:6be with SMTP id l6-20020a170903120600b001e453b606bemr2926772plh.1.1713864113257;
        Tue, 23 Apr 2024 02:21:53 -0700 (PDT)
Received: from [10.3.43.196] ([61.213.176.14])
        by smtp.gmail.com with ESMTPSA id h15-20020a170902680f00b001e89e7b2b74sm8884164plk.235.2024.04.23.02.21.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Apr 2024 02:21:52 -0700 (PDT)
Message-ID: <6e9d6af5-74bc-4e97-84c0-2ba8a6499da9@bytedance.com>
Date: Tue, 23 Apr 2024 17:21:48 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Re: [PATCH v3 2/4] virtio_balloon: introduce oom-kill invocations
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 virtualization@lists.linux.dev, david@redhat.com, jasowang@redhat.com,
 xuanzhuo@linux.alibaba.com, akpm@linux-foundation.org
References: <20240423034109.1552866-1-pizhenwei@bytedance.com>
 <20240423034109.1552866-3-pizhenwei@bytedance.com>
 <20240423051151-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: zhenwei pi <pizhenwei@bytedance.com>
In-Reply-To: <20240423051151-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 4/23/24 17:13, Michael S. Tsirkin wrote:
> On Tue, Apr 23, 2024 at 11:41:07AM +0800, zhenwei pi wrote:

[snip]
>>   #define VIRTIO_BALLOON_S_NAMES_WITH_PREFIX(VIRTIO_BALLOON_S_NAMES_prefix) { \
>>   	VIRTIO_BALLOON_S_NAMES_prefix "swap-in", \
> 
> Looks like a useful extension. But
> any UAPI extension has to go to virtio spec first.
> 

Sure, I'll send related virtio spec changes once virtio comment mail 
list gets ready.

>> @@ -83,7 +84,8 @@ struct virtio_balloon_config {
>>   	VIRTIO_BALLOON_S_NAMES_prefix "available-memory", \
>>   	VIRTIO_BALLOON_S_NAMES_prefix "disk-caches", \
>>   	VIRTIO_BALLOON_S_NAMES_prefix "hugetlb-allocations", \
>> -	VIRTIO_BALLOON_S_NAMES_prefix "hugetlb-failures" \
>> +	VIRTIO_BALLOON_S_NAMES_prefix "hugetlb-failures", \
>> +	VIRTIO_BALLOON_S_NAMES_prefix "oom-kills" \
>>   }
>>   
>>   #define VIRTIO_BALLOON_S_NAMES VIRTIO_BALLOON_S_NAMES_WITH_PREFIX("")
>> -- 
>> 2.34.1
> 

-- 
zhenwei pi

