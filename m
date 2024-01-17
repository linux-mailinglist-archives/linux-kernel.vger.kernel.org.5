Return-Path: <linux-kernel+bounces-29255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EC14E830BAF
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 18:07:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 608331F223E2
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 17:07:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2BBF225CF;
	Wed, 17 Jan 2024 17:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="sv22wVEc"
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76759225A8
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 17:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705511272; cv=none; b=tukgy5HMdX9AZ3S8LDTWL65lzHCqZCUtXbiWI81c/7RRjlXJnlIcfi5iqokSCj+VcKe9jk2ZfNKKnM8wUZLFBE7e8SMefXJAvbb/c4Z+bjrf0hsWrnWQOWo00t7ftHqs4+bjk2NWKO6nSprzm8UeDn0FjXEPhYysMRkCiC+1JFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705511272; c=relaxed/simple;
	bh=j4MagUT939h34aJBkbZdvETtPZRr7k3PVF5IEDPhqM4=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:Date:
	 From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=qMAmJzDUjcAFKDApp6I82ipUctwn+6wvqX83YC39t34GR4qcJ50sJRe1Wv+zuU3mzI84Y6LEzodkfsnrwxC9zUkizhpbrr3i38tbj6xTKFdlOIjQq/p3ctAKwKr4KJqE5k255asIX5BaW8Lpg97X2qYjreFCdGDrGQJJc1lwNI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=sv22wVEc; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-680a13af19bso68123356d6.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 09:07:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1705511268; x=1706116068; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zWOiEU+kR/KCpSSXoCm9gZI4gFvMUBHX2MKPUoiQ5Zo=;
        b=sv22wVEc7cPLEpCZcyVLBM5NeXJqZHXi/jIxx9VRVwwJCWMj4Tso6ueb3v08G61Nnj
         hnO3ECqzNpxd2Qp8B572EKWIpZfBEo98VQlo7dmG2FmlFL+ROvYGZF62x48c38rYqJPe
         VUn/E02SRb3MESyCaoeUq4cRqQdhomIX51VesKs2bhrEssRvUGcpKB4+U8oBdl850iC1
         R9nI+UgURpPsWablNqkDXsV6RQThWA8u8+bk6qH582gKzS9YPR/GqJr0QD5TNjv5YlIR
         V11cYuOlsIY4T+L+tOQNdJN46PiQqcNexvLeo7AWC2kxp5YUVFujgs2aO7fddEH8zJBo
         saAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705511268; x=1706116068;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zWOiEU+kR/KCpSSXoCm9gZI4gFvMUBHX2MKPUoiQ5Zo=;
        b=GWUz7T9PjPsvtDG4llpZy8fB7WJynKfdFVMHRovmM4lfqy+8yJokCwnyk0BIcGfZS2
         Y6al5OIuQapXgFnNX1KOZQCPAmneud+NXswKq04imNIh0+28HEiieNFwGXzqY5lIp2EE
         ZdpTfs1WvMw3NPAy4zK4A7hnXar7t4MAvxsPglPiRWeBfMegpRfITz/NWnCYJfFqPf9v
         zpFqT6caHpj2HlmwXIpSjhFWFyThQ0sjIcbBGT1ucKoTD4C68oyGryC6Yr0z0EqCiEMb
         1VDCZ2SHwGNFsInmV49U1KfgzVxfzIqUCRtaIyuWrxqficzzgbxuafVw8aEuP0iCBK9o
         jr7w==
X-Gm-Message-State: AOJu0YxfFw3UMYSftsSmu00Aa/tE3o9ihjrUDQ7tMb5R2WmK3FMYabJy
	y/dsxsOk9z/hOtTYNkVl2QpEvp/AJaPW6w==
X-Google-Smtp-Source: AGHT+IGKmLAGAr22Rl8M9CD8UH3WoTASOM5aKzmuta9xYSt6dGDDsHb2a69hjQdNAE52hYQ/jlJC3w==
X-Received: by 2002:a0c:dd93:0:b0:681:795c:b5b0 with SMTP id v19-20020a0cdd93000000b00681795cb5b0mr1437318qvk.105.1705511268093;
        Wed, 17 Jan 2024 09:07:48 -0800 (PST)
