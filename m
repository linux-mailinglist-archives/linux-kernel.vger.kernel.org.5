Return-Path: <linux-kernel+bounces-54663-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CAD984B22F
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 11:13:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6FCD21C23D24
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 10:13:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7E1712EBE3;
	Tue,  6 Feb 2024 10:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="N+4pxnhs"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EB2B12EBCE
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 10:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707214384; cv=none; b=jNGsfteYtXhDS1ID3pvFK83OFOBQbf//QJwPD1R0p8el2bukkyKHNWXlOvo25Zt6CGp2oPkr314SNF2HhumMsa8L+sHQ8YC47NzGmgEmOwWO4Y7dndzzGrbGTB5De7HvKJ26NiLTfF44JDeVdH5BU4bn8oD41TCdqOgmdMZ4Fr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707214384; c=relaxed/simple;
	bh=v4XVMsXqCjDb4FoYvAxW909zIoiT+8uQw/E9lIX5SpI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lJh7QubKxLGAYbXLN6Yp8lQ7s9E9GwppVvez4J2ZwIzFTrnqNQU0LPnIYsY+aXH0btRb8KwWsA0X160uxI8fqYIkwjtsIpOtr8LbPtKAHdsvpytpnDYw9H1D293N08WjyLizzVCaXiQ8G2Q124sevg1F2ljYDAOlN4elzI0WXQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=N+4pxnhs; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a30f7c9574eso721836866b.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Feb 2024 02:13:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1707214380; x=1707819180; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rIfhGveLVdv928TlKPqq3OWj/gTbC/K8X3iijI8040k=;
        b=N+4pxnhsWKrQX1waQoGYgs2XFBroVjxXLg/uvgoN/9F5N+Q/hXJcSpckAxziQxv2pm
         ds5JEW2PfMrTTMIc8pRhg7afwGfJfRCDsZ+lZm4hjWUQyWuLOTA/JBkqHUmEUqx86AnJ
         jmlmR+MGnkooEvdDEw+jQ4hROJF4UZTOYAW2+wzebIv1phbOCyWtxjoeQQ/M5gjq5pYG
         /2dD5TLMEBtYM7ZSsy9dHQWKU29cDgjGcDudAz35hyoRkuZ/gsNnZysODX0dpngTMMK1
         atcmyMUxWx+Azq1HaWoiPt4JMngTBWDq2wRjaDb2XrnXZ4Q9puQFivE5YqmbfcU/ddDH
         XgWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707214380; x=1707819180;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rIfhGveLVdv928TlKPqq3OWj/gTbC/K8X3iijI8040k=;
        b=OIacs4nWeQhpOH0KacM5p3N4MvnmkdkYPj9FgbQlB+nyjua10tk641NfFgBBsxbdRh
         1dv5g2pRZQGanKCAO4xqFcMao77kGT8l8H9IrL3Flgjq1jP7QkFLFiJS00I5t7JAKqJ6
         i7PS+ytckr3kSqzY8BdI4sAmSsQgS3wBab1ylCPo7iAUZUX9Gat+4sADEGm6F6fBCDt2
         +8+vij64FO7QbiVk39X0PgSHv417jXU2wi0Y8hLJ8LSzbGMjLUT6jUIDpB29m6X0/s9j
         gSMRqXatsAYmoyEtpu66hbeqSdAw9LVlhJQxpRPDokzIk6xnSC+OTfE9pyUOejSaOj7k
         9E7w==
X-Forwarded-Encrypted: i=1; AJvYcCVP74rMnkksvIlrM3cXBg+PN3reNmlfa0dU87ii1/fF90sVB2tAzAqSQkdqbA64vBn/5U0ELBpKzafxUh1TZKzC0pRGQyOgJH+RE+3C
X-Gm-Message-State: AOJu0Yy0Ni3sCEn/XmxG1/2P1p0raPtUAN2C0FMTiYyKvCD1FYhq1Vdc
	LGTf01OYRuUat2v0YtaNT+XhX6A4CLRkaAHVwSWCU55dX3qBGzYo1L/BEQcrlK8=
X-Google-Smtp-Source: AGHT+IGHiczDYT0Fj3srrsFORzXQif6ghHUW7eFeyAMs4WpqfygdfzWKB4GaNfaWpBQKbMRq+dqelg==
X-Received: by 2002:a17:906:74b:b0:a36:569a:1bd8 with SMTP id z11-20020a170906074b00b00a36569a1bd8mr1431283ejb.28.1707214379843;
        Tue, 06 Feb 2024 02:12:59 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCX75Jh68E1OukAAD//0AvSGpnbb7nG9pOLBb1WgUQqZkztpu2sL0ZYc9UnVyYwOptTAvXTzClFdV6N/jWGqJcDkTJFvgtYe1Rfx7EC2RiZaBY9mJ542u+s6EWYQxWShhpm3atQmjsyT4Bx+lJ4U7E4UgVAkrg8yQsFufHLgQzdyKecTn6eojXQ0YIhSo4gWjAThIWJJ7K4inTLleMoFLsu6ftx/msKGz6Ie4BhmOjB9FBw=
Received: from alley ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id e23-20020a17090681d700b00a3717f96e6esm977330ejx.171.2024.02.06.02.12.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 02:12:59 -0800 (PST)
Date: Tue, 6 Feb 2024 11:12:57 +0100
From: Petr Mladek <pmladek@suse.com>
To: Douglas Anderson <dianders@chromium.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Li Zhe <lizhe.67@bytedance.com>, Pingfan Liu <kernelfans@gmail.com>,
	John Ogness <john.ogness@linutronix.de>,
	Lecopzer Chen <lecopzer.chen@mediatek.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] watchdog: Better handling of concurrent lockups
Message-ID: <ZcIGKU8sxti38Kok@alley>
References: <20231220211640.2023645-1-dianders@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231220211640.2023645-1-dianders@chromium.org>

Hi,

On Wed 2023-12-20 13:15:33, Douglas Anderson wrote:
> 
> When we get multiple lockups at roughly the same time, the output in
> the kernel logs can be very confusing since the reports about the
> lockups end up interleaved in the logs. There is some code in the
> kernel to try to handle this but it wasn't that complete.
> 
> Li Zhe recently made this a bit better for softlockups (specifically
> for the case where `kernel.softlockup_all_cpu_backtrace` is not set)
> in commit 9d02330abd3e ("softlockup: serialized softlockup's log"),
> but that only handled softlockup reports. Hardlockup reports still had
> similar issues.
> 
> This series also has a small fix to avoid dumping all stacks a second
> time in the case of a panic. This is a bit unrelated to the
> interleaving fixes but it does also improve the clarity of lockup
> reports.

Just for record. This patchset has finally got on top of my queue
(after Christmas and a sick leave). And it looks good from my POV.

I was slightly afraid to use printk_cpu_sync_get_irqsave() on more
locations. It has to be used with care to avoid deadlock.

But the patchset looks good. It takes the lock only around code
proceed on the same CPU. And it always releases the lock before
triggering backtrace on another CPU.


Idea:

I have just got an idea how to make printk_cpu_sync_get_irqsave()
less error prone for deadlock on the panic() CPU. The idea is
to ignore the lock or give up locking after a timeout on
the panic CPU.

AFAIK, the lock is currently used only to serialize related
printk() calls. The only risk is that some messages might be
interleaved when it is ignored.

I am not sure if this is a good idea though. It might create
another risk when the lock gets used to serialize more
things in the future and a race might create a real problem.

Best Regards,
Petr

