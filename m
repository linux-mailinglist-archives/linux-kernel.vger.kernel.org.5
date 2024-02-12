Return-Path: <linux-kernel+bounces-61691-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD338851569
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 14:38:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72057286534
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 13:38:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 491D04C622;
	Mon, 12 Feb 2024 13:28:39 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3046238FB2
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 13:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707744518; cv=none; b=l0znpGGDyL4ZIkAC5ihghHLs+YD8TNrGb7yJk4v+qm4yZaO77wJxUnSvICWc82mlbN1UmfrlfI1SdCfNXjXL4OBDutaFI+uaue8m0gJub3SLO6DcvYq//4yVVP7b13zKLBt64aQzBKf00/gDNNx7twjpnAS+Zj7emUH48AEJNxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707744518; c=relaxed/simple;
	bh=f73SHcPfM2QhZLAtN0ksmvdhsF8obYYxUIXVCxv/EAI=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=Nq7tdg9Al7CSeNkF8M2bGlEq4T7v0QfhKfco+zXGNONSw0BEDXJeprNFce5yh09c2fKYgForRT0eu28Lp3NsJDyAHFGB5hTYpWKyOOFxPTZYP2gjkrX66csgcfX8qGhZ8BoQQClPyRneBPgXok+A3tC4ytnfshoZJv/IQYb4chI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-363be7d5b20so31867995ab.3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 05:28:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707744516; x=1708349316;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ObKSC16eAptSqU30mun4surYToSSq3dApxjAL/tX6gw=;
        b=ZLUjxvVmtr0z8iH1oCtcZtX1tJDdSgCJ/o8znwAmE4RW7A0b47/rD5NyZh8wXrrREU
         LjzYDlrTUOCGlt0Y0WVCFDU8oeNj69LqVmgiapHpRI9d64nZTrPFfrTLvGl8cs0uoNbh
         4bedRVcN8PMs5VQJ2ytHyK+eyNWIdh4wYTbDLANQ/q67ZufhFN/e/tl8crR2wg2egCfl
         HtWmrv3GQW519SXLlNiLRb3kL8sUVCZJYoqrLcBFxmo4nFGW+2MIcuXP68L0czh9WLY7
         32dqJeDYWsAv6QMrCgqnj79MITxoJG3rINcfhPQwkI+8OlpootqpJUgiWNScuQQ4yu69
         NgKA==
X-Forwarded-Encrypted: i=1; AJvYcCWr1SHTCufS9Vxxg0kUCl5MQLXYJ2+r0VGzGB2TEyPM1ngkl9f4u8uwe2YdXLmgzlQiXkS8B2hlrjxiYAB/dESnmcIo+t2DS/g0C19H
X-Gm-Message-State: AOJu0YyFMjJwWxaYSU0qv6WfMbJmF6Br3H8Df9nwZAVmdX1NYFXYGIL5
	wbdlV3Jm6HQEuSXnO9J/7mEOtLODTu9gYI68wm/Nu3Q+EKKzqbRYRY1KxlL77X5htGrNbr2cJl/
	7TkDNwHYYffVcS2XQ4YHQ4FXS4x0hxxamimEMx8zEqmbXQrR/djQoozA=
X-Google-Smtp-Source: AGHT+IHfkrFFxnp5qczPid0DMB6lHfZKxsUkP/JbTv6q6YSpbuczYG9H2u4I3KdB22kZsZNI292eWhtMsSwySB1BsAlvWTGzM3qO
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12c7:b0:363:7b86:21bd with SMTP id
 i7-20020a056e0212c700b003637b8621bdmr612673ilm.4.1707744516291; Mon, 12 Feb
 2024 05:28:36 -0800 (PST)
Date: Mon, 12 Feb 2024 05:28:36 -0800
In-Reply-To: <3281463.44csPzL39Z@ripper>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000042c47206112f4123@google.com>
Subject: Re: [syzbot] [batman?] BUG: soft lockup in sys_sendmsg
From: syzbot <syzbot+a6a4b5bb3da165594cff@syzkaller.appspotmail.com>
To: sven@narfation.org
Cc: a@unstable.cc, b.a.t.m.a.n@lists.open-mesh.org, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	mareklindner@neomailbox.ch, netdev@vger.kernel.org, pabeni@redhat.com, 
	sven@narfation.org, sw@simonwunderlich.de, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

