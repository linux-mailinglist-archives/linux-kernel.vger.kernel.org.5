Return-Path: <linux-kernel+bounces-118526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B62E88BC2C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 09:20:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5DD7A1C29476
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 08:20:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A32413341C;
	Tue, 26 Mar 2024 08:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QTn0d5LV"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5D3321A0D;
	Tue, 26 Mar 2024 08:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711441237; cv=none; b=Ks4yghedtOOOs41jm0bJME2jlfVhqj1iiAWuu51KwXyBLOd7tNRVnQ7YlvpV3WX3RfW7nDpS95ERDs2rRGHXrD7zEUL3CUgKc7jaYwK61hE1zT46JT7FB/2dmVwDQWqcLah6KbopikEhXq9ua8nq6S3J3fFZRN9wqiRJBgnqxw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711441237; c=relaxed/simple;
	bh=AVjAfchceJJVbN2BKP2n1Bdxxx/whXq07FVw0FG8hfg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mR2LeFAOjQCQbWiRieBUeqBo4LNNjuutR/2MASx9wMt53jpdNsqiKZrR5ForhXFqeuP9mFt66r/NB1lbI8sJxvAKBvZrHi1AMEU70lounyGkK9iAB6wbcV9NLV6n41h4RjkqdsWoRlFMobztKc8IZ8evoY/Rk8h+NpEYcJQrSZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QTn0d5LV; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-341d730bdfcso464399f8f.1;
        Tue, 26 Mar 2024 01:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711441234; x=1712046034; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aHZKQFm/uRfn0WbsxRlg4KlgchvunMLU0uCQHGFlP3c=;
        b=QTn0d5LVQLcxMt8h9hfHMUj0/YgzyHyc3a/LtZVB8uwpiFdy1ivmYrOMRm4v9BmNvU
         6MFcOCoOxBdAfYImrQT8syKub/ZIm8f8ga9vugZXf+2FoNE8ByodwVxWgOYLnUw0t22j
         ausiQcUVZvCxO1rSFdR/FyKE/3uSYv1OoEOgsEYtoFFqRxisGE2tu1nzDG8a8OmtiG5v
         HsRfkUNoRn2fmWZF0/OEFa8je/FGuXE6UGn1cQW0fWjcBH4qNZTT+1yoRGqxp8ihxvr3
         iyzslpeQsquRfDt22SRJxOMq+ntlFjghI7kBUbFWqNZ6tvsdyCcUmJo2llwgAxNelu+G
         y41A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711441234; x=1712046034;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aHZKQFm/uRfn0WbsxRlg4KlgchvunMLU0uCQHGFlP3c=;
        b=mg163J2TiiVjhO9L1Nc2DXL6zhLBna5ZSYmbuydeOwbxYsmOFBfaq7Gk6D4tPwsHlN
         9ODqe4qGzF3XQKn0M2TF/+PBka5fkI4VMMbfx/WIWUseWHtLaWFnm3FTqz5pxUldoZsC
         gUojSQ181wnQpwcm4m0lMkHxFnlG3HixWHkDNDcGeyigmxNMFnn5nFy85Xz/IumOQXtF
         /VDhSTwOStecuHWsqdJFEdOmog5zmpYkOtL8rDlfjECXHLmtih57Zx0OK6XclYCDLSyC
         CxSDEJOwDnYss/0P3Mvm1V06ffNpPiHbzny86jTSdNNhLZARncF+ePsa3f/qpOI9Yvzi
         d3Aw==
X-Forwarded-Encrypted: i=1; AJvYcCUzWqWF05gboMaYXREkmECiyZWMjetK0s8GFKH0YReZUF63ZB7ZEwsb0YGrH/AwBen+mKCGFr0XxyJia18v8cm5pcuSSGhmP8JT+91oVd0v774OUzVBRnV9Qfjw2eZSUFNIadptZss=
X-Gm-Message-State: AOJu0YzcfYCDNFOFrIJOR7KehQRIZwcYYqsd3OoqDrKTqL1h+25ua8az
	A8prf+VWRYBDXPNPhfti2Z6BGq5v5CgRw2cHZjFOl2ZXS0MX7CrO
X-Google-Smtp-Source: AGHT+IHThHT0QtWmLc/pbNlZ0GvywR/kmYzxL3c7VbYxmyKAbnkMvykMMlSJhU3ZSQhLji1f6euVNw==
X-Received: by 2002:a5d:6342:0:b0:341:bfe4:80cc with SMTP id b2-20020a5d6342000000b00341bfe480ccmr5939148wrw.9.1711441234043;
        Tue, 26 Mar 2024 01:20:34 -0700 (PDT)
