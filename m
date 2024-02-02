Return-Path: <linux-kernel+bounces-49578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59F4D846BF3
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 10:29:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14855290EE9
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 09:29:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 552C578B7D;
	Fri,  2 Feb 2024 09:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="c7Vtdbmp"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DB227869A
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 09:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706866026; cv=none; b=swly50KXzBqjQ85LYjy0rsxknyb+jQJ4RrunR/w1T7bH7WmNPEjVV9pHvCzOyM7Bishla3pX9uj6BMJA3mkayqUQi/4Obk6gJsnIe0ugmE1RHRLsUhjPfq0zGLGXkLFq3PHJlZCAoLJDCFBxNsrznbeArH5zQ6/XxNI2yYdFLBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706866026; c=relaxed/simple;
	bh=x5u1nz+Cg3nU/mZVDA54R7aNvx66CQZrP0sVG6CHmU0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c2Z6DWzz1Km2ONwddSl0q8sbdnM/4NQokpA1bhSwr0/MzNZfqkUO1wWFHR5cQCv1b7sIazwRSyqRZFMwAWvKqSCDcC6U5AjrMaf9ANSWl/PSS/SE3MMkYpil945ECveEa6M1LYgkrIs/ZxgFjQxJczV3EvXbdwB7VP+0yT4TTME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=c7Vtdbmp; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a271a28aeb4so277387866b.2
        for <linux-kernel@vger.kernel.org>; Fri, 02 Feb 2024 01:27:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1706866022; x=1707470822; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=D55dCjTjZ3OFIaN3mYYht0ubpj5TCCakCn4hIxqLFNw=;
        b=c7Vtdbmp5MoE8pAXbAAbv23PpOudl5QS0reUVi91vXLwewNCDtpjIjz62Z1znAKBDi
         VRIJBPTT8V6tIcZ3xTP5TQzMs/C/FWwLR+wTy3z2x2UYZqNtTCNS+8AXbtN3M7Vd0nfg
         P8q7YUv1G6S5JsWOFxJEBQQXj4UDJm8ioeyW4lPRynOAq268dunhXpDJ37VcCFqIWQSv
         ehoGowsd2QPeXvAtRXBUgLXZAS42PmP1KH9+Tj+zT0Begjatsp2+oiYDJThx6mru5v7v
         bxSs765uYXZmwElU2iBqrfmu1XgVpipA72KoeavjySVZphfood6YBq48dIRlJvJKiWij
         RCSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706866022; x=1707470822;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D55dCjTjZ3OFIaN3mYYht0ubpj5TCCakCn4hIxqLFNw=;
        b=CTF6SjYwqh3d89s3BFM9iT5GQD5UDmchbW0RFQOSR4US1Z/HQ5CDoPRgcfVf8//S12
         a0BVc+xAaoeS7UYDWZ5+mn4EIY+IhSdC49aiZDBng1iNhdtj0wdSx1Ve30TCVkv7pWbq
         N27devKNgeVeDnl+r1FZGYcx6MrK2WX2FwrnFr8ieTg5wSkVciEIwTHFUhQ+2I8vrrIv
         FURsyAvfrpepLeNHM83OB5tfisDLmIZSBZmOS4ozKeU7GPH9cuIdHvDqqhpdNzpIWjIQ
         /gSJj+Y7lCgXicRvvQILmuZUTDDaQ89/PAkqNbpn98ZWW8xtuyZ6/d5F1r+n08HNPFYi
         36sQ==
X-Gm-Message-State: AOJu0YyntyfEV+UhVl2fsJMcHBP9TzMitx4xPEC94KE8KkZZ5nFBuLAJ
	l7WDjxiw9+oaJ76fWQl2yD5728i39353EfyvmBulcHgpSn2Us4adsZTaq/iD1EsiwqzHVI5M3sj
	i
X-Google-Smtp-Source: AGHT+IFdkljpvc5ASuaHT2pmfN5i+dFMx81fPkDQ6sc0wl0TnNQfmao+hKqUbJPP7SBCkkJawTqh0w==
X-Received: by 2002:a17:907:88d:b0:a36:2d2f:3385 with SMTP id zt13-20020a170907088d00b00a362d2f3385mr924181ejb.9.1706866021810;
        Fri, 02 Feb 2024 01:27:01 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWUsgiVQpP0TdEAs6lB8oVReF6KRGy2gU+BjLMpBPWx8XUucjp14Rcaxqlbq9u8llHKQU9rmwoC/Twj8g5S9k/3TxMaC5cVWfrw9zC2NNYTnLd0XiR6s380RhQD+eV6HzI5z83j86c/4+bpOVrV+MJQjpofdW4=
Received: from alley ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id b17-20020a170906039100b00a35b4edb266sm690819eja.87.2024.02.02.01.27.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 01:27:01 -0800 (PST)
Date: Fri, 2 Feb 2024 10:26:59 +0100
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk v3 13/14] printk: Avoid non-panic CPUs writing to
 ringbuffer
Message-ID: <Zby1Y7eqCOPYa3Vw@alley>
References: <20231214214201.499426-1-john.ogness@linutronix.de>
 <20231214214201.499426-14-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231214214201.499426-14-john.ogness@linutronix.de>

On Thu 2023-12-14 22:48:00, John Ogness wrote:
> Commit 13fb0f74d702 ("printk: Avoid livelock with heavy printk
> during panic") introduced a mechanism to silence non-panic CPUs
> if too many messages are being dropped. Aside from trying to
> workaround the livelock bugs of legacy consoles, it was also
> intended to avoid losing panic messages. However, if non-panic
> CPUs are writing to the ringbuffer, then reacting to dropped
> messages is too late.
> 
> To avoid losing panic CPU messages, silence non-panic CPUs
> immediately on panic.
> 
> Signed-off-by: John Ogness <john.ogness@linutronix.de>

I am slightly nervous about this change because it looks
too agresive ;-)

But it makes perfect sense. And it nicely complements the 10th
patch, see
https://lore.kernel.org/r/20231214214201.499426-11-john.ogness@linutronix.de
The 10th patch allows to skip messages in reserved state. It might
cause skipping random messages from other CPUs. So it really
looks better to skip/ignore them completely.

It would be nice to mention the relation to the 10th patch
in the commit message. Something like:

<proposal>
Another motivation is that non-finalized messages already might be
skipped in panic(). By other words, random messages from non-panic
CPUs might already get lost. It is better to ignore all to avoid
confusion.
</proposal>

With the updated commit message:

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr

