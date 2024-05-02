Return-Path: <linux-kernel+bounces-166791-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E3B988B9F84
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 19:30:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D6C11F22FBD
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 17:30:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7367F16FF3D;
	Thu,  2 May 2024 17:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="DBnAz794"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A535016FF39
	for <linux-kernel@vger.kernel.org>; Thu,  2 May 2024 17:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714671014; cv=none; b=INnMyhMlvq4OurDw8mtGsrag3KZT5VpFNEAlHicEGMx1miEd5T/6eCWW7DVVjP15Z0hEArRukFkz15u7x93e+vEcxpLEwMoP0C37e3YygEHjIf0MtL071vGQh5kF6TNSo0w/AdYqFvBlhlK7wm/fHvlZAiJswk+CU2+jWcJ6Q7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714671014; c=relaxed/simple;
	bh=J2ZneBvOCmv6w7g5DfFYRHZ0EG8iANH8HJsLT/96dgY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=thOiYcsZa7f97yvWlfkiscTlFxWyY/3LDkkQmIH6WUCGmw0fenTKYhLVEWSbCLh9skuI8olzaFuKjtMjr4A4J5u5aqDAS5A/o4eKN/BVL/2ot/L973DaWWo5yXzYZoNghIB/APSpZRmPpm6GnZO/6z3kFUfsQWXRJi4w5H5syC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=DBnAz794; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a595199cb9bso295312366b.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2024 10:30:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1714671011; x=1715275811; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=al/XALPvGZ6wbzrZ3ZXTgtodLl0MJe+M6+JN32CWI4g=;
        b=DBnAz794yQjRTtVHHNPouRuBydlw8bShuJy6YPB8uK7do50ftdHT3lySKIkJxjKmq+
         BYGZuwAhI+z7/wxBWtgPqtjsF69rAL7BQ5NArXTdZtA+e6f3AKvygI9XMw1SN/rZ0LGz
         KFl4r70StG9WkAW9uEEdKwJmoAdbbh8Aaj8jg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714671011; x=1715275811;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=al/XALPvGZ6wbzrZ3ZXTgtodLl0MJe+M6+JN32CWI4g=;
        b=q3YXUQfMZaLRJuylMb+IjowPoP6Fgs1zB2J8JwJ+x1rOLT8gZa36Ahc0xMBFLgMEpZ
         2+XpZYQQaFn8VR3sKkYSE46b78TK083PXwcZA00aj2Ad5pdgNciElThO855YWZaPeZkT
         61ZdSgdxBhw/O8PVw4gfUbLryfgUz2LJC/dtWKf5lqTIXgIoGeX550mvAL10oVlnD7pZ
         CR5tlduabu9LG274jioAS7hjaJu6VBPkC94uMVwS4PxxpKLi9bnqC1fIPGAA/NSds36n
         yrbfsPWfEEBZsYK4RfLlWC3HhtPnzyZvWYCgtWePIrF72Q/tPBS8+lNBruvQZJrzW9XX
         516w==
X-Forwarded-Encrypted: i=1; AJvYcCU2lO2SVQ2DFUgd8NwomHMUhNcm/f1Ghc8Ct0/0EvKRQ75K5ZDMRsHUPIusYV7fUjobkECrtQM/577w53UDrICZI3I54QNGISXHRZbh
X-Gm-Message-State: AOJu0YwPkmXv+mVqZ35yAdynd2QrR6IOZDPc3V2IYBwYJftYqO7q6m3D
	SbwCHH2x8/sDtQyJbLBVY8PMMoWDuh6lB9ysu53KgvnAgvOAm1QfqVFEt8qxwDkpZRWjyxmRjhR
	hgnTigg==