Received: from localhost ([2620:10d:c091:400::5:479b])
        by smtp.gmail.com with ESMTPSA id qd11-20020ad4480b000000b0067f99a564bfsm5196754qvb.91.2024.01.17.09.07.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jan 2024 09:07:47 -0800 (PST)
Date: Wed, 17 Jan 2024 12:07:43 -0500
From: Johannes Weiner <hannes@cmpxchg.org>
To: Yi Tao <escape@linux.alibaba.com>
Cc: surenb@google.com, peterz@infradead.org, linux-kernel@vger.kernel.org,
	Miles Chen <miles.chen@mediatek.com>
Subject: Re: [PATCH] sched/psi: Fix the bug where the last character is
 overwritten
Message-ID: <20240117170743.GD939255@cmpxchg.org>
References: <a33440f33d42aab66ad4120303ecbe8dca401d5c.1705490349.git.escape@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a33440f33d42aab66ad4120303ecbe8dca401d5c.1705490349.git.escape@linux.alibaba.com>

On Wed, Jan 17, 2024 at 07:26:01PM +0800, Yi Tao wrote:
> The buffer buf in psi_write has only 32 bytes, and to ensure the correct
> parsing of the string, it needs to be terminated with '\0', which means
> users can input no more than 31 characters. When the user inputs fewer
> than 31 characters, buf_size equals nbytes, which causes the last
> character entered by the user to be overwritten by '\0', affecting the
> parsing results.
> 
> Here is a specific example.
> 
> $echo -n "some 500000 1000000" > /proc/pressure/cpu
> $bash: echo: write error: Invalid argument
> 
> Because the last character is overwritten, the value obtained by sscanf
> parsing is 500000 and 100000; window_us is missing a zero, hence the
> return of -EINVAL.
> 
> The reason 'echo' without the '-n' flag can be parsed correctly is
> because the last character that gets overwritten is '\n', so it won't
> return an error.

Good catch. There is actually a history of this code changing back and
forth. However, it's always assumed the last byte to be \n and cut
that off. The original version was this:

char buf[32];
buf_size = min(nbytes, (sizeof(buf) - 1) /* 31 */);
if (copy_from_user(buf, user_buf, buf_size))
        return -EFAULT;
buf[buf_size - 1 /* 30 */] = '\0';

Which expected \n and actually cut off the last copied character. So
without a newline, the window would have been truncated then already.

It also didn't use the full buffer, which Miles fixed in 4adcdcea717c
("sched/psi: Correct overly pessimistic size calculation"):

char buf[32];
buf_size = min(nbytes, (sizeof(buf)) /* 32 */);
if (copy_from_user(buf, user_buf, buf_size))
        return -EFAULT;
buf[buf_size - 1 /* 31 */] = '\0';

but it still cut off that last character, which is either newline or,
welp, the last character of the window spec. Bad, bad.

It also copies the last input byte just to overwrite it again, which
is a bit odd.

> Limiting buf_size to no more than 31 and writing '\0' at the position of
> buf_size can fix this bug.
> 
> Signed-off-by: Yi Tao <escape@linux.alibaba.com>
> ---
>  kernel/sched/psi.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
> index 7b4aa5809c0f..5ae336e1c2d8 100644
> --- a/kernel/sched/psi.c
> +++ b/kernel/sched/psi.c
> @@ -1523,11 +1523,11 @@ static ssize_t psi_write(struct file *file, const char __user *user_buf,
>  	if (!nbytes)
>  		return -EINVAL;
>  
> -	buf_size = min(nbytes, sizeof(buf));
> +	buf_size = min(nbytes, sizeof(buf) - 1);
>  	if (copy_from_user(buf, user_buf, buf_size))
>  		return -EFAULT;
>  
> -	buf[buf_size - 1] = '\0';
> +	buf[buf_size] = '\0';

This looks right. It'll leave a newline in the buffer if present, but
the sscanf() that follows is happy to ignore that.

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

I'm thinking we should also CC stable. A truncated window is pretty
difficult to debug, and may not even result in the (ominous) -EINVAL
if the resulting value is still a valid size. It'll quietly poll for
very different parameters than requested.

Cc: stable@vger.kernel.org

