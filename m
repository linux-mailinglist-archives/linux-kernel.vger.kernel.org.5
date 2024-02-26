Return-Path: <linux-kernel+bounces-82436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2680B86848A
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 00:17:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 534FD1C218C9
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 23:17:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03B3A135A47;
	Mon, 26 Feb 2024 23:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="XhE7ozGm"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C02B133285
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 23:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708989431; cv=none; b=UTbY4haBp7hnzlqryq32wNj7evUbms//EV8xI6aazJYPKFBJPPmsFEd0jT9jhp0f6znPwUj9gAlsYCckXhMpNyqR5fGUO55KnjGS8UZcqnZFY0nQdGwd4t6iVKI8+6NXCud9YOgSOF+w2YpinCv3bQ07amvIt97doP/E58IdIyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708989431; c=relaxed/simple;
	bh=qOuAEHrf8q5fX3cChhCFW8ymfxwHQRMOJI5lw870U9Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UkNuNaNe/VhWGLx+Y9IhBOZ7XUUEcg3Cwf4pb5F+d8DsGv+MK/aQYS6VgFtCe6M6kQTq72TEXuJsc2DcaxmeZglmwmY+bI8qqIwWGS6BVKUJwB6ZYoxVocTyXot3aZQGFC6j0JKbPrXNvlttH4HtoS1v+ivfeDAcpBKQKlvHRhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=XhE7ozGm; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-299e4b352cdso2736626a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 15:17:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1708989428; x=1709594228; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eYuGQ7XfN8pbZjALsZ8f3cB3Gxf+yNkm9MR0bR+0+ps=;
        b=XhE7ozGmwgq4SsoKlUkPgQeU4OlwwzJeDxtRLHJIeTkjqsSTZR8X8oWsjoxZGYR2EP
         lxevk7gdSVPVj443CIFp4e7GtL7fmxGcx0ryBFJTqGyPZDbTgW5MURwhI/VfTzMnYsPY
         RxosxKuAiHQG2hwoLtKKN/9aGls70OKXBnBFe7M5B4laF8m5ADMDc7c1Vr9lEJmwVLaE
         W2ump7RJsVdiqwoR0Tw3ZUZ0qE6IYUyn0AusAMewe44czOqKH6XuQFTLouBPsjAYGakt
         vG68RLwcQfcO06IywyM5rlzXogIDCGxASCHpyKagNVWer+uIDHcqbqRDfYm1zOx9B/v3
         QQfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708989428; x=1709594228;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eYuGQ7XfN8pbZjALsZ8f3cB3Gxf+yNkm9MR0bR+0+ps=;
        b=cAkkW9miZ6V9O9GjDyK0e/A29w0Kq19qWUqPTAdDX7ZYLYxvVffZQPx66kzoFHPWDS
         ZSTNH9bOCCHYPXVw/IHH4usuj1ooOHtBQlhPbvLhVkNh6H0QSNEJIz3C/b6rkxh8KUQG
         MiVEsmsfHE9wl5sghYbdvul1wZd6/ll6v3yb/BAypkK91BzmBbY0f/F9Z8wQHu8GlHoL
         Y01NorZF8m6+zmqSrwEcb6zcJ7y56gSRmeoYNAdlTopCR4MQVzsVnQo9Q9xMrKvTVl2B
         D4CEFP5jvE+HTL9OI6qqu81/jhDHYKfzL5JAVD+imARvLAceghpBAgKqh0QQIDsPQWnz
         sHFw==
X-Forwarded-Encrypted: i=1; AJvYcCVYxYQOA9gT9IdIJrsKCJkJDXLOzXKnl3QU1Ev3e1exRusbSArx/Z6zLZUh2D54+j4S5q106uXzzHVpa7oUOpKhMBBby0gGpWKV97OX
X-Gm-Message-State: AOJu0Yw1OLClHF8ujjEcVKmH2sRI2L1QjCzPbKp8+sZ1H6XE8QDVjuEP
	9hPqBIqxSyLCOsDb46QEDMwUxffFfsU6Hren7o7AYR/0Wzpp6KwBfxGYbS5suiM=
