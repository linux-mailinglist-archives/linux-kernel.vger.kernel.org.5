Return-Path: <linux-kernel+bounces-126795-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90558893CCE
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 17:22:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 493EB28300D
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 15:22:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5C5647779;
	Mon,  1 Apr 2024 15:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="oJN4K/kp"
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1552846426
	for <linux-kernel@vger.kernel.org>; Mon,  1 Apr 2024 15:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711984879; cv=none; b=G6RNrwewUpztvCYbpnZDX6pACOeuKfomIst7kFPEdY3hN51tkvM7opnK5Ewuj2QRU8V+Cs6ma0dkM82duicEBq6RTEBKCZQ38LKf9gESXeHssv+upNme+g/rtZxY5c9/5M6EEFhsms0VnCkbMmRMOhsguzY61BJ4/guCOFFz2NI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711984879; c=relaxed/simple;
	bh=/KLdZiR4QXPlmZ2IyRX/B74PqmuFJXw/EHBtXhxRrcQ=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=LCNLMhZ8k2ztD9UDD/ToPLh0rlW/k4MwzN9fIfybaY1Rz713A3WeyB9sbcENHgMplK8cNbrCpaC/rQBQpB3hCvSvB+IO2Ya+LL6/ezraV1CH8MOcTvHaU70okNckOI5wf3Hz3eL4qFXDtzxh1k859ZxyVfLHg9DsFV1sh93W0qM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=oJN4K/kp; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-7d0ab7842b4so26942839f.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2024 08:21:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1711984876; x=1712589676; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=P/V2MZ5uh3gLfvXWw9QFbKA/inszNG5TrDoVBEM3XV4=;
        b=oJN4K/kpob0buDTkPKOc24f3WNEwcKoxW1QfmwAC9/GDjpahYncqQen99AwysD5Sja
         dWzpeqX/g69RN4q74raipg/DNByss1ydHLHAa2FfqXgvZiMFij1YWooB3JINMNxH9mkZ
         03CfC7XFq8diFerHwjZlG08tGgbT9JDQbgPX+X/E1TY3x1+Yc2vzabYZGDrg0q40SrRN
         CNlGPDIjef39IvBqNr2ba3J2kzPr0tmkc/5kABWOHvrRxc2T8eVhxjOR9wkmeWB+LlrN
         mXLoZ/L8c6KES2j8slZQJvU7W9nLt/1KOQLK5rkuZlof5NynkwKyYInzbxXDoo8isRDd
         Z4eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711984876; x=1712589676;
        h=content-transfer-encoding:in-reply-to:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P/V2MZ5uh3gLfvXWw9QFbKA/inszNG5TrDoVBEM3XV4=;
        b=eITHOW5IQKG9xA9u3ohtF0vJfyf/qbxUz/cTHMxpI//zvFNQ+7nFMQOTWIXwyvD31+
         uIUkXnJtRx/P1KEK0MYx4Zuv+fNLgi5iY6RaxQXCJUJsRCRVRr6gR3FtqK8NvTBkoTgJ
         7dirLKU+SXwqiEoqFpucUSY8hL2ojJmywroyl+XojbKuSU7W1WgwK/kJOz5i1XXkZXAA
         0GuOKkSuNArUk8QdBvPQO+qNAZGKm/8U627Q85NWPDbxm+L1ODU8nUA40LT8VLEWxzsU
         vmkYLraCWQjXO9T46ZnC1Fl3pnlORfag6euRksCa690m0QHTGUt7fnZaW87gGdEXJ51B
         v0+g==
X-Forwarded-Encrypted: i=1; AJvYcCXMCzG9FWpiEeOkKnrQGoUWpgGzZOJgePSAuIyW8ppGs6iABKEEw1JhB0DJLI3EfT2m7A37+ACJJ0YZ8kbWs8+77caBdRtAOyjdz2ta
X-Gm-Message-State: AOJu0YwTQCIftS1mabGgCezJxciLt0mU508L3Fzz3uiy7IJ/WW/B+a4V
	OysYwj5cM315Xe/ux9cPAHCMnH7Bh66HKHb78D4PRO6QXQJ7UKObPzD8Nqsa7yk=
X-Google-Smtp-Source: AGHT+IHtPUA6MoDL6pF6M3w1Ctukj+h8rfggeiJyWbO/sid7Xq4kATg69AICl5/lJgmSKHySgFrpVA==
X-Received: by 2002:a5d:9b1a:0:b0:7d0:8461:7819 with SMTP id y26-20020a5d9b1a000000b007d084617819mr9360885ion.1.1711984873215;
        Mon, 01 Apr 2024 08:21:13 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id fn16-20020a056638641000b0047ecd14e8fcsm2624456jab.130.2024.04.01.08.21.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Apr 2024 08:21:12 -0700 (PDT)
Message-ID: <c37a4c3f-e584-4e8d-9973-e4b95cfb0169@kernel.dk>
Date: Mon, 1 Apr 2024 09:21:12 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] timerfd: fix nonblocking reads
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
To: Christian Brauner <brauner@kernel.org>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>
References: <b4059ed0-5567-44e7-95f7-f7e4b227501c@kernel.dk>
In-Reply-To: <b4059ed0-5567-44e7-95f7-f7e4b227501c@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/1/24 8:36 AM, Jens Axboe wrote:
> timerfd is utterly buggy wrt nonblocking reads - regardless of whether
> or not there's data available, it returns -EAGAIN. This is incompatible
> with how nonblocking reads should work. If there's data available, it
> should be returned.
> 
> Convert it to use fops->read_iter() so it can handle both nonblocking
> fds and IOCB_NOWAIT, mark it as FMODE_NOWAIT to signify that it's
> compatible with nonblocking reads, and finally have timerfd_read_iter()
> properly check for data availability in nonblocking mode.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> 
> ---
> 
> Can't believe it's this broken... Patch has been tested with a test case
> that was reported via io_uring, and I also ran the ltp timerfd test
> cases and it passes all of those too.

OK pre-coffee email, it's not actually that broken. Which makes me feel
better, because I'm not used to finding stuff like this in core bits,
mostly just the odd drivers.

I'll send a revised version of this with a fixed up changelog, as
supporting IOCB_NOWAIT is still very useful. Won't change the actual
patch, as that's really all it does.

-- 
Jens Axboe


