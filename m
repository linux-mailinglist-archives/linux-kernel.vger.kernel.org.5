Return-Path: <linux-kernel+bounces-28308-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3393B82FCCC
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 23:29:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD56F28D58C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 22:29:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4A0835297;
	Tue, 16 Jan 2024 21:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="IpImeec6"
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C0D9321B9
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 21:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705440758; cv=none; b=qx/FZ7Yaz44FJXn564S+SmbCDBKH5LP/ZJVWACBARsZ4q03Ey9PPdJNHhFQYIgKj1bWpWGowH446eiHtuwxYA75ydI1BA/3tly9y1+trViZdwfufpUauWBwPTSCOa5w7i/ywvZsqOS5CPaQYh8VbEYfpVwqAEPbFGWLuVR8cVEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705440758; c=relaxed/simple;
	bh=3yocsVfSDvxZThq90Dj3nH0nus8tfly+X0MaJvdgtaQ=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:Content-Language:
	 To:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding; b=uPhHve2b/veWrU09iIHjetmHfv6bPrkhVrvMP/Tre5NE1XyZTdyRk34ZoqOPgOk2y/69LeUto5bzYWEw3P28V0GIOluznlPcEsOD4Y7Kb9s3NjEiby0r579nN23C/bpg/nx67aVeUFaEjpl7Pqr5qgmxEkjW5ULC2q3ejzHERSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=IpImeec6; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-7bee9f626caso51543439f.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 13:32:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1705440754; x=1706045554; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YuP1ZSfv05ObmtuBguIF3PEonyWKaCpp8Usq9FqYdaQ=;
        b=IpImeec6Ztag7ymu/BeQsnkdHhwh7+spJR3C1QKE87bd5cRFu1FQ9TsFK9ckMe3XNZ
         7/3cc81cOhF0R4ZB0YQ6I2axnHm6VVspDFParUnOfwOMcn8QJq8tW6mI/y7jvwu8EjB6
         gZKOuY4vZMM4iK8G6sdBi/fpsLeSKKS2uoOtAf5fPg8w4+HZh2Vg2ihBDIUKSn44pviH
         TOhdRnfDNx/UR2Uj+4UGC2H9ackzI+DD0vSms5Bsd73ZMrOLSpSYfLJzpmtHtbelMfkK
         yq61bS6MHawmBYpfBpnI60xC7s2ShAr5+UYIxivKFrAs4r7Z0TpigMGoBzIRD7wkQPXH
         Rg9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705440754; x=1706045554;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YuP1ZSfv05ObmtuBguIF3PEonyWKaCpp8Usq9FqYdaQ=;
        b=ek+vExsvriMH9DTK8AU5KBf6Sv1/PVBVznrjGe/ozdr8ft5QiDEn/eHEShG2i2Zw0w
         7avfkKo83vXZFC2hltYjSFZrLJj5DUGrrlKnT+MOamshPBibHQ49mFpDhqA+ho79Kspy
         PzKimcBVghIXTKdkepOQ4sL8saMnVXCtmqXhZBUPlFDzUHQFcWCK4FHdRVlk68Avia85
         sCBlCCMnl82IGVkVdwgV7o0+HD8mNI0TBUHJ0+FlwBZR5eTDpcVbq1IwrZMWFwYjvhZb
         yvg5uw3KiWdsIIKgOTgxhvaGFGzThdT+JFHndXtcX/S/Lsd0fosbgbkwyqbaiaHFYhkM
         R46w==
X-Gm-Message-State: AOJu0YyJoHdPnyxSXmoeIPJciqgd2XPhg1rfQJAZ9VAAiBaCOcOkV8ch
	r4MA5qXuPUSbo3+Bcld81TVVDWMSg1nTxQ==
X-Google-Smtp-Source: AGHT+IHGBWfXZuz+JxnUw5W0S83vUvP3llxnQWtTkehX6ZpkBeJfEhlXbU3TUyeDZuGlC1GwlETGow==
X-Received: by 2002:a5e:834b:0:b0:7bc:2603:575f with SMTP id y11-20020a5e834b000000b007bc2603575fmr195550iom.0.1705440754189;
        Tue, 16 Jan 2024 13:32:34 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id n22-20020a056638265600b0046e552de3c0sm23529jat.117.2024.01.16.13.32.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jan 2024 13:32:33 -0800 (PST)
Message-ID: <71ba9456-45a7-4042-8716-ccd68cc7329f@kernel.dk>
Date: Tue, 16 Jan 2024 14:32:32 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iouring:added boundary value check for io_uring_group
 systl
Content-Language: en-US
To: Subramanya Swamy <subramanya.swamy.linux@gmail.com>, corbet@lwn.net,
 asml.silence@gmail.com, ribalda@chromium.org, rostedt@goodmis.org,
 bhe@redhat.com, akpm@linux-foundation.org, matteorizzo@google.com,
 ardb@kernel.org, alexghiti@rivosinc.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, io-uring@vger.kernel.org
References: <20240115124925.1735-1-subramanya.swamy.linux@gmail.com>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20240115124925.1735-1-subramanya.swamy.linux@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/15/24 5:49 AM, Subramanya Swamy wrote:
> diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
> index 09b6d860deba..0ed91b69643d 100644
> --- a/io_uring/io_uring.c
> +++ b/io_uring/io_uring.c
> @@ -146,7 +146,9 @@ static void io_queue_sqe(struct io_kiocb *req);
>  struct kmem_cache *req_cachep;
>  
>  static int __read_mostly sysctl_io_uring_disabled;
> -static int __read_mostly sysctl_io_uring_group = -1;
> +static unsigned int __read_mostly sysctl_io_uring_group;
> +static unsigned int min_gid;
> +static unsigned int max_gid  = 4294967294;  /*4294967294 is the max guid*/

As per the compile bot, these need to be under CONFIG_SYSCTL. I'd
recommend just moving them a few lines further down to do that.

I think this would be cleaner:

static unsigned int max_gid = ((gid_t) ~0U) - 1;

however, as it explains why the value is what it is rather than being
some magic constant.

-- 
Jens Axboe


