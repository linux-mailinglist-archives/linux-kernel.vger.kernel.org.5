Return-Path: <linux-kernel+bounces-56744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ACB0684CE7D
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 17:00:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62ACD284FA1
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 16:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B58C180048;
	Wed,  7 Feb 2024 16:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="JG3zpjcX"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92E8F1804F
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 16:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707321621; cv=none; b=ObVQNWtH31r1HMx5/gXKJ4kiTaiLlP3dP6HvxD//GyBo2DT7Et5HxeZ9r4UdZXvbpusJO+LpzZWRZQaiEPBBFHS2qB7+HUYouQzrmmI0I2g+7WAC4C31IvFa3jQgkV2+ldKDsEWikiCtrOhReFU2ZNx0DjdR2ujwfc9r5FGzyPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707321621; c=relaxed/simple;
	bh=InwlxTrlZjyLSH46Ca9UqbpzKCW5oxFKMnOGZNGH1ZY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JpFwXxG2GNvYWSOysvTlGKEoKrQO+ekIo4VxXgFd4uHE5snHFXEDgHSN3EnZzb2TPEv7+uDvcOZzc4BzTPvur3GqzPMh7pbOEDy/iQ+/6oBZxi3cg68uFWn6d2ekfzG21x551jJNkg6phVdMmA+znL7GGcFIpYFxBgpDpZmwF84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=JG3zpjcX; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a38271c0bd5so109164466b.0
        for <linux-kernel@vger.kernel.org>; Wed, 07 Feb 2024 08:00:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1707321615; x=1707926415; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KYG6ZbtFTOpJk8RRLSAYKyNIlDFQAo+kMqCBzS8fehs=;
        b=JG3zpjcXZgt4pUlx8LX34rgRA5bS6ZlwTB1XLtzJwLx4iAd9SskL7KfjEFcu8hEUR7
         Gro4Gj0V6hG7YvCZGJwl4b3KB4J5n+0DqWgGs0+XhuhGFUa2uWesuLMD0rlGgq98Bg6P
         lW4TNbVp0NJ65urQJSXGUobKZbTxUCB5A5AblLNvTMdFL2m1KAVivVCkJnjBxvDeTS9g
         OJRyhDiY6Z5/fWFd61Ri2x06cXN6O9BA+uVypsFkm3MVoY5D/tluimm9FMTd2RnIGfp5
         1iIPfvwkhvgj4UeBYnZ2z9fUsIw2L4JlEqEMfoenVlyqtT1V+DoeIDYxC3ujqFaz6YLf
         BjcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707321615; x=1707926415;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KYG6ZbtFTOpJk8RRLSAYKyNIlDFQAo+kMqCBzS8fehs=;
        b=tv/8xnKp30ZoI7yLvLATViNmp1HS0qXE4jbC9FNWYvER5nZmPUiLVjs/lmRJbVDEj3
         30i1PPhG+1PkvVV2UUJ940PbKOz66xDWBKvZO99as0R6O0Jn9G/ekVItQEHf9hphIFTt
         VfqfvFnjS9PMArTMi2s1VjMKXPQ1faXCaM/+dW3OMqOTLOB5kvoLgdlCl/4P5virdxoA
         ao/EEMEoM4gey8dMiRpcgRXi/GRaazqQgfAvJGuvBj0H88cZLZR9eeO4oF9r0/1vzyCh
         TW7oTrPX6VTRjhcfI4WcJBaXs8F/9WwR9RPOQxwuOvCp5D8N0E2OX4r5DqFRFNKF4U7k
         RR1Q==
X-Gm-Message-State: AOJu0YwjBwG39CNOlPAFlbBQqmrciXmohiFxpmWhOx/u5Vo/G9I5KlsP
	D9eyCBsDO8FpcRIUDAZFulYfe5qDCRUEHH5yqZZ/XGVCga23jHB63bcO84RImUU=
X-Google-Smtp-Source: AGHT+IF7bzdLGQYvYPu1tnsiObM7K4gB7e04x/G5AsiDlzGGQZvBLR7t9M3WRsh+eANjW3ojwOU2fQ==
X-Received: by 2002:a17:906:6b8a:b0:a38:5ce0:2f86 with SMTP id l10-20020a1709066b8a00b00a385ce02f86mr2434600ejr.40.1707321614725;
        Wed, 07 Feb 2024 08:00:14 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV9hlIl1FfjsCXvRGzUtMlJJaUbmEzhoY6vsXyzvNCgFdfYPr9owKbEJH8MdtO6K8QYRWEDOmrwr2m89/N/z3EVG6FnxncvuzGJHwZpG8VuGPjJEG2NKB2V63jex4cE1bKzAMtDq20yoDo6fK3xBEZOnd8V/Ovn6mEei+VRFea1ftggisZg5zAmsGsvdGw=
Received: from alley ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id ty13-20020a170907c70d00b00a338fedb9ebsm905100ejc.54.2024.02.07.08.00.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 08:00:14 -0800 (PST)
Date: Wed, 7 Feb 2024 17:00:12 +0100
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
	Mukesh Ojha <quic_mojha@quicinc.com>
Subject: Re: [PATCH printk v4 04/14] printk: ringbuffer: Do not skip
 non-finalized records with prb_next_seq()
Message-ID: <ZcOpDM3qqinug_Wt@alley>
References: <20240207134103.1357162-1-john.ogness@linutronix.de>
 <20240207134103.1357162-5-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240207134103.1357162-5-john.ogness@linutronix.de>

On Wed 2024-02-07 14:46:53, John Ogness wrote:
> Commit f244b4dc53e5 ("printk: ringbuffer: Improve
> prb_next_seq() performance") introduced an optimization for
> prb_next_seq() by using best-effort to track recently finalized
> records. However, the order of finalization does not
> necessarily match the order of the records. The optimization
> changed prb_next_seq() to return inconsistent results, possibly
> yielding sequence numbers that are not available to readers
> because they are preceded by non-finalized records or they are
> not yet visible to the reader CPU.
> 
> Rather than simply best-effort tracking recently finalized
> records, force the committing writer to read records and
> increment the last "contiguous block" of finalized records. In
> order to do this, the sequence number instead of ID must be
> stored because ID's cannot be directly compared.
> 
> A new memory barrier pair is introduced to guarantee that a
> reader can always read the records up until the sequence number
> returned by prb_next_seq() (unless the records have since
> been overwritten in the ringbuffer).
> 
> This restores the original functionality of prb_next_seq()
> while also keeping the optimization.
> 
> For 32bit systems, only the lower 32 bits of the sequence
> number are stored. When reading the value, it is expanded to
> the full 64bit sequence number using the 32bit seq macros,
> which fold in the value returned by prb_first_seq().
> 
> Fixes: f244b4dc53e5 ("printk: ringbuffer: Improve prb_next_seq() performance")
> Signed-off-by: John Ogness <john.ogness@linutronix.de>

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr

