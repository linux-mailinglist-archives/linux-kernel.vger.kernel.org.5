Return-Path: <linux-kernel+bounces-160430-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C56408B3D6A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 18:59:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DFA5283B55
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 16:59:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3986415D5C8;
	Fri, 26 Apr 2024 16:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Napl2QMk"
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AEB5158DB5
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 16:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714150653; cv=none; b=AtGBGpxn9KvJDeE3xRHzD2lLj+lQ9KVXUgFcD/0bFPqw2vWhVfILh0tEJkRSDD6S9k4ohSD4aKMoRLGgYREIjze24io7ylnlRvjGN7BgEQVc95u+d2VCRHA3PW3HnZejwVRUF6e3TrysweHY+6AUk4pa6PnGl0faH9+DsBAEqP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714150653; c=relaxed/simple;
	bh=iwM6s7Kd0eHXQvuCS74HOcuoxgkEaaCMuqibWr+uRU4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MVTj5lRgw1od5hpQN5OK0wfh9UaG/ku7uOr6edWLrdDPlqot7dCU8eGID4KH2mijyJWhxIC6yzFuvP/8Vka6CBqc+R1Qcii0qoyZoYdkj2KlfH7VKCem5XfpwUyzw82c+O4G1iGLh6lWxoOczm54txHTMUsltTxEaKLLQxGJHcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Napl2QMk; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-78efd1a0022so165226885a.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 09:57:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714150651; x=1714755451; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QeNec6TOUGkbstqdXszHUxwBIyDBbdMz+hQZJpjjTis=;
        b=Napl2QMkCBlt3RqlmZoBj+/hHsfvwMXWynEqNIen5Q+kQr8dokXi1eoJnUBufumAZq
         +tpznG9l3foQArSev1xCiWsG57qEOtrumEazY8e2G2ibL6W4sTx1+Lig0uQJsw6EdHRV
         2n3M7le/SoOTf2E/p15BpcZJMSoGRAILUzL3oQd1YZskfgfXVWbxW33mqT79MgpZgynB
         Q2+SInrEVdtqrKPGQzpdfhYh0G6vkgC+AQmPrfSU5/aGTWlSwjqMWXM7qDj7lrPST3Qd
         KAKJRz+I+pZnPGC16JYpUL1kj/14h/m8vdWJxc3wZjimCs3CSSnfjTtsKw5c3bSG0b50
         ziNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714150651; x=1714755451;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QeNec6TOUGkbstqdXszHUxwBIyDBbdMz+hQZJpjjTis=;
        b=rXrEk0726ohT/O91JKyx+j6rcha0rQ7IOQzxN1nat2c8R+K0Y7EeN3z5RLdAItkOwq
         lVGrwdaUaeLo4PmufsDKWzM+AV8I/ARD95asE/bkTrcS/uHbIUhpq5/iWu5SHNhNOcGP
         wWRrOrJPj1lo8/Zz7tEiiOO0PROQx+0gAjN8e7rtNFMRkNpGZlXYieyUdyD+m3X419ZT
         BW1uPotwuAqoOjbxc+mKWvonFAF4EKUe0dEXUhvCyn0qAsOuxdHs62pWFe0uwsVZuVDZ
         nG7O6ANUke+v1cnSVq2nYD7TgzxydZUlBoiv+byGzCKvfgzHj/qWeM4a1px3Uq0aF5Dy
         93QQ==
X-Forwarded-Encrypted: i=1; AJvYcCV8LkMP8J32wLHGlStlg0UxzGxsyVBXEiDMvc4fcLWZRy4gM2SNmhr2Qy+LKtcKSznMd3Dotvlk2+lu6O/m/AkR9yJeh0YYVJ8n4QhN
X-Gm-Message-State: AOJu0YwjCJC55cbN3hpBjAVgdKBcxIc9DoKiwquHmUCmFVn2KLoH7A2e
	H3n5i+I+hoePAHLA9R90fDSHp8lALw5EaA1bWoCE8GqfLUV9K5UYbvcNWDgaUw==
