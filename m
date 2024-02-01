Return-Path: <linux-kernel+bounces-48615-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C7CC845EDE
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 18:49:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E9EA7B29BA9
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 17:49:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5900B7C6E1;
	Thu,  1 Feb 2024 17:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="PJ+teQ/7"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86BCA7C6DA
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 17:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706809736; cv=none; b=oGfT35H0+GNA0zmDNgRFwb8XHQ4hwISceKj70eELmIdKKj0tu2j06NCetNycKSJXYQwKchDCMnbWIqNf6rDfbHtTm4x1i7jU8ved7X8C81eT0OXHPvN7BCkou2qHkW730XBxN+T7tkSIgmjFpFF8DB5XjJD2fNrhtIxX6ks+A00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706809736; c=relaxed/simple;
	bh=Grgjp5eNCkIOqriHl4Vdp4WOeqDo3ixIM5+oKQyWaZo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iBi33fupgjEUUZJRdvj5/HI4e1ezkpALmCqSgLvmBcr5cOOLgBGwh1Xyb44c5S7fWLWVyQzWCYbNUEAVz2n6zbCR1KMwqk76k+zbW9EIcku/pia8oAKYhxg41nw0ZWBOEJ2oMyazRO5+c/0bve5Wj7kp241meBRMlCTDoFq7Zz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=PJ+teQ/7; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-55faa1e3822so1673921a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Feb 2024 09:48:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1706809732; x=1707414532; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=p1AVzZb0NYW5XZP6aUzDR5tG81geNwdMzzdRW+0+Img=;
        b=PJ+teQ/7o8eRX2hdhyG2FyPpKaTaaTrzhYClR0jlXTgzwhBxrJT9yFjzS3nsheOm3B
         /deChve6FW8eoPkYJquJg8QpUmJX0AgxWTPwY0J9HxFf3Spf4ofSXwT1sczs/2SwnWUB
         noumZTKpSqh5Qy+jr2eg4w1oPGi5l/hV8Wh8c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706809732; x=1707414532;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p1AVzZb0NYW5XZP6aUzDR5tG81geNwdMzzdRW+0+Img=;
        b=q5HkQcsmO9t4GJeMNaJCtkVW07TbLq7bneLr0px1aGSIVMQtX1WcnW+K7SYMZ2NpYI
         nTCcnf+Os2cyEQLt/kFjGZQtBpKCpf3TRqinG2kuAxdZginwei50bB/HTQoWafM/UsNp
         uDXkB9BaySjYhsxWMy6BR523tD9yRZ7d/nUZCxq/lr2lpvuOZ4bx/JeuqBbRMbelrcby
         7WgzGZMCuYEf1/bUsKybQOdrQ61ee5l+m6+KmhXqnCl82unnubgl9vUvLhOY8UQuz78j
         /xhG+X4TkGxICBQ40I/8+IHbI5TX/Wt6K7AQ/kX3yXMHgXVRhpU0J7SWyEbLNZMzZ9uO
         pgQw==
X-Gm-Message-State: AOJu0YxsPKFBzLhzG+B8krzD/prc2yjF4cKiBlFoytuCSOoElHSLZCJK
	M2F3kmSIPlxke30F/W6PKdexIW/Kp/N0WKZWtuHrCQ8mm2rrKQyq0JgV8ZYe+d2x5enE2ES3H58
	5zHfBdw==
X-Google-Smtp-Source: AGHT+IGPsPbSGcQwWesm4R+3xJC3nt7sOSL8AD3Te2xo8yFNqK25YY5S9CZBMqbG9D4n3e96AE8rUw==
X-Received: by 2002:a17:906:24ca:b0:a36:c327:9a9b with SMTP id f10-20020a17090624ca00b00a36c3279a9bmr1775195ejb.12.1706809732248;
        Thu, 01 Feb 2024 09:48:52 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXg90sWYsUu6cgGGbXnvsq/02zAYOqsMw0AsSifqOThqaNY3NdeEYF/G7g6YiXWlw1185s8ZYK6IIGdg50L8f/Yx2xeRY3DjUIn4STL
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com. [209.85.208.52])
        by smtp.gmail.com with ESMTPSA id vi18-20020a170907d41200b00a353bfdd411sm16767ejc.59.2024.02.01.09.48.51
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Feb 2024 09:48:51 -0800 (PST)
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-55f15762840so1458728a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Feb 2024 09:48:51 -0800 (PST)
X-Received: by 2002:aa7:d6d1:0:b0:55f:1a79:8b8d with SMTP id
 x17-20020aa7d6d1000000b0055f1a798b8dmr3775037edr.3.1706809731384; Thu, 01 Feb
 2024 09:48:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240201-exception_ip-v1-0-aa26ab3ee0b5@flygoat.com>
In-Reply-To: <20240201-exception_ip-v1-0-aa26ab3ee0b5@flygoat.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 1 Feb 2024 09:48:34 -0800
X-Gmail-Original-Message-ID: <CAHk-=whUp8cDxLr3EKZ1e-83+MJcazjtmpjmXGG-Y+7xvRqoRg@mail.gmail.com>
Message-ID: <CAHk-=whUp8cDxLr3EKZ1e-83+MJcazjtmpjmXGG-Y+7xvRqoRg@mail.gmail.com>
Subject: Re: [PATCH 0/3] Handle delay slot for extable lookup
To: Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: Oleg Nesterov <oleg@redhat.com>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	Andrew Morton <akpm@linux-foundation.org>, Ben Hutchings <ben@decadent.org.uk>, 
	linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mips@vger.kernel.org, linux-mm@kvack.org, 
	Xi Ruoyao <xry111@xry111.site>
Content-Type: text/plain; charset="UTF-8"

On Thu, 1 Feb 2024 at 07:46, Jiaxun Yang <jiaxun.yang@flygoat.com> wrote:
>
>  arch/alpha/include/asm/ptrace.h        | 1 +
>  arch/arc/include/asm/ptrace.h          | 1 +
>  arch/arm/include/asm/ptrace.h          | 1 +
>  arch/csky/include/asm/ptrace.h         | 1 +
>  arch/hexagon/include/uapi/asm/ptrace.h | 1 +
>  arch/loongarch/include/asm/ptrace.h    | 1 +
>  arch/m68k/include/asm/ptrace.h         | 1 +
>  arch/microblaze/include/asm/ptrace.h   | 3 ++-
>  arch/mips/include/asm/ptrace.h         | 2 ++
>  arch/mips/kernel/ptrace.c              | 7 +++++++
>  arch/nios2/include/asm/ptrace.h        | 3 ++-
>  arch/openrisc/include/asm/ptrace.h     | 1 +
>  arch/parisc/include/asm/ptrace.h       | 1 +
>  arch/s390/include/asm/ptrace.h         | 1 +
>  arch/sparc/include/asm/ptrace.h        | 2 ++
>  arch/um/include/asm/ptrace-generic.h   | 1 +
>  mm/memory.c                            | 4 ++--
>  17 files changed, 28 insertions(+), 4 deletions(-)

The only user right now is mm/memory.c, and it doesn't even include
<asm/ptrace.h>, but instead does the proper thing and includes
<linux/ptrace.h>

So please make <linux/ptrace.h> just do

     #ifndef exception_ip
        #define exception_ip(x) instruction_pointer(x)
    #endif

and all those non-MIPS architecture updates should just go away, and
the diffstat should look something like

  arch/mips/kernel/ptrace.c          | 7 +++++++
  include/linux/ptrace.h             | 4 ++++
  mm/memory.c                        | 4 ++--

instead.

                  Linus

