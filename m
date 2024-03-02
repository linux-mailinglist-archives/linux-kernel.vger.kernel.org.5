Return-Path: <linux-kernel+bounces-89472-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8378086F0D3
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 16:19:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B29B81C20FD9
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 15:19:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E631E1B7F1;
	Sat,  2 Mar 2024 15:19:06 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BF7A1B267
	for <linux-kernel@vger.kernel.org>; Sat,  2 Mar 2024 15:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709392746; cv=none; b=rKqTgTT07wDcWANn+SO1iWxMERSis3XNbVCnAkjcunyuvLwQDcWoWZ4GvX//+8HiosoGRM2Z77EwlACI1BLNN5MacBtmSd8hLQcBE+nF8bG6Ku/QEMVdn32QPqMaL8SL482wpaHJRWzD1JfNwO9qAbKXqypLcka5Ikqx00zlVWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709392746; c=relaxed/simple;
	bh=0ERln8J3TJYrJZ9bLSbjDBFctTDxyDIuAzme6cUygX0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=VgPzhWF7XceRI/I68XwZacQPdyN1W7Oa16t22lbhYaVijGOwi3QDINZcCKqTM/3OBZjW8vBVuWrv8PuNxaDTWuAeZ1khvSHV4tfHeD8CzdqrNPxFNKY/58zn2AUXQ3Yu9v8BMs1uC75whp9p3+LvYeYVSMGaXtUPip3c7Sh+Ii8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7c834655a6cso31199039f.1
        for <linux-kernel@vger.kernel.org>; Sat, 02 Mar 2024 07:19:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709392744; x=1709997544;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SKys6Rb7JLVGIs6D1784jC1UbdMEAMKrSUMf7HacXzg=;
        b=IuPVfbr9o6FYQtmQxYl23NI6ls6b+L1WK/bWveBD6XO0H7/3fdTyzzjbCqIbw6HuXn
         vUHbYMv2jGvilm6bsKhWjOGaOZGv4TrONHfunsbKvZ8QSxufS0Nrexyuk14NPQRjqHCA
         btU2MmyFIOynZc5HA9pyVvv+4EeGSCTKr+vSGfJs59Bbd0Ov4yNcwfDrgRtJC+xgki55
         5C+kYmk9n1X0g0UhZsuo2Ltej7IgPJJcoF0LyGpPWli15oUm3qYfGdMU9U2IORjPokSm
         dIL9g1RXSHlH07Y9bMHmxGh2Oj2VnxeFn9LCOZxUF6utQphFOnSOkAU7Gc5Ay9JbnBgQ
         tGJw==
X-Forwarded-Encrypted: i=1; AJvYcCW+4Alch1gN6aCKUoxVpjObtEucIZ4lYWDfnpGpx4wpVBfoFpuHhG7sx9u5X5SyDnHxvbr2ufF+FiwghKmRyLFQHWQTzk23fiVD6OFU
X-Gm-Message-State: AOJu0YwWOJJhH7oisvmm68CkNAVGcn2eabquLz0L3G6rFPBoOqH4XLyQ
	HJn3UwrdpIPX7ocXWnXFyERXlfBBE6KMZXDusHKI2jC/jpYmFFTz4ZMGk84YfiDScfUL4Xxz6TS
	mP6ECaiaNsUygqCEUJSeLGPb0NY7GZ1gOCUMLC9Dh8R2wkGaSzedkEVw=
X-Google-Smtp-Source: AGHT+IGkTiSt3QEIVLdLEE0FTfFUnV004RjlY3UrQMrn4cwFr1M4RyvOfudcJaPb7n0/yyMr8Ln2CdB5T2a49hZjH0muAVKtY/ri
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:809:b0:7c7:96d6:aeb5 with SMTP id
 z9-20020a056602080900b007c796d6aeb5mr31628iow.2.1709392744411; Sat, 02 Mar
 2024 07:19:04 -0800 (PST)
Date: Sat, 02 Mar 2024 07:19:04 -0800
In-Reply-To: <000000000000d40c3c05fdc05cd1@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004ff6580612af035e@google.com>
Subject: Re: [syzbot] [udf?] KASAN: slab-use-after-free Read in udf_free_blocks
From: syzbot <syzbot+0b7937459742a0a4cffd@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, axboe@kernel.dk, brauner@kernel.org, 
	eadavis@qq.com, hch@lst.de, jack@suse.com, jack@suse.cz, linkinjeon@gmail.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, syzkaller-bugs@googlegroups.com, willy@infradead.org
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 6f861765464f43a71462d52026fbddfc858239a5
Author: Jan Kara <jack@suse.cz>
Date:   Wed Nov 1 17:43:10 2023 +0000

    fs: Block writes to mounted block devices

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=11030516180000
start commit:   f8dba31b0a82 Merge tag 'asym-keys-fix-for-linus-v6.4-rc5' ..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=3c980bfe8b399968
dashboard link: https://syzkaller.appspot.com/bug?extid=0b7937459742a0a4cffd
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10bcb6b5280000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12fbcfd1280000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: fs: Block writes to mounted block devices

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

