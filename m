Return-Path: <linux-kernel+bounces-134779-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AFFB489B6C6
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 06:15:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2AF661F218B8
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 04:15:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CE9E63BF;
	Mon,  8 Apr 2024 04:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cJjj1s8w"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FFF24C8A
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 04:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712549738; cv=none; b=guQe9KsKyY1P1dy+HjeDDyxLK5Q8bGorjUqFadaGF+lHovAAD+Dn/GAlSsEDgucvYbUt/qvRhgbC46RJKV907l63PTOHYPfz4Z8To6YF4rsYuAEfDtuZQHDeXLZ0U/MwuORgrvUCfxMq92C0RshnIbiETGt9UzEyEGgKwKLSu4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712549738; c=relaxed/simple;
	bh=HS6zRCwXRp8mHfW5n/V4KSKw4rQNg96xJBCGcj8rkBQ=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=OdKLIpnw5TAd/h9oTQN35QYCk42Q2N2Hu1pScLXFNyFRXCEjY20zbEIbgBDrFF3ci4AzPZnj3H8W9hckH1p5XOn8V/HP2cRWBp80zuveujlN9/fSq5TrJDQ8FFIravHdPDsecOOUnfL6G/3EYXhijAufkC+PalMEyeQZxfS73r0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cJjj1s8w; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712549733;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uMI9Rc+vz00z1+F9UYkKs5XZT6R+0Na57ZuSQun0rhU=;
	b=cJjj1s8wmOQxhmVtCI3bwyVbtONpatJSAFHlnSaoE51/Ytl0DftC5TzjTEAB+bHkhvZlup
	XKqPBzvh6FzlkEhgCmq0lOzw+ys/yStw047KJSQmXHKYDpjWgnFxipzCtTA2kkyGj77KrY
	p+EIvwhKl7ah11+QGWRFICAokQ6mST4=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-444-VadGXABcMDqtdkqXGkiLFw-1; Mon, 08 Apr 2024 00:15:32 -0400
X-MC-Unique: VadGXABcMDqtdkqXGkiLFw-1
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-5f034b4db5bso2004469a12.0
        for <linux-kernel@vger.kernel.org>; Sun, 07 Apr 2024 21:15:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712549731; x=1713154531;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uMI9Rc+vz00z1+F9UYkKs5XZT6R+0Na57ZuSQun0rhU=;
        b=Jity051mrOldV8AY7AZjjin+OnvL8Aekz6nPyIJyvzsWHS6b/fNe5u63iU40cuyFAA
         69GrzppAxKBrm+PaUwoiZUHUrm1eiwYnFpxtA/PFh1uykRLZIQcyDx9ye0eI9zIR/jov
         TymDv5W/059FPfMhnnSF9dJrZqRUThiUP6AUMVfdRe3FPk/lfMA3iLnKIIqSI/f+qk5r
         mi7vGh21gtnOA6Y1tNMvYAELD4UZj9Edk1kbQ9uo0guS8y+w24VPhHp3YjGX6hyXKbqr
         azHf9p9RT/O8gWZy74JW9zYDC7+mENxBchPC4wT5os8iN58WLh4jsBiiGFJn8PAfs5wa
         kErQ==
X-Forwarded-Encrypted: i=1; AJvYcCUNjeZ7rw0arhHkyT9AYsNbFNOPZyx9y7bfpflscgTcEt9gXpYB0nwYTdKJt7GPspknaN8nvDuar488PiYzgE49fx5ni/C1BKfNyZkv
X-Gm-Message-State: AOJu0YxYPTSkDFde9RdlvCYOjUR0TkmQvwX1gYYc6xMh5xFezQqKL9bs
	3cGk7S3ziKeVXLxoSuZbt2zDTJeR0iGJMexE6DNnl4pcPu39HwOC7wpbfm2+rpE6jCZBp/nLm/X
	KMX2W6P0iIoNDW2KaBIgGZvgs2gbpFt1WdHnXtf4M4pQf9NJuApvXGBL0PPz/oQ==
X-Received: by 2002:a05:6a20:2d28:b0:1a1:776d:15c with SMTP id g40-20020a056a202d2800b001a1776d015cmr8260137pzl.21.1712549731543;
        Sun, 07 Apr 2024 21:15:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHA+NbFsEoe8HareLS7Zq9uR/kEBk9cR4T7P0ee0wsdTPqVFXoP5RW7T6CWr6sI/JI7rVhP3A==
X-Received: by 2002:a05:6a20:2d28:b0:1a1:776d:15c with SMTP id g40-20020a056a202d2800b001a1776d015cmr8260127pzl.21.1712549731247;
        Sun, 07 Apr 2024 21:15:31 -0700 (PDT)
Received: from [192.168.68.51] ([43.252.115.31])
        by smtp.gmail.com with ESMTPSA id 60-20020a17090a09c200b002a47e86fd5esm5126799pjo.4.2024.04.07.21.15.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Apr 2024 21:15:30 -0700 (PDT)
Message-ID: <b41d65de-dc43-45f6-ba6c-ae722fbb70a8@redhat.com>
Date: Mon, 8 Apr 2024 14:15:24 +1000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] vhost: Improve vhost_get_avail_idx() with
 smp_rmb()
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
 jasowang@redhat.com, will@kernel.org, davem@davemloft.net,
 stefanha@redhat.com, sgarzare@redhat.com, keirf@google.com,
 yihyu@redhat.com, shan.gavin@gmail.com
References: <20240328002149.1141302-1-gshan@redhat.com>
 <20240328002149.1141302-4-gshan@redhat.com>
 <20240328052814-mutt-send-email-mst@kernel.org>
 <8faa07aa-d330-4e3f-95b7-26437d448beb@redhat.com>
In-Reply-To: <8faa07aa-d330-4e3f-95b7-26437d448beb@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Michael,

On 3/30/24 19:02, Gavin Shan wrote:
> On 3/28/24 19:31, Michael S. Tsirkin wrote:
>> On Thu, Mar 28, 2024 at 10:21:49AM +1000, Gavin Shan wrote:
>>> All the callers of vhost_get_avail_idx() are concerned to the memory
>>> barrier, imposed by smp_rmb() to ensure the order of the available
>>> ring entry read and avail_idx read.
>>>
>>> Improve vhost_get_avail_idx() so that smp_rmb() is executed when
>>> the avail_idx is advanced. With it, the callers needn't to worry
>>> about the memory barrier.
>>>
>>> Suggested-by: Michael S. Tsirkin <mst@redhat.com>
>>> Signed-off-by: Gavin Shan <gshan@redhat.com>
>>
>> Previous patches are ok. This one I feel needs more work -
>> first more code such as sanity checking should go into
>> this function, second there's actually a difference
>> between comparing to last_avail_idx and just comparing
>> to the previous value of avail_idx.
>> I will pick patches 1-2 and post a cleanup on top so you can
>> take a look, ok?
>>
> 
> Thanks, Michael. It's fine to me.
> 

A kindly ping.

If it's ok to you, could you please merge PATCH[1-2]? Our downstream
9.4 need the fixes, especially for NVidia's grace-hopper and grace-grace
platforms.

For PATCH[3], I also can help with the improvement if you don't have time
for it. Please let me know.

Thanks,
Gavin