X-Google-Smtp-Source: AGHT+IG1eGfqECsQpxJSwMZLLwGt8HuV0DGjXqhn+LjKpEDMihG+sv43Mx7xBO1LWhF+joCQ+V2m/A==
X-Received: by 2002:a50:9549:0:b0:572:78df:c606 with SMTP id v9-20020a509549000000b0057278dfc606mr72373eda.26.1714671010906;
        Thu, 02 May 2024 10:30:10 -0700 (PDT)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com. [209.85.218.46])
        by smtp.gmail.com with ESMTPSA id d17-20020a056402517100b0056fe755f1e6sm724906ede.91.2024.05.02.10.30.09
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 May 2024 10:30:10 -0700 (PDT)
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a596cb8a7dbso194866166b.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2024 10:30:09 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU95FeFqLu4RiyMRQus0crKp9QE/aEx1gXWPus5Cx6HrwROvlkv0Z9LfbSVM2nYlz8pjz9uL6NrEL7xNqL8OQCbxDdvR7Cxg2opR1PG
X-Received: by 2002:a17:906:4a09:b0:a59:6dc8:6e9 with SMTP id
 w9-20020a1709064a0900b00a596dc806e9mr105065eju.24.1714671009446; Thu, 02 May
 2024 10:30:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <8edbd558-a05f-c775-4d0c-09367e688682@I-love.SAKURA.ne.jp>
 <2023053048-saved-undated-9adf@gregkh> <18a58415-4aa9-4cba-97d2-b70384407313@I-love.SAKURA.ne.jp>
 <CAHk-=wgSOa_g+bxjNi+HQpC=6sHK2yKeoW-xOhb0-FVGMTDWjg@mail.gmail.com>
 <a3be44f9-64eb-42e8-bf01-8610548a68a7@I-love.SAKURA.ne.jp>
 <CAHk-=wj6HmDetTDhNNUNcAXZzmCv==oHk22_kVW4znfO-HuMnA@mail.gmail.com>
 <CANpmjNN250UCxsWCpUHAvJo28Lzv=DN-BKTmjEpcLFOCA+U+pw@mail.gmail.com>
 <CAHk-=whnQXNVwuf42Sh2ngBGhBqbJjUfq5ux6e7Si_XSPAt05A@mail.gmail.com>
 <d4de136e-c4e0-45c2-b33e-9a819cb3a791@paulmck-laptop> <CAHk-=wi3iondeh_9V2g3Qz5oHTRjLsOpoy83hb58MVh=nRZe0A@mail.gmail.com>
 <892324fc-9b75-4e8a-b3b6-cf3c5b4c3506@paulmck-laptop> <CANpmjNOY=Qpm3hBu-eN4Xk8n-2VXQRvcQ3_PfwPwNw9MmC8ctw@mail.gmail.com>
 <CAHk-=whTakjVGgBC5OtoZ5Foo=hd4-g+NZ79nkMDVj6Ug7ARKQ@mail.gmail.com>
 <CANpmjNNo_jyTPrgPVCeSfgvsX-fK8x0H81zbBA6LZMVNodO6GA@mail.gmail.com> <b13ab60e-503a-4c11-8a99-0ccccce33c6c@I-love.SAKURA.ne.jp>
In-Reply-To: <b13ab60e-503a-4c11-8a99-0ccccce33c6c@I-love.SAKURA.ne.jp>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 2 May 2024 10:29:52 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi_QBG68QshO1e-xK-jt0ZFsMpZczEJe4nQMu+U7q_7EQ@mail.gmail.com>
Message-ID: <CAHk-=wi_QBG68QshO1e-xK-jt0ZFsMpZczEJe4nQMu+U7q_7EQ@mail.gmail.com>
Subject: Re: [PATCH v3] tty: tty_io: remove hung_up_tty_fops
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: Marco Elver <elver@google.com>, paulmck@kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Dmitry Vyukov <dvyukov@google.com>, 
	syzbot <syzbot+b7c3ba8cdc2f6cf83c21@syzkaller.appspotmail.com>, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	Nathan Chancellor <nathan@kernel.org>, Arnd Bergmann <arnd@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	Jiri Slaby <jirislaby@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 2 May 2024 at 09:42, Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
>
> OK if below change is acceptable.
>
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -1012,7 +1012,7 @@ struct file {
>         struct file_ra_state    f_ra;
>         struct path             f_path;
>         struct inode            *f_inode;       /* cached value */
> -       const struct file_operations    *f_op;
> +       const __data_racy struct file_operations   *f_op;

No, this is very wrong.

It's not the *pointer* that is __data_racy. It's the structure *fied*.

So that should be

        const struct file_operations   *__data_racy f_op;

which is very different.

> Hmm, debugfs assumes that f_op does not change?
>
> fs/debugfs/file.c: In function 'full_proxy_release':
> fs/debugfs/file.c:357:45: warning: initialization discards 'volatile' qualifier from pointer target type [-Wdiscarded-qualifiers]
>   const struct file_operations *proxy_fops = filp->f_op;
>                                              ^~~~

This error is a direct result of placing the __data_racy in the wrong place.

It's not that the _result_ of reading filp->f_op is racy. It's the
read of filp->f_op itself that is.

Yes, this is unusual. The *common* thing is to mark pointers as being
volatile. But this really is something entirely different from that.

               Linus

