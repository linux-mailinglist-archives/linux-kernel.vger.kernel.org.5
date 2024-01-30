Return-Path: <linux-kernel+bounces-45436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6326B843073
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 23:58:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 168E7287E9F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 22:58:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F0377EF04;
	Tue, 30 Jan 2024 22:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="PAS4TnT+"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD2117EEFD
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 22:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706655527; cv=none; b=D0fpiLO0NNtiil0Javk1Iw3zsClJEhoIufauTxFd1Q+FpqvNSndpVCjlguhQh5JBVgtd42zh9wkyYdmjUlxIgLu/A04kdB9KSP9EZLmQBir5SPSpiiTtIsqZWTrdUGbxYRRLdKJd9fsTqu0uOlqtHbf39s/AY5srGMNit/QQ7gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706655527; c=relaxed/simple;
	bh=w8/uJ+SUEqNhrF6n2qTlW5Zxi/j1BpjjVRW2sAz0Ev0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qyllZ7K4sNTAdlTX+vbm9Q/1q7sP0AnL9dLL1ySKREv+iJrlDGtvczg/4QNOT6uF3/5CC30M1ta6MrZIGyJMPL1RH4qBJJggkAF1gsOG49n2QDXr31M9WQstlzOr/mobydvhtTE6pVQnUQOkizFEo7uPLQhsPus7PFG1Usiq75E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=PAS4TnT+; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a34c5ca2537so510182966b.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 14:58:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1706655524; x=1707260324; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6u8d8IRFtua7Qk5gvgpajAZgmyBQzeYWdWgDLsMs/FA=;
        b=PAS4TnT+HqTTmhj8K/EgraHFzDqiDc5zlim3dIQ/aWgPjXcsbmdhD7fI5U+MBx3AGz
         AriMr9riGT35t3a21Uxqua9NIIZUM7QvXx4wQHuDW9w2/tC2Mjr5wfguFGWLtz3aSPUC
         q5Zakcf2Cda35esbE7Th12GMTUHLnGPa9Vfqk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706655524; x=1707260324;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6u8d8IRFtua7Qk5gvgpajAZgmyBQzeYWdWgDLsMs/FA=;
        b=ALV6cDmJisb0k7uuLfOADrLm2z1zBLZv1oooFfXA0ZR2dlG1Qr5BM2KaT90uGyJQp2
         TCBfr+jr+u3WRgvJngjrVkZ0lDaOYtN3pev7IkNW9gFqijNwMmjYu5nnny+vco8tyLdH
         8DHTYEl6FG9sY1zTX/lfN0yeoQhI9nVtn5K29XIsDeW6zVxSxBnErIuJq0qKlXU2e4Ko
         KQZgtc7EKNPw6VhqkPjRKBAnuyJAaO55W55gv3HI9RdeCzqrLy0K8242ageJmJMX4eR1
         m4OdwAI4g/+NtFQtjECGsfrV2u2A/00pO9x5fwErCpOMdYqk3yhwQvnu0M/SEiYjDyj1
         qNxw==
X-Gm-Message-State: AOJu0YwW0zBujxkxnEg/3DtD2GNlN4qOPqBJt2RYTunF0TI5nQheIDBn
	TsvkH8MTAIzvUKuWaDaDPGKkkwTQXBX8rxK80ugYSC/nqFvbPXnrBCGPvRc4wOQHyxYA0YgijaW
	qsbgPcw==
X-Google-Smtp-Source: AGHT+IFu4CQ3w/gpDVpSX7+vUPnOU22SnH57M9fLEO3NO09zmJckoWXnJjIFyl9Fx66YyQG6YUSNMQ==
X-Received: by 2002:a17:906:3482:b0:a35:42d0:5d60 with SMTP id g2-20020a170906348200b00a3542d05d60mr6418888ejb.61.1706655523726;
        Tue, 30 Jan 2024 14:58:43 -0800 (PST)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com. [209.85.208.54])
        by smtp.gmail.com with ESMTPSA id v2-20020a1709060b4200b00a35ed4fd4cesm1993986ejg.115.2024.01.30.14.58.43
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jan 2024 14:58:43 -0800 (PST)
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-55f496d60e4so1501187a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 14:58:43 -0800 (PST)
X-Received: by 2002:a05:6402:2692:b0:55f:6f08:d75d with SMTP id
 w18-20020a056402269200b0055f6f08d75dmr227786edd.21.1706655522944; Tue, 30 Jan
 2024 14:58:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240130190355.11486-1-torvalds@linux-foundation.org>
 <20240130190355.11486-5-torvalds@linux-foundation.org> <20240130155550.4881d558@gandalf.local.home>
 <CAHk-=whD=9qTfhYVhH+d44KbwefC_vnRAjqz-pthcSn1p5zZLA@mail.gmail.com> <20240130175603.5f686e46@gandalf.local.home>
In-Reply-To: <20240130175603.5f686e46@gandalf.local.home>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 30 Jan 2024 14:58:26 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgTKsxPYyys-U5guyEUDb63MtfTz4y+r6cgKT52zBNOpQ@mail.gmail.com>
Message-ID: <CAHk-=wgTKsxPYyys-U5guyEUDb63MtfTz4y+r6cgKT52zBNOpQ@mail.gmail.com>
Subject: Re: [PATCH 5/6] eventfs: get rid of dentry pointers without refcounts
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 30 Jan 2024 at 14:55, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> Remember, the files don't have an ei allocated. Only directories.

Crossed emails.

> I then counted the length of the string - 7 bytes (which is the same as the
> length of the string plus the '\0' character - 8 bytes) to accommodate the
> pointer size, and it's a savings of 22KB per instance. And in actuality, I
> should have rounded to the nearest kmalloc slab size as kzalloc() isn't going to
> return 35 bytes back but 64 bytes will be allocated.

No. See my other email. The kmalloc sizes actually means that it comes
out exactly even.

             Linus

