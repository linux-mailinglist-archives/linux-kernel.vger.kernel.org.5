Return-Path: <linux-kernel+bounces-48560-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B02AD845DE0
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 17:57:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFFDE1C25CC7
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 16:57:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 769111AABD;
	Thu,  1 Feb 2024 16:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="CN+THqdt"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BC4053AB
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 16:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706806618; cv=none; b=YeQOCkE5LfGM33Xur37DPFKGnl+S3Eq5SdWA/txjMmxa1VZpcQ/sipZMa+TSe79lQYE/1XT5Nts232eJTB9x0Aw8hrDHcgFRTvr42S+CS7Rrbaun9CBH4wDvK53gedv3BWRI+kCPPStbJVSN3n65KNHF6KqDG3+II7eNn+W9LUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706806618; c=relaxed/simple;
	bh=1TyGcUJteUe3Ay1dqqyUUF9jwFYj9b1XBMtLo4KWxoY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KSCrYJBgvEMkbz7kvp5IQ6TvjFUa52LyXh49m7K2e73RqG3qkXq5NN1w0fhvBX8szuF1Kd3OdCJ920yBeCX3L5zD4XcuRhok50MgeDiCjbcP1vuqmHTnZtZ1vtIHoNQxqqYEjutU0b01YA7tgNu4bqKL7ycHorpiMJPbjwt/ueM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=CN+THqdt; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-55f0367b15fso1545825a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Feb 2024 08:56:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1706806613; x=1707411413; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=r2zWO0smLAGmtvPb3ivEDnsJI2xQS1BwMneE9ALhqNA=;
        b=CN+THqdtgGdQOfM5E/5wk1o81nBvU8QwEvjH46WTrXjDN5IYOanck3YQecAdYzUyOJ
         hwdgf+2D416R58Oz5I48DUi9WXN08g44cYvbs1N5OncKJecozqki5JEUWgwGP1ZSnzGD
         /+mS2z5T/euPt9USxloBjpG7m/e3twwPhdhbQ7PqSKMjbBFn5K1/l00i3WRU3z6jMkuj
         K1PORfGo4RDOurfuiOqsW20jM/Y8LZ1LVHdiGHjHllDYkC70b86Owxgqo0Amd9pQbLuW
         76zYyQjg3y6tgTqY8DjpcC4fspCRC9E7xO8NUVOMOs4znHaTaFd683AIUiVrbWZA2ahZ
         /How==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706806613; x=1707411413;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r2zWO0smLAGmtvPb3ivEDnsJI2xQS1BwMneE9ALhqNA=;
        b=iSmc8YKb846KF1/3nkzi/UFhLh0+c/gWBO50IYuTO2y12msWFzDZzLGgnAh5LilQMv
         iEnFew7nT74zvjWzeKrGAX8gMaqJyLchRniuM4wxr1RebSPYAc0uJYbvW2T5eFYvJGFo
         2ZsLdQTGf7qeMcg0xHb1pafWFkWz4HzQkxPi2dYS5tIJ4h2tXBVZnfgN2mrrSj8jQKmR
         QZeSK52kf0CgD9s/w5Ce2ODfdJZEU2swL8WvGwIIzOD1MTNO9l4a1HwxvcbaXMRzioN9
         Fw0Q4pAgkhHOE/Q/QoiiZ6ec/u+iMEjo7qFvb378TLwezUNFNJ8p+0UX+xLIbkMl0aa+
         wikg==
X-Gm-Message-State: AOJu0YxPz5Rnq7iPxO3dKl2I9Kcgdnm3Mgd1oKA+ZgUZzrO/T0IC1QRV
	uvH244/UoAPYzPS1fNWxKCmgLaZCk6tdd0+AQoPurnKdObnZdSVK5HbXww+zEGU=
X-Google-Smtp-Source: AGHT+IFP9OOGaeXQkhAJVgUdAod4AclPuX+eiGYFpsJIL6p1CvCS3OpFzOMaQ7flfZO9FaI/0RZrDg==
X-Received: by 2002:aa7:c353:0:b0:55f:41b8:7a2d with SMTP id j19-20020aa7c353000000b0055f41b87a2dmr3639683edr.32.1706806613356;
        Thu, 01 Feb 2024 08:56:53 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWRyF/K4rE+1A+WEDZO9x9IqgaiXJHFX12WjuDps+gjNm6/LZVl2OGcWxVmQDZQxmdzDeyO1t+OPR6Ux0sTjbB0oQiCDRv3ikQfSWPwn3/3hV38bU/2qAQANfz5dkg/TkWLfWOJoTM1hF4VhTiUDSo7RpJz7UY=
Received: from alley ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id i26-20020aa7c9da000000b005581573e251sm6980810edt.2.2024.02.01.08.56.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 08:56:53 -0800 (PST)
Date: Thu, 1 Feb 2024 17:56:51 +0100
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk v3 10/14] printk: ringbuffer: Skip non-finalized
 records in panic
Message-ID: <ZbvNUz326uZg6ogt@alley>
References: <20231214214201.499426-1-john.ogness@linutronix.de>
 <20231214214201.499426-11-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231214214201.499426-11-john.ogness@linutronix.de>

On Thu 2023-12-14 22:47:57, John Ogness wrote:
> Normally a reader will stop once reaching a non-finalized
> record. However, when a panic happens, writers from other CPUs
> (or an interrupted context on the panic CPU) may have been
> writing a record and were unable to finalize it. The panic CPU
> will reserve/commit/finalize its panic records, but these will
> be located after the non-finalized records. This results in
> panic() not flushing the panic messages.
> 
> Extend _prb_read_valid() to skip over non-finalized records if
> on the panic CPU.
> 
> Fixes: 896fbe20b4e2 ("printk: use the lockless ringbuffer")
> Signed-off-by: John Ogness <john.ogness@linutronix.de>

Makes sense.

The most interesting information from other CPUs are backtraces. But
they should be finalized before reaching panic().
trigger_all_cpu_backtrace() waits until all CPUs print the backtrace.

In fact, it might be even useful because other CPUs might just spam
the ring buffer with mess caused by the panic() situation.
Messages which caused the panic() situation should be in the ring
buffer before panic() gets called.

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr

