Return-Path: <linux-kernel+bounces-29416-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0615830DF9
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 21:30:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 126681C20EDD
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 20:30:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53E1324B3C;
	Wed, 17 Jan 2024 20:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PIPhefsK"
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4613724B2A
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 20:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705523392; cv=none; b=nBjdOvDIOJWbjz62rWASGHQC7M47E0GywPF/6k8bKbTdOH0ktR3f0DxTggeg+Wb1upxy77QaA2MieKKlEmfw1nMqZo2O2K29hM+yI0IA2gUvMg/F6vLUf2U68eM4yMmAL+06DLAyHnZwvhHOLiRs65kihrUcWdcAVdHhxUEpDAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705523392; c=relaxed/simple;
	bh=DvwjtH/oOZoE4Lq3KXQ0ZuGRWhuNqbTn1Q0x1w0hLN0=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:Date:
	 From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To; b=gmjdtcAAQLATdAeYZAgG+s8ZMt/ao6spLNz7rSt+MorKICI6Ffwt17WlvTJHoB8oaNkinEL1PB83fWnMTMxo+mvd0tUYO39gGaTCzFTbvRI2GdYFDo7x3qaIkYanRlp0SWFMMMWZY3fY8k6bQa9hM/UPlUUkncYqFfwCI/gVCKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=PIPhefsK; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-3608bd50cbeso48286545ab.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 12:29:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1705523390; x=1706128190; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RIlPx5Fv1DAFpxKYm/WA9Edd1lJzoBYsIqyytrhrcqw=;
        b=PIPhefsKFx6wTlMDZcXOuwYnUDfvLAy+Mf3KHFzAEpgD0E8wRLcZB17Pl1SUHGVaOf
         o2IPZKSENFndzu6VbFdBHM8B/61w6vLa0g4e2lTM5MVwwLzzBYT3yDTX+Al7iZc7LGwt
         i3DRksrL1UCgtRc/FBRI045DVBQStG0E5Mi3I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705523390; x=1706128190;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RIlPx5Fv1DAFpxKYm/WA9Edd1lJzoBYsIqyytrhrcqw=;
        b=bvEVSrZH8PeXdnxL9KGvV6xufczx7XYZ1LXfj5noTvRdMTVClS8bAlqDL5ybIaVI/f
         CddWRh4qpv7uTxcDhNabaSrkNNkZHd05087wmJ/OJ8UiaHqfLZ8Qsd+kQJMd8SghyqZx
         jByFPpmzX8VYMEb2Z22Ajb0F58/8xWMyvN3CXF5ZDoZ/SWeMZa7LUN+W5Tnjotg9WB++
         fQxbVW3KIqrA6Ldii3OTTvYN7jjlm8JHnN5CGYqQfdoyg7Lguni9mc8Lq0HMmJDzeluP
         IULjtMLZRhxu2JFF0EbdX9Y0CzkenxHaIjiFWWxQt3QbquktTnN4h1wzs1AXS5erx6fQ
         +lpQ==
X-Gm-Message-State: AOJu0Yx2JHVPIhkRJhdwLeD/FfVmHa4Phf6v3DsFip2/EHjLbytQHGQC
	jaDJOxS/NnYQ6oCUIwb6V0EKL/rOCblSyI9pHKFP/wBi/Q==
X-Google-Smtp-Source: AGHT+IHJjq3/P/cxTVdyUMOXiREQLpfXVsK0F1ecX/lSR6DYwuuYkqGwGTfW8PHKlwr27gBVjNMOLQ==
X-Received: by 2002:a92:b0e:0:b0:361:8f10:1a01 with SMTP id b14-20020a920b0e000000b003618f101a01mr3045834ilf.18.1705523390390;
        Wed, 17 Jan 2024 12:29:50 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id i15-20020a63cd0f000000b005ce6b79ab6asm64196pgg.82.2024.01.17.12.29.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jan 2024 12:29:49 -0800 (PST)
Date: Wed, 17 Jan 2024 12:29:49 -0800
From: Kees Cook <keescook@chromium.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Nathan Lynch via B4 Relay <devnull+nathanl.linux.ibm.com@kernel.org>,
	nathanl@linux.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] seq_buf: make DECLARE_SEQ_BUF() usable
Message-ID: <202401171229.56A2F70@keescook>
References: <20240116-declare-seq-buf-fix-v1-1-915db4692f32@linux.ibm.com>
 <20240117093234.660d4150@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240117093234.660d4150@gandalf.local.home>

On Wed, Jan 17, 2024 at 09:32:34AM -0500, Steven Rostedt wrote:
> 
> Kees,
> 
> Are you OK with this change? I ran it through my tests and have another
> pull request ready to go that includes this. But I don't want to send it
> without an Acked-by from you.

Yeah! This cleanly solves the lack of being able to add the "static",
etc.

Acked-by: Kees Cook <keescook@chromium.org>

-Kees

> 
> Luckily, Linus is on non-voluntary vacation so we may still have time ;-)
> 
> -- Steve
> 
> 
> On Tue, 16 Jan 2024 08:09:25 -0600
> Nathan Lynch via B4 Relay <devnull+nathanl.linux.ibm.com@kernel.org> wrote:
> 
> > From: Nathan Lynch <nathanl@linux.ibm.com>
> > 
> > Using the address operator on the array doesn't work:
> > 
> > ./include/linux/seq_buf.h:27:27: error: initialization of ‘char *’
> >   from incompatible pointer type ‘char (*)[128]’
> >   [-Werror=incompatible-pointer-types]
> >    27 |                 .buffer = &__ ## NAME ## _buffer,       \
> >       |                           ^
> > 
> > Apart from fixing that, we can improve DECLARE_SEQ_BUF() by using a
> > compound literal to define the buffer array without attaching a name
> > to it. This makes the macro a single statement, allowing constructs
> > such as:
> > 
> >   static DECLARE_SEQ_BUF(my_seq_buf, MYSB_SIZE);
> > 
> > to work as intended.
> > 
> > Signed-off-by: Nathan Lynch <nathanl@linux.ibm.com>
> > Fixes: dcc4e5728eea ("seq_buf: Introduce DECLARE_SEQ_BUF and seq_buf_str()")
> > ---
> >  include/linux/seq_buf.h | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> > 
> > diff --git a/include/linux/seq_buf.h b/include/linux/seq_buf.h
> > index 5fb1f12c33f9..c44f4b47b945 100644
> > --- a/include/linux/seq_buf.h
> > +++ b/include/linux/seq_buf.h
> > @@ -22,9 +22,8 @@ struct seq_buf {
> >  };
> >  
> >  #define DECLARE_SEQ_BUF(NAME, SIZE)			\
> > -	char __ ## NAME ## _buffer[SIZE] = "";		\
> >  	struct seq_buf NAME = {				\
> > -		.buffer = &__ ## NAME ## _buffer,	\
> > +		.buffer = (char[SIZE]) { 0 },		\
> >  		.size = SIZE,				\
> >  	}
> >  
> > 
> > ---
> > base-commit: 70d201a40823acba23899342d62bc2644051ad2e
> > change-id: 20240112-declare-seq-buf-fix-9803b7e679bc
> > 
> > Best regards,
> 

-- 
Kees Cook

