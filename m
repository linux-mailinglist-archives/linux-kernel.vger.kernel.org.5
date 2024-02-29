Return-Path: <linux-kernel+bounces-86784-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B211286CAB8
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 14:53:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6AD82284F97
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 13:53:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9253B12B17A;
	Thu, 29 Feb 2024 13:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Zr8txi9h"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEE1512836A
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 13:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709214820; cv=none; b=rWNKkEVuRtT+t9c7DawvxifVZsDUhYobddG6xiFkdPSdkvkWLAix1IN67mkSVy2hB7u5tTxHGGcV9KMXGuRvGL+BE9CBlxe+l5lghqBZv42IPdP98ErHB9WoTQqxvOgWai3MBTZhoc+YuYqkiute0QQwG+zJGJ1SoZmLr3gqF0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709214820; c=relaxed/simple;
	bh=xqOQmxL3ZsCB8YdwIJpWgiC0m6lbboEPpbmStPBJu3I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gsAkfwI0vTUG27+HNcTqeVzRHVODL4ELCjUqHbWkwPy1/9AbcrmxwaJcDRVZfZOrZ26mlpQQBHKfWh9Ec6ElR8rrOksVHFTvcJquwMz7LX55Y89iMXmlrbnPTlLZwTpUgWRch8gDfVrTNBZhG25LYrRyhSf3M9NBRM7Iv8WSYMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Zr8txi9h; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a3e85a76fa8so133259166b.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 05:53:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1709214817; x=1709819617; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2gchPagg7fwMGrF9ukD7ikfnfYbiju2GAEPYqQMS7gc=;
        b=Zr8txi9hmukZrYMxouhoLnW/nZjIuCQ9v7cKWj9yay5Shqu08axCzM/cv8lKdCInn6
         Vs82ONGbMDsIDcILO1cuKmr949P1IN6okiPYlQ92sEgIaP913HEAS/DPgBW3kkCt68TQ
         Dl1uHM8QdyPbVuiZXKKQcW9qeSnjk/nuy1VWeB1Gy3yGladltPhyeNL+KQQssyZmHC1X
         QbxMni4G4bI+RWcoSkMoKiJ1N3k4gdWr/O2ZEwDPdXg83yKIbCqZkuyfTQ65ZWRkDrGa
         cDPmpJpSTVofopJuFxK6R9OpMCGLModqful92q3U+GMNYXR8RSEe1Q0osnHitPU04pTA
         rRdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709214817; x=1709819617;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2gchPagg7fwMGrF9ukD7ikfnfYbiju2GAEPYqQMS7gc=;
        b=eaq7hW5CgwA2UqdWNfuGobURZjG8uyAMnK8CcIoiuy9QSOGXgaA9W1HOPbilrKBPGL
         bt24k5JcB88JMgeZy7lwmlYua1G49Dc24lMYS7OxjQl8Rha0pWZ/2nNoSrbyjyl9U37A
         lq0HMLuO+dz1vl9rJ7zl6+ekzizVsmxK2E87ftixgUcmhSVWbK3+HbCDxy6Jde0hKS/v
         TCj24pj0KPaKcK413QxIid+DrbW95UEGgMFhEI5uYiqWJ6ymzhucrmq2wPyIYypRnZ2M
         hJY0vVNYJ0NUTCTsADHCrb32NDn2N7Jzet2QHZ/0X68en408avAW53mQTCimKnJR7VzH
         w96Q==
X-Forwarded-Encrypted: i=1; AJvYcCUbEWNEsVvpXxcXyEoRGPIbVHmSg5YWuvStikP6uJDWV1zWWZbqWPUPqx4OiZJ9LolbWZJJL8LDklCg66eJSndMtxtjN656u88E8B1O
X-Gm-Message-State: AOJu0YygWTQgs+W3F9WeXUT6UFvu6U4vwgDDskTaump48c6iVi7DAjv/
	83DSwmtkZsNCsjE4vTyEOuJyWbe0MsGQ2hTtE0AL73Zdl+wKa7RGPBTZaplfPkk=
X-Google-Smtp-Source: AGHT+IHSKus6AVYOBpDqfVeaQpeTbHO55a+7CC/cAqv3/P3411VACjX6YYODZ5cXOQJqtH5hJDA45g==
X-Received: by 2002:a17:906:24d6:b0:a3f:48c1:9b9e with SMTP id f22-20020a17090624d600b00a3f48c19b9emr1535386ejb.20.1709214816990;
        Thu, 29 Feb 2024 05:53:36 -0800 (PST)
Received: from alley ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id n8-20020a170906378800b00a43c51efb11sm711505ejc.3.2024.02.29.05.53.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 05:53:36 -0800 (PST)
Date: Thu, 29 Feb 2024 14:53:35 +0100
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Uros Bizjak <ubizjak@gmail.com>,
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>,
	Lukas Wunner <lukas@wunner.de>, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH printk v2 18/26] printk: nbcon: Add unsafe flushing on
 panic
Message-ID: <ZeCMX2udjcxGLDtd@alley>
References: <20240218185726.1994771-1-john.ogness@linutronix.de>
 <20240218185726.1994771-19-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240218185726.1994771-19-john.ogness@linutronix.de>

On Sun 2024-02-18 20:03:18, John Ogness wrote:
> Add nbcon_atomic_flush_unsafe() to flush all nbcon consoles
> using the write_atomic() callback and allowing unsafe hostile
> takeovers. Call this at the end of panic() as a final attempt
> to flush any pending messages.
> 
> Note that legacy consoles use unsafe methods for flushing
> from the beginning of panic (see bust_spinlocks()). Therefore,
> systems using both legacy and nbcon consoles may still fail to
> see panic messages due to unsafe legacy console usage.
> 
> Signed-off-by: John Ogness <john.ogness@linutronix.de>

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr

