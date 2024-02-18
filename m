Return-Path: <linux-kernel+bounces-70135-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D0D08593D7
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 02:25:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9FFB281C6B
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 01:25:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CCDE15D0;
	Sun, 18 Feb 2024 01:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Xq5UyXTr"
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1BF8EDD
	for <linux-kernel@vger.kernel.org>; Sun, 18 Feb 2024 01:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708219537; cv=none; b=q+4DTXOESV9TuKbYy5z/DItD+U2BpxcYzzwBDpX213rCGjB5y+yb9v358pTTfd85uUXEV+07c/e9HI8YAFi1N3Hhw5PDS0W2Za9NlbUaUoFKN0QR9EtB1WoM7arw3da3a0BcjZtcGGHbiF1n+UDfw8YD+k0DehRdQRmDd1BFbps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708219537; c=relaxed/simple;
	bh=a3hJQoAtYSUkKDh/waTTxwVQsYYIvXqoZW7AfetXO1Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jyLzoXdIC/mG9/DDqzFIjUc4szjV4TqCiT+F1JICCyaF/ZlN1zugwZMZhYWSr/ekFk3kP0+ePfmqup9QRAhRrnFSXWFGGlT+g6TwfcJxJMOLbVVg3kP/Fid5wwTGw2Sj802yI4UP4yR1N/sY3Q6q0ky5mFKhGxZbaXb8Q8DN6fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Xq5UyXTr; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-2185d368211so2009527fac.3
        for <linux-kernel@vger.kernel.org>; Sat, 17 Feb 2024 17:25:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1708219534; x=1708824334; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VuoBtT2e7jiJsHrgcaJkRcD5zeydER6RGTa0O/OCH9A=;
        b=Xq5UyXTrn3X6COKYrRkFMlDVB0KcI0cr+RjjxXQ61P76WT6ApgRMYI6+4wF4Gv2qhI
         ggfozzffPJun+wMy5DBToaePmcgv12KzuLyUHk6eA2H14zScdcgC5MIfFEalLnastZUf
         EUbbNOXTUILTpIP1xoT4D6ygu0h3oCCzvrP0E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708219534; x=1708824334;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VuoBtT2e7jiJsHrgcaJkRcD5zeydER6RGTa0O/OCH9A=;
        b=TidZMY2nSlE6GXhFlrP7HvBcUeBH5n1PNb2Ix0C48s7yl3l6I+uR5XgaDJcT6Fjr85
         or6dy/lyJ2eyj5M7e7v5dH7Gu3Oo8JL0gLXJvUf0ZyPl+k5S1HR+qspC8oQ5pc6qTHCc
         LThr3My/kTss0eNtf94buHT4JErcgL2Ui+487PbQ6WamUCza1CMYhO93Bk7xXnRBqt4c
         3Kunlf63LMBg9WcULpB9t1oQEFj2mmmER4ZfLbjEIFGQN7Qvh2tzhIRTxhzbtJwxIw/T
         mK/9k/M03KA4ZwZrxmnkssdZWgbrunMVYnTVQJWpZxCU8X+uhRkLxOgR4bJF5EW8B2RG
         tSKQ==
X-Forwarded-Encrypted: i=1; AJvYcCVZHzddDYf2nDlBa4qoJrXfEjUWavycLEeewnLn+4sewHKnrDzn7znwqCPD/7NGbxm0Is/1moG5+PqAkdEKMusitptW4dIv4o+X6cRJ
X-Gm-Message-State: AOJu0YyUGCMV5HUcOLL+Vjo4/pe1otSyqU6TjzDJ92OHklVP8Ed0jhWx
	rzZ4WRRXA4L0hddvbBMRJopGwKIj4tZkrXXDbVarGEEZ8zxHjrPkWBaxzQ4LgQ==
X-Google-Smtp-Source: AGHT+IHjBUDoientSzd3b5MGz9AJNkPP1IEibihvCcJEeLidYINReimoOazQTftO263H7irZPdbdug==
X-Received: by 2002:a05:6871:453:b0:21e:bbdf:8b94 with SMTP id e19-20020a056871045300b0021ebbdf8b94mr543705oag.37.1708219533979;
        Sat, 17 Feb 2024 17:25:33 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id r135-20020a632b8d000000b005dc4f9cecdcsm2168893pgr.86.2024.02.17.17.25.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Feb 2024 17:25:33 -0800 (PST)
Date: Sat, 17 Feb 2024 17:25:32 -0800
From: Kees Cook <keescook@chromium.org>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Jiri Kosina <jikos@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Qi Zheng <zhengqi.arch@bytedance.com>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Eric Biederman <ebiederm@xmission.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Brian Gerst <brgerst@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Tony Battersby <tonyb@cybernetics.com>,
	linux-kernel@vger.kernel.org, y0un9n132@gmail.com, x86@kernel.org,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH 0/2] Adjust brk randomness
Message-ID: <202402171723.914538A526@keescook>
References: <20240217062035.work.493-kees@kernel.org>
 <05E12A71-D8A4-4E6D-9C9D-024251C1BDC7@zytor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <05E12A71-D8A4-4E6D-9C9D-024251C1BDC7@zytor.com>

On Sat, Feb 17, 2024 at 04:25:33PM -0800, H. Peter Anvin wrote:
> On February 16, 2024 10:25:42 PM PST, Kees Cook <keescook@chromium.org> wrote:
> >Hi,
> >
> >It was recently pointed out[1] that x86_64 brk entropy was not great,
> >and that on all architectures the brk can (when the random offset is 0)
> >be immediately adjacent to .bss, leaving no gap that could stop linear
> >overflows from the .bss. Address both issues.
> >
> >-Kees
> >
> >Link: https://lore.kernel.org/linux-hardening/CA+2EKTVLvc8hDZc+2Yhwmus=dzOUG5E4gV7ayCbu0MPJTZzWkw@mail.gmail.com [1]
> >
> >Kees Cook (2):
> >  x86: Increase brk randomness entropy on x86_64
> >  binfmt_elf: Leave a gap between .bss and brk
> >
> > arch/x86/kernel/process.c | 5 ++++-
> > fs/binfmt_elf.c           | 3 +++
> > 2 files changed, 7 insertions(+), 1 deletion(-)
> >
> 
> Why do we even have the brk, or perhaps more importantly, why do we use it? Is there any reason whatsoever why glibc uses brk instead of mmap to her heap memory?
> 
> I thought the base of the brk wasn't even known to userspace other than in the form of the image end...

AFAIK, it's part of ELF ABI, and the loader uses it only for very early
allocations. e.g. it's what shows up as "[heap]" in /proc/$pid/maps.
It's also available to any program that wants it still (see "man brk").
I don't think glibc has plans to redirect it.

-- 
Kees Cook

