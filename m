Return-Path: <linux-kernel+bounces-166741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 00CF58B9ECA
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 18:43:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 322921C2266C
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 16:43:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74136664DB;
	Thu,  2 May 2024 16:43:07 +0000 (UTC)
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3FF428FC
	for <linux-kernel@vger.kernel.org>; Thu,  2 May 2024 16:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714668187; cv=none; b=tpTpPjd3ek/PaMsRRBQWugzCPMvtnjGcPpx7zDyljf/1dBdZW1WzTgRXsAR8AQ6NzmJ9ixsuyDnd5gcxbdPYU40hEN5eCT1MdTgSe8is5DAWKWdQl3BggQU9IWIQQwF0iDhe0qQmtYh/KUtnCL5ff+IexwUkMKd0Oz2hxFjZ/KI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714668187; c=relaxed/simple;
	bh=nDCteMAo7TB7jOqFNL8Pl2VdYrsWy9L3aMTAc4Aka7I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VSJiVOBdVj9mZNxuj2MTAXeQb5q394MKjFcZpBtaRbgOFTv2sdNOsFkmhfmLVGn6yK/VPZFiZpJcW89AjkK8yD8Erhifoae1RJtgz7qGtsUGNPfxrTbLRxWOxsB+e55RiVRBCZFhuF+2kqz6jWO98eiPQZyZ5YkahK16lKZAYKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from fsav116.sakura.ne.jp (fsav116.sakura.ne.jp [27.133.134.243])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 442GgFuK015746;
	Fri, 3 May 2024 01:42:15 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav116.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav116.sakura.ne.jp);
 Fri, 03 May 2024 01:42:15 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav116.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 442GgFtk015742
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Fri, 3 May 2024 01:42:15 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <b13ab60e-503a-4c11-8a99-0ccccce33c6c@I-love.SAKURA.ne.jp>
Date: Fri, 3 May 2024 01:42:12 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] tty: tty_io: remove hung_up_tty_fops
To: Marco Elver <elver@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc: paulmck@kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        syzbot <syzbot+b7c3ba8cdc2f6cf83c21@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        Nathan Chancellor <nathan@kernel.org>, Arnd Bergmann <arnd@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>, Jiri Slaby <jirislaby@kernel.org>
References: <8edbd558-a05f-c775-4d0c-09367e688682@I-love.SAKURA.ne.jp>
 <2023053048-saved-undated-9adf@gregkh>
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
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <CANpmjNNo_jyTPrgPVCeSfgvsX-fK8x0H81zbBA6LZMVNodO6GA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024/05/02 23:14, Marco Elver wrote:
> I sent a patch to add the type qualifier - in a simple test I added it
> does what we want:
> https://lore.kernel.org/all/20240502141242.2765090-1-elver@google.com/T/#u

Want some updates to Documentation/process/volatile-considered-harmful.rst
because __data_racy is for patches to add volatile variables ?

  Patches to remove volatile variables are generally welcome - as long as
  they come with a justification which shows that the concurrency issues have
  been properly thought through.

> 
> I'll leave it to Tetsuo to amend the original patch if __data_racy makes sense.

OK if below change is acceptable.

--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1012,7 +1012,7 @@ struct file {
        struct file_ra_state    f_ra;
        struct path             f_path;
        struct inode            *f_inode;       /* cached value */
-       const struct file_operations    *f_op;
+       const __data_racy struct file_operations   *f_op;

        u64                     f_version;
 #ifdef CONFIG_SECURITY

Hmm, debugfs assumes that f_op does not change?

fs/debugfs/file.c: In function 'full_proxy_release':
fs/debugfs/file.c:357:45: warning: initialization discards 'volatile' qualifier from pointer target type [-Wdiscarded-qualifiers]
  const struct file_operations *proxy_fops = filp->f_op;
                                             ^~~~


