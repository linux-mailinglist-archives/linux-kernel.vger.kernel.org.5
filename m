Return-Path: <linux-kernel+bounces-32169-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 548FB8357A0
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 20:57:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0AA59281C2C
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 19:57:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DD78383A9;
	Sun, 21 Jan 2024 19:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="GDYIEDED"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EFF0182DC
	for <linux-kernel@vger.kernel.org>; Sun, 21 Jan 2024 19:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705867047; cv=none; b=atHK+U4He9l5QZpLUjnFDWKhqCjlQEsFPJJDiRFk+ZzJ25YITXHhMXc97082nNTBtr7rBAowqve2D+sx7wmSE8KzRi9+PfpvVZYWuLAruceP3BFQMrk/sSd2ri/sraWOSALDW5WQ5WAkw94Ms6DxTisw31F6MoTXiMBXkidspbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705867047; c=relaxed/simple;
	bh=JoonGw9vQNXaHQmMN+LL9oyTK5rcSC4rZUk0sfhe/Zg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XmNfVN0h+AHdW8pwZkvMDK8asKQKwC0O4xjdcZoA4UeL50EkYeTmrqRjkt/oA6DY+miu/SxnaxNST0MLq7UbtuLw1a4Z52O6bdeQLBfriTsTfvwCKnuZqRbxMacEFo44yn3wYRKf/0ZLB+W5qNKcqaJasSY+1MyrlfCoGcHFzAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=GDYIEDED; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-55c33773c0aso305250a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 21 Jan 2024 11:57:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1705867044; x=1706471844; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=J0/ycZHO2LVW1a2k1bwDkHHCW1t09pgf1oyaA+mSkcw=;
        b=GDYIEDED4C3IYCD5oBQGC6PdYFX/8Sa4O9cOuPqDCs+YWsSdxJDrhDRCYuqGRHvgZw
         9vbfqDCyki0SDzE1gRNDqOyCCEb2qYHeHKgwu57nt70j5mJRXJJZD99/9prjzT5ZmieN
         4+CaLPNLnOFmzOExe8yeWzTyOQLUOjG/J1kdU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705867044; x=1706471844;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J0/ycZHO2LVW1a2k1bwDkHHCW1t09pgf1oyaA+mSkcw=;
        b=GvfD3LA7KTUDPdCOsN8tcGktqSgE17mdS8/TBi1BYxAX4M8v0d6Zm5lgUtG0WxEhH9
         Jn+lFLk+S1BwcWM4yBLHamzqPIesDnZPW9Jb9vFqt2CxprhpQ2ys8stBim0jzrSkdegK
         Dw3P5REbgTEUiWSrsuh+zJHVbbH7DSb9G6k76qFazj+EXhavd8OsYIMDQDOin6TC5GsN
         AvBDzXomuyk0mIz9J6FUJA0TmRgB+kEPoy3oRX+NJ/XkLUtKHK6MiAc/hqkBzbtimOu7
         DbodjpRBuawnXOMh4lCEUUuQD6tDUtPgOn8Jma3OnGoMmnXQEzlmQAJ2IcU/ZQG2DEO4
         7MQw==
X-Gm-Message-State: AOJu0YwNfJNaZOF3+FqgoMwSydwFiWrxL++8EkWUMdgKdrDziZ4VOOkG
	VhYoKwRHMXmL5vt9Mi2dCpQiPSUDIMalZI9sN4epBIEviYNz7UPPNPNb4Hh3YeGJk4/O7RHj6yc
	OTN1rFQ==
X-Google-Smtp-Source: AGHT+IH3IH7I07DRebSBFeazJIMF0q58S0ycKdQVLh2M0BZyNXqt2aSOmyG2CIG6Vip2bEydEDGUaQ==
X-Received: by 2002:a05:6402:b09:b0:55c:7d:1a9c with SMTP id bm9-20020a0564020b0900b0055c007d1a9cmr1364581edb.53.1705867044506;
        Sun, 21 Jan 2024 11:57:24 -0800 (PST)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com. [209.85.128.47])
        by smtp.gmail.com with ESMTPSA id i23-20020a0564020f1700b0055c0dba33b7sm1408664eda.18.2024.01.21.11.57.24
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 21 Jan 2024 11:57:24 -0800 (PST)
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-40e86a9fc4bso33215925e9.2
        for <linux-kernel@vger.kernel.org>; Sun, 21 Jan 2024 11:57:24 -0800 (PST)
X-Received: by 2002:a05:600c:56c5:b0:40d:8794:8535 with SMTP id
 ju5-20020a05600c56c500b0040d87948535mr1754394wmb.160.1705867043768; Sun, 21
 Jan 2024 11:57:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240113183334.1690740-1-aurelien@aurel32.net> <fd143cf8-5e3d-4d80-8b53-b05980558e45@xs4all.nl>
In-Reply-To: <fd143cf8-5e3d-4d80-8b53-b05980558e45@xs4all.nl>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 21 Jan 2024 11:57:07 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgDh18QD_Z6V96J8_gjbSo-7CvGZb9VLRLSL-JD2F8WqQ@mail.gmail.com>
Message-ID: <CAHk-=wgDh18QD_Z6V96J8_gjbSo-7CvGZb9VLRLSL-JD2F8WqQ@mail.gmail.com>
Subject: Re: [PATCH] media: solo6x10: replace max(a, min(b, c)) by clamp(b, a, c)
To: Hans Verkuil <hverkuil@xs4all.nl>
Cc: Aurelien Jarno <aurelien@aurel32.net>, linux-kernel@vger.kernel.org, 
	Bluecherry Maintainers <maintainers@bluecherrydvr.com>, 
	Anton Sviridenko <anton@corp.bluecherry.net>, Andrey Utkin <andrey_utkin@fastmail.com>, 
	Ismael Luceno <ismael@iodev.co.uk>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	"open list:SOFTLOGIC 6x10 MPEG CODEC" <linux-media@vger.kernel.org>, 
	"Andy Shevchenko'" <andriy.shevchenko@linux.intel.com>, 
	"Andrew Morton'" <akpm@linux-foundation.org>, Matthew Wilcox <willy@infradead.org>, 
	"Christoph Hellwig'" <hch@infradead.org>, "Jason A . Donenfeld" <Jason@zx2c4.com>, Jiri Slaby <jirislaby@gmail.com>, 
	stable@vger.kernel.org, David Laight <David.Laight@aculab.com>
Content-Type: text/plain; charset="UTF-8"

On Sun, 14 Jan 2024 at 03:04, Hans Verkuil <hverkuil@xs4all.nl> wrote:
>
> I'll pick this up as a fix for v6.8.
>
> Linus, if you prefer to pick this up directly, then that's fine as well.

Bah, missed this email, and so a belated note that I picked the patch
up as commit 31e97d7c9ae3.

It even got your Reviewed-by thanks to b4 picking that up automatically.

               Linus

