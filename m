Return-Path: <linux-kernel+bounces-33997-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 075AE8371BB
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 20:03:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 382F71C26D0A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 19:03:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1DD75B20D;
	Mon, 22 Jan 2024 18:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="h2PmiSuZ"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6D8B5B1FB
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 18:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705948999; cv=none; b=HqaKRjqvLojYgioJRzKmI9WNbCmUDys7inBxHyc4Ki4HjgILcRf6jVTOZng/wncasGkoklLlKdBUgxuFvC8D2dDyqBbYoVVDnQCxP3aNTh1UdNOoUYLn8qEWc5SDVpKxuYWfRPUW+vxsFiBrIGRdzrc/WKEze7ufhfUjLDFo6y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705948999; c=relaxed/simple;
	bh=T+o/s3CTIcYJ3N/YCphjc6ZbvjLA4Ub+xxTCqaIlLeM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e3DFwbCV3vXrgkroslbEhwFad80wchE11q32u6fhuhrUeQzvOHdOWcdHlb6ydPPLT1QhkMPtwKIVM2Galvxo4OEOnhvW/0KDvKxZaj3N69CK9IX5fkRBmRShLwlmxf0xd1wonFaCJy2MqPc+kuJbaCy/zPILuS+a9KBMkJtHQGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=h2PmiSuZ; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6d9b23698c0so332980b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 10:43:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1705948997; x=1706553797; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZWvcjSDej03OJY/u+kBZhuwfFd3b6LTV2fJ66OBqjM0=;
        b=h2PmiSuZOQNt3rj+JN84gd2KEQlBPhTGoo1NPxTuI//IlKfos9LKXIWZlsCI+p/Rag
         9KAYj2uoB0pMsifrbb/gB+CyPXQ0VzdzwSbp2//MvQEb9Ejs84gNz5tyryjowEVwo7+/
         THj7JklFLgI1yTguDu+JQznY0NCHq7xv8R3T4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705948997; x=1706553797;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZWvcjSDej03OJY/u+kBZhuwfFd3b6LTV2fJ66OBqjM0=;
        b=Ly1XBWypCa0/pgljQECbfBe61X7NBvokfgLZrtDdpCOCacz7dEILg8+4FaoGpt36u3
         9kYERjZ6t+Yo6Mg8pSBtWK+HtKghgyH5FX+xhH0/vFiFif95BAiEW98fPnDeE+O88UC4
         AcsecStQ12AZmM/epYAnX4xVHPggzpWhyz49W5ai6UoteUVSzK4BMmkM6XV7E4iNiOdR
         jXNLalUPGPr1C0GhSu0MFurKvGfL6kEAYcCvjFSmMkAibjj4WU+v6sLBLP4GUQijt2nI
         TsGL/CbDkIBe36/WZgB8N8CqeBDMELV6uPbiXHLPTZdaD4tkTFuLtO6yPF1vNKhnjIlY
         CQxg==
X-Gm-Message-State: AOJu0Yw3gDk+r7pAvNsmkDnkKPpuGhg04DXPrKrq9FdsASrEQvh5TjEo
	ziQm48h/pCguWBg/PCvqL42zlR71NIawMLV377OvpUv08KTlQhPo9w+IenUILQg=
X-Google-Smtp-Source: AGHT+IFM2/AEpPgCECSEqjEMfANbYoQZet972fXu+eeLtG3EdP6FbKLTvqqWdPyVxM9FUYbvFoEjAQ==
X-Received: by 2002:a62:84d7:0:b0:6da:86e5:1648 with SMTP id k206-20020a6284d7000000b006da86e51648mr9465187pfd.0.1705948996938;
        Mon, 22 Jan 2024 10:43:16 -0800 (PST)
Received: from [128.240.1.152] ([206.170.126.10])
        by smtp.gmail.com with ESMTPSA id g17-20020a056a0023d100b006db8d08660asm9860037pfc.211.2024.01.22.10.43.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jan 2024 10:43:16 -0800 (PST)
Message-ID: <40935ea7-9da6-455d-8df3-94e7e0fc6fa4@linuxfoundation.org>
Date: Mon, 22 Jan 2024 11:43:14 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/rseq: Do not skip !allowed_cpus for mm_cid
Content-Language: en-US
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
 "Paul E. McKenney" <paulmck@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240111154922.600919-1-mathieu.desnoyers@efficios.com>
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240111154922.600919-1-mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/11/24 08:49, Mathieu Desnoyers wrote:
> Indexing with mm_cid is incompatible with skipping disallowed cpumask,
> because concurrency IDs are based on a virtual ID allocation which is
> unrelated to the physical CPU mask.
> 
> These issues can be reproduced by running the rseq selftests under a
> taskset which excludes CPU 0, e.g.
> 
>    taskset -c 10-20 ./run_param_test.sh
> 
> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Cc: Shuah Khan <shuah@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: "Paul E. McKenney" <paulmck@kernel.org>
> Cc: Boqun Feng <boqun.feng@gmail.com>
> ---

Hi Mathieu,

I applied this to linux-kselftest fixes for the next rc.

Please cc linux-kselftest mailing list on your future patches. This makes
my workflow easier as it relies on patches going to linux-kselftest patchworks
project.

thanks,
-- Shuah


