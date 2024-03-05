Return-Path: <linux-kernel+bounces-91604-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A2B0987142B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 04:16:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42CF61F25564
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 03:16:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0350E2943D;
	Tue,  5 Mar 2024 03:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="S8VPX6tG"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 336DA38FA7
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 03:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709608585; cv=none; b=fZMSKiZ3TujsrAVgsrqlaPsI50550EcEhVmhhRrwikd1QD9GM4KXLZIGsPoebrqaet9dzURiX3yfWhxv2ylGyWJphvOgRcguoKg4LuLivNrbDlJAadD9I2LOqSbuuKG3GBe1u2Qh2RPOLRN8HfklMNegeR7WeiTs1sHiewm8EXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709608585; c=relaxed/simple;
	bh=tiEDYnc/wAhfPPZQ9V/0HNeQiahhRnw7cSW6jaWgbv8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YdtBLOqj+yG5i/ppEMQ8Ry3EuvsKqFS6bgoeFOSrs4AukC56RSNV0kSRGwQezuwkonnwQw36YRDOC+199Ww0o4UhERMb0jWRh4tYN2RZlRRaG36p8G3VO7Z+sS/36cdEp7CZMzKAnErwmSR8F5urcXTV8WmIYk//bMEMDsG7hNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=S8VPX6tG; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-6e6092a84f4so1608043b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2024 19:16:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1709608582; x=1710213382; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BI+L2texUlWaaIlUkdZ7hdiC5rznyELVG+l55NF0jTM=;
        b=S8VPX6tGcCNDKg9uT1JBiTcsWAZOe5X6mrmRZgojynLopdnqdcm/RVUM0Wf369vLrR
         hrOEoSXj0Xd3Mu7+XEc6YqLSEpxXJkfl7IqI/3IptbVGhJwvvNJMg7Gk0QjbHwlZHvPw
         95OCHCQJVtDFTf1GsuFtHhdbHuYlaMTyJ2Rv/2uH0hi/laY5ckleLGsZAEeJ7MZhyHFx
         6RyHKc7oFQaPQX3E78drHJNgFCgWgQG/Rd3wJPccWAvSKMLlpnlc7R7YikmuIU/sqqZK
         U8lWBuU8BIxjLPDqH38oQbKflM8kUGNmwlu3aNu8KiH71c2QtNsWO1OSy61YulbKb/YH
         Bw5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709608582; x=1710213382;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BI+L2texUlWaaIlUkdZ7hdiC5rznyELVG+l55NF0jTM=;
        b=DuGUX5ZB28gc2GtMcbXHMVM1HCGqZFfyABk2AB3Pyy7u90RMGCb/jiTwLi9icHiS2e
         HcdfmpGbIxNC9UwMprE0LAqES26hDjOqVnPHk92lDkBEWYYw5iAhlZrDGxcy2PFFEeEz
         cu2pMN+GszWlq9kOqGwM0fWmLRIWW6JSMDGdLYc9sY7h1UGb1u4+Cho1dV6fG1VJQkc0
         OK0613FO6BeQMhfh4QTKJObPySAJY5p5jzISDjg32xll40GdtpsRJ4gy19GeFzPPh9K6
         s8QHmYu3dwTDQNXb9o/dZXuBA9qVnE+/qBLtKsc3ADIkiYQnw4P5kb69dxg+iwvkOPmr
         sJ3w==
X-Forwarded-Encrypted: i=1; AJvYcCXk5h+OjXKwwBFAkE9hGoqeiesZKRwLg1hgpRGnidwV8IxAMs/5P42mERdjdgs2JWnnlIUHFuOPoOW/rtswef9fSEYTK4YSsCurMEXD
X-Gm-Message-State: AOJu0YxAK5Db+Cbnze4czLJ3owDa+WCWcuPJ0+HLpWexKzhn5Aw5IjT8
	RFtwA1Wvs+4U+2abOztCRuILro7Vsn53gjcd4ABQ+ACOuQ70qoBVZA16S0MnNBFXRjugjrlA6ZG
	a
X-Google-Smtp-Source: AGHT+IF7MEpkETHIp1R28gFULtHGc7xIrq8HH3TAtBvHh3odOsN25timUMLh+B42xnOo7p3npn/lyg==
X-Received: by 2002:a05:6a20:160e:b0:1a1:e2b:d26f with SMTP id l14-20020a056a20160e00b001a10e2bd26fmr668719pzj.7.1709608582456;
        Mon, 04 Mar 2024 19:16:22 -0800 (PST)
Received: from [10.84.154.116] ([203.208.167.155])
        by smtp.gmail.com with ESMTPSA id e11-20020a056a0000cb00b006e6215bfcf4sm2603667pfj.194.2024.03.04.19.16.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Mar 2024 19:16:22 -0800 (PST)
Message-ID: <4ab8d0aa-7c03-4160-a2bf-39351c394a6e@bytedance.com>
Date: Tue, 5 Mar 2024 11:15:00 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Re: [PATCH 1/2] sched/eevdf: Always update V if se->on_rq when
 reweighting
Content-Language: en-US
To: Tianchen Ding <dtcccc@linux.alibaba.com>, linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Daniel Bristot de Oliveira
 <bristot@redhat.com>, Valentin Schneider <vschneid@redhat.com>
References: <20240304030042.2690-1-dtcccc@linux.alibaba.com>
 <20240304030042.2690-2-dtcccc@linux.alibaba.com>
 <ad801d18-6243-47c5-8e37-ce712ca5d0c5@bytedance.com>
 <5b863dfe-bb97-4bc9-a117-153b1ba087f0@linux.alibaba.com>
From: Abel Wu <wuyun.abel@bytedance.com>
In-Reply-To: <5b863dfe-bb97-4bc9-a117-153b1ba087f0@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/5/24 10:13 AM, Tianchen Ding Wrote:
> On 2024/3/4 20:06, Abel Wu wrote:
>> On 3/4/24 11:00 AM, Tianchen Ding Wrote:
>>> reweight_eevdf() needs the latest V to do accurate calculation for new
>>> ve and vd. So update V unconditionally when se is runnable.
>>
>> As this should come along with commit eab03c23c2a1, I think it would
>> be better add a Fixes tag?
>>
> 
> I'm not sure. In fact avg_vruntime_sub() in reweight_entity() was first introduced by af4cf40470c2, and at that time the algorithm about reweight was not completed...
> 

It is because before commit eab03c23c2a1, reweight didn't rely on V.

