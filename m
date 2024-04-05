Return-Path: <linux-kernel+bounces-132525-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 71F8A899637
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 09:07:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 951B91C23CA5
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 07:07:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2AB52C68B;
	Fri,  5 Apr 2024 07:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JvfO7ut8"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BB7C2C1B5
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 07:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712300843; cv=none; b=NclwZ94Wbk1bBJNFRTlrw/BVtjBg0C2Qcoqhn0p5gNs88nYFHaVHyVucnXRcCgIVEB2nAhhLpaK8iFJh5vEcZuWyJpXd0YSbjF5eeqcKycf8fUllIsKFtzV9/ho83JFGTb0O6t0SVbVRo559WIXdMfDjpQuj6SY4IcXht/C84xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712300843; c=relaxed/simple;
	bh=95uFBOAhneffb1Ja1KSyqrBwkrrb/TGDWR+j0XJMpyM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jwHujQSKpVMcai8JIT7K9AKZWfPTiPe4nN2gvfy5y7Ygy84iFHfFTjyZp36D+TJRO41lA2H+lE5j1CPWty5a0A/b4pX0r+Depnkvm/GqASz27OxWITyhoAGk/FoMos4TQMfpNkDfimDqYLdAkRvzBUOM8f4kBykgJ56EGa7AwUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JvfO7ut8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712300841;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=W2PfWq36kzHF1BupaBwFSGwfn97ZJcuXsplgJ/7yRFQ=;
	b=JvfO7ut8fIEOVcdesnV/9KIA87rYR3sqpItTm+2Zq8rUj1cqpnYGSFnpQEDxbU1ayTFc6f
	6GD4uDE65UWJY9mxxaM5v/pVc9hXG2MMHxROgIBEfgPKJcOAqUPMvFOs6uX+FBRgYqma4c
	DXfBUZk1NTLUkvMlLIieW4rGcoeqV2g=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-279-_6_xpP3_PKGbkISz8oJ-kQ-1; Fri, 05 Apr 2024 03:07:19 -0400
X-MC-Unique: _6_xpP3_PKGbkISz8oJ-kQ-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-343c6a990dbso635371f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2024 00:07:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712300838; x=1712905638;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=W2PfWq36kzHF1BupaBwFSGwfn97ZJcuXsplgJ/7yRFQ=;
        b=NuW3SU7y0o4yqK2NcG3TuLXQYgjiHkZZhZ5kIUaKFOxQohc3TfO29NqdLcA0VcLTsW
         SyizTPjBXxYxRj8fYuHhAZqKIynzIlno4zgkGRBWGov1xQIWcnVTIjULlrXg1r4PhSWA
         RFrezBol4repMzo+v24hfO1Z5IPF4hYNuldL7KAg1aRSp6/JlyTVtSgBbamYNT8FlB0m
         Gy15CbQW83f7FiSE5yHXFahvGXleh/gBLSYuLJJvoZ4qEBeolQNwaUYzgxOLRjeTx1az
         BFkKP/YuybIrt+k4JXhFWuyU43TZg3CkPRvD7RuuSfhJOC31m5FEVvLam8LuYBvc9q+T
         hnuQ==
X-Gm-Message-State: AOJu0YwL1FWGhnHyswNzND4ayZ7vTN266xcxdTrqfRJWvrzuWT16lWPf
	svRabT4j/Nj1SbcDCld130dB/GDcMc/R56hIAprpUbZpqIYzm6JWtKHmHQFFMxHIrWlA4ia2BlG
	StBpmulGZSSZ2ciqpPLRbttpKbKxBRygahclCqX0X672UjRoUoq1BbUyjpVj/xQ==
X-Received: by 2002:adf:ab1e:0:b0:343:6b42:b3bb with SMTP id q30-20020adfab1e000000b003436b42b3bbmr1380570wrc.31.1712300838641;
        Fri, 05 Apr 2024 00:07:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFXr3R2IrdekK/JeUtjm6kdjkqeG6B/zHKWTGSIrupjmzyYrP5W+5ukd+tuH2+TKIuB3QGXCw==
