Return-Path: <linux-kernel+bounces-31961-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8995783545C
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 04:48:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F6301F21A56
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 03:48:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E161B360BA;
	Sun, 21 Jan 2024 03:48:47 +0000 (UTC)
Received: from mail115-100.sinamail.sina.com.cn (mail115-100.sinamail.sina.com.cn [218.30.115.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAE34394
	for <linux-kernel@vger.kernel.org>; Sun, 21 Jan 2024 03:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705808927; cv=none; b=owIIGG7HwP+yyWStna4j+tqqhVnjuZMSwCJI8U+0SH88DVaEfiHd1RUQlzuuru+KALkP1t7k5gEKIKEbe9DCsT75aASFsIwco2DRq3zZwcesQqnvPIVNmm+ueF688ja6AxP4uD0NuOZSSAOp+DzPxMn60EjnLGLbFmIBqEejU8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705808927; c=relaxed/simple;
	bh=NeXNOLXa+KSwKAx108/YJBWDHFBEoDCvggAEIN0WvxU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YNYjRl7aekxfYknsEckWRE9y/YsP0AXkT/YECLT/vx1FDp1KBPn8jFlarat9Wnr1lSorbnagXdeGl1aQ9QOqLkWU7jwcMYQSLmVpnMazWhGsd1y2u7g+kMzCx/QW6SqfOHkTagAw/YPARvqw474ViSwIOAe0TEiunt+S+86YMPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.115.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([116.24.10.125])
	by sina.com (172.16.235.24) with ESMTP
	id 65AC940B00004907; Sun, 21 Jan 2024 11:48:30 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 82941045089336
X-SMAIL-UIID: B8F0E85540F94D2AA2082D91544C97C6-20240121-114830-1
From: Hillf Danton <hdanton@sina.com>
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: syzbot <syzbot+06fa1063cca8163ea541@syzkaller.appspotmail.com>,
	syzkaller-bugs@googlegroups.com,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org,
	linux-serial <linux-serial@vger.kernel.org>
Subject: Re: [PATCH] tty: vt: check for atomic context in con_write()
Date: Sun, 21 Jan 2024 11:48:17 +0800
Message-Id: <20240121034817.2280-1-hdanton@sina.com>
In-Reply-To: <9cd9d3eb-418f-44cc-afcf-7283d51252d6@I-love.SAKURA.ne.jp>
References: <00000000000039f237060f354ef7@google.com> <83414cb6-df16-4b6d-92e3-d54d22ba26cc@I-love.SAKURA.ne.jp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat, 20 Jan 2024 19:34:02 +0900 Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> syzbot is reporting sleep in atomic context, for gsmld_write() is calling
> con_write() with spinlock held and IRQs disabled.

..

> --- a/drivers/tty/vt/vt.c
> +++ b/drivers/tty/vt/vt.c
> @@ -2856,7 +2856,7 @@ static int do_con_write(struct tty_struct *tty, const u8 *buf, int count)
>  	struct vt_notifier_param param;
>  	bool rescan;
>  
> -	if (in_interrupt())
> +	if (in_interrupt() || irqs_disabled())
>  		return count;
>  
>  	console_lock();

Given console_lock(), no sense could be made by calling do_con_write()
with spin lock held at the first place, regardless irq.

> @@ -3314,7 +3314,7 @@ static void con_flush_chars(struct tty_struct *tty)
>  {
>  	struct vc_data *vc;
>  
> -	if (in_interrupt())	/* from flush_to_ldisc */
> +	if (in_interrupt() || irqs_disabled()) /* from flush_to_ldisc */
>  		return;
>  
>  	/* if we race with con_close(), vt may be null */
> -- 
> 2.18.4

