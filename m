Return-Path: <linux-kernel+bounces-78807-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 095EA861913
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 18:14:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A8B51C24435
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 17:14:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFAEB12D76D;
	Fri, 23 Feb 2024 17:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=opersys-com.20230601.gappssmtp.com header.i=@opersys-com.20230601.gappssmtp.com header.b="w7ujQ6vX"
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0AC912CD95
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 17:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708708374; cv=none; b=W2AMgzfrnvTWAToc/s6WqO3zYaTunSvDpP3BzBFD5vme9UwT88F2hy/kP1Mmg74dOoKPbqvAJloSrX8nbeZ8Mp1OkO8ranoZDSXv/9zEzF23eOL3DGJvUmt/8sq8uZv/MQGsnuus+hFFuk/UfcY8OUHBWh7+Bm5SHc6QVCwVci8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708708374; c=relaxed/simple;
	bh=FemLqQRZMjKPGZWcjuJfugNFu3A7yhat/m0jNaSRFj8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cNKqmCK7o7qG4Hj/kBwZ0qf85Gh97co+y1onI0XS8Ngl6qjeMB1AmbX8u+Sklxstvfi4b4gp7u898sj44taJyd8bE8QG+sJmzTVYPTMsf4soZmh6CDkYcol801/8CtRxg2KjjxFJi0RfAs86jY6KfM4l7LxRsNangUgMaBZ5c34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=opersys.com; spf=none smtp.mailfrom=opersys.com; dkim=pass (2048-bit key) header.d=opersys-com.20230601.gappssmtp.com header.i=@opersys-com.20230601.gappssmtp.com header.b=w7ujQ6vX; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=opersys.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=opersys.com
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-68fbfd245adso2382256d6.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 09:12:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=opersys-com.20230601.gappssmtp.com; s=20230601; t=1708708370; x=1709313170; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jXCiSOazfM9UUsgzhAu8QK0JWGc1jQKsRm/PEVTVlb0=;
        b=w7ujQ6vXGF19S+tiwYVtSGOxK+WKRUJJmzCpfgKGusrLVI+TUv9K2bs+5McyoeManE
         K9XVcYjKnPNA511zr67imRSlUdSlAkyuSFVFlCeFUVJytmWLggPR+gpMJFi5GmoNluMK
         O/eaXy/K/Y0khvTfXZhTB6FXW6cSMxrGLwIWY8T1KQOnk6RJLxuq4BWVT1e1VYPwrBPY
         0rtOFp2HEI8BM2lRVVSUnqsRxzRStAwZ1sqEWj4it0KvHo5EI7VKcqHLSj8d7udg/als
         ieh/aD2IFtdPNB7qQG3fbx9NDrr+pnrXEG4RscV0SXgqJ5z3M7qv6ZwMY5pEkh2T6L2T
         q/CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708708370; x=1709313170;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jXCiSOazfM9UUsgzhAu8QK0JWGc1jQKsRm/PEVTVlb0=;
        b=qcEr/1uqHFQeXF/djRKFX8NOliTkk/J5aIDRczQLTT4rBxwj5YkdoJlThAVcDqKsNu
         T1sQ4uVAJl7mJSje7JDnLqx7se40VSq5rJDx1wTkP+nVcKHpH5WlgSkGCSZMsGuHSrUC
         qHxa4SdtQM1hh+a9xQ8ErihKBdxFpmtC/vDN8iEuwQAdd7Qfx8HlU47lK5OG/ECvqj2j
         wx8t429py8MQ3ZTocsoAY9VpPizwHoV6Ehjy6F7XbtNCvTrPZq1bvitCRhHLoAuMH0Um
         OQjA9vJKyMCaD13Z4OIBphGjAWoDsrBzzlDiVEadxkA4W35xY+o3An/LRIRkzvtUayRH
         RVbQ==
X-Forwarded-Encrypted: i=1; AJvYcCWTnipZA+LGFBJqlZGVeMSdkrIrZHMZP755KC0FX0hXmaf+gFgwKfJgvN+S+CSSs0MfGyQlyTv7jtecD5yEhQjfCpHso5W3bx0h/VQC
X-Gm-Message-State: AOJu0YyPE+hv43CgXk2fr0DPqLzRiK44CMcs38YXlqMGoMeTmHJYwnwv
	uFRzplKmvtyCC+EGUo18ml4ZXlVlj1HIUMlh2grwRYuXkfqboqGBEmd8yQXv8R8=
X-Google-Smtp-Source: AGHT+IGsp7MUtcj4A5A3apd96BUQmUetKWTJGe0ybnKpAGIHfZbdKHOa+b7IDTEUgMlGGrA1x/wggQ==
X-Received: by 2002:a0c:e28c:0:b0:68f:2a2b:c6e0 with SMTP id r12-20020a0ce28c000000b0068f2a2bc6e0mr345056qvl.64.1708708370598;
        Fri, 23 Feb 2024 09:12:50 -0800 (PST)
Received: from [192.168.202.90] (modemcable170.15-70-69.static.videotron.ca. [69.70.15.170])
        by smtp.googlemail.com with ESMTPSA id oh2-20020a056214438200b0068fdc55ec7dsm724285qvb.68.2024.02.23.09.12.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Feb 2024 09:12:50 -0800 (PST)
Message-ID: <ee3dbbfa-2ef1-4481-b67b-80dcd3c7010d@opersys.com>
Date: Fri, 23 Feb 2024 12:12:47 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] coredump debugging: add a tracepoint to report the
 coredumping
Content-Language: en-US
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Steven Rostedt <rostedt@goodmis.org>
Cc: Oleg Nesterov <oleg@redhat.com>, wenyang.linux@foxmail.com,
 Masami Hiramatsu <mhiramat@kernel.org>, Ingo Molnar <mingo@kernel.org>,
 Mel Gorman <mgorman@techsingularity.net>,
 Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org,
 lttng-dev <lttng-dev@lists.lttng.org>,
 Matthew Khouzam <matthew.khouzam@ericsson.com>
References: <tencent_5CD40341EC9384E9B7CC127EA5CF2655B408@qq.com>
 <20240217104924.GB10393@redhat.com>
 <20240219112926.77ac16f8@gandalf.local.home>
 <20240219170038.GA710@redhat.com>
 <20240219122825.31579a1e@gandalf.local.home>
 <776b842b-b19f-44bf-bc34-ac756fce7466@efficios.com>
 <20240223092630.49b9d367@gandalf.local.home>
 <c9427e40-10b1-49eb-9baa-dde1364e8fe5@efficios.com>
From: Karim Yaghmour <karim.yaghmour@opersys.com>
In-Reply-To: <c9427e40-10b1-49eb-9baa-dde1364e8fe5@efficios.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 2/23/24 11:54, Mathieu Desnoyers wrote:
..
> So this sched_process_exit placement was actually decided
> by Karim Yaghmour back in the LTT days (2001). I don't think
> he will mind us moving it around some 23 years later. ;)

Gee ... the shadows are longer than I thought :)

It's all yours. You guys have been doing a fantastic job and I'm happy 
to be on the consumer side of it all these days :D

Cheers,

-- 
Karim Yaghmour
CEO - Opersys inc. / www.opersys.com
http://twitter.com/karimyaghmour


