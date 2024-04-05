Return-Path: <linux-kernel+bounces-132750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EED489999E
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 11:38:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4935C2837C7
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 09:38:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2700E16079C;
	Fri,  5 Apr 2024 09:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WdjB9hOI"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07392160792
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 09:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712309859; cv=none; b=Ov//C3thGgHf8D7n2wX6HgTN4hdXolExwsOoDAXP8vL86n2iqVkHEOKKH5F8Ctryk7YEZ9Zv7JnZvpuGqgW34xy40JEeR3ssINOtCrw3dFOOlCCTYO7vsfbzXGNme6jZIQUkan4RZytPuzWAOiplYxUOtk9nkLqRkKr3NWz6ekg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712309859; c=relaxed/simple;
	bh=hA6D7fT4sD8jKG9PTwt7L4CrU9WIO8s4oBXtxdTk/M0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZMlSL3HZDYqaryu2VVtvtK1CA3Vbn7LV1fGs+VkHd2LoWJ2m61slaDv+yxgSEulaZOFKJzPJmfwPxwMfci1b2HjPP7SEY1oPu4sWcPJJNJwp66rIQkhh/ZfE+8yXNPfH3O9X1r95nB/qXPwvvn5mkSpot8mmPsXhq25bYrYO7kI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WdjB9hOI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712309857;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7i6B99SnbU2yp2qEccSjOSod/Gd1R34IkiKn/iTeu1U=;
	b=WdjB9hOIhAzrhL/gI/T6Qdsd8igg7O4jJ8cv28uqR5JWniOJIbBlZMLis5Sgt156jDF5+Z
	VrmDOo0fosXmDDAIAPu3m64Hn/Q4ZURXHsUSu666YpkEhgAe+04PURhNYsQmaigTLspVE4
	tjkwE80b4ykkKjMwACucyWNWr1J1PEI=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-624-h3cdVzeiMam5tyuOxYRMfg-1; Fri, 05 Apr 2024 05:37:33 -0400
X-MC-Unique: h3cdVzeiMam5tyuOxYRMfg-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a4455ae71fcso129655266b.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2024 02:37:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712309852; x=1712914652;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7i6B99SnbU2yp2qEccSjOSod/Gd1R34IkiKn/iTeu1U=;
        b=Qv/0WqCWzmb4IP40Wn0Ujh40Km+WJXpEufeBp1uZlGia2jPpaAq0p2k609mqryie/e
         nle5oBblrWZOYoW7uw7hRyqWSGnHzb/ks7iOiKPCrznuuMuGiljTc4He8iRbvf0c1DEk
         hkXO7qz1+BEONl0kq5wTBWAg2tuLFqUfSmL9MKVcFNCgV1oAbH3TKkn6DYqNZKiG/zTi
         6oLTfM8nlInQe+EpmOEAADjvR1YuEtFIQT4anQa4RrRohC1PZnYJ9ZSezcd+uK+wmKd9
         W2SeaSyWFArJHIv0PS/0JQbo1OERmTLSk/VqVPeqfPoCvuj9KV+xJTKIaewjc38KQsuT
         q2Cw==
X-Forwarded-Encrypted: i=1; AJvYcCXsLDCSKE0FZ67b7on0badfXWeILrLRgO/x5z4KLrBxoH8vXvH5jPNaIMPshbYeYU445YeST5OXx6TylLbick4OD2bmz4sWS1m8ljdm
X-Gm-Message-State: AOJu0YxYZ71SNZXh40uu3x5XD7zUIa2Vre2PSTOTFoTLiu36pOicveni
	9AvKkAGjkyYjYlAZmhWnzP3y4+84cAGhmGQDywsCJmUUrl+XT+g9YA/W7gjI3nyPYKlCZwyWL3B
	JtL4XdGUdaeGRTm7O+DA66h7C4zxVn+nINVuI8Pp8ICEv2akFwq6EhqQmFrVSHg==
X-Received: by 2002:a17:907:da5:b0:a51:a995:607a with SMTP id go37-20020a1709070da500b00a51a995607amr693026ejc.25.1712309852555;
        Fri, 05 Apr 2024 02:37:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG/zBqPPJlyXSz7JApGKIr5oo4tEUzHJuqsMgORqemrsokUF2aZ1kOTRyBPkj+pt6agIKasSQ==
X-Received: by 2002:a17:907:da5:b0:a51:a995:607a with SMTP id go37-20020a1709070da500b00a51a995607amr693003ejc.25.1712309852226;
        Fri, 05 Apr 2024 02:37:32 -0700 (PDT)
Received: from [192.168.0.182] (host-87-2-128-150.retail.telecomitalia.it. [87.2.128.150])
        by smtp.gmail.com with ESMTPSA id jz8-20020a17090775e800b00a4672fb2a03sm645421ejc.10.2024.04.05.02.37.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Apr 2024 02:37:31 -0700 (PDT)
Message-ID: <8567127c-c009-4960-a0e9-59f852571b11@redhat.com>
Date: Fri, 5 Apr 2024 11:37:30 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/15] sched/core: Fix picking of tasks for core
 scheduling with DL server
Content-Language: en-US, pt-BR, it-IT
To: "Joel Fernandes (Google)" <joel@joelfernandes.org>,
 linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>
Cc: Suleiman Souhlal <suleiman@google.com>,
 Youssef Esmat <youssefesmat@google.com>, David Vernet <void@manifault.com>,
 Thomas Gleixner <tglx@linutronix.de>, "Paul E . McKenney"
 <paulmck@kernel.org>, joseph.salisbury@canonical.com,
 Luca Abeni <luca.abeni@santannapisa.it>,
 Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>,
 Vineeth Pillai <vineeth@bitbyteword.org>,
 Shuah Khan <skhan@linuxfoundation.org>, Phil Auld <pauld@redhat.com>
References: <20240313012451.1693807-1-joel@joelfernandes.org>
 <20240313012451.1693807-5-joel@joelfernandes.org>
From: Daniel Bristot de Oliveira <bristot@redhat.com>
In-Reply-To: <20240313012451.1693807-5-joel@joelfernandes.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/13/24 02:24, Joel Fernandes (Google) wrote:
> * Use simple CFS pick_task for DL pick_task
> 
>   DL server's pick_task calls CFS's pick_next_task_fair(), this is wrong
>   because core scheduling's pick_task only calls CFS's pick_task() for
>   evaluation / checking of the CFS task (comparing across CPUs), not for
>   actually affirmatively picking the next task. This causes RB tree corruption
>   issues in CFS that were found by syzbot.
> 
> * Make pick_task_fair clear DL server
> 
>   A DL task pick might set ->dl_server, but it is possible the task will
>   never run (say the other HT has a stop task). If the CFS task is picked
>   in the future directly (say without DL server), ->dl_server will be
>   set. So clear it in pick_task_fair().
> 
> This fixes the KASAN issue reported by syzbot in set_next_entity().

These two sched/core patches seem to make sense.... things are working with them.

But I am not an expert in the CORE_SCHED, so I am adding them on top of the dl
server series in the v6... it is easier for people to review them...

The only thing I did was to adjust the log to fit into the 75 char that
checkpatch warns...

Thoughts?

-- Daniel