Received: from gmail.com (1F2EF63C.nat.pool.telekom.hu. [31.46.246.60])
        by smtp.gmail.com with ESMTPSA id m9-20020a5d4a09000000b00341bdecdae3sm9359997wrq.117.2024.03.26.01.20.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 01:20:33 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Tue, 26 Mar 2024 09:20:31 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Qais Yousef <qyousef@layalina.io>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Christian Loehle <christian.loehle@arm.com>,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] sched: Consolidate cpufreq updates
Message-ID: <ZgKFT5b423hfQdl9@gmail.com>
References: <20240324020139.1032473-1-qyousef@layalina.io>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240324020139.1032473-1-qyousef@layalina.io>


* Qais Yousef <qyousef@layalina.io> wrote:

> Results of `perf stat --repeat 10 perf bench sched pipe` on AMD 3900X to
> verify any potential overhead because of the addition at context switch
> 
> Before:
> -------
> 
> 	Performance counter stats for 'perf bench sched pipe' (10 runs):
> 
> 		 16,839.74 msec task-clock:u              #    1.158 CPUs utilized            ( +-  0.52% )
> 			 0      context-switches:u        #    0.000 /sec
> 			 0      cpu-migrations:u          #    0.000 /sec
> 		     1,390      page-faults:u             #   83.903 /sec                     ( +-  0.06% )
> 	       333,773,107      cycles:u                  #    0.020 GHz                      ( +-  0.70% )  (83.72%)
> 		67,050,466      stalled-cycles-frontend:u #   19.94% frontend cycles idle     ( +-  2.99% )  (83.23%)
> 		37,763,775      stalled-cycles-backend:u  #   11.23% backend cycles idle      ( +-  2.18% )  (83.09%)
> 		84,456,137      instructions:u            #    0.25  insn per cycle
> 							  #    0.83  stalled cycles per insn  ( +-  0.02% )  (83.01%)
> 		34,097,544      branches:u                #    2.058 M/sec                    ( +-  0.02% )  (83.52%)
> 		 8,038,902      branch-misses:u           #   23.59% of all branches          ( +-  0.03% )  (83.44%)
> 
> 		   14.5464 +- 0.0758 seconds time elapsed  ( +-  0.52% )
> 
> After:
> -------
> 
> 	Performance counter stats for 'perf bench sched pipe' (10 runs):
> 
> 		 16,219.58 msec task-clock:u              #    1.130 CPUs utilized            ( +-  0.80% )
> 			 0      context-switches:u        #    0.000 /sec
> 			 0      cpu-migrations:u          #    0.000 /sec
> 		     1,391      page-faults:u             #   85.163 /sec                     ( +-  0.06% )
> 	       342,768,312      cycles:u                  #    0.021 GHz                      ( +-  0.63% )  (83.36%)
> 		66,231,208      stalled-cycles-frontend:u #   18.91% frontend cycles idle     ( +-  2.34% )  (83.95%)
> 		39,055,410      stalled-cycles-backend:u  #   11.15% backend cycles idle      ( +-  1.80% )  (82.73%)
> 		84,475,662      instructions:u            #    0.24  insn per cycle
> 							  #    0.82  stalled cycles per insn  ( +-  0.02% )  (83.05%)
> 		34,067,160      branches:u                #    2.086 M/sec                    ( +-  0.02% )  (83.67%)
> 		 8,042,888      branch-misses:u           #   23.60% of all branches          ( +-  0.07% )  (83.25%)
> 
> 		    14.358 +- 0.116 seconds time elapsed  ( +-  0.81% )

Noise caused by too many counters & the vagaries of multi-CPU scheduling is 
drowning out any results here.

I'd suggest somethig like this to measure same-CPU context-switching 
overhead:

    taskset 1 perf stat --repeat 10 -e cycles,instructions,task-clock perf bench sched pipe

.. and make sure the cpufreq governor is at 'performance' first:

    for ((cpu=0; cpu < $(nproc); cpu++)); do echo performance > /sys/devices/system/cpu/cpu$cpu/cpufreq/scaling_governor; done

With that approach you should much, much lower noise levels even with just 
3 runs:

 Performance counter stats for 'perf bench sched pipe' (3 runs):

    51,616,501,297      cycles                           #    3.188 GHz                         ( +-  0.05% )
    37,523,641,203      instructions                     #    0.73  insn per cycle              ( +-  0.08% )
         16,191.01 msec task-clock                       #    0.999 CPUs utilized               ( +-  0.04% )

          16.20511 +- 0.00578 seconds time elapsed  ( +-  0.04% )

Thanks,

	Ingo

