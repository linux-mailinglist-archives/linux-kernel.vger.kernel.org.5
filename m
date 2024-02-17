Return-Path: <linux-kernel+bounces-69910-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 63EE1859023
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 15:43:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8EFAC1C212E0
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 14:43:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1740F7C080;
	Sat, 17 Feb 2024 14:43:23 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45176149E03
	for <linux-kernel@vger.kernel.org>; Sat, 17 Feb 2024 14:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708181002; cv=none; b=u9+omqYngX4XtQ/G68DPusR1wygjW+WeLOOdiID05Xr+dmoQZbJEqwM9WP9IMjC4oGfa4Hh8sshT1NT4SfL4azIdGcczw43tq74cW5wU7dwz3AeGtiY8v06pRKJVthk/r1C5dXRcRNiF05sLsZ470hoP56Y0Zsd6pZp+PiHOiWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708181002; c=relaxed/simple;
	bh=TZ0y3aVpF7C8KltuvmbMmwIVNNDanpPi2S/HXQ/ocSg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=aUJObxwqQxt2yLa0y1QpMFawUNcS7Pj8HtaNQn8b9mhB0mhjYgbfJsIlVfDF3l++cBKjR1aHypkpiJmMwH35k+451wVtC+lQSVwuJnxh6DIop+rz3cTgqwEWxar/gsXvugOClQjkFE2Z/aKZjSrg51wkSHoQp5plIlg3K25wxvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-365032b8456so15537135ab.2
        for <linux-kernel@vger.kernel.org>; Sat, 17 Feb 2024 06:43:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708181000; x=1708785800;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yxgwFaGmbKW0ehKsu3OuuZK9A0Cvn9rXai+nVeD7el0=;
        b=acIqiDKwX6GgZmcbhYMsoEthEsAVIruT7/hNPX/7oCwoKJcfhZU8kR7INQWXeNajbp
         mxV1fZ9XGolWlsOWtA9fObAgzErO9gYjv2ZGR90CvlYSmC7OAojIB5Zk3ceNXOlu/TDt
         CRUXCtudkMJQsm1WRRMBER1NeIxaFt2gNcvsrPQ/kTL8S3PZLULFtWFI9rcUn9mb0iFp
         vQ9b6KWfBAvRT/HVI0dI65DetRyEu6yUrrevPDpAr/p1xSWZnf1+soqzmB4wvHCyXN0t
         hQcBs7IUBpHlTjitDIKOTXuZly5H5Iq9VIUga2ZDnYu0XmQde8RKt0ywven8WvEz+D3V
         J1iA==
X-Forwarded-Encrypted: i=1; AJvYcCXSjbqtM9M4RSJyG0KVK+kmzYRbYpLYW/cLmnOcA6jqVwheRCiJVw/ECaNYJo+6NdFMwj7YX7NtOASBMM7HrLKKLxO62u4FvzfdrJeP
X-Gm-Message-State: AOJu0YxDk/YuLqahS8SnCVpdW9vKE8+y/+o5Au5gq+ZW7dtmRZ6aEo61
	vf2zzh+A6ugBNUbpS4DHeI7HzSs5XcnEveC6r9mafgKO6VL7/Y6TyetMBP/pH4LXbtwuwfOJh6x
	CerP1Lu1xqQGDMwff2L5ZNdOCURfl5UCYiC1Ia9Zse/nhPgYFKS78gbk=
X-Google-Smtp-Source: AGHT+IEXudJDz0MH8FXd1pGgCXpaAHIRzjRJSsYg6KQ6WpCUKtpUNoBRASEYMQ8w7x89DyTfq6RJ/YDIaU3sKSuIUZx8y3p63EZg
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c89:b0:363:c3d9:c10 with SMTP id
 w9-20020a056e021c8900b00363c3d90c10mr581820ill.0.1708181000518; Sat, 17 Feb
 2024 06:43:20 -0800 (PST)
Date: Sat, 17 Feb 2024 06:43:20 -0800
In-Reply-To: <CAHpthZojFipy1QVY=61vbBD6s6QdJdoNmQdTo90a=JixHA-V5g@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000bf86ff061194e1ba@google.com>
Subject: Re: [PATCH] net: Fix kernel-infoleak in __skb_datagram_iter (2)
From: syzbot <syzbot+34ad5fab48f7bf510349@syzkaller.appspotmail.com>
To: ryasuoka@redhat.com
Cc: ryasuoka@redhat.com, syzkaller-bugs@googlegroups.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> #syz test git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git

want either no args or 2 args (repo, branch), got 1

> 9f8413c4a66f
>
> diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
> index 27998f73183e..c7bf1c38b292 100644
> --- a/include/linux/skbuff.h
> +++ b/include/linux/skbuff.h
> @@ -2532,6 +2532,11 @@ static inline unsigned char
> *skb_tail_pointer(const struct sk_buff *skb)
>   return skb->head + skb->tail;
>  }
>
> +static inline unsigned int skb_tail_offset(const struct sk_buff *skb)
> +{
> + return skb->tail;
> +}
> +
>  static inline void skb_reset_tail_pointer(struct sk_buff *skb)
>  {
>   skb->tail = skb->data - skb->head;
> @@ -2549,6 +2554,11 @@ static inline unsigned char
> *skb_tail_pointer(const struct sk_buff *skb)
>   return skb->tail;
>  }
>
> +static inline unsigned int skb_tail_offset(const struct sk_buff *skb)
> +{
> + return skb->tail - skb->head;
> +}
> +
>  static inline void skb_reset_tail_pointer(struct sk_buff *skb)
>  {
>   skb->tail = skb->data;
> diff --git a/net/netlink/af_netlink.c b/net/netlink/af_netlink.c
> index eb086b06d60d..f11bb308f1ed 100644
> --- a/net/netlink/af_netlink.c
> +++ b/net/netlink/af_netlink.c
> @@ -167,7 +167,7 @@ static inline u32 netlink_group_mask(u32 group)
>  static struct sk_buff *netlink_to_full_skb(const struct sk_buff *skb,
>      gfp_t gfp_mask)
>  {
> - unsigned int len = skb_end_offset(skb);
> + unsigned int len = skb_tail_offset(skb);
>   struct sk_buff *new;
>
>   new = alloc_skb(len, gfp_mask);
>