X-Google-Smtp-Source: AGHT+IEpkBisnFY51DxSCQVNGVHByQM/L8pu9TXeuE9bPXGftlegROVVVLta7KVPD3RdCTgh+hFK7w==
X-Received: by 2002:a17:90a:68c8:b0:299:42d1:91df with SMTP id q8-20020a17090a68c800b0029942d191dfmr7094179pjj.14.1708989428406;
        Mon, 26 Feb 2024 15:17:08 -0800 (PST)
Received: from ghost ([50.213.54.97])
        by smtp.gmail.com with ESMTPSA id qa2-20020a17090b4fc200b0029ad1df1661sm1671155pjb.52.2024.02.26.15.17.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 15:17:07 -0800 (PST)
Date: Mon, 26 Feb 2024 15:17:05 -0800
From: Charlie Jenkins <charlie@rivosinc.com>
To: David Laight <David.Laight@aculab.com>
Cc: 'Russell King' <linux@armlinux.org.uk>,
	Guenter Roeck <linux@roeck-us.net>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Helge Deller <deller@gmx.de>,
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	Parisc List <linux-parisc@vger.kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Palmer Dabbelt <palmer@rivosinc.com>,
	Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v10] lib: checksum: Use aligned accesses for ip_fast_csum
 and csum_ipv6_magic tests
Message-ID: <Zd0b8SDT8hrG/0yW@ghost>
References: <20240223-fix_sparse_errors_checksum_tests-v10-1-b6a45914b7d8@rivosinc.com>
 <7ae930a7-3b10-4470-94ee-89cb650b3349@csgroup.eu>
 <e11fea7a-e99e-4539-a489-0aa145ee65f0@roeck-us.net>
 <ZdzPgSCTntY7JD5i@shell.armlinux.org.uk>
 <ZdzZ5tk459bgUrgz@ghost>
 <ZdzhRntTHApp0doV@shell.armlinux.org.uk>
 <b13b8847977d4cfa99b6a0c9a0fcbbcf@AcuMS.aculab.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b13b8847977d4cfa99b6a0c9a0fcbbcf@AcuMS.aculab.com>

On Mon, Feb 26, 2024 at 10:33:56PM +0000, David Laight wrote:
> ...
> > I think you misunderstand. "NET_IP_ALIGN offset is what the kernel
> > defines to be supported" is a gross misinterpretation. It is not
> > "defined to be supported" at all. It is the _preferred_ alignment
> > nothing more, nothing less.

This distinction is arbitrary in practice, but I am open to being proven
wrong if you have data to back up this statement. If the driver chooses
to not follow this, then the driver might not work. ARM defines the
NET_IP_ALIGN to be 2 to pad out the header to be on the supported
alignment. If the driver chooses to pad with one byte instead of 2
bytes, the driver may fail to work as the CPU may stall after the
misaligned access.

> 
> I'm sure I've seen code that would realign IP headers to a 4 byte
> boundary before processing them - but that might not have been in
> Linux.
> 
> I'm also sure there are cpu which will fault double length misaligned
> memory transfers - which might be used to marginally speed up code.
> Assuming more than 4 byte alignment for the IP header is likely
> 'wishful thinking'.
> 
> There is plenty of ethernet hardware that can only write frames
> to even boundaries and plenty of cpu that fault misaligned accesses.
> There are even cases of both on the same silicon die.
> 
> You also pretty much never want a fault handler to fixup misaligned
> ethernet frames (or really anything else for that matter).
> It is always going to be better to check in the code itself.
> 
> x86 has just made people 'sloppy' :-)
> 
> 	David
> 
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> Registration No: 1397386 (Wales)
> 

If somebody has a solution they deem to be better, I am happy to change
this test case. Otherwise, I would appreciate a maintainer resolving
this discussion and apply this fix.

- Charlie