X-Received: by 2002:adf:ab1e:0:b0:343:6b42:b3bb with SMTP id q30-20020adfab1e000000b003436b42b3bbmr1380540wrc.31.1712300838172;
        Fri, 05 Apr 2024 00:07:18 -0700 (PDT)
Received: from ?IPV6:2003:cb:c74b:5500:e1f8:a310:8fa3:4ec1? (p200300cbc74b5500e1f8a3108fa34ec1.dip0.t-ipconnect.de. [2003:cb:c74b:5500:e1f8:a310:8fa3:4ec1])
        by smtp.gmail.com with ESMTPSA id g11-20020adfe40b000000b00341cb22a8d4sm1251698wrm.108.2024.04.05.00.07.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Apr 2024 00:07:17 -0700 (PDT)
Message-ID: <3bae9c8b-d723-4a08-8579-fa6f3ea508e8@redhat.com>
Date: Fri, 5 Apr 2024 09:07:16 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/5] s390: page_mapcount(), page_has_private() and
 PG_arch_1
To: Matthew Wilcox <willy@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-s390@vger.kernel.org, kvm@vger.kernel.org,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>,
 Claudio Imbrenda <imbrenda@linux.ibm.com>,
 Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>
References: <20240404163642.1125529-1-david@redhat.com>
 <Zg9zOJowhmOozmcp@casper.infradead.org>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <Zg9zOJowhmOozmcp@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 05.04.24 05:42, Matthew Wilcox wrote:
> On Thu, Apr 04, 2024 at 06:36:37PM +0200, David Hildenbrand wrote:
>> On my journey to remove page_mapcount(), I got hooked up on other folio
>> cleanups that Willy most certainly will enjoy.
>>
>> This series removes the s390x usage of:
>> * page_mapcount() [patches WIP]
>> * page_has_private() [have patches to remove it]
>>
>> ... and makes PG_arch_1 only be set on folio->flags (i.e., never on tail
>> pages of large folios).
>>
>> Further, one "easy" fix upfront.
> 
> Looks like you didn't see:
> 
> https://lore.kernel.org/linux-s390/20240322161149.2327518-1-willy@infradead.org/

Yes, I only skimmed linux-mm.

I think s390x certainly wants to handle PTE-mapped THP in that code, I 
think there are ways to trigger that, we're just mostly lucky that it 
doesn't happen in the common case.

But thinking about it, the current page_mapcount() based check could not 
possibly have worked for them and rejected any PTE-mapped THP.

So I can just base my changes on top of yours (we might want to get the 
first fix in ahead of time).

> 
>> ... unfortunately there is one other issue I spotted that I am not
>> tackling in this series, because I am not 100% sure what we want to
>> do: the usage of page_ref_freeze()/folio_ref_freeze() in
>> make_folio_secure() is unsafe. :(
>>
>> In make_folio_secure(), we're holding the folio lock, the mmap lock and
>> the PT lock. So we are protected against concurrent fork(), zap, GUP,
>> swapin, migration ... The page_ref_freeze()/ folio_ref_freeze() should
>> also block concurrent GUP-fast very reliably.
>>
>> But if the folio is mapped into multiple page tables, we could see
>> concurrent zapping of the folio, a pagecache folios could get mapped/
>> accessed concurrent, we could see fork() sharing the page in another
>> process, GUP ... trying to adjust the folio refcount while we froze it.
>> Very bad.
> 
> Hmmm.  Why is that not then a problem for, eg, splitting or migrating?
> Is it because they unmap first and then try to freeze?

Yes, exactly. Using mapcount in combination with ref freezing is 
problematic. Except maybe for anonymous folios with mapcount=1, while 
holding a bunch of locks to stop anybody from stumbling over that.

-- 
Cheers,

David / dhildenb


