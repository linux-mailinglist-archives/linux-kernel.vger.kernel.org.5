Return-Path: <linux-kernel+bounces-153608-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B0858AD056
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 17:10:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6BD0288EFF
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 15:10:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 222F915252E;
	Mon, 22 Apr 2024 15:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DMrZFIg/"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C44FE5025E
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 15:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713798625; cv=none; b=a5FyK6qrRnzQ/4vSxrqsDaAT9IcPSbOCD3I58Hf8r03FTSBbhnS0zwZ9VWFvHZPwUEZdLgyTS3OKB/BSdaE1GyxdMkBdB34aHD66LGJDat+iBvzAWPl37IleLPh8V21VIIgvnHju0tGU0Xoo9rh1Rp5PzmS+ipZitaLdzyZjTro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713798625; c=relaxed/simple;
	bh=25K6GfwEwLIIqeJ+YjgS0qk1C8QuwawLw8l+q6uhR1E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ChOKM9/AwqITZIRYm2oPdSPs4wVHiIDG+boRmLXUo+z/wTdlSyZkfVvdrH+6m5dUcje+NDtQHRqsthxyLS2W0W4hmWsaSrExJbCAI/aiATFgGXOFtSbp0Rwgnb+5/nVVs3boZpTWgDk1dG+dFpzn5M7AkCqnnU4JwKdfD3peIfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DMrZFIg/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713798622;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=SYEYMI/hb8rZwyL8ySST/HIo0ivLCTpK54/UiDi1T8k=;
	b=DMrZFIg/VV/siamirBrVy8NgGcuubqKmPMHt2sWF7V7U75hRZ9IhDg82e5epM5enN74z5P
	qF41oUbYN2LGLJdEzI1MkUt5WiB8BEnaelBubZFxVkPvkps066o8aPybFT/dvrCcayTS5E
	Uz16qh6P0Dyr18zTWeeM+bkJ1cNeh5g=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-625-OR-mJHEQOEu7TUZYWktVuQ-1; Mon, 22 Apr 2024 11:10:18 -0400
X-MC-Unique: OR-mJHEQOEu7TUZYWktVuQ-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-343e54fc19bso3317527f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 08:10:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713798617; x=1714403417;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=SYEYMI/hb8rZwyL8ySST/HIo0ivLCTpK54/UiDi1T8k=;
        b=i9Vl46RV/iu5Rjp1ZpPe1XHLzzlKY4aBxuVerhqmCvUrFsfhWmy48GmrR3XD5EqjwC
         b57hBMT5s/Em/aQqF+/WxKJ4KKnV/lMvt1ORle2AtlCE4H1HF0mdQacnk+1M0+75M05L
         AQ4xbvI/5kwHhKPzG4WI7H2Y9nG59L4OhAfnDI8i/UY1DaAILoErcVNzVHVc6DQUwn4l
         hv66LQAPskWQIr2zngmrtrPE/Dt97wy4Y61sxxArzEwD9PxdwGnvARNH/q3WxEj2iaaX
         Fhw5vskI25oGHYC7u+J06SXO7n9Fe0CFUx+iq9hlIIVRcNNcSxiVcUoJiBdTyudVCtZA
         nR2w==
X-Forwarded-Encrypted: i=1; AJvYcCW9r7XxB6tfKlUqqxEilg/M/UXyVfwaICFn5lNvvzVFbefs9uhK9ptShHLzNMr/Uu4Lg0u55ntl5TEXvG6tFCAOlt7SpdZ9cqS1evkX
X-Gm-Message-State: AOJu0Yz9GdHosCkfYZ6A9NigCdUtxgXKeCCQKXdGhjDkWyQUb8xorFX8
	QylbdqCOnzCYNQW15kX7+5Y8Tpr2emp3oGnW0myI1cOJc7hl9ywo2K10TufFMxWo3biKfSynsvP
	D2PD1PSY/IhDXXj3m8Ut16AQuFT8LEvD1Wkq++69hd63M8pH1MV5UmSLMHMK+sw==
X-Received: by 2002:a05:6000:dcf:b0:34a:e778:e619 with SMTP id dw15-20020a0560000dcf00b0034ae778e619mr3213268wrb.6.1713798617394;
        Mon, 22 Apr 2024 08:10:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFmq5aYiLF7UA58hgkQ7TGVLtzBPCrZwmPKMkhx2U6LnXQsk2f2JUVBo1gL5VqLUmchtG0Zhg==
