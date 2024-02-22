Return-Path: <linux-kernel+bounces-76147-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E201A85F377
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 09:51:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CEED1F244ED
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 08:51:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FFB72C689;
	Thu, 22 Feb 2024 08:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LPwadc/1"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB4F122F0A
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 08:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708591868; cv=none; b=msPZAgrKXy/w+ECICxkjMKgy38qZINfu85UZP0+MWtKvbl4vWOf69UA3R4QlObSkf4KoddV8LyY4SXv/S3YTS4QBh7NuBomCC038gyuUGKh+aazBjr7JoZde9Pyq8MHFwgKH84OLqw5lZk7dEVp/s2JgOVA4mCh5eFTVO0H363U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708591868; c=relaxed/simple;
	bh=J75ulf2QS0sytPy1LP/7bIqFK5J9UWab3EkEI7Zgsto=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sD9O3SARWlyQ3lVcMAPZOjoS8T/S1p6zkUXrsVXgf7jntiORvdbAUQA6ksvKgQqEZzO1IIqIu3TOe8nGdQf/w9xhIFTZaHQcr3qEUcTPnHEu4D3P1ks/WD6dywVpXiTmPYR4V9CPowyh9ujQMsac1IH3AGNuABAKHN6UFknwq3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LPwadc/1; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708591865;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=2nFn5jCZTy1s9WBf67eU2Zf2Y/G1Fhgpl8nVuZPJzLo=;
	b=LPwadc/1/IR0sDt7yIjRju4E7Q6x/eoqiX86YAkcwZ8OztwglMX3ac41/7MxArHX++locm
	4+gEhnH63eMjnD0fVXYy9hLy10x2EtxkFmpTNv9Vt0wUeQtT5sIO/Px1yA50/A/TLgPVMn
	xtz0ZRYfZt3r/ol5txkwjvDx/aKEshM=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-73-4mp5om_DOjmCaB2OS8UloQ-1; Thu, 22 Feb 2024 03:51:04 -0500
X-MC-Unique: 4mp5om_DOjmCaB2OS8UloQ-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-512cc3ea8b8so1999450e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 00:51:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708591863; x=1709196663;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2nFn5jCZTy1s9WBf67eU2Zf2Y/G1Fhgpl8nVuZPJzLo=;
        b=MMVvuWUCnzdCOxJvjgA8Q3HL8VJEbIo44RFLUgpOUH4zANVZ7h4nuEqPwso67lS8la
         qhOihPOE3vtjG0Lf+iWDoVuoUfd+ykjKHwpiKDfhhlMSWkpZ8ZWKs71l0Unp1jzCgsh/
         nVjTn737qqlsqLVwhOgQt3fadjZBPOtj4XTHSVhD/zRfXCBnfbnhvSNGQ/bzc9o+a4wb
         GwKBydyfYPDzmN4CMEc1kUcwbwcvM0YbtB142RPDAuV7ekiyCAdMUxG90Hi+vjkcO38E
         Zkvbww7Vrv0tWWbEkPLL4Jv+/uvmTHfsYyaXERKaQPWesPJjhh2JgIE84HCfP1KV9r5e
         0Nyg==
X-Forwarded-Encrypted: i=1; AJvYcCWIn9ESdIXSzXrdkZB83jSagImavhRLTZ2GiuMEbGc7l1zgTVbPeU7bmikfj2//cwodp4SgO3I6mEuHNaBrSKlhtWtJqGrZAUP8YK4V
X-Gm-Message-State: AOJu0YxqPVszJucfclem2MmHClsl/0541kbVeqgGv4qCIr3N19oh8Xcr
	RSuY8h0YWJxn2ZyLI8Up3j2p+Z62dpYgmJi+kOBt7PZozCdQVE69QoKA4eE0Wy2gWoC5B1ZgdWb
	3+HREsXzhLg29hOzSzvG7SJ5Ttc6HJMf8J+HZraPhcjBy9e3U0MJ9Abq+F/LywA==
X-Received: by 2002:a19:9115:0:b0:512:d4f6:aba with SMTP id t21-20020a199115000000b00512d4f60abamr2491887lfd.0.1708591862688;
        Thu, 22 Feb 2024 00:51:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHKvihlLAIYg4Xo4Tso6CmcImOyTH2YZcm2QQiRHQWD5z/KlRSQgERl69V9XKNNlyQhWq1w4A==
X-Received: by 2002:a19:9115:0:b0:512:d4f6:aba with SMTP id t21-20020a199115000000b00512d4f60abamr2491870lfd.0.1708591862210;
        Thu, 22 Feb 2024 00:51:02 -0800 (PST)
Received: from ?IPV6:2003:cb:c70f:8b00:ed48:6d18:2152:1cda? (p200300cbc70f8b00ed486d1821521cda.dip0.t-ipconnect.de. [2003:cb:c70f:8b00:ed48:6d18:2152:1cda])
        by smtp.gmail.com with ESMTPSA id f19-20020a05600c155300b00411ff030f06sm21647703wmg.9.2024.02.22.00.51.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Feb 2024 00:51:01 -0800 (PST)
Message-ID: <84fc211a-075d-44c7-a4c3-698931b6dc7c@redhat.com>
Date: Thu, 22 Feb 2024 09:51:00 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] mm/khugepaged: bypassing unnecessary scans with
 MMF_DISABLE_THP check
Content-Language: en-US
To: Lance Yang <ioworker0@gmail.com>, akpm@linux-foundation.org
Cc: mhocko@suse.com, zokeefe@google.com, songmuchun@bytedance.com,
 shy828301@gmail.com, peterx@redhat.com, minchan@kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20240129054551.57728-1-ioworker0@gmail.com>
 <CAK1f24keWtJNVv37r2vNsqnmMLRMvF-F76WR5RD_Y-BbAgEaYQ@mail.gmail.com>
 <CAK1f24nk19eciysFqvTd=rqpiKePhstDWEEQ_mvT89WCDNrWNQ@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <CAK1f24nk19eciysFqvTd=rqpiKePhstDWEEQ_mvT89WCDNrWNQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 22.02.24 08:51, Lance Yang wrote:
> Hey,
> 
> On an Intel Core i5 CPU, the time taken by
> khugepaged to scan the address space of
> the process, which has been set with the
> MMF_DISABLE_THP flag after being added
> to the mm_slots list, is as follows (shorter is better):
> 
> VMA Count |   Old   |   New   |  Change
> ---------------------------------------
>      50     |   23us  |    9us  |  -60.9%
>     100     |   32us  |    9us  |  -71.9%
>     200     |   44us  |    9us  |  -79.5%
>     400     |   75us  |    9us  |  -88.0%
>     800     |   98us  |    9us  |  -90.8%
> 
> IIUC, once the count of VMAs for the process
> exceeds page_to_scan, khugepaged needs to
> wait for scan_sleep_millisecs ms before scanning
> the next process. IMO, unnecessary scans could
> actually be skipped with a very inexpensive
> mm->flags check in this case.

FWIW

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


