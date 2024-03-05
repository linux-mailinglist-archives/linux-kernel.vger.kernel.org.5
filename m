Return-Path: <linux-kernel+bounces-92479-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E20BA8720FF
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 14:59:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 997321F2643A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 13:59:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D1788664B;
	Tue,  5 Mar 2024 13:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="BZLlVgOp"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00B41762DF
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 13:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709647145; cv=none; b=pLzHCjRmZE1JHfF1mQcfFSAYQxpeYg88JMsC7/ruqY8TNKUyyMo46o7AS79j3VHnu4VQ7Fwv9Qq4/5z2r4akCQo6bfDTe958NJW0/F2TSA3LZlf4o3CHhtTq7Tto7zTJy8HiYW1LyxdW6WnVnlP6kj39PPZCFu6KcuoVKSXvMZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709647145; c=relaxed/simple;
	bh=JRNihLQrU/+iEtpGvlfMV+4iDbB/4i030568B2Dcgm4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ECIO7e/GJpcsnC3aDg3QOer1vrH3aIHYA7hKyKIY3kaF1RXgZCYAhzZqsnpb+z/ij3DmZMjsUMiYykG0lkaEj77AYYOuEhBaOY4qv2sCi1Poy4otsjAnMZbWmtyL0NlCNM50rR+qgE65oxo1g3tHxc2+AaptklycUOiOtTxJhIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=BZLlVgOp; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1dcfe6e26c9so9159715ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2024 05:59:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1709647142; x=1710251942; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QU7i/GFGA3BeZcXyAk0JvlJF5wgpx4zGSLUMIo15nLE=;
        b=BZLlVgOpgg4M7yHZ/bAmieWGKzNEYJ/XR5FsYfsjqGCb4TPf1/oGKmJ/pYtSrZV9wi
         HbAxVkW5KNWUNrkFxwoRNSrHL5wOvgwBC1ubTKJfIasd6QyB/pqqEk6tCStaQ7d2gXnq
         ZvPVQd6IGvuA7u2OYLPd1PwpFjVbehh3Y364juyyfeyLtcYtWCP935s2qW/FM4xhFUnF
         tVL4IFJeT1+5Lp4v1vnWPb0aMYqnxpU/gRd6tXUX9UCAk/LvBQwG/Xp1uxOVp1nhk4Vt
         ayKYjLF6VYfnePUZsi2HrcP9cc5f1E4jSgP2tJcyl/n0K/0DLkRiNYcZy4oixwreVIiC
         ekpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709647142; x=1710251942;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QU7i/GFGA3BeZcXyAk0JvlJF5wgpx4zGSLUMIo15nLE=;
        b=L85Hw3HTjo9RMt39bPHELirn6Y8/bUR77VLXA3nFjWtw/OhKaoHZ6Z3o233EhS0Gcq
         FBzIkAvWX+dpTSycslskGvw8hjEsTS5nyjlREBNwtdF8+v+yvBIb48B9LNKHSnWXzPU3
         TuARu3vLyIm5Ie+18atVBIIgwlFTWp8npd+KYN0Jtvu1+BxkDNVaxJt7KJ8glBfCiNeN
         WYGG48I/ASd5gHee7igj6ZM6l5Q1F1RXiYJFl2FBS2dRSj5glH508pUAYGVzEtggqvx+
         k0DzEtvXDHSrM+tjxCczWApk2HSCRn1hVhaTWnyQUU1H/1iSoxjM7pLs68zngo6ZvIHN
         eoRA==
X-Forwarded-Encrypted: i=1; AJvYcCW46JtIwCUVbaRb2d72G+lKUfaw44S/+7OXbj4P2O4Y/eOG6G/tULsXofkRAd2y9K5pXaHRj9EAfVWC8ib+FwL5ffrm4DDi7z1dxxZg
X-Gm-Message-State: AOJu0YxbuKkEsLcTlyrsvoC7o34tUgC4rf7yL8T+riG8tI+URKB9QjT8
	O1qTEjSlCGku4flZjvcsakUvzG4qMWo2IUzS0CUwt3KXs4NDYqFtHaT7Z1d2YUE=
X-Google-Smtp-Source: AGHT+IF+Cyeo2mWoylUN+f5sX3aHqZjl0czKC66QZp6hGbPe4oQB/7UWKaqNwH8HfMckY+LPhaXuhw==
X-Received: by 2002:a17:903:41cf:b0:1db:ce31:96b1 with SMTP id u15-20020a17090341cf00b001dbce3196b1mr478555ple.6.1709647142261;
        Tue, 05 Mar 2024 05:59:02 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id ld4-20020a170902fac400b001db5b39635dsm10625132plb.277.2024.03.05.05.59.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Mar 2024 05:59:01 -0800 (PST)
Message-ID: <dc4933d0-f865-4da6-90b1-320daf2e4294@kernel.dk>
Date: Tue, 5 Mar 2024 06:58:59 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] coredump: get machine check errors early rather than
 during iov_iter
Content-Language: en-US
To: Tong Tiangen <tongtiangen@huawei.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 David Howells <dhowells@redhat.com>, Al Viro <viro@kernel.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 wangkefeng.wang@huawei.com, Guohanjun <guohanjun@huawei.com>
References: <20240305133336.3804360-1-tongtiangen@huawei.com>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20240305133336.3804360-1-tongtiangen@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/5/24 6:33 AM, Tong Tiangen wrote:
> The commit f1982740f5e7 ("iov_iter: Convert iterate*() to inline funcs")
> leads to deadloop in generic_perform_write()[1], due to return value of
> copy_page_from_iter_atomic() changed from non-zero value to zero.
> 
> The code logic of the I/O performance-critical path of the iov_iter is
> mixed with machine check[2], actually, there's no need to complicate it,
> a more appropriate method is to get the error as early as possible in
> the coredump process instead of during the I/O process. In addition,
> the iov_iter performance-critical path can have clean logic.

Looks good to me, and I'm a big fan of getting rid of the copy_mc bits
on the generic iov iterator side:

Reviewed-by: Jens Axboe <axboe@kernel.dk>

-- 
Jens Axboe


