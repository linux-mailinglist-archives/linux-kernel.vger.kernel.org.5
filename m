Return-Path: <linux-kernel+bounces-43889-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10DC4841A6D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 04:22:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8AFFCB20C11
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 03:22:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ECCF374FB;
	Tue, 30 Jan 2024 03:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="UtCuiBPP"
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67887374DD
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 03:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706584910; cv=none; b=aro66taEt0ibjaR8gB1+c6vedF32oXno/iSeO7NZvZcH6V5NxotNNsD3Bqs6efs/VXq9A2fOXsLS25Jyyl42aTXydBLOi836sZLvpfAhNJECl4dPkNbl4SmoIWXf3gpWhV/9viShVQ9k1pwVmEQh1+JVQclOph5NdiMelBxtnDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706584910; c=relaxed/simple;
	bh=GVgpS0kWdba5RHznJAUo54ANw3Oz18XB79QwSzgGW1I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=odeIsvE2Rsi5UmC2XN+ruXuBYGRxsTWh4xWryPgVJo/xGdpx12nISabUVKIkT02iP6xEdzl2KchffoiRD4+baqyhzQ3MDGT4nY3nwoSDM3pVQFviuFgDkA+e8KAlvHFnW+6Jv81gbnLs51e4AV2gH0alzwv2fK2Myi7OmDXYjXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=UtCuiBPP; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-290b37bb7deso2922092a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 19:21:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1706584908; x=1707189708; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=F0sbop7XQqdjmioWaFQ3H9fsjzAkSy2+DWUpY41QSrM=;
        b=UtCuiBPPS2LtAygT6M33IpRZg2rWTDjLdshlsTlQJZ7BdhbxtAAUe6eoH6IdpmYDMm
         FMPbB4VID2ZkzJlJtmzFLFUjhNnAPFBm0mCGt94cZ92lj0dYL0VgGvmKTxLO3qoWIhgl
         um8cm262ngi8tuS+NzFyCWAuXJk1/1UOIHIDX9fxJ9+yggEgHaFpoudEF5JYGMXt/E6c
         t9YTPEkCYgn+MB/n0ifFueujecjnYaz6rr8h/y3ZXA6p5jxg9mpieUzZ//XjRsAn4t79
         dX5LBLRBGdzWirr6NPWq6vYOuFCWJFx3er+swjvQ1osFrkCvgJZybZo+GlaDvBjU1fOB
         aaVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706584908; x=1707189708;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F0sbop7XQqdjmioWaFQ3H9fsjzAkSy2+DWUpY41QSrM=;
        b=sU6lC01vOTmYsEPGCmEe2I91PtbNl6Mk6Mq6RvKjAZLCPW23oRmynVDRFWy1uofK1g
         R6B3ZP2q3zzRkfmmlE8CksyhTOGQ7ACaMxCWfCjk29aGRtMcmqyj9j56mRc03JMzdC/G
         g6/ehe8k9gv4jr+bx2SICwn3kCT6eU3dyvcP8M6X/nxjpl/aYAuCmcaUvrSzuWNYddmV
         5fGeyZ4N/mDnUTbrIIUV4AK3zL4dg7B1znd+7quIR83rF28SS+sPsba+7zMwnc05Td5b
         ebQw/wXKeE3ugopJuf3bv+q8GCwIxiT45MOMXIMhgMslt56LjSiw46OwWMdlvm/wNvoX
         BPtQ==
X-Gm-Message-State: AOJu0Yx+Fwb3fv34H3RVw9/JLlVs5m8TjkA+Vmoz9Nds3SIGvGentW7W
	Gs860fFzk7Nt0MRY72FS4n1CItH3dww8SqUTKxD3Dfn+1VA1xnWhBbQ3lN+VSjs=
X-Google-Smtp-Source: AGHT+IGs4cIwjAEL8S1Pi2YUsDojQGkhT4IamQA2tICFDYHddN5Dz2xG9Fu0iOYaXtt2kAYQWVhPQA==
X-Received: by 2002:a17:90a:b398:b0:290:f7a7:333d with SMTP id e24-20020a17090ab39800b00290f7a7333dmr4686882pjr.36.1706584908715;
        Mon, 29 Jan 2024 19:21:48 -0800 (PST)
Received: from [10.4.207.234] ([139.177.225.234])
        by smtp.gmail.com with ESMTPSA id sw12-20020a17090b2c8c00b0029105d49b2dsm7199938pjb.20.2024.01.29.19.21.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jan 2024 19:21:48 -0800 (PST)
Message-ID: <0e7c202d-3a53-4b07-b316-259d6fedc592@bytedance.com>
Date: Tue, 30 Jan 2024 11:21:43 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/20] mm: zswap: rename zswap_free_entry to
 zswap_entry_free
Content-Language: en-US
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Nhat Pham <nphamcs@gmail.com>,
 Yosry Ahmed <yosryahmed@google.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20240130014208.565554-1-hannes@cmpxchg.org>
 <20240130014208.565554-2-hannes@cmpxchg.org>
 <eceb2dc5-f13b-4c54-b2dd-0e4a199c1280@bytedance.com>
 <20240130031938.GA772725@cmpxchg.org>
From: Chengming Zhou <zhouchengming@bytedance.com>
In-Reply-To: <20240130031938.GA772725@cmpxchg.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024/1/30 11:19, Johannes Weiner wrote:
> On Tue, Jan 30, 2024 at 11:13:16AM +0800, Chengming Zhou wrote:
>> On 2024/1/30 09:36, Johannes Weiner wrote:
>>> There is a zswap_entry_ namespace with multiple functions already.
>>
>> Another is zswap_invalidate_entry(), maybe zswap_entry_invalidate is better.
> 
> You're right.
> 
> I originally had a patch for that, but then dropped it because it is
> sort of also a tree operation and it looked a bit weird to me.

Right.

> 
> But I could be persuaded to include it again, no strong preferences
> either way.

Never mind.

