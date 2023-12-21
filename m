Return-Path: <linux-kernel+bounces-7927-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3709681AF52
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 08:23:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6ACE1F22C41
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 07:22:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6830BE7D;
	Thu, 21 Dec 2023 07:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="jfh2dIEE"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3B2DD2E1
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 07:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1d3d0faf262so4122045ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 23:22:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1703143369; x=1703748169; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8JWrW+IEVHMjZq4fIupoComMYAyw+v4n8pU1GtYpLyk=;
        b=jfh2dIEE/y2LSP/R7fO8SMKFTTJMRnuHMzhGDtA2JV4wtI2zB51MbIhh1sfQcm9/az
         mK1xLTVdpT2WLW6yeR6W5jK37OPEbH13lPubzjMv9KPb/Cp0M0TjVCasaF3WlSwg7uPb
         b0pKd+qq8TGOPpGYBmQomLeg8f3E8KZGWKRH8nGMbPHcLvrqr6zbzZ0mXPUvAFd5tdBK
         qIsMf0TraEmW6bxEh5Fki96BDNGYcgmNlm960Yyac8kP9l04wur8EZWlxtfHansa/vZE
         mMFCsrAh4zsrYhZOi0tVmEB3t+Pu4Yp1cgCfNMqfvtbgzjmr1XUNPCAdY/vgx8LCQVrq
         szhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703143369; x=1703748169;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8JWrW+IEVHMjZq4fIupoComMYAyw+v4n8pU1GtYpLyk=;
        b=BTqjZ/J+wSQTFX9cXwIzgfHnp/qtFkRy+A1KFDII/3YfYgze7uiAnJnVX8UZ24Iwip
         Nf7i0hYaNw3Kdja5mN2jQgN5+iwooS+xb3tNpCIyRxKfkquzKUdENLXQwyhR5WPBxR+u
         eCWSjV0SAUziTo4896dIBvRZ4GiJyzBTIJlqtrM51HwB67RXvTWGgWPsBCARFWXGUBMX
         LJXhXGo7wfXOqnw3BPDTarcbOsKGP3JaxIHHCiWtFHwMsDI3QMYyxhTk7PMZgGM0lGUc
         2+dJjxFTjX8xxo15Sn1sv5yq6sLz2jRMOWY+6NOTXPPZKfOumu77I3nRSKjz+frklXSr
         bnvA==
X-Gm-Message-State: AOJu0YzkGZDp3FRMLDsf0oYJn8IB7pmQ58QvfaOpHFu5rTNd5e/hObWy
	PokTE3CmEwIx2MGGf9coDvMgFQ==
X-Google-Smtp-Source: AGHT+IEj3GDlylzsimgqCGPEQsleUlysirGuXQiTOleks6R7RwIWSJ0HQUF4Tl434sorYTQhNei1TA==
X-Received: by 2002:a17:902:c406:b0:1d1:c96a:c5e with SMTP id k6-20020a170902c40600b001d1c96a0c5emr25078114plk.70.1703143369021;
        Wed, 20 Dec 2023 23:22:49 -0800 (PST)
Received: from [10.255.163.20] ([139.177.225.237])
        by smtp.gmail.com with ESMTPSA id g15-20020a1709029f8f00b001cfb84c92dfsm881320plq.276.2023.12.20.23.22.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Dec 2023 23:22:48 -0800 (PST)
Message-ID: <31b3ced3-953b-49fd-865f-52aa1627e71a@bytedance.com>
Date: Thu, 21 Dec 2023 15:22:42 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 0/5] hugetlb: parallelize hugetlb page init on boot
Content-Language: en-US
To: Mike Kravetz <mike.kravetz@oracle.com>, Gang Li <gang.li@linux.dev>
Cc: David Hildenbrand <david@redhat.com>, David Rientjes
 <rientjes@google.com>, Muchun Song <muchun.song@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20231208025240.4744-1-gang.li@linux.dev>
 <20231212200653.GA7043@monkey>
From: Gang Li <ligang.bdlg@bytedance.com>
In-Reply-To: <20231212200653.GA7043@monkey>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2023/12/13 04:06, Mike Kravetz wrote:
> With today's code, allocating 6656 2MB pages via the kernel command line
> results in:
> node 0:  924 pages
> node 1: 5732 pages
> total:  6656 pages
> 
> With code to parallel allocations in this series:
> node 0:  924 pages
> node 1: 1547 pages
> total:  2471 pages

Hi Mike,

Disable numa_aware for hugetlb_alloc_node should solve this problem.
I will fix it in v3.

