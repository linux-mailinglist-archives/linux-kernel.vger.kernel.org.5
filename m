Return-Path: <linux-kernel+bounces-119349-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5122688C76B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 16:40:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9C6ABB27935
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 15:40:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EA5913D256;
	Tue, 26 Mar 2024 15:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U322PJeN"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08ECF13C8ED
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 15:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711467386; cv=none; b=vFbfLYMcSlijnHW/PfYgDP8KHsIctmtge9kjHCsIx4H4P9VNkLWC8h58NrEh8alh5i/4UyKxuhNDbdMFaxm/H0WS23PNhnWOYhoCOw7DdYi6Lp6kWHvBAhenVZZt4QfHY46NyeS//FkHGtnbFHpvmrRch75SjQcAnf+T8mhu2tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711467386; c=relaxed/simple;
	bh=WjduyezMyJgXE+CV4glcOFAh/2FSU2yWbLJarIfwxXk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=twtidYVKMTE5nu+F0F6K9mYslC5S1J4ajGLqwEFWYOB6j7DmU20T/HAFogvxy5DX+vYED2kOmz3lnC/4Qj3p12Js/j0ygHf0X5k1Dgm689IOI/aTDz1zkUXIt2oNnBx+rURGbbfWCzBu+1Au78k8vxpaHmQ9MbMOoqRVgcHyLss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=U322PJeN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711467382;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=3IoP/uIjCVx3xjBmhXcu+ibQvDzjCyC7N9xRWM9JDXA=;
	b=U322PJeNOq96axtTUEQOAlEqCjy1vTxLpFqCH+imH4nHImeirlnmlbyxIlrgWFrdqeh7r7
	pG1GqwR5OjJX65rtu3pnA9myx0Md7GbThQ6GtWDIImKXMpGsM4tyJClIIgMDSElMW4jSAX
	x4bsN+HwR8HkWtatsP9r7sEJ3QOZ+MU=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-49-kckh0Hd9Ng-Xtf2PqOXYSQ-1; Tue, 26 Mar 2024 11:36:19 -0400
X-MC-Unique: kckh0Hd9Ng-Xtf2PqOXYSQ-1
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-2d49fa5dfadso47746461fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 08:36:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711467378; x=1712072178;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3IoP/uIjCVx3xjBmhXcu+ibQvDzjCyC7N9xRWM9JDXA=;
        b=tFp0k++G5sswVOqZJxO9X4BXyD9Dqt5igHEYgd5bo2ZfYqR1UFRCja5mdzE3NcO/5Q
         9OT2WASxbUtbOXxoSeMlUHK4hsw2L3DY9h2Vcs53dk1BNlRBxiRXimUCXCq5wHGa6yTK
         BbAvSi1EzpgzMkcZJZ8mEDHGevbsm/H/SmoekEzuCQmQgNZ39Ssv/417g7y9RN3bFkPt
         IWXsLLztHbVIt1W9qDrQCHS8h+RltZTLm8vou4GMaccdRK8FyF5lou/g2uBsli5suEI/
         nCXxues00rHCKXTPcH26mSnAUqlFUi/xvrC4WGt7/Hz2Wy0Rkw5MmlND5RNAFSiuWJZq
         VahA==
X-Gm-Message-State: AOJu0Yx8HcBB+0PcgL6W4Cia10B2+xWMcaz+tSrAPsxXvdGT8vU2AwHG
	ONEDCP4Xk5ORIJWfCvmgDYBthqDRC4aLWF5n+OUFpoqIRic3Kvu433D0F4xWsZiU3/aD4dtjflH
	Wiqpgxv2eBU4n1MCy7rYfifzFdwiEzLwhkOdGnZGaysBbYTiE9rXW9IJbJgqoyA==
X-Received: by 2002:a2e:9e17:0:b0:2d3:3305:c373 with SMTP id e23-20020a2e9e17000000b002d33305c373mr4435ljk.3.1711467377979;
        Tue, 26 Mar 2024 08:36:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH2h4q41+sxDzjlavGKRpW//ZC/MnJzwFbRClX0GSm1CQrH9mLaodYkZHwfcA8JxvlzSDq1iw==
X-Received: by 2002:a2e:9e17:0:b0:2d3:3305:c373 with SMTP id e23-20020a2e9e17000000b002d33305c373mr4421ljk.3.1711467377601;
        Tue, 26 Mar 2024 08:36:17 -0700 (PDT)
Received: from ?IPV6:2003:cb:c741:c700:3db9:94c9:28b0:34f2? (p200300cbc741c7003db994c928b034f2.dip0.t-ipconnect.de. [2003:cb:c741:c700:3db9:94c9:28b0:34f2])
        by smtp.gmail.com with ESMTPSA id t21-20020a05600c451500b004146e58cc35sm11991594wmo.46.2024.03.26.08.36.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Mar 2024 08:36:17 -0700 (PDT)
Message-ID: <1365c52b-2883-4b1a-aa9f-f587e38df695@redhat.com>
Date: Tue, 26 Mar 2024 16:36:16 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] selftests/memfd_secret: add vmsplice() test
Content-Language: en-US
To: Miklos Szeredi <mszeredi@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 Andrew Morton <akpm@linux-foundation.org>, Mike Rapoport <rppt@kernel.org>,
 Lorenzo Stoakes <lstoakes@gmail.com>, xingwei lee <xrivendell7@gmail.com>,
 yue sun <samsun1006219@gmail.com>
References: <20240326143210.291116-1-david@redhat.com>
 <20240326143210.291116-3-david@redhat.com>
 <CAOssrKdKaYua48K5F2xD68cFCoiGZSxcYdqgVXrdYTocey2pTg@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <CAOssrKdKaYua48K5F2xD68cFCoiGZSxcYdqgVXrdYTocey2pTg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

>> +static void test_vmsplice(int fd, const char *desc)
>> +{
>> +       ssize_t transferred;
>> +       struct iovec iov;
>> +       int pipefd[2];
>> +       char *mem;
>> +
>> +       if (pipe(pipefd)) {
>> +               fail("pipe failed: %s\n", strerror(errno));
>> +               return;
>> +       }
>> +
>> +       mem = mmap(NULL, page_size, prot, mode, fd, 0);
>> +       if (mem == MAP_FAILED) {
>> +               fail("Unable to mmap secret memory\n");
>> +               goto close_pipe;
>> +       }
>> +
>> +       /*
>> +        * vmsplice() may use GUP-fast, which must also fail. Prefault the
>> +        * page table, so GUP-fast could find it.
>> +        */
>> +       memset(mem, PATTERN, page_size);
> 
> Shouldn't the non-prefault case be tested as well?

That's the "easy" case where GUP-fast is never involved, and it should 
mostly be covered by the ptrace/process_vm_read() tests already.

-- 
Cheers,

David / dhildenb


