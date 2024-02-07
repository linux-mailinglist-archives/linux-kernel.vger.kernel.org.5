Return-Path: <linux-kernel+bounces-56168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 903E584C6E9
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 10:09:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2C2D1C240CC
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 09:09:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 388D720B20;
	Wed,  7 Feb 2024 09:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="iuJEcJah"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09A8A208B9
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 09:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707296945; cv=none; b=Ah95jQJKyoHk80Ug5ijch/T2j+KrbNB6wWIUG2YZ3sKNZWUPn6Ba6zpvRM8LqlJ2Zf9wMMPjo28Z1It/IFc1EBLF7ZIzOQJWOuXnRueDwnH3ThXwikhN/UbPY4oi/FGKBIi6AHKUFN0Q/Y/ZLT+NL++MDQotjcDfDeyB01pnMz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707296945; c=relaxed/simple;
	bh=xyb6XSX2rw0cO0dtyv7Tbh7XPxohWY4se8HFD4IGFIU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gnj+X727msrIXsMzfqrS+da+uBFvkbg5W7WwoRASs293g7bpSSkIsw2dk9fAYCdrWrJnWfFL0187whzWvuQFaWdKTjhyUjYCSZ0yjcmqzAcWzPdFLuhItQ21dxBaokGqAu8AumAkBMXFqyMToGpvqgFiulxEJ1appTBAmXfUcj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=iuJEcJah; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1d98fc5ebceso2612185ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Feb 2024 01:09:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707296943; x=1707901743; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jODr6cxPYhr2AZCIthfN0oFS1GjHga/6A2oQsTBVDlI=;
        b=iuJEcJahA3BvGqzogWjxgZg1evb0QA2s7V7K6hu7UP0zV0PqNaMVpIGNRvRQoYndTd
         xwJlBuoBBGSvfMQ2wCIlrf7KkYTPSIjFtVgMkbUd1kjHAf4xET1eNn6vrS0G9kob4LuC
         EjaK+lHQ/raUhQaDahpuCEKhEEwdJQxxC8BH8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707296943; x=1707901743;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jODr6cxPYhr2AZCIthfN0oFS1GjHga/6A2oQsTBVDlI=;
        b=r7rDHJm+r7kLAxgzZ90ZqC8Sab041vKkxAMjgExEp8GA19Yw5VWxt3+4wOd4qVuSRd
         ZOyrppz2bqeF4LIOJUP0wI/0UGoEZWizWt9YUX41wHEmr0wPVcH2v1jQh0o8A8VCIZKz
         MxOnScIB4w1PYuhLKLWwFL5suWmmaFeET74fqxkMO41WbvF/hIZqQA0BkswaMsbL6XCj
         ydU0VN57zbEWaelkNb0Ju2g3dhRKKgUxeYim2pT4l2pOSxNIHmTJfZRx7b1bZiSM8zbE
         tbP7pXoxaOuELEqsfq9PH12TJMd0/TaVG1Zx+cVzY6+DADkRkfw2He8AJmb+H/COYoBb
         ASfw==
X-Gm-Message-State: AOJu0YzS6TaxDxRWggWlWhni2R08/qhWLdSqvdY2zImbqpcvycvkmElJ
	NTRMHYvEPgSRbbnyhPKqWxl4D1Ne6lAGRJhPB5KCU2uCKnwp9o7rOvur8lrqKw==
X-Google-Smtp-Source: AGHT+IHS2CFIdwOHhuBcp3CA1c4A6wHnklyZqC1U439w2hPuYbtkiza2h5WLqp/UlUMqrIJ16jGjqg==
X-Received: by 2002:a17:903:22c5:b0:1d9:5b75:4602 with SMTP id y5-20020a17090322c500b001d95b754602mr5345746plg.7.1707296943271;
        Wed, 07 Feb 2024 01:09:03 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXueprT99MxCl6fPyLLsM0pD2V1QJ/Jjq9t6icKQjmqSBE7nz6TP3tP08CmvX/zK9QmIKQGCOA7ZuFZnuOi5AYtn+sSP1X/S2xVWRcu3bQ++a463OLOm00pSM+RYLQRgOafePSydzSfvJms/Ad4xQ+FcSgllRc1+RU8V/Y5qRj6Jiw/dQ==
Received: from google.com ([2401:fa00:8f:203:aa4c:2868:935:7ac6])
        by smtp.gmail.com with ESMTPSA id jb6-20020a170903258600b001d8d04a4fa8sm918072plb.300.2024.02.07.01.09.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 01:09:02 -0800 (PST)
Date: Wed, 7 Feb 2024 18:08:59 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Minchan Kim <minchan@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [RFC][PATCH 0/2] zram: decouple comp stream and comp buffer
Message-ID: <20240207090859.GE489524@google.com>
References: <20240207065751.1908939-1-senozhatsky@chromium.org>
 <20240207084720.GD489524@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240207084720.GD489524@google.com>

On (24/02/07 17:47), Sergey Senozhatsky wrote:
> On (24/02/07 15:57), Sergey Senozhatsky wrote:
> > 	RFC
> > 
> > 	We keep compression work memory buffer per-comp stream (which
> > is per-CPU), but we don't need that many buffers, because on each
> > CPU only one compression backend can access work memory at any given
> > time. Hence the patch series moves compression work memory to a
> > dedicated per-CPU area, reducing the amount of memory we allocate
> > for those buffers.
> > 
> > For instance, assume a 12 CPUs system, 2 compression streams
> > per-CPU (a default and one for deferred recompression). Before
> > we'd allocate 12 * 2 * 2 pages, after we'll allocate 12 * 2 pages.
> > 
> > NOTE:
> > The series stops short of moving comp buffers to a global per-CPU
> > area, which all zram devices can share. Compression backends use
> > CPUs exclusively (disable migration and CPU hotplug), so in theory
> > comp work memory can be in global per-CPU data. This can reduce
> > memory usage on systems that init numerous zram devices.
> > E.g. instead of num-zram-devices * num-cpus buffers we'll allocate
> > only num-cpus buffers.
> 
> And this is the patch that moves comp buffers to global per-CPU
> area, so that *all* zram devices and *all* comp backends share
> them. It also moves local_lock (which disables migration/preemption
> and CPU-hotplug once taken) to global comp mem per-CPU buffer.

That's a squashed patch. I also have an incremental one, atop of 0002
in the series. So first move comp buffers to device per-CPU, then to
global per-CPU.

