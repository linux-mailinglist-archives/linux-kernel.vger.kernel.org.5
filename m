Return-Path: <linux-kernel+bounces-120191-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FAC388D42E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 03:01:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B87891F3645A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 02:01:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4BD820313;
	Wed, 27 Mar 2024 02:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="gi6qv8q8"
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6C611CD2B
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 02:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711504858; cv=none; b=F6fZTGQwEJ2ztjQBHWvbyfCCGvRVqVTDENz6Z7XRhImIOQIRzVisIfOgFFmc5/gT1kBb5klBDZGxpVJ+otkQCrQGEUNW6mQRaj7AEq35PBoqNDWKp/IBYUtqo1gB9lcaoo2hOXkUQTvlPD5QbgtqANRXNRzAhOV2mDvQlHdjBmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711504858; c=relaxed/simple;
	bh=Vnz0/kfD7mpaeVP4AHPJ1jUdAS3sK3bMZMvy9LkhM5c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H9ZHJAiIm3tkvk76SZg13yD8BPhIqtX1/zZVU7OsuEOjQU7prJ8HZehpI4CEzyj7s2F1g0JkTJOXB8MkF2qC4YVmQxiJ58lPIPJo3wf6vJ8hiz3NZ/vDTNKtARzE8XzLy8Jx8fmR87xBOsoHuLfrutmuGwalSXMNo0Z5DBUNFCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=gi6qv8q8; arc=none smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-5a46b30857bso1559751eaf.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 19:00:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1711504855; x=1712109655; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cmf5UAQ88z5Xj0UbZhmF0l+sQTmyxOxjOsynEFySfzw=;
        b=gi6qv8q8uG539XDmRaUFRB56Xst4zhqcThmrIEzmfcexCtTSnuusalZBCmnnP5VKkF
         oofof9q9gcGxX6Iug1roFSrV0Tq1WxhmlqOefLHq6Uch6Qtk75j73DnToShIBragJZbK
         PpQ0t/XYVWNWpwpwqqtNqKiV13vPD54Y9XUbeMnRslYRoz9ekMU+H/d5Yr4gAuLRVXE9
         ud/HR1lfacu60tzuFhV+mogMukzQQ3BmfUTqC3xonY773EC1CTYyZr3CvX5/ECyqtjzT
         lgkUJVP8c/o3MX4nwVpkBGTaXiaUfNCIdPZK/zlejiRGlN3kjcwYaHkZMhaAlswFKkc1
         cqaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711504855; x=1712109655;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cmf5UAQ88z5Xj0UbZhmF0l+sQTmyxOxjOsynEFySfzw=;
        b=isXUrEQlinXTFaIrvwiBnFB+FeOl/kPd8edcUdc5YTx1u5ETXwi0P2Tr9H7YPT7WPf
         jumnqMiTUN8gd9PlVe2yCyJj0axLJYXIzhQOTmXD9b0kw+DuKlsC2q0J99YwX6gfnnTl
         qXI2XDIei4Eu8nHj9nUejP3Um12F2MVffza0F9nIgmeMAQm4vD9W+WvQrSZjhoS1L3sL
         TX8q9UH09tKsA0iViVxEdEFCxf01mI2bjInLzTThPLHrHdMuNkT8qMiU1vYKzG/W9Eq/
         VXPn/uHHWXCc0NBLPR1o/sTEMcsDg4NATrJmmV0JKzVsz0Z5velioeFdvG4t5auuYuaN
         /Qkg==
X-Forwarded-Encrypted: i=1; AJvYcCXQFSMJtr+iIbQoSHWnRqZ1xiB01DjAnkn0MlDqUmBeMLecWmyKAXP20cjpOm9Lf61ApwmupSIk1vxRmSDUs6gHdTO9gUcjd1o1avhw
X-Gm-Message-State: AOJu0Yx0AEcHV+wvxLoOaRYATQBA0TFx11eGFqYJ73Sl1VQFBpTL4dM3
	NIIi2jlFBUXqaELcxuJEqMV1fc9CrbJgT4KrS7fX7XjStgTuPtWvXOZ+ZKkRrQU=
X-Google-Smtp-Source: AGHT+IF73fHO/Z6YyBpVFlKropkN3bskeJkIca7oJegD2t0qhUuIWsgeiz974jHcO5ljSN73dLPIBg==
X-Received: by 2002:a05:6870:65a0:b0:229:ee6d:77da with SMTP id fp32-20020a05687065a000b00229ee6d77damr11635219oab.2.1711504854810;
        Tue, 26 Mar 2024 19:00:54 -0700 (PDT)
Received: from [10.254.105.249] ([139.177.225.230])
        by smtp.gmail.com with ESMTPSA id p23-20020a056a000a1700b006eaafccff73sm3585242pfh.212.2024.03.26.19.00.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Mar 2024 19:00:54 -0700 (PDT)
Message-ID: <4b0d600e-654b-488f-8ac7-2a83d71d91d0@bytedance.com>
Date: Wed, 27 Mar 2024 10:00:46 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] mm: pgtable: correct the wrong comment about
 ptdesc->__page_flags
To: Vishal Moola <vishal.moola@gmail.com>
Cc: akpm@linux-foundation.org, hughd@google.com, david@redhat.com,
 rppt@kernel.org, willy@infradead.org, muchun.song@linux.dev,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <cover.1709541697.git.zhengqi.arch@bytedance.com>
 <cc42d5915fd98fd802f920de243f535efcfe01db.1709541697.git.zhengqi.arch@bytedance.com>
 <ZgMeKa3ee7oHrkq5@fedora>
From: Qi Zheng <zhengqi.arch@bytedance.com>
Content-Language: en-US
In-Reply-To: <ZgMeKa3ee7oHrkq5@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/3/27 03:12, Vishal Moola wrote:
> On Mon, Mar 04, 2024 at 07:07:18PM +0800, Qi Zheng wrote:
>> The commit 32cc0b7c9d50 ("powerpc: add pte_free_defer() for pgtables
>> sharing page") introduced the use of PageActive flag to page table
>> fragments tracking, so the ptdesc->__page_flags is not unused, so
>> correct the wrong comment.
> 
> Thanks for catching this!
> 
> In regards to naming, we're trying to prefix unused variables with
> __underscores so I'd prefer to see the __ eliminated from the
> ptdesc->page_flags field here as well. This doesn't warrant a fix
> as it is already in 6.9-rc1, but is something to keep in
> mind for the future. 

Got it.

> Aside from that, LGTM.
> 
> Reviewed-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>

Thanks!

>> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
>> ---
>>   include/linux/mm_types.h | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
>> index a7223ba3ea1e..5ea77969daae 100644
>> --- a/include/linux/mm_types.h
>> +++ b/include/linux/mm_types.h
>> @@ -419,7 +419,7 @@ FOLIO_MATCH(compound_head, _head_2a);
>>   
>>   /**
>>    * struct ptdesc -    Memory descriptor for page tables.
>> - * @__page_flags:     Same as page flags. Unused for page tables.
>> + * @__page_flags:     Same as page flags. Powerpc only.
>>    * @pt_rcu_head:      For freeing page table pages.
>>    * @pt_list:          List of used page tables. Used for s390 and x86.
>>    * @_pt_pad_1:        Padding that aliases with page's compound head.
>> -- 
>> 2.30.2
>>

