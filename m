Return-Path: <linux-kernel+bounces-85796-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1B5B86BAE1
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 23:45:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 42B6CB279CE
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 22:45:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA6EC72918;
	Wed, 28 Feb 2024 22:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ahRXfpxD"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77C6B72900
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 22:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709160311; cv=none; b=U8aqE3VT+n7UM95ifnabgKqYcK4xb7ugkl+BLsTDqkJkCLcQRYlxBHDFoakBoqULECUUOL3z6gowr0k7hvT6f3RxERxWAZyMIBDhHIQOhgegZYYidwDBh/KEKcHJ1vEGMprNEGwRNQRUOfDkyDvOQFkVZ7aExyANhdpWkUT5WRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709160311; c=relaxed/simple;
	bh=g7xQFQu3lLzNX4Vd9so5KMCqq2700AsVTNNzgICe2Nw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hPitzVggTp8v0U4ENkJQM9mfATqB9iz8UqiMMjJ7DiYt7wjVPa8ptIFz7W+QlL0duH3bjU80HwgJD5YdnmNhgRd0itcfrSxY24/ELdyDQm5zkVwhsUOyOLoIdebk/ub93JviLXN5vMNJRYfTwXquYQh+mQgRvPczKhBwt3Pn3oA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ahRXfpxD; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a34c5ca2537so53705866b.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 14:45:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709160306; x=1709765106; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d+Wb6NhI/vtCiU6t546gnwmXs9J3vtrwxtAXa2CAncw=;
        b=ahRXfpxD37Mog6Bs62vWDRtZsgkWmlQ50nobBOZEN7/TPYGqb/00qV0YLfPJR7FyQN
         wlvRbVKdiyQM0Atl3/3QDbu4njF6PGqVopo96XFd9JLSjlNHaz/eASjtdVMMU4wvvxJa
         KM1bRBZ2rJNNADncjMHerPmvDtlDOayNIlZ8A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709160306; x=1709765106;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d+Wb6NhI/vtCiU6t546gnwmXs9J3vtrwxtAXa2CAncw=;
        b=WdtTQcAupAbS+5Za+EjQAAezB5FmjVRSYKRDsK16dWvv3k7I2rpOtoKvJu4mZcFsXS
         lNlS0ZuycpFf2IfBIJyBQbF7sfltOBLcaLKJzMVtAqSSt2R4ApTRZf1ueAh/ine5CbgH
         JhI4TSAGYNdqSAOGBqp7rLlmakT6fz2pOJW7ezAIsEm0SttW1f1tTKSgAq7fR34pb254
         rHcOkyV6ya/EqoOhyOx1JKnZFAD69ObAdhC49c7B5CHEAFDG/8qM14W0jkQLwobgK0QQ
         kWPb5N9nIFFlwCNEvsTOADNweVdo6jwFxrGIK0/ol4b1EDQBB2TMQ0O1kK4yVRlqRHVj
         S+CA==
X-Forwarded-Encrypted: i=1; AJvYcCVGNWntwIyWg5T4IXFUk1VFYDmmGNt0etahVWvwjCO7J74T9bJ/SzaEiGoWkMdNMgMgZPVD1JN477vZu2OSknD09n47eOtSlHD14h3A
X-Gm-Message-State: AOJu0Yw4QDAutRgPHpK+qHj+xqhVzji4RFfafyVef4bZOa48FlN2QddI
	uCmRUKrJ3Co0sWG/ehO9poadQ3SgJmgHczHJcnFDT2NG4BU1LWrj27Q4wdGwjCyIkWXVUzLfg8/
	cZ/Tn
X-Google-Smtp-Source: AGHT+IG5qXcA5s0v1eefOWnNlMT0S2q75uivHS4SpEdnD7SXTpB47mpj4RqpX3ZEIbZtijz2VZNBcw==
X-Received: by 2002:a17:906:face:b0:a43:734e:db47 with SMTP id lu14-20020a170906face00b00a43734edb47mr187728ejb.20.1709160306707;
        Wed, 28 Feb 2024 14:45:06 -0800 (PST)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com. [209.85.208.52])
        by smtp.gmail.com with ESMTPSA id cu16-20020a170906ba9000b00a43aa6e3f4bsm2166946ejd.44.2024.02.28.14.45.06
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Feb 2024 14:45:06 -0800 (PST)
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5654ef0c61fso4871a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 14:45:06 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW5cB9kpm9AaBXGUhLqDO13HyPB5q+r0lYnwCQzQ1AlXC5dm3pE6img0M3I6Q6hb5y7QXWF2U+anBpzYcZY5lJFFTPRc3pSSpEZwAYR
X-Received: by 2002:a50:8aca:0:b0:561:a93:49af with SMTP id
 k10-20020a508aca000000b005610a9349afmr11944edk.7.1709160305919; Wed, 28 Feb
 2024 14:45:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240228072216.95130-1-yaoma@linux.alibaba.com> <20240228072216.95130-4-yaoma@linux.alibaba.com>
In-Reply-To: <20240228072216.95130-4-yaoma@linux.alibaba.com>
From: Doug Anderson <dianders@chromium.org>
Date: Wed, 28 Feb 2024 14:44:50 -0800
X-Gmail-Original-Message-ID: <CAD=FV=W7gOpLw2VwRO7EwwNoqSJFM8iC0-R1GC4RHtz4=fwa5A@mail.gmail.com>
Message-ID: <CAD=FV=W7gOpLw2VwRO7EwwNoqSJFM8iC0-R1GC4RHtz4=fwa5A@mail.gmail.com>
Subject: Re: [PATCHv11 3/4] genirq: Avoid summation loops for /proc/interrupts
To: Bitao Hu <yaoma@linux.alibaba.com>
Cc: tglx@linutronix.de, liusong@linux.alibaba.com, akpm@linux-foundation.org, 
	pmladek@suse.com, kernelfans@gmail.com, deller@gmx.de, npiggin@gmail.com, 
	tsbogend@alpha.franken.de, James.Bottomley@hansenpartnership.com, 
	jan.kiszka@siemens.com, linux-kernel@vger.kernel.org, 
	linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Feb 27, 2024 at 11:22=E2=80=AFPM Bitao Hu <yaoma@linux.alibaba.com>=
 wrote:
>
> show_interrupts() unconditionally accumulates the per CPU interrupt
> statistics to determine whether an interrupt was ever raised.
>
> This can be avoided for all interrupts which are not strictly per CPU
> and not of type NMI because those interrupts provide already an
> accumulated counter. The required logic is already implemented in
> kstat_irqs().
>
> Split the inner access logic out of kstat_irqs() and use it for
> kstat_irqs() and show_interrupts() to avoid the accumulation loop
> when possible.
>
> Originally-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Bitao Hu <yaoma@linux.alibaba.com>
> Reviewed-by: Liu Song <liusong@linux.alibaba.com>
> ---
>  kernel/irq/internals.h |  2 ++
>  kernel/irq/irqdesc.c   | 16 +++++++++++-----
>  kernel/irq/proc.c      |  6 ++----
>  3 files changed, 15 insertions(+), 9 deletions(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>

