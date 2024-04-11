Return-Path: <linux-kernel+bounces-140375-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 596888A137F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 13:47:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A95B1C21A0B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 11:47:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A729B14D71B;
	Thu, 11 Apr 2024 11:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DAFB1+UA"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A165A14EC6D
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 11:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712835920; cv=none; b=Y+LPWiOdzTwDU/PQRHBA1CZTBnVhFHHf0i657iwHmAeDUxAXCQizeZGVp3fe0sU3i5tnhJRwne8DcS/fwOyRDTXp3zwX+46N9QSxIH8X1cStFWK9ErPJnSSi3sW/b4xpApCFXB+PvhNLGiE2AHWS+9UefxGNFMkvjCUnTNowE6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712835920; c=relaxed/simple;
	bh=Gf6BqJhTI6xLtm7Ghz6ZgDb0K+kvYZtsw2Yw0yVDzig=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=MEk2rjLmdFDEKGrejJjYi8/22hv5eBq2cBFdeqclw+JepXcmtsun41sJvk9JMnh1omwk9xYK4FMSNQ6qjq8Y3BHzucY0LEM3yGemSm4vBFvFJyZIXsABCyFk0Rx5eMg8qngorthk7GNHQtDyGmgKY1vLEQ+ovKjYiF+raeFeQho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DAFB1+UA; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6ecee1f325bso6892743b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 04:45:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712835918; x=1713440718; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aHrjvGOl5lMV3nAUz9GjM2jU/th5hsop1Os5mXlVWog=;
        b=DAFB1+UAkHWOc9ZngASar4V7elulNGDzrS9gLEhpjdnC5zmWkKk/x+ibcM4FvvKYUl
         Iq+SufFoQKNCECwChkvE83NK1tBCzQ5BUmtC4i/l4j0LuYZWDU5Kh0Sc26kaIPSqF2gN
         SDKPGpxFS/MroO4/F4kMrmqb5C9H3xrkerV69JGc2DuEsCpAjTvseB4Vi70d7x9kcvkl
         p/ZDljHMks+yAMTDaA03q8l/gfdIE4X5axVCxdPqPDww/h4Z1S74mCqjkUq0Do+QbDac
         eLjEIcJEBEXon++1dqY3AL+/r9+OXM6+ZGXKffrxVK9ciHyGS6MD2TPCe4QYRPw+7OA/
         hucA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712835918; x=1713440718;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aHrjvGOl5lMV3nAUz9GjM2jU/th5hsop1Os5mXlVWog=;
        b=NKNHJCkZkHrKNCH+HnoGQPU8t6RPA7VXM3h1jYSAueZJCYPVVNfdhVfZrAIxCFUXoR
         2W7kHNM9E7DPDxWLfNhgsQM/UfduoQLTqdnMds/Wh7M4sAIToISlr5DqKTawrcWxabwn
         zqnUdGOaXRj1LaRGpX/bhMr6Wh7pBjY4MLYnIq6bA37nsmsp36U5F4vTl3jGjowUyb9H
         pXbdkH/NJfJFxaf8JncZw8RkHnnRDUJNs2jhqWNiky2A6noW0H+708+dUX1ACJPLjar4
         PVvhSkvzEztp+EKYYnLrezeEMSu+4leQhYOsXHx01QxdmdtK+N7qBV0XSIslhJ4rYO0/
         oudg==
X-Forwarded-Encrypted: i=1; AJvYcCUSmh7ASjXIFgnW15SoIPyvTLe3h7CNUWMzmT+4E5mGnb4sKv7/ZG1cCu5qyaFO9u/x6S1eBWD1c3nTXYXeI9UtExHA7Up5g1GEK1xG
X-Gm-Message-State: AOJu0Ywhk+bHW1mM374l0DfN3bX8hXZJVTmM8mWOY8jLWLTr9VXrJPAO
	o8C7A9GxRjmJS1crjQkjx+9AwdTnyh15+erEQ7rU/5zXQGUfAQfV
X-Google-Smtp-Source: AGHT+IGqtlCT5h6Fb4Ji6MnmrIGfQLghE3ZiR7z51UNRjrRBmS90R3cXYfUsPRotYq+rh4nihj1pTw==
X-Received: by 2002:a05:6a00:244f:b0:6ea:8b0c:584 with SMTP id d15-20020a056a00244f00b006ea8b0c0584mr6028779pfj.9.1712835917996;
        Thu, 11 Apr 2024 04:45:17 -0700 (PDT)
Received: from [192.168.255.10] ([43.132.141.20])
        by smtp.gmail.com with ESMTPSA id hq6-20020a056a00680600b006ed14fed3a5sm1019760pfb.154.2024.04.11.04.45.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Apr 2024 04:45:17 -0700 (PDT)
Message-ID: <adf9d74c-6f22-4653-a27d-c50f7320efd1@gmail.com>
Date: Thu, 11 Apr 2024 19:45:14 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/10] transfer page to folio in KSM
To: David Hildenbrand <david@redhat.com>, alexs@kernel.org,
 Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, zik.eidus@ravellosystems.com,
 willy@infradead.org, aarcange@redhat.com, hughd@google.com,
 chrisw@sous-sol.org
References: <20240411061713.1847574-1-alexs@kernel.org>
 <db95e01f-9334-4db8-8f8b-83f25a7dda87@redhat.com>
Content-Language: en-US
From: Alex Shi <seakeel@gmail.com>
In-Reply-To: <db95e01f-9334-4db8-8f8b-83f25a7dda87@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/11/24 3:55 PM, David Hildenbrand wrote:
> On 11.04.24 08:17, alexs@kernel.org wrote:
>> From: "Alex Shi (tencent)" <alexs@kernel.org>
>>
>> This is the first part of page to folio transfer on KSM. Since only
>> single page could be stored in KSM, we could safely transfer stable tree
>> pages to folios.
>> This patchset could reduce ksm.o 57kbytes from 2541776 bytes on latest
>> akpm/mm-stable branch with CONFIG_DEBUG_VM enabled. It pass the KSM testing
>> in LTP and kernel selftest.
> 
> Just a nit (no need to address for this patch set): "transfer page to folio" sounds very misleading to me. I'm not a native speaker, but I'd have called this patch set
> 
> "mm/ksm: convert some KSM code to use folios"
> 
> It's rather code conversion/transformation, not a transfer.
> 
> But again, I'm not a native speaker ...
> 

Uh, me neither. but sounds you're right. I will take care this next time.

Thanks
Alex

