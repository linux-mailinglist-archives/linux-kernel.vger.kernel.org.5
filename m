Return-Path: <linux-kernel+bounces-133764-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8447F89A858
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 04:07:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 396911F22583
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 02:07:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07EBF11CAF;
	Sat,  6 Apr 2024 02:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="v6gGufni"
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4FCCC8E1
	for <linux-kernel@vger.kernel.org>; Sat,  6 Apr 2024 02:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712369214; cv=none; b=fzrVtKI3OFHPE9Bk7c75OZXG2lTNDG/sT4GMVtw2SsbAgUJmDqMQ5KY5EhFwtauoR2yg1t4zyGVScOTV7TxU/JVO8u/huqyUOL092BTAIs6cs4rc80O9zGr1fTdwO2s1ctsOrRV74KCUm/LmXBy1PnGddX+4LtENpv4HeT+n0B8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712369214; c=relaxed/simple;
	bh=e5EXRkMuQtcY4FFU97cFwK+6ZxBGztReN24wshOxQy0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rNZ0Ui32vJA1D2rj6xBjq1nW+kHuAmjg9H8znEdFWVVYYlMJqqqpc9ZBAZ/qCnt9UHoykISU5nFiZ/nSZlHt/nItYiQFxUjOt5rT8lctOYzRR2IrOte0mqX4hOz6BwmV6xblAmrGYiRrRmWwnShm2cd/uvJ8FtncXJ/R9v3zdF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=v6gGufni; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-7d341631262so47484139f.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2024 19:06:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712369211; x=1712974011; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ef5+3CH6LeOgjKhuTScYGIub12ur0Qg70xfmZlVajOg=;
        b=v6gGufnicAEAhOuCdXEobKx5BsOkcvq6mtHZHi0fY4ix8tX1md7i6+k7eEgNVaqhOi
         8yqBHAE1IF+x0lHeunfEmQBFBUk6F7VNhMzX4XcOaAfhL04M2QWJ3G20lkDFI72LhV3O
         IvqIEtMzzme/htx6fJziUh4nQoERCTiGppA8XfLUBusX1um54jrihaXwsSJUlEZVYe3a
         KafIZh6Zx3n6aNuYQ2ATVZOpGYe58q+8NNg+YDMCLETv9Jwc5ktqVBjyrA1kOSDKp2o0
         FZT70aN29TT4tXmpWbWnF9TKoowJAm/CQBtyGYCkXOx9fcQaFW3iKxXxh0s4kNvk/339
         d9XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712369211; x=1712974011;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ef5+3CH6LeOgjKhuTScYGIub12ur0Qg70xfmZlVajOg=;
        b=e28XTfDSrrub4iwwMK7zfDjB2Xc/YSZUdXKsNZz0h87R2YWwrtZCRk2Y3D3YmDgRpj
         E2D8rQHq02qvrY1hzaf7H7nChlqZn+WUgpqqiSmJ8CLOL9STXob83Km2w0BO2J2oZRCK
         R4988btnmo6lw3CV8SMojjmk2pJLvxJPR3BRqzZhhlYNg+vXZCihEBWssCLJeJNo5Cpa
         +yQC8TI8FUV5B1LLo5gIZQM60E4kkFVh8eihSE2DzyUIJ/aASlwiIoiN4sxYxqw698OT
         Egr9RJaeJCD6qF7w7c3SeFzHcJGKE5fWmy5SxJhFO684cbl4LvTMbmYKYGgSYY+vW+et
         hfsw==
X-Forwarded-Encrypted: i=1; AJvYcCUrkamSJo4Ig58XEFqODTZX0fyJmhyr3o773mCOgQm03uuOT7seVHc+5LAe/LoyZgan6t2k6Snx4VKTsx0X4uLq+g0Nd5kRq5yt/mM+
X-Gm-Message-State: AOJu0YzHe0QTqSjRl0cUVxUxOTvOuZKjm70YwOzHJDqhM2DTeCTlKf3k
	FkavqSZ51CWUZNLpvFOdT9gULRbgZ1coDWDsUg1o9Sv/Wf/rulwbuSS9kGt0n3c=
X-Google-Smtp-Source: AGHT+IExzl72Id5N9VkNFUS4umNfTVh7GQ9SiT5dtfpNtOvaY2lc3a0JXNa024TUWD4io0C+OlTx5Q==
X-Received: by 2002:a92:d986:0:b0:369:f53b:6c2 with SMTP id r6-20020a92d986000000b00369f53b06c2mr2663931iln.1.1712369210867;
        Fri, 05 Apr 2024 19:06:50 -0700 (PDT)
Received: from [172.19.0.169] ([99.196.135.167])
        by smtp.gmail.com with ESMTPSA id s5-20020a92cb05000000b0036a0e23db86sm612548ilo.33.2024.04.05.19.06.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Apr 2024 19:06:50 -0700 (PDT)
Message-ID: <b2e8a3e7-a181-42cd-8963-e407a0aa46c6@kernel.dk>
Date: Fri, 5 Apr 2024 20:06:38 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] io_uring: Fix io_cqring_wait() not restoring sigmask on
 get_timespec64() failure
Content-Language: en-US
To: Alexey Izbyshev <izbyshev@ispras.ru>,
 Pavel Begunkov <asml.silence@gmail.com>,
 Olivier Langlois <olivier@trillion01.com>
Cc: io-uring@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240405125551.237142-1-izbyshev@ispras.ru>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20240405125551.237142-1-izbyshev@ispras.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/5/24 6:55 AM, Alexey Izbyshev wrote:
> This bug was introduced in commit 950e79dd7313 ("io_uring: minor
> io_cqring_wait() optimization"), which was made in preparation for
> adc8682ec690 ("io_uring: Add support for napi_busy_poll"). The latter
> got reverted in cb3182167325 ("Revert "io_uring: Add support for
> napi_busy_poll""), so simply undo the former as well.

Thanks - ironically I had to hand apply this one, as some of the
commits you mention above are not in the base you used for the
patch...

-- 
Jens Axboe



