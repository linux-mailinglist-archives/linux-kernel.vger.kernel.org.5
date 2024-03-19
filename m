Return-Path: <linux-kernel+bounces-107593-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D403187FEE1
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 14:33:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DF56284129
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 13:32:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D553F8003D;
	Tue, 19 Mar 2024 13:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f4rN6drT"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DAA32E400
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 13:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710855172; cv=none; b=dxmbxqHEImrPYWxaT3Lxr+OZG8aXJyPaGpZwVLkcoTuL7t4OeHYXyb1gMm/y1SCkAyu8hsTw2kux8GgXqG6roRU69CUqDJ7tW/HKDXsrgb4jSg50VTpOpV3swuwwzCJ2U60SqFr5qjS7o1y8uncxc8gWZKbMTLR2kZYcEriXtRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710855172; c=relaxed/simple;
	bh=zZfuaMUoEkDdTO83ce/Z1G9rmCQIbriG2aWZt8aCzZo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=W2zmGgDN/DNHn5aKloTiB7m6CWb+APzLQvyPvfZ+k7R7Xe02G6MHZi1BA7DgTtia+F7XEZr5W6ZwruMKXVfZXDXCtGLTCv+Xf45BYg81bzdPR03MJIsjRf8+9zZF9YUBiwTEWQRaipinHIreFOPRLj0Iamlt0G+x/eQy83CJykU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=f4rN6drT; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710855169;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=+MIY6dftoX/+veKGXKMUqul8mGwWZtfcFZ3OoR9iZfU=;
	b=f4rN6drTx1kNZSOxg/G82dwO30tMJtCyCvU1U0FnQ764lBDwTcOfq42Z9gfQniqENvSo1a
	kq/m2L03NFtNADT7b8vtGVWj0lLmaIG7yX+bCR0U7Nx60TFIpT249msUIv1bG0+qEAQhLN
	qWDvctv+O7hGE6yQpQRGg5vGpM74BOE=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-554-CV-xHQk5Ng24UDb7mGOt_g-1; Tue, 19 Mar 2024 09:32:47 -0400
X-MC-Unique: CV-xHQk5Ng24UDb7mGOt_g-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-33ed8677d16so1854059f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 06:32:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710855166; x=1711459966;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+MIY6dftoX/+veKGXKMUqul8mGwWZtfcFZ3OoR9iZfU=;
        b=tAGrAJSJKgqwuI6v5d2PtDCiBrbxkHQAJt0ELUeoARe6B8jKctZ14n1R91R/9L3MQ5
         xMmWpC3W+ZtqNI2SLASvG7sC9YL/GajLEowIjYmgzU7qcmeJbrw4wV/biEtrX9y4Vlo7
         sDJvj3rqGdA3g9aL90pwKUVnQmDwUkZGSSg+S8p2+g4uIeMfUy8Pp6mUm7OcfLxPOSxF
         G1dbd/uPTmAf7zqSLGtSgMWkFSnItLn69U9SyXYooCSA6aoyA2sFiLQRFoesANS9oNqC
         pP+qYC8dmh1X2jrHLcls6ET0AtHAWBZGZZnAcD+AyoaXk2jWY7Zy3GEClH3lAhtgfdVJ
         806w==
X-Forwarded-Encrypted: i=1; AJvYcCV3KQuKcO062En+cCFfcrvFMERGwEkZ5CmjO2jE7+/OPpVeYq6OAaYXGbJJSoyhiuPXss1pFYL0v6+bpwRwbCyWOictSJxUEx2RZ8UE
X-Gm-Message-State: AOJu0YxYi5k45JV+5IszP7QA3w4PAQ7GDEUoTaUe0zmIDACADnZ+2hpt
	PfZcGt1xOOy7uINGd2Hkcze169YVfw7cCQ3R4D1TSyO2wJPI9QeebBTuIg3l5IWS3GxuFs5Hjyx
	RKNVLnzXtoCEovbTwtoYHV7AsE4PbYKtvpI+QOGPcB5oZsXvIWsW5Q75jXR2Ahw==
X-Received: by 2002:a5d:47cc:0:b0:33e:1ee1:ef92 with SMTP id o12-20020a5d47cc000000b0033e1ee1ef92mr2892371wrc.67.1710855165818;
        Tue, 19 Mar 2024 06:32:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGXKtjizAwLjgoFdsjgzI14VVNV2s0seiz9NFLM2aGZObDjPCZuzYrHCWSQURABi9u0FUtZaw==
X-Received: by 2002:a5d:47cc:0:b0:33e:1ee1:ef92 with SMTP id o12-20020a5d47cc000000b0033e1ee1ef92mr2892336wrc.67.1710855165408;
        Tue, 19 Mar 2024 06:32:45 -0700 (PDT)
Received: from ?IPV6:2003:cb:c741:2200:2adc:9a8d:ae91:2e9f? (p200300cbc74122002adc9a8dae912e9f.dip0.t-ipconnect.de. [2003:cb:c741:2200:2adc:9a8d:ae91:2e9f])
        by smtp.gmail.com with ESMTPSA id n2-20020a5d4002000000b0033e93e00f68sm12355290wrp.61.2024.03.19.06.32.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Mar 2024 06:32:44 -0700 (PDT)
Message-ID: <d6eb589c-ac84-4c6f-b5f1-fdf91f3cf674@redhat.com>
Date: Tue, 19 Mar 2024 14:32:43 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [mm?] WARNING in unmap_page_range (3)
Content-Language: en-US
To: syzbot <syzbot+e145145f0c83d4deb8fa@syzkaller.appspotmail.com>,
 Liam.Howlett@oracle.com, akpm@linux-foundation.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, lstoakes@gmail.com,
 syzkaller-bugs@googlegroups.com, vbabka@suse.cz
References: <0000000000007de0cf06140124c0@google.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <0000000000007de0cf06140124c0@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 19.03.24 11:43, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    e5eb28f6d1af Merge tag 'mm-nonmm-stable-2024-03-14-09-36' ..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=1383c6c9180000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=4ffb854606e658d
> dashboard link: https://syzkaller.appspot.com/bug?extid=e145145f0c83d4deb8fa
> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14583abe180000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14298231180000
> 
> Downloadable assets:
> disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-e5eb28f6.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/a5c7ad05d6b2/vmlinux-e5eb28f6.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/531cb1917612/bzImage-e5eb28f6.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+e145145f0c83d4deb8fa@syzkaller.appspotmail.com
> 
> WARNING: CPU: 2 PID: 5169 at mm/memory.c:1539 zap_present_ptes mm/memory.c:1539 [inline]
> WARNING: CPU: 2 PID: 5169 at mm/memory.c:1539 zap_pte_range mm/memory.c:1603 [inline]
> WARNING: CPU: 2 PID: 5169 at mm/memory.c:1539 zap_pmd_range mm/memory.c:1720 [inline]
> WARNING: CPU: 2 PID: 5169 at mm/memory.c:1539 zap_pud_range mm/memory.c:1749 [inline]
> WARNING: CPU: 2 PID: 5169 at mm/memory.c:1539 zap_p4d_range mm/memory.c:1770 [inline]
> WARNING: CPU: 2 PID: 5169 at mm/memory.c:1539 unmap_page_range+0x2a54/0x3bf0 mm/memory.c:1791

Fix is already on its way upstream:

https://lkml.kernel.org/r/20240313213107.235067-1-peterx@redhat.com

Should shortly appear at mm-hotfixes-unstable.

#syz fix: mm/memory: Fix missing pte marker for !page on pte zaps

-- 
Cheers,

David / dhildenb