X-Google-Smtp-Source: AGHT+IGUtyNxSPXf0KA1xAi6zd1MZuzLQ+yvQizRd21qN73Jlwgy6FtVIZSWl4hLSM0HzO/nwBksIg==
X-Received: by 2002:a05:620a:1d96:b0:790:7d72:977c with SMTP id pj22-20020a05620a1d9600b007907d72977cmr3293158qkn.62.1714150650772;
        Fri, 26 Apr 2024 09:57:30 -0700 (PDT)
Received: from [192.168.1.31] (d-65-175-147-142.nh.cpe.atlanticbb.net. [65.175.147.142])
        by smtp.gmail.com with ESMTPSA id y10-20020a37e30a000000b007907319aa02sm4873093qki.67.2024.04.26.09.57.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Apr 2024 09:57:30 -0700 (PDT)
Message-ID: <81c1590d-076b-4cc1-9fe0-f6ba9304c281@google.com>
Date: Fri, 26 Apr 2024 12:57:26 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/36] sched_ext: Implement BPF extensible scheduler class
To: Joel Fernandes <joel@joelfernandes.org>
Cc: Tejun Heo <tj@kernel.org>, torvalds@linux-foundation.org,
 mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
 vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org,
 bsegall@google.com, mgorman@suse.de, bristot@redhat.com,
 vschneid@redhat.com, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@kernel.org, joshdon@google.com,
 pjt@google.com, derkling@google.com, haoluo@google.com, dvernet@meta.com,
 dschatzberg@meta.com, dskarlat@cs.cmu.edu, riel@surriel.com,
 changwoo@igalia.com, himadrics@inria.fr, memxor@gmail.com,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, kernel-team@meta.com,
 Andrea Righi <andrea.righi@canonical.com>
References: <20231111024835.2164816-1-tj@kernel.org>
 <20231111024835.2164816-13-tj@kernel.org> <20240323023732.GA162856@joelbox2>
 <Zf9Tz2wHT6KYtqEG@slm.duckdns.org>
 <CAEXW_YR02g=DetfwM98ZoveWEbGbGGfb1KAikcBeC=Pkvqf4OA@mail.gmail.com>
From: Barret Rhoden <brho@google.com>
Content-Language: en-US
In-Reply-To: <CAEXW_YR02g=DetfwM98ZoveWEbGbGGfb1KAikcBeC=Pkvqf4OA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/25/24 17:28, Joel Fernandes wrote:
> But if I understand, sched_ext is below CFS at the moment, so that
> should not be an issue.
> 
> [1] By the way, now that I brought up the higher priority class thing,
> I might as well discuss it here :-D :
> 
> One of my use cases is about scheduling high priority latency sensitive threads:
> I think if sched_ext could have 2 classes, one lower than CFS and one
> above CFS, that would be beneficial to those who want a gradual
> transition to use scx, instead of switching all tasks to scx at once.

The way we initially went with Ghost (which is the Google project 
similar to sched_ext) was to run Ghost below CFS.  That was a "safety 
first" approach, where we didn't have a lot of faith in the schedulers 
we were writing and wanted to convince people (including ourselves) that 
we wouldn't completely hose a machine.

For the same reason you pointed out, we eventually wanted to run our 
schedulers above CFS.  Currently, Ghost has the option to run above or 
below CFS, and we're pretty close to being able to run all of our 
schedulers above CFS.  Once we do that, I imagine we'll drop the "above 
or below" aspect, since it's a bit more complicated.

It's actually even more complicated than that - ghost also has a 
separate "ghost agent" sched class above CFS, even if ghost itself is 
below CFS.  This lets us run a single userspace "agent task" on a cpu to 
make a scheduling decision.

Anyway, when we port Ghost to run on sched_ext instead of our custom 
ghost sched class(es), we'll be running sched_ext above CFS, and I doubt 
we'll want to run below CFS at all.  Though whether that's a local patch 
we carry, or the default upstream probably depends on what everyone else 
wants too.

Thanks,
Barret



