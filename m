Return-Path: <linux-kernel+bounces-132536-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 10502899663
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 09:19:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7869F1F210B3
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 07:19:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2D692E85A;
	Fri,  5 Apr 2024 07:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bO0m4pU2"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9C872E657
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 07:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712301555; cv=none; b=m97+Sh1JUMiJtUUnMi9FmpOfU90kKh28mtnkTV1A9ePTrylDWSsANRKBmYONafZjwm38YVrCzw6Eu1+eZIy/jgTnyOZ8cSwhbZCcJSS8TXfjysJqCtB4sPDDRPo+p92v9BQXLXGctt2RLpxeXpY+JntMlTnxrBSii3yTj2Grcj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712301555; c=relaxed/simple;
	bh=jzTKGxt+8BlbEYQfVJMn8/alU77HEpqrIBQy7jdjQqs=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=P7uTPRN9RZRctvmoRKtinDZm8OVw0bWV75ekGXv3i287d5ZxhVXRpqYNUDM6MLsL3qNKFqCm9F9yzlFRp3BeqHPf+vmr8v7FhuMPLZ4/zMaJPFfaNFHTgAtx5BtLpaG9atawyTNoZHTTFdWiGV4PLkEQG7ec74CU4c/Ibo+5fpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bO0m4pU2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712301552;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=uJgd5/tZ6U4b++pOGuZQBWzs0qEmD4LqCtIS6LzZMP0=;
	b=bO0m4pU2OdN3tEqnFHXq1n9oyObtG5oel4oWE23jp/4kiW3bsnzEjf8npoLxPAPYUTfTHP
	IYIwqgV3oQmYRBIu41PMHXgE3uTbMobzEQyZ0koCmxo73VLgGGue/A4uQ+0LhbNvwqRA2d
	R1eIuu3Lfv24n8kGxrBJwopDZkQNVbE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-263-5PQfP7S0NdKKjkDE26_BFw-1; Fri, 05 Apr 2024 03:19:10 -0400
X-MC-Unique: 5PQfP7S0NdKKjkDE26_BFw-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-343678d2d26so959234f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2024 00:19:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712301549; x=1712906349;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uJgd5/tZ6U4b++pOGuZQBWzs0qEmD4LqCtIS6LzZMP0=;
        b=BCOu+XE9aHBtTvXLVO4IN3+/4cZ34CpftnHZVIokcPv8/tfR0Xu2yGk9JfeVVDaskX
         47oBqVp5j2I+4wISBiV6Lt1EpcEFigW9ZPKjWJevxLEYsmnetWIeokAzWFdL8viW++qi
         QA3DuLQq+30bGQ2aJzHquMgwduLf0Wck9myIV0nURGAgc+rM9lFaaLL5CsZFtnBqYhPg
         B/8ff7T6lmoDD28JmK53l0P41U+hKyvnRgaXWXEUiNILKLSKAmDWqkNDuasO8Lf9wdfx
         VhOi18Lv/JtgiS/NsciGentxPha1edNN2JT53bUkzP5T6D6axUHnsRzKkIgpzQOO5THe
         dmeQ==
X-Forwarded-Encrypted: i=1; AJvYcCW925ygpRNhtjkaQ0o+1wuP9lj2D3np8uRntyNYiVHC8pWU+XO8hUAWsAf0UqVmXsZ/WLtMaUZLjyZkWFbHo75ViQJ2QhpcWgLKHp/1
X-Gm-Message-State: AOJu0YzGg/YLidAgQADn3mNi2Alt/+IDZpobsArSid4zPhbhXOgNnsHy
	OrrKt3GVZgiz3mIH8uZHQupeQV9BCHd714JRKwzYaFSYTM+879SAsbGVO0TeEfUntMyf8YZlD80
	kd8SsmAU72Z5gDoD+AYnSAppnDWR3UM2ehAMrG9vfWX4T61PUxVv0ISvwJcNkJA==
X-Received: by 2002:adf:ed46:0:b0:343:8097:213d with SMTP id u6-20020adfed46000000b003438097213dmr1371400wro.20.1712301548455;
        Fri, 05 Apr 2024 00:19:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGfAQ4NR2jUAsFoLqUf6fy5Endi0borLCdOovPRxlugCywzb3cqah3CJRtI+CXx3b8LoVyNRQ==
X-Received: by 2002:adf:ed46:0:b0:343:8097:213d with SMTP id u6-20020adfed46000000b003438097213dmr1371372wro.20.1712301548041;
        Fri, 05 Apr 2024 00:19:08 -0700 (PDT)
Received: from ?IPV6:2003:cb:c74b:5500:e1f8:a310:8fa3:4ec1? (p200300cbc74b5500e1f8a3108fa34ec1.dip0.t-ipconnect.de. [2003:cb:c74b:5500:e1f8:a310:8fa3:4ec1])
        by smtp.gmail.com with ESMTPSA id d11-20020adff84b000000b0033e7a102cfesm1286585wrq.64.2024.04.05.00.19.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Apr 2024 00:19:07 -0700 (PDT)
Message-ID: <1e943439-6044-4aa4-8c41-747e9e4dca27@redhat.com>
Date: Fri, 5 Apr 2024 09:19:06 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Machine check recovery broken in v6.9-rc1
To: Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>,
 Yazen Ghannam <yazen.ghannam@amd.com>, Miaohe Lin <linmiaohe@huawei.com>,
 Naoya Horiguchi <naoya.horiguchi@nec.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <Zg8kLSl2yAlA3o5D@agluck-desk3>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <Zg8kLSl2yAlA3o5D@agluck-desk3>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 05.04.24 00:05, Tony Luck wrote:
> v6.8 works. v6.9-rc1 fails with:
> 
> kernel BUG at include/linux/swapops.h:119
> 
> 117 static inline unsigned long swp_offset_pfn(swp_entry_t entry)
> 118 {
> 119         VM_BUG_ON(!is_pfn_swap_entry(entry));
> 120         return swp_offset(entry) & SWP_PFN_MASK;
> 121 }
> 

Do you have the full backtrace?

-- 
Cheers,

David / dhildenb


