Return-Path: <linux-kernel+bounces-105185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4001687DA41
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 14:13:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63E2F1C20D71
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 13:13:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77C9A18AF8;
	Sat, 16 Mar 2024 13:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="SYsqsXQn"
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 272FF17BAF
	for <linux-kernel@vger.kernel.org>; Sat, 16 Mar 2024 13:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710594800; cv=none; b=Sg3wuXZ9ch6pzDWX4TBaYUTjL7r9+HfTZ7EYnPUsrMDopkfiDrP9lb5M4odmxoGZVzeFePgtXpdDLPjsQL8QPsD1QLjHgAj72FvgrT35IfXsGL7DkPJJvay3hVNqUHa/S+yM7xvq7tlURXAJnfbzksW2n6uaE942x47ThxuU1wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710594800; c=relaxed/simple;
	bh=9IKAL9O5Kzhj2bWwcxxcLVVHc+FpAsBJbr8QW4g4aUo=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=h+XXnYiSWRoySa7ajghksGtphlfen8Yf6hyo80MgGBHcNj8vzQdcIyA1nrMMDJ3O02v/y/D9ixC/zAbSQUbLfUfQ6dTjjCKkH6U81StiHmVwJhkXRTEiP+7MK3hY+6zAXQ9eefObZnrneQf6toxOTNUT8qXahbAqvGEHH1slLZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=SYsqsXQn; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-29f66c9ffa5so61615a91.0
        for <linux-kernel@vger.kernel.org>; Sat, 16 Mar 2024 06:13:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1710594797; x=1711199597; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=021yMPdarsacqdEo/8CW8u8ZNpKM/XY65JYdTMbED3E=;
        b=SYsqsXQnyxjI5FaI3H4Ei4p6f2DHpFTCq5uuHn5HoBMxAcHa1Ne/EGuJ1XCJ4+vd3N
         fAklUSYbVg35/Fu/BBAmwHljfq8ZmkfGsWafhadRsKAI49w+ZFhICHsu9wCQerJjjUel
         NgCWeZvGoqiSCULURemeyQWNxMu0j92CAf69y9Iz8IeLKyYySp8uDwgwY6Frj3CQmiic
         8B24sngWY5HHIDVOhRX9h+BbS7LlOjkP6WtSIYUsxsZIA9JJpGu1y8qMzqI2bV7jraSe
         XwVRLJCKdlV5jnzCXWJlK3vj6+cW/Oj69NG92cn6S2Ojtnk+sFmOK8aMnA04ACAuF17G
         +83w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710594797; x=1711199597;
        h=content-transfer-encoding:in-reply-to:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=021yMPdarsacqdEo/8CW8u8ZNpKM/XY65JYdTMbED3E=;
        b=dIVfr27WciF68SpvdjmxJblo4FnrXIhlii9HKUq+fm2rLcTbBaYtd6uQnXUGuvGgsQ
         rJqXok92ME7ANLIo8mhLafj7A0wYVp/jGwA9iDWIz165uyps9HERPzajEaeIRZk+e2He
         kHyGMh3bXBWp9TLFMnPz51bPWY9il6200vCAWE1L390Fqf8dT3QHXVioHZs564e8vlSd
         vYXmQAsEk58KRiSkLQ8wkvnlDigF4tPoQtIlfJQM/q8HAG6E95ShgooW6eD2GTcTSp3N
         XLxOhkTkxeJ0u7n7En0frlJqhi5/Kw3lbtH0+RGhzXyOM1AfHVO/KCR88ak3ryIMrHdK
         KTsQ==
X-Forwarded-Encrypted: i=1; AJvYcCUgChvB+HObbKXkZMadO1yPIjoHU7yqqssfH4SBA0VfwnKQ3tp2x95xFEj9cukuOlhByiWfiCEflrTzlI8Fx2Bgw9feM/xMdyjDjW8z
X-Gm-Message-State: AOJu0YxKFGT5tWRWAR7vs5OBwXChaoaG0XCRXUH8Z7YCjwOs8l0WNKMr
	i21uQ9DrM7sqBjE338MGjAga2CkPvkQXo5Y3KrV/aUtscz8vA8ePQEa81zU6Jtw=
X-Google-Smtp-Source: AGHT+IGEB06ioccjFGEijllB1TxsKceBi0Cg4zSrV2NbWYgWBhNn0T9hLjMGz7iRHDJPhTfSg7DauA==
X-Received: by 2002:a17:902:e810:b0:1dd:667f:bf1b with SMTP id u16-20020a170902e81000b001dd667fbf1bmr8749305plg.0.1710594797320;
        Sat, 16 Mar 2024 06:13:17 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id i17-20020a170902c95100b001dd59b54f9fsm77566pla.136.2024.03.16.06.13.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 Mar 2024 06:13:16 -0700 (PDT)
Message-ID: <dc93c896-19f9-4b6b-aabd-742cc8afae84@kernel.dk>
Date: Sat, 16 Mar 2024 07:13:15 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [io-uring?] KMSAN: uninit-value in io_sendrecv_fail
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
To: syzbot <syzbot+f8e9a371388aa62ecab4@syzkaller.appspotmail.com>,
 asml.silence@gmail.com, io-uring@vger.kernel.org,
 linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
References: <00000000000024b0820613ba8647@google.com>
 <b090c928-6c42-4735-9758-e8a137832607@kernel.dk>
In-Reply-To: <b090c928-6c42-4735-9758-e8a137832607@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

#syz test: git://git.kernel.dk/linux.git io_uring-6.9

-- 
Jens Axboe


