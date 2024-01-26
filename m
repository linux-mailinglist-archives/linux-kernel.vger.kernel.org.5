Return-Path: <linux-kernel+bounces-40543-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3635783E237
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 20:10:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9BA11F278EA
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 19:10:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FBFC22334;
	Fri, 26 Jan 2024 19:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="GzmDInZm"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBAA421A1C
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 19:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706296198; cv=none; b=Ehsbztgt+UphHpvEen4jB+6UXcxzZWJzvXYpDrtMXNTKsjw70CByPdJE+4sZzegXfj6vk2OfTX/Lj6MYt5C6hF313Ld8TmPOVNxVcyb+SdvqP9pZWEF+VU9rpXc3yMfmqg/dHtFckb2Q9+vVzUFdk1oX8+qFPrW7uYRI/xdrSRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706296198; c=relaxed/simple;
	bh=GI3V1xv08yktad6hU6ccQYuieybEkQ4n1unPPcnqxLc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kdoTYKVXtU9lPjyr++hRP+UtwX2v3hntJJT35O8P79Pbq4xLt80wQufW7kAO+Rrl9uiPs6gAoAqG7yOPRjqM2O+kXthrshW+Y79GAf5BAZyAq6As6DJt2l2zKMjbHEGKE/n+9CZp+/ghP5AKjDeNSXrzo/MBkbgosmxYqtXy22w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=GzmDInZm; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5101ae8ac40so889348e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 11:09:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1706296195; x=1706900995; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6aZ97vQxzWM87G5uxqrxMpNck695VI7AtteUqTwvz5I=;
        b=GzmDInZmrvoi8SPfwBv/EMMuq6VbMaqPTniwwxmtWq5vaBzRi/z6k2dsuMZBUGCwyW
         ZI+obOesxHBfSIT8HqWWpXJhC+vT6IfbvqBs4mTE3VtWgRuG9L9xc8G62QxxjF+8M9mC
         D+Zxb4AOktOQUZ4T3X4DgO9EI8fOU1xzYfpKg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706296195; x=1706900995;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6aZ97vQxzWM87G5uxqrxMpNck695VI7AtteUqTwvz5I=;
        b=aCGB6PH39X45LZ2dhKhamujrZrGnG1Axv3fubRg5sx0LfBDhTRNTrFW9S1mhIGqqAL
         9ar+zPU6j7ff1T1fq0rBOGpuu0MrdPRRjGxLcVvAdvRnY5L9qcgkLck1Syqr9K611LOT
         dz2/6P2dsVhU1aMUH465qxjye8oFBJm1zFXcUgebuPmA2F0L7qndbsaulgIrgq9m7LaH
         /fBGzxy9yHtmtEYLc5DaLkpQ9k+SL6teKrCQd0h76nRc+XJv0yZNxiJkqM0/yoyBAGDZ
         tuSiy4dKRl9qv5LVKVj1rV3uDrs3VpypjjZEFP5JvPGqSTL3Zrllb+/wyd81JR4vOXJA
         IUFA==
X-Gm-Message-State: AOJu0Yyx+tNLe6rB5kc5g2D37I+sXiqrU7W2guErxn9iZDXrJJqeyDm3
	FzwjUHRq8OFKv75kalW/b6Ll+mu449OoF4VlSc1xx/ZWSd8J+3Z4AJvkTwv3IkI5DpftohV3Jgz
	ImwNw3w==
X-Google-Smtp-Source: AGHT+IEsL4/cVnWNrBYjwwCCukncHtzbU0yREdljzMhunV9EREcLPzQx3wE0ZXCidnOmtEXTHQAHgw==
X-Received: by 2002:a19:ca0a:0:b0:510:d29:cf57 with SMTP id a10-20020a19ca0a000000b005100d29cf57mr94428lfg.33.1706296193280;
        Fri, 26 Jan 2024 11:09:53 -0800 (PST)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com. [209.85.167.47])
        by smtp.gmail.com with ESMTPSA id m15-20020a19520f000000b0051011f3c55asm260716lfb.100.2024.01.26.11.09.52
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Jan 2024 11:09:52 -0800 (PST)
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-51028acdcf0so845581e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 11:09:52 -0800 (PST)
X-Received: by 2002:a05:651c:b28:b0:2cd:fabd:1b9c with SMTP id
 b40-20020a05651c0b2800b002cdfabd1b9cmr179911ljr.70.1706296192000; Fri, 26 Jan
 2024 11:09:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAMuHMdXD0weO4oku8g2du6fj-EzxGaF+0i=zrPScSXwphFAZgg@mail.gmail.com>
 <20240122114743.7e46b7cb@gandalf.local.home> <CAHk-=wiq5mr+wSb6pmtt7QqBhQo_xr7ip=yMwQ5ryWVwCyMhfg@mail.gmail.com>
 <CAHk-=wjGxVVKvxVf=NDnMhB3=eQ_NMiEY3onG1wRAjJepig=aw@mail.gmail.com>
 <CAHk-=wiLqJYT2GGSBhKuJS-Uq1DVq3S32oP0SwqQiATuBivxcg@mail.gmail.com>
 <20240122144443.0f9cf5b9@gandalf.local.home> <20240125-deportation-sogenannten-2d57a7ce8f81@brauner>
 <20240125130731.3b0e2a42@gandalf.local.home> <20240125130821.0a1cd3a7@gandalf.local.home>
 <CAMuHMdU-+RmngWJwpHYPjVcaOe3NO37Cu8msLvqePdbyk8qmZA@mail.gmail.com>
 <20240126-wirksam-wenngleich-cd9573d8cb28@brauner> <20240126112551.6b8c0450@gandalf.local.home>
In-Reply-To: <20240126112551.6b8c0450@gandalf.local.home>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 26 Jan 2024 11:09:35 -0800
X-Gmail-Original-Message-ID: <CAHk-=whu43G8zdLwTLkshziaA8_N3+jZd9-a8HEjyagPDvZRNQ@mail.gmail.com>
Message-ID: <CAHk-=whu43G8zdLwTLkshziaA8_N3+jZd9-a8HEjyagPDvZRNQ@mail.gmail.com>
Subject: Re: [for-linus][PATCH 1/3] eventfs: Have the inodes all for files and
 directories all be the same
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Christian Brauner <brauner@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, 
	Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Al Viro <viro@zeniv.linux.org.uk>, Ajay Kaher <ajay.kaher@broadcom.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 26 Jan 2024 at 08:26, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Fri, 26 Jan 2024 11:11:39 +0100
> Christian Brauner <brauner@kernel.org> wrote:
>
> > The size would be one thing. The other is that tar requires unique inode
> > numbers for all files iirc (That's why we have this whole btrfs problem
> > - let's not get into this here -  where inode numbers aren't unique and
> > are duplicated per subvolume.).
>
> Well, I guess that answers Linus's question about wondering if there's any
> user space program that actually cares what the inodes are for files. The
> answer is "yes" and the program is "tar".

Well, the fact that it hits snapshots, shows that the real problem is
just "tar does stupid things that it shouldn't do".

Yes, inode numbers used to be special, and there's history behind it.
But we should basically try very hard to walk away from that broken
history.

An inode number just isn't a unique descriptor any more. We're not
living in the 1970s, and filesystems have changed.

              Linus