> On Monday, 12 February 2024 11:26:24 CET syzbot wrote:
>> syzbot found the following issue on:
>> 
>> HEAD commit:    41bccc98fb79 Linux 6.8-rc2
>> git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
>> console output: https://syzkaller.appspot.com/x/log.txt?x=14200118180000
>> kernel config:  https://syzkaller.appspot.com/x/.config?x=451a1e62b11ea4a6
>> dashboard link: https://syzkaller.appspot.com/bug?extid=a6a4b5bb3da165594cff
>> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
>> userspace arch: arm64
>> 
>> Unfortunately, I don't have any reproducer for this issue yet.
>> 
>> Downloadable assets:
>> disk image: https://storage.googleapis.com/syzbot-assets/0772069e29cf/disk-41bccc98.raw.xz
>> vmlinux: https://storage.googleapis.com/syzbot-assets/659d3f0755b7/vmlinux-41bccc98.xz
>> kernel image: https://storage.googleapis.com/syzbot-assets/7780a45c3e51/Image-41bccc98.gz.xz
>> 
>> IMPORTANT: if you fix the issue, please add the following tag to the commit:
>> Reported-by: syzbot+a6a4b5bb3da165594cff@syzkaller.appspotmail.com
>> 
>
> #syz test

This crash does not have a reproducer. I cannot test it.

>
> From 5984ace8f8df7cf8d6f98ded0eebe7d962028992 Mon Sep 17 00:00:00 2001
> From: Sven Eckelmann <sven@narfation.org>
> Date: Mon, 12 Feb 2024 13:10:33 +0100
> Subject: [PATCH] batman-adv: Avoid infinite loop trying to resize local TT
>
> If the MTU of one of an attached interface becomes too small to transmit
> the local translation table then it must be resized to fit inside all
> fragments (when enabled) or a single packet.
>
> But if the MTU becomes too low to transmit even the header + the VLAN
> specific part then the resizing of the local TT will never succeed. This
> can for example happen when the usable space is 110 bytes and 11 VLANs are
> on top of batman-adv. In this case, at least 116 byte would be needed.
> There will just be an endless spam of
>
>    batman_adv: batadv0: Forced to purge local tt entries to fit new maximum fragment MTU (110)
>
> in the log but the function will never finish. Problem here is that the
> timeout will be halved in each step and will then stagnate at 0 and
> therefore never be able to reduce the table even more.
>
> There are other scenarios possible with a similar result. The number of
> BATADV_TT_CLIENT_NOPURGE entries in the local TT can for example be too
> high to fit inside a packet. Such a scenario can therefore happen also with
> only a single VLAN + 7 non-purgable addresses - requiring at least 120
> bytes.
>
> While this should be handled proactively when:
>
> * interface with too low MTU is added
> * VLAN is added
> * non-purgeable local mac is added
> * MTU of an attached interface is reduced
> * fragmentation setting gets disabled (which most likely requires dropping
>   attached interfaces)
>
> not all of these scenarios can be prevented because batman-adv is only
> consuming events without the the possibility to prevent these actions
> (non-purgable MAC address added, MTU of an attached interface is reduced).
> It is therefore necessary to also make sure that the code is able to handle
> also the situations when there were already incompatible system
> configurations present.
>
> Cc: stable@vger.kernel.org
> Fixes: a19d3d85e1b8 ("batman-adv: limit local translation table max size")
> Reported-by: syzbot+a6a4b5bb3da165594cff@syzkaller.appspotmail.com
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
>  net/batman-adv/translation-table.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
> index b95c36765d04..2243cec18ecc 100644
> --- a/net/batman-adv/translation-table.c
> +++ b/net/batman-adv/translation-table.c
> @@ -3948,7 +3948,7 @@ void batadv_tt_local_resize_to_mtu(struct net_device *soft_iface)
>  
>  	spin_lock_bh(&bat_priv->tt.commit_lock);
>  
> -	while (true) {
> +	while (timeout) {
>  		table_size = batadv_tt_local_table_transmit_size(bat_priv);
>  		if (packet_size_max >= table_size)
>  			break;
> -- 
> 2.39.2
>

