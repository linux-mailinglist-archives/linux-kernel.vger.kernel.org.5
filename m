Return-Path: <linux-kernel+bounces-129206-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F98F8966EF
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 09:45:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 171751F299F4
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 07:45:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7AD55C8E6;
	Wed,  3 Apr 2024 07:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="gW0xVN4o"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC01C5D903
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 07:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712130321; cv=none; b=ZIZyd1HM0jv4MERbQ7YwsLcSu7zhwl32E/UZlnJyqTuHalkhRdV6lmtHxf5k7JYWqJ5J/h/58YRejkdVYB7yJxkUaJ0xYoA1xYN4DMyI08Gsu4t1rP8oXt/Rr3uxToEDliZgO73aFnN5IaIxenCPYjnSWYdjTePuXdZc5ibLHMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712130321; c=relaxed/simple;
	bh=P+ymv59+XPwhmmC1tXPNUwhkKRHh9CCFQRAHfsCi/Hs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tzV+wfHe7NKY/tppAppQBcjX2xRFS2lPdsBK7SlS6bUYqKz4NbJIZKpKHiY7DC6r3DOi3ZDwDPWyXpk8JIS9kSXQSBA5wNQc9WgyB9bU3FXAvbJGUvQIbTmP8aMf7OiYNQR/Qnk07/RwQIOmtXRLZVPYG3ovytPizuuOXTCo4o4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=gW0xVN4o; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1e296c7aa7cso1675735ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2024 00:45:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1712130319; x=1712735119; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=G6UlaZMTnbxA96vbvATXylhXvaYbKi6kAc2YotmnHXo=;
        b=gW0xVN4oITPrrODZ2Zop3ePLoUl9SdOchKpYcF3tFHMpnM0KwkBxr0qwQKCITBoSDb
         /hBGK7Oz61hUX1OtyC1QlaMK3MM1CMxIFpaZlTMD6yqE5cBeHOCcA/JDkgR1u9WhwKjU
         c8jhWlRgK+F8BAI0L57vvwWo2XT0aPeDEOwMY45mXcy1MH86oLUe+ASDPAQ0P7MxAup1
         61zsPHpxIsy+npq8jrokJm4Y02KqIn8vG1s7ipH8MKqPxvzvVv6h+2b5mvYakzelYiPZ
         5pFLGDAStUnDYsCGnNYwCOPmlVabMk4ax2l2BGYQ38tQVmInu4bs/ONYZl+Q7+0w/2va
         0/RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712130319; x=1712735119;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G6UlaZMTnbxA96vbvATXylhXvaYbKi6kAc2YotmnHXo=;
        b=ZKsdTD0oEBCT+6VZlyB/vzN2/VUe3mf3j/nCnfoOX3lnk3ul+TC68jqKApne1uQNRG
         7+7nqFJ18pa98VuiwMVIUGtsvDHSr3VckT2HqmcF12nam/apPXwQYQQKZQ+yz8I9z5n+
         eK5PBLorXH53QS3uTk4iX6r4l1AK/iSeXi4XvPi8Jq458WPZQE/ilAxsS6kXmpibyjLp
         VuGGJtkzm3AUnmj5Qa+HiG+xQAiqx1UcVouEMbg/gL3xhoLaGdhbO8Xk2urVjrKMUJu/
         NwaTjT+ecNF29ZsSqoNc9RA7oaNcS/Y4GYnCGPQ216cN58VH/3PIEM20m6661le+kC9d
         6fWw==
X-Forwarded-Encrypted: i=1; AJvYcCVrHar/AnUlmY4+4BpTiRWT1d5kRguCzoOMTdWvXgXDD7Uvo7B02CoKn8aaDYRyRUPRJv1m48+TCSPGKr+M/FIImHRF/ztMN3ohxj27
X-Gm-Message-State: AOJu0YzxZekyrBjOjF5ZE57pXQ+XQNoRm1IUbPkZj/Ue77eUjRQx2OIh
	le0qkMNyYzXMxaKbAPFAoyLTELa2uWq9ehVMc8OdSCBjLk9ry6bBif4cbua9Z/I=
X-Google-Smtp-Source: AGHT+IFdgfnRPQf+r6TuP+UrXweCza3KRzieFrS+SjQEAI04ntMVVmPgZmWTWVgVFgR9QSxGudL7xw==
X-Received: by 2002:a17:903:191:b0:1e0:59f4:a776 with SMTP id z17-20020a170903019100b001e059f4a776mr17844629plg.13.1712130319192;
        Wed, 03 Apr 2024 00:45:19 -0700 (PDT)
Received: from [10.70.146.105] ([203.208.189.8])
        by smtp.gmail.com with ESMTPSA id b15-20020a170902d50f00b001e0eae230f2sm12532969plg.151.2024.04.03.00.45.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Apr 2024 00:45:18 -0700 (PDT)
Message-ID: <20fd87a5-7c9b-458f-9f77-3235185db7f4@bytedance.com>
Date: Wed, 3 Apr 2024 15:45:12 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [External] Re: [PATCH v2 2/2] perf evsel: Use evsel__name_is()
 helper
Content-Language: en-US
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: peterz@infradead.org, mingo@redhat.com, namhyung@kernel.org,
 mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org,
 irogers@google.com, adrian.hunter@intel.com, kan.liang@linux.intel.com,
 james.clark@arm.com, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240401062724.1006010-1-yangjihong@bytedance.com>
 <20240401062724.1006010-3-yangjihong@bytedance.com> <ZgxzmkCGNXLipMVg@x1>
From: Yang Jihong <yangjihong@bytedance.com>
In-Reply-To: <ZgxzmkCGNXLipMVg@x1>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hello,

On 4/3/24 05:07, Arnaldo Carvalho de Melo wrote:
> On Mon, Apr 01, 2024 at 02:27:24PM +0800, Yang Jihong wrote:
>> Code cleanup, replace strcmp(evsel__name(evsel, {NAME})) with
>> evsel__name_is() helper.
>>
>> No functional change.
> 
> Well, its not building:
> 
> builtin-trace.c: In function ‘cmd_trace’:
> builtin-trace.c:4919:90: error: macro "assert" passed 2 arguments, but takes just 1
>   4919 |         assert(evsel__name_is(trace.syscalls.events.bpf_output), "__augmented_syscalls__");
>        |                                                                                          ^
> In file included from /home/acme/git/perf-tools-next/tools/include/linux/kernel.h:7,
>                   from /home/acme/git/perf-tools-next/tools/include/linux/refcount.h:42,
>                   from util/cgroup.h:6,
>                   from builtin-trace.c:29:
> /usr/include/assert.h:50: note: macro "assert" defined here
> 
> I'll fix it, but please test build things next time.

Sorry. I compiled it in a new environment before. This environment does 
not support bpf skel, and the modified part of the code is included in 
HAVE_BPF_SKEL, so I did not find this problem when I compiled it in my 
environment.


Thanks for the correction. will confirm whether the modified code is 
actually compiled next time.


Thanks,
Yang

