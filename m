Return-Path: <linux-kernel+bounces-167081-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 538598BA43E
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 01:54:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E45941F213E0
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 23:54:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30CD3158878;
	Thu,  2 May 2024 23:54:45 +0000 (UTC)
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75EF01C683
	for <linux-kernel@vger.kernel.org>; Thu,  2 May 2024 23:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714694084; cv=none; b=omjPlJAQMHgY1Gm3SRygAgx26xnF5iIFz7bjQhrr5JOazGUE7tAX4UkjBAnne8ukqRhDCeF3Jjx9SO+1NXNEYx2w5hLqv2tL1DB/66vokEErDlvOmCxf+C+T+IEObryfOmP0d7GtT7v57okwzrabmXlWhHZfdeDyGUE9rp/xPwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714694084; c=relaxed/simple;
	bh=R7zvqIEVHCQucEkuQis7KHQ9EfpPJDpzAXpo8fb2NtI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DVMFeSBQfDwnPn51BaOKhd9bnbMVyONZ9KiC8zm31TWWK8c6Nt9nYsNyQuvxqqirm5Gzv/mkz8731V/sDXPoS0rJ3tVltHzzsxkmwdTwAsTNpvp+u7FKZTQgldP/dD4g0crYqGXuR0mjLN1Thg3LvZ/KyQIRGnduxvROdq+7b30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from fsav313.sakura.ne.jp (fsav313.sakura.ne.jp [153.120.85.144])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 442NsBtJ085623;
	Fri, 3 May 2024 08:54:11 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav313.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav313.sakura.ne.jp);
 Fri, 03 May 2024 08:54:11 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav313.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 442NsAgW085620
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Fri, 3 May 2024 08:54:11 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <5125d9ac-32d5-476d-82cc-b57d4e5d0807@I-love.SAKURA.ne.jp>
Date: Fri, 3 May 2024 08:54:10 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] tty: tty_io: remove hung_up_tty_fops
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Marco Elver <elver@google.com>, paulmck@kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        syzbot <syzbot+b7c3ba8cdc2f6cf83c21@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        Nathan Chancellor <nathan@kernel.org>, Arnd Bergmann <arnd@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>, Jiri Slaby <jirislaby@kernel.org>
References: <8edbd558-a05f-c775-4d0c-09367e688682@I-love.SAKURA.ne.jp>
 <18a58415-4aa9-4cba-97d2-b70384407313@I-love.SAKURA.ne.jp>
 <CAHk-=wgSOa_g+bxjNi+HQpC=6sHK2yKeoW-xOhb0-FVGMTDWjg@mail.gmail.com>
 <a3be44f9-64eb-42e8-bf01-8610548a68a7@I-love.SAKURA.ne.jp>
 <CAHk-=wj6HmDetTDhNNUNcAXZzmCv==oHk22_kVW4znfO-HuMnA@mail.gmail.com>
 <CANpmjNN250UCxsWCpUHAvJo28Lzv=DN-BKTmjEpcLFOCA+U+pw@mail.gmail.com>
 <CAHk-=whnQXNVwuf42Sh2ngBGhBqbJjUfq5ux6e7Si_XSPAt05A@mail.gmail.com>
 <d4de136e-c4e0-45c2-b33e-9a819cb3a791@paulmck-laptop>
 <CAHk-=wi3iondeh_9V2g3Qz5oHTRjLsOpoy83hb58MVh=nRZe0A@mail.gmail.com>
 <892324fc-9b75-4e8a-b3b6-cf3c5b4c3506@paulmck-laptop>
 <CANpmjNOY=Qpm3hBu-eN4Xk8n-2VXQRvcQ3_PfwPwNw9MmC8ctw@mail.gmail.com>
 <CAHk-=whTakjVGgBC5OtoZ5Foo=hd4-g+NZ79nkMDVj6Ug7ARKQ@mail.gmail.com>
 <CANpmjNNo_jyTPrgPVCeSfgvsX-fK8x0H81zbBA6LZMVNodO6GA@mail.gmail.com>
 <b13ab60e-503a-4c11-8a99-0ccccce33c6c@I-love.SAKURA.ne.jp>
 <CAHk-=wi_QBG68QshO1e-xK-jt0ZFsMpZczEJe4nQMu+U7q_7EQ@mail.gmail.com>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <CAHk-=wi_QBG68QshO1e-xK-jt0ZFsMpZczEJe4nQMu+U7q_7EQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024/05/03 2:29, Linus Torvalds wrote:
>> Hmm, debugfs assumes that f_op does not change?
>>
>> fs/debugfs/file.c: In function 'full_proxy_release':
>> fs/debugfs/file.c:357:45: warning: initialization discards 'volatile' qualifier from pointer target type [-Wdiscarded-qualifiers]
>>   const struct file_operations *proxy_fops = filp->f_op;
>>                                              ^~~~
> 
> This error is a direct result of placing the __data_racy in the wrong place.

Oops. But it seems to me that the problem is that

> 
> It's not that the _result_ of reading filp->f_op is racy. It's the
> read of filp->f_op itself that is.

debugfs (or maybe any filesystems that wraps f_op) caches filp->f_op into
private data

  struct debugfs_fsdata {
      const struct file_operations *real_fops; // <= may not be up to dated?
      (...snip...)
  }

and cannot update cached real_fops value when

	filp->f_op = &hung_up_tty_fops;

or

	mfile->file->f_op = &snd_shutdown_f_ops;

is called.

Such filesystems need to be updated to cache "struct file *" rather than
"struct file_operations *" ?