X-Received: by 2002:a05:6000:dcf:b0:34a:e778:e619 with SMTP id dw15-20020a0560000dcf00b0034ae778e619mr3213246wrb.6.1713798616964;
        Mon, 22 Apr 2024 08:10:16 -0700 (PDT)
Received: from ?IPV6:2003:cb:c739:600:d2fb:3a8a:9944:7910? (p200300cbc7390600d2fb3a8a99447910.dip0.t-ipconnect.de. [2003:cb:c739:600:d2fb:3a8a:9944:7910])
        by smtp.gmail.com with ESMTPSA id j1-20020a05600c1c0100b00419ea5fb0cbsm9148814wms.42.2024.04.22.08.10.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Apr 2024 08:10:16 -0700 (PDT)
Message-ID: <bb3605e1-81e6-45a3-bd08-79662b371049@redhat.com>
Date: Mon, 22 Apr 2024 17:10:15 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [mm?] WARNING in __page_table_check_ptes_set
To: Peter Xu <peterx@redhat.com>
Cc: syzbot <syzbot+d8426b591c36b21c750e@syzkaller.appspotmail.com>,
 akpm@linux-foundation.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 pasha.tatashin@soleen.com, syzkaller-bugs@googlegroups.com
References: <000000000000ca4df20616a0fe16@google.com>
 <71cf84d4-77d2-42d7-a649-b67497b171f6@redhat.com>
 <a4c4c508-0d04-428c-b674-ec6e8847ea9f@redhat.com>
 <bbeb3704-e4a6-42fa-90e7-28de1e885249@redhat.com> <ZiZmCl3fTFfIYf1t@x1n>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <ZiZmCl3fTFfIYf1t@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

>> commit f369b07c861435bd812a9d14493f71b34132ed6f
>> Author: Peter Xu <peterx@redhat.com>
>> Date:   Thu Aug 11 16:13:40 2022 -0400
>>
>>      mm/uffd: reset write protection when unregister with wp-mode
>>
>>
>> close should behave just like unregister.
>>
>>
>> Simplified+readable reproducer:
>>
>> #define _GNU_SOURCE
>>
>> #include <stdint.h>
>> #include <fcntl.h>
>> #include <sys/syscall.h>
>> #include <sys/mman.h>
>> #include <sys/types.h>
>> #include <sys/ioctl.h>
>> #include <linux/userfaultfd.h>
>> #include <unistd.h>
>>
>> int main(void)
>> {
>>          void *src = mmap(0, 4096, PROT_READ, MAP_ANONYMOUS|MAP_PRIVATE, -1, 0);
>>          void *dst = mmap(0, 4096, PROT_READ, MAP_ANONYMOUS|MAP_PRIVATE, -1, 0);
>>          struct uffdio_register uffdio_register = {};
>>          struct uffdio_copy uffdio_copy = {};
>>          struct uffdio_api uffdio_api = {};
>>          int uffd;
>>
>>          uffd = syscall(SYS_userfaultfd, O_CLOEXEC | O_NONBLOCK | UFFD_USER_MODE_ONLY);
>>          uffdio_api.api = UFFD_API;
>>          ioctl(uffd, UFFDIO_API, &uffdio_api);
>>
>>          uffdio_register.range.start = (uintptr_t)dst;
>>          uffdio_register.range.len = 4096;
>>          uffdio_register.mode = UFFDIO_REGISTER_MODE_WP;
>>          ioctl(uffd, UFFDIO_REGISTER, &uffdio_register);
>>
>>          uffdio_copy.dst = (uintptr_t)dst;
>>          uffdio_copy.src = (uintptr_t)src;
>>          uffdio_copy.len = 4096;
>>          uffdio_copy.mode = UFFDIO_COPY_MODE_DONTWAKE|UFFDIO_COPY_MODE_WP;
>>          ioctl(uffd, UFFDIO_COPY, &uffdio_copy);
>>
>>          close(uffd);
>>
>>          mprotect(dst, 4096, PROT_READ|PROT_WRITE);
>>          return 0;
>> }
> 
> Thanks, I'll post a patch.
> 
> PS: next time feel free to try "strace ./reproducer", it'll do the
> translations and I found it handy to work with syzbot.

Cool, was not aware that it would do that amount of translation!

-- 
Cheers,

David / dhildenb


