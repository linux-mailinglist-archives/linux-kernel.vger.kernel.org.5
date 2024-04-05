Return-Path: <linux-kernel+bounces-132687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EACF899898
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 10:55:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 196FAB226D4
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 08:54:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9067F15FA6B;
	Fri,  5 Apr 2024 08:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M2ew5+H9"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68F06611E
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 08:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712307291; cv=none; b=m8ezy8h3CJ0nBOXlEfbJy0RGBLeYX5IQErclSuimnHA2UtI3RpRz7GMQ8IjLFwLnxNOJuElt4SpIu7MchBucw6nso0JsjTEwuFm3LSBSyJQFXTUED59wsUaXpIwTwKqkMMBsQW+xwAhjfWBB6jOqK51Bdc5zSIjMeitIZsY/OPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712307291; c=relaxed/simple;
	bh=N3tSnJJ5B9cvcmlA05jWhatlsn0eDJOoakXmXKZPw0M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i7WANIbWBrG9Ne3WEsCb9hLKLanubU/nZFL2od/X6lWJHA2R6BwlFxmkWOwvHAuJ2nKQUT9+N+7oAtP46PXVMnPrtfaaBFw0VLEJaZUYzWlKfnq6ETs9iG4t9Tqaa+N+4tzWc2VJchqF8cpFl2xuaZ+jJscEJjrem/8bLGRX1C0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=M2ew5+H9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712307289;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+rd7OWEfOgaXcRrsSTTxKuVoa46Lnc9mtKHiCb+X01E=;
	b=M2ew5+H90/7juVMGikvT9yDGOFEHkznzPfDOjOJKANyhEtNetDh681RcpKg8sSrziRuQNG
	icmRjfcJr6bmYEdQSozkpPi7ZU13KyWJAwRNfkzRt4sxQQ1zegNnUzJa7GgzX8aE7C7WmX
	ONeCkCQ/RpKs7vaUi1hpjO05wYE3G/E=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-10-3OhZOoMvOJ6BR-EB9nfbtQ-1; Fri, 05 Apr 2024 04:54:47 -0400
X-MC-Unique: 3OhZOoMvOJ6BR-EB9nfbtQ-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a467a6d4e3eso109280866b.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2024 01:54:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712307286; x=1712912086;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+rd7OWEfOgaXcRrsSTTxKuVoa46Lnc9mtKHiCb+X01E=;
        b=IgrnB44GTUbPC0mcLTq0S+HZY59rX3PI7jOXnMjxS+FoJAcOIjn+mVdkOTRqOdN2q9
         g++DBnqrgljOw8XqIGCedYHL9va7xXeYONRM9D5+OSOFSS6M14Lf15Pp+cnCkG3buCV2
         f8i+OylLHS9ttDYgDI8i6cePGyf44EeC2T2D7NNvHRl+jVAOwWXYm5KAzZRoTkpJhHil
         VCa5dYbXZvhinPFAj6cdtt4C9iz5ejWlOGQxHeY2APMQ3bFTM30USoZL7iAaJVhskNBn
         X4cw/ZpcDTj4vo7HlqUaTMWsXeGFeGbLKtLrlkKv3Kr91wi2fI2LhuLgbocJsJsyIcok
         IsiQ==
X-Forwarded-Encrypted: i=1; AJvYcCVXggjOzhK5XZQLJzyCtbHbdMGJ+FmQ+yjds36/O2S3VXJ7KFwH2pSG3uexlYFli+0mRw2KxceoAPYWW/PuyByQNSuswT/w540ECfe7
X-Gm-Message-State: AOJu0Yxz0Uk/3UhILOFRcGxz7T2PrrI7DwuFEi3PTAB2CWRQnJlT8BA2
	RsnLaldYHAALe+fTa0p2vAIQPxVJGWZYDR8U19hpOoeKZXquR0MH9wJvXm3q4uZIUx4eNwHN8zk
	KUEJ0yHXLp6HHZ0IiZp5XS/8JFZCnDM5vbmLzZzVUYTLm4MOnJqd7iE+2x/rWjg==
X-Received: by 2002:a17:907:7b89:b0:a51:9d99:78ae with SMTP id ne9-20020a1709077b8900b00a519d9978aemr712166ejc.67.1712307286661;
        Fri, 05 Apr 2024 01:54:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGsJl6PzDAKkRMB2gDp39CI1VRHpD8SlyhCvrBgGiMcgRk44TtWhmTbhlXsf+UCBaojR6xdQQ==
X-Received: by 2002:a17:907:7b89:b0:a51:9d99:78ae with SMTP id ne9-20020a1709077b8900b00a519d9978aemr712152ejc.67.1712307286440;
        Fri, 05 Apr 2024 01:54:46 -0700 (PDT)
Received: from [192.168.0.182] (host-87-2-128-150.retail.telecomitalia.it. [87.2.128.150])
        by smtp.gmail.com with ESMTPSA id z12-20020a17090655cc00b00a42f6d17123sm594252ejp.46.2024.04.05.01.54.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Apr 2024 01:54:45 -0700 (PDT)
Message-ID: <4f30b6cd-8077-4ab3-87ab-8f29a66cc6c4@redhat.com>
Date: Fri, 5 Apr 2024 10:54:44 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 12/15] sched/deadline: Reverse args to dl_time_before
 in replenish
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
 <20240313012451.1693807-13-joel@joelfernandes.org>
From: Daniel Bristot de Oliveira <bristot@redhat.com>
In-Reply-To: <20240313012451.1693807-13-joel@joelfernandes.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/13/24 02:24, Joel Fernandes (Google) wrote:
> From: Suleiman Souhlal <suleiman@google.com>
> 
> dl_time_before() seems to be incorrectly used, we need to check that the
> 0-laxity time is ahead of the rq_clock. Fix it.
> 
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>

Makes sense, I am adding it to the defer patch in v6 as it is a fix for it...

-- Daniel


