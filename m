Return-Path: <linux-kernel+bounces-152156-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC03F8AB9F6
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 08:09:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 684E62816DF
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 06:09:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A8A9125C7;
	Sat, 20 Apr 2024 06:09:27 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C73BEED4
	for <linux-kernel@vger.kernel.org>; Sat, 20 Apr 2024 06:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713593366; cv=none; b=nvQ7UUidIGO5o803ujWTRdvMVlu5fbfCAsjyUUItM5F/u/BtPWBQnP2eEH9+S9nqkc+d/uZklIIE9cW+anq9fVzXtK1N6MdxHpIoNMDZGD6qe4KKuW9bVfriTFi1ibcaYZWxdnTE7w6zH1MOxnCEH5sBb87z8sxjP3kMh/9mKbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713593366; c=relaxed/simple;
	bh=YvORPu34qUfCvuW9YDmuHUpwtQJ9BEJqVuwhDkLUbGM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=BSRdMsaRu/c1oXOnwhBSmylG4MFHXYcA8ODUpr2yPXqD/9vwVIkw/nzKA3NGeNRqgkQwdWf91CPAfEar6mBKXsp6UYSL1M53Y2O3VByewV16G1JKHwG//d79WIeQP+j4sQP48CtCEa5KU/4WvVUZCkZY//ehUgSPQUB9raBhx54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-36a0f6b6348so36380105ab.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 23:09:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713593365; x=1714198165;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CSBrUKj2KXuFI1bsasQooiETjY8WhvG2rehRzAjNDzc=;
        b=SxGGNuEGh8z5IGZOUxsJfNrRsqKY6bAO3egHh4kCtNJf16aNWsF/quaR1qqcycJt25
         3Mf3fFHQHPaczjpVUEaXgG3Vgu5SP5YPWwia2dd3yj6q5Q0Wuw8b7STR6V9w8fi70FFx
         d1Bq9El10D1egnDuWP9Oq3QE3MzW0deRe9M5jEvTycwgQxR4+V/oos0SJ4uw1b/bk0xP
         OZ5IDBkTRP/qktwkpGBajpEno9/el8PIib9gU89VR7TjaTMsE2WA27bozi6EcqRMK4As
         I1V0tWIyt/XsKanBVZctklQu5l7qApZx87nVawzJe0bRwQfXVZREKBzFYP6Y/i6ZIbPo
         Q+Yw==
X-Forwarded-Encrypted: i=1; AJvYcCU2tpgDX5gKcRE9qHklomDzsHoKD8x60pTv+li3qYJFlkLb2IUDLQzNtu3knP6ipADoyd9mZ+oJ5RgysdrdsitsNzNs5Ns8okiUmLbC
X-Gm-Message-State: AOJu0Yzh509zU98ZT/1zeJaHFDXRvjn/pA9k91jQ/QHPyRibFg9e/Z4B
	DrjcEKUsoJQlbgpwdQTAv19PIL2Hx0743axYzG6yI7YIpbVGR/n2C0qrMz6PdHn23tzYyKW3DyU
	Ui3fw90THu2eHZ8oZkwFbY+TNR2nRro/STVN9a5Mn9U7hy4HzM/xfhvQ=
X-Google-Smtp-Source: AGHT+IHEuS+5G1A6tHnGKSWyJ8rV34djcXq4G09BKsVajg+GRqXrjWkjzYH+KW9yfFRM3TFM4ng5N5JqJzbinwbT/C12Y8z+NrkC
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:188d:b0:36a:3615:33e4 with SMTP id
 o13-20020a056e02188d00b0036a361533e4mr263090ilu.4.1713593364865; Fri, 19 Apr
 2024 23:09:24 -0700 (PDT)
Date: Fri, 19 Apr 2024 23:09:24 -0700
In-Reply-To: <20240420060919.62280-1-aha310510@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000cd73500616810b77@google.com>
Subject: Re: [syzbot] [hams?] possible deadlock in serial8250_console_write
From: syzbot <syzbot+8e03da5d64bc85098811@syzkaller.appspotmail.com>
To: aha310510@gmail.com
Cc: aha310510@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

> please test deadlock in serial8250_console_write
>
> #syz test git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master

This crash does not have a reproducer. I cannot test it.

>
> ---
>  drivers/net/ppp/ppp_async.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/net/ppp/ppp_async.c b/drivers/net/ppp/ppp_async.c
> index c33c3db3cc08..d12b8155e839 100644
> --- a/drivers/net/ppp/ppp_async.c
> +++ b/drivers/net/ppp/ppp_async.c
> @@ -134,11 +134,11 @@ static struct asyncppp *ap_get(struct tty_struct *tty)
>  {
>  	struct asyncppp *ap;
>  
> -	read_lock(&disc_data_lock);
> +	read_lock_irq(&disc_data_lock);
>  	ap = tty->disc_data;
>  	if (ap != NULL)
>  		refcount_inc(&ap->refcnt);
> -	read_unlock(&disc_data_lock);
> +	read_unlock_irq(&disc_data_lock);
>  	return ap;
>  }
>  
> -- 
> 2.34.1

