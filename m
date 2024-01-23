Return-Path: <linux-kernel+bounces-35585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8F8A8393AB
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 16:50:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB13D1C26323
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 15:50:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B23616A336;
	Tue, 23 Jan 2024 15:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="XmvUj9ZN"
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4E9E524A4
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 15:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706024673; cv=none; b=GXROjm5NNbePW1rqXv0tNL3jVWKvQW+wokcuYpdneOG8ZPnJM+Fv7ieO1zx98sZMXhq3M8ANzvIm1o78tws3EB+zid6SNuafTacCHXZSXXg4lNTNxcdmjuvb7FfPXVaHj25AZq/cQ6UFNjKGGB9icjR0ycUPw5EcjshqqicB2Uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706024673; c=relaxed/simple;
	bh=cZsWIGSnswkpJfNQ1zY6Bc/UlVwQs6ttZZj85VwnUUA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BIR2Gx9q9+KfppbjQXeQjWTe1V8OoJVAgRC/9PwRohqzsZKsF8Iqx7J92R+9U/Z+M2V2WRwPhE5u7lyqgOEUjSmGlRRS9qpKCJ+x4TJCxuSLl3pU9OH+IG1i1IoEKNhmnsYH1Nqa+oCUwssNBFXVKx80vntTXHWuSQJw2j/pJMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org; spf=pass smtp.mailfrom=joelfernandes.org; dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b=XmvUj9ZN; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=joelfernandes.org
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-429ca07044eso33965821cf.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 07:44:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1706024670; x=1706629470; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cZsWIGSnswkpJfNQ1zY6Bc/UlVwQs6ttZZj85VwnUUA=;
        b=XmvUj9ZN40RHlUCTOCAgYOQgAiJHqXLpcFsmMcc8mS9kIi6MqpkDYkFshzF7Q9GNET
         hi4k81s8LGhlVbLAZ7EU4Qxvg+I3sS4M6GQmUTYGK9PFlu/ncqA3Qan4I8Cx+DZtzGG7
         xRwxpmG+txe6B8HLuzLQAPP0J+brjbmRR7Ito=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706024670; x=1706629470;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cZsWIGSnswkpJfNQ1zY6Bc/UlVwQs6ttZZj85VwnUUA=;
        b=V7gffx04A98o4AaTotwKMYmT7+B2/46W8vMUtk4ns6ihKs2D1EwOu8rtla2q0CLeM+
         HtfqcVmZSQP9AHsDyagNxg+aQ2U4NJNAoDOAr60j6NAo2FSXA0DEAbz0diIAOcTAtSBG
         SYGCObXpD2BWdZ3jG1OoQ8I10y42S5t4GAj7xF93uyo6bpvzEHVjLw/JnJDJGoAyZ7On
         6gC7ZyqGKmOc8s+mvnS/XzCbDOdpYm+ZbV4XyQ4aWwPIU6KebO/2p19dAScw2Q3BlHhO
         +57ZHQ0DElHAkN+v4EZ7FXrP+n3e6GPHfOFt2IH4l+IkVLykM8vcj5tKyFUdAbm+Lka9
         Uc+g==
X-Gm-Message-State: AOJu0YyHzrprOj4pypl9RTqAsMIvgIyrWvV4tBJ3hQnci39WYJdzdKPd
	gxQGSqEfLW3Dd3ApLD6E1OLLevpk9u/SW7pG16pEAHIqyfCf8rFpZEI03uEosq8=
X-Google-Smtp-Source: AGHT+IEa+M6myW1ZUclUpAeTXxs7+k+AQmHTNgsak6oyXNySB845AQqeFG9zgDjQsIVwAk2yXjhIVw==
X-Received: by 2002:a05:620a:25cc:b0:783:26fd:6055 with SMTP id y12-20020a05620a25cc00b0078326fd6055mr7463575qko.110.1706024670501;
        Tue, 23 Jan 2024 07:44:30 -0800 (PST)
Received: from [10.5.0.2] ([45.88.220.198])
        by smtp.gmail.com with ESMTPSA id v18-20020a05620a091200b00783534c512bsm3231784qkv.32.2024.01.23.07.44.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jan 2024 07:44:29 -0800 (PST)
Message-ID: <0454a852-5e61-4181-b8cd-518e1cb45b58@joelfernandes.org>
Date: Tue, 23 Jan 2024 10:44:27 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 7/7] sched/fair: Fair server interface
Content-Language: en-US
To: Daniel Bristot de Oliveira <bristot@redhat.com>,
 Daniel Bristot de Oliveira <bristot@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 linux-kernel@vger.kernel.org, Luca Abeni <luca.abeni@santannapisa.it>,
 Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>,
 Thomas Gleixner <tglx@linutronix.de>,
 Vineeth Pillai <vineeth@bitbyteword.org>,
 Shuah Khan <skhan@linuxfoundation.org>, Phil Auld <pauld@redhat.com>,
 suleiman@google.com
References: <cover.1699095159.git.bristot@kernel.org>
 <26adad2378c8b15533e4f6216c2863341e587f57.1699095159.git.bristot@kernel.org>
 <20240119015513.GA2187855@google.com>
 <3f002616-0975-49b8-a2bf-04abd0446b95@redhat.com>
From: Joel Fernandes <joel@joelfernandes.org>
In-Reply-To: <3f002616-0975-49b8-a2bf-04abd0446b95@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/22/2024 9:14 AM, Daniel Bristot de Oliveira wrote:
> Interesting, does it keep any task hung? I am having a case where I see
> a hung task, but I do not get the splat because the system freezes (printk
> with rq_lock I guess)...

I missed replying to this part of your email. We see it as a syzkaller report
with splats, so it is not clear if a task was hung at the time of a splat.
syzkaller runs in its own separate VM instance.

The fun part is though, I found a way to do ftrace dump on it without having to
pass any boot parameters (that's another issue that we can't pass it boot
parameters). So we have that tool in our debug arsenal for these issues, thankfully.

> It might be the same problem.

True, possibly.

thanks,

 - Joel

