Return-Path: <linux-kernel+bounces-46667-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E8F19844268
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 16:01:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D9151F2E25C
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 15:01:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4998212C527;
	Wed, 31 Jan 2024 14:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="w008ksq8"
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C92584A57
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 14:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706712889; cv=none; b=lCHt9eeVhkOiRuKk1vDSfO2jNJj7baSrGk4gg7Qv7jIpWi0ftGPBL3pRh/XInGLJAMikaoOAmC29mRifQRVI0E5QBFFm27wPFWaLKmZRezYrnxdY0P5JPS44FqbOLB8z1LFpg1zwdZm6FTSarXqXNFvV+ldckvKwDMimMurwwGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706712889; c=relaxed/simple;
	bh=lDjFKNdSjktCWTnrP36guAx2KyT01h+vfaOsmV3kEqw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R51k6XL/aPjI8BE5hyWKpWAJ4FuUbozOobLR6mTCkCXTwR9/n1jQn72FSWhSNG9lFX8GD+8u182Rp9v5l6hhHeoH9l1uZ7CEunq1WHexSlr3t5ugJMe1sZXan9tB4EQtvMUJtHk7zms02O4lrq9JPCvq50WAHu7LsgMWFNOwWww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=w008ksq8; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-7bbdd28a52aso67364539f.1
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 06:54:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1706712886; x=1707317686; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OHJQ/aG4p3T91agak0V8di4mytjOgAxT9qUMt5eIZHo=;
        b=w008ksq895OnsRl6funjwLly+BnNzUOIoJsAy7glokT5xdh9WiC3HiXLq/4NWrWJM3
         ajl/+QHmEzoPRFdgxjrK6oy43csOICn6UslNYP2uQnmilQq8jeeAOB5RqPeQs12vOGtm
         00vOD1DyKbgStY7l+2iL5m1XZI6RW/APf9HJwrYalYZu1SnZnSQEqrRxz5rwlKMPcLr3
         NRNItGERLIRHi5acm+L0EhgctJHPzPv57kFgvElKDMuYxQMzLBNZhTWcYI0pnlEeWVgl
         WtzRfuV/E+w0Zo019aoTQDvV+uuwyVHCRVIIRJ4Tn9hG8Lp6TuLFXsa1fsl8t72v+JUM
         Anag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706712886; x=1707317686;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OHJQ/aG4p3T91agak0V8di4mytjOgAxT9qUMt5eIZHo=;
        b=ovceSUnfmkpBrPCJY1VulUbB+/FZcwYm+cgzOvixrWzz8kOFnQrtGD7PqyCs5pGE5n
         YjtDNEnrDR2WuqWV/CH0RaNdIKEcjus7bQs4R0I2dJgx4x59JGX+XZ070Jy/A/68J0ZQ
         uY9+IDD2qdaLjME5H+LUIq280CZoqqKTk6M/vH/lOFevDvVt/mD5WsvE1tSXGcOSOE0n
         HRMg3gHf+iqxJX+vGHfHH2wzQla1+E/KtIPOPDEtseaXbStUZmaO6f0HnZLOcQEJchH+
         Z9kcoLRw0mBSMPWBlAPKTKvznzDmk/UQp9Om186xJ/Wt5vwU0wuC9NB5tAxjatPKjOch
         FI9A==
X-Forwarded-Encrypted: i=0; AJvYcCU5H/uzB/w6r00crTU/kyCIAnMv8Gs8uBsTMqGwSTx6wbaPiO08p+gBpFExXW9ckcB25jcQgidk+a6az9zRR7fCWfqxkm6dJxnOwqwq
X-Gm-Message-State: AOJu0YyogoEngCJhQYarQQLXhM5t+d+tmR9oxG2zXKMDig5i3FwgXb5Y
	tVpQMTgoFK+Vpjgd391/vlLi7bEVZ1Chx2cE1OKtiF5LD6RTF6QrbVrI3v2TIVU=
X-Google-Smtp-Source: AGHT+IEt1S3q1yxIamRX2NO+jB7ghgLZERhYPZgKQ/bWKhlHRf1N8j4BmbVE/+5xSCORU5L/shVDVA==
X-Received: by 2002:a6b:e211:0:b0:7bc:207d:5178 with SMTP id z17-20020a6be211000000b007bc207d5178mr2105418ioc.2.1706712886384;
        Wed, 31 Jan 2024 06:54:46 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id x7-20020a5eda07000000b007bfe7b63a30sm2231455ioj.21.2024.01.31.06.54.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Jan 2024 06:54:45 -0800 (PST)
Message-ID: <27bf629b-7549-4f15-8d88-cbc2def86df3@kernel.dk>
Date: Wed, 31 Jan 2024 07:54:44 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] trace/blktrace: fix task hung in blk_trace_remove
Content-Language: en-US
To: Edward Adam Davis <eadavis@qq.com>,
 syzbot+2373f6be3e6de4f92562@syzkaller.appspotmail.com
Cc: akpm@linux-foundation.org, dvyukov@google.com,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, mathieu.desnoyers@efficios.com,
 mhiramat@kernel.org, pengfei.xu@intel.com, rostedt@goodmis.org,
 syzkaller-bugs@googlegroups.com
References: <0000000000002b1fc7060fca3adf@google.com>
 <tencent_6D33089EBD1B9C4BEE1B2425C6BAB4BB9F08@qq.com>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <tencent_6D33089EBD1B9C4BEE1B2425C6BAB4BB9F08@qq.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/31/24 6:28 AM, Edward Adam Davis wrote:
> Delete critical sections that are time-consuming and protected by other mutexes
> to avoid this issue.

What is "this issue"?

-- 
Jens Axboe



