Return-Path: <linux-kernel+bounces-121979-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE64E88F026
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 21:32:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C42BA1C2C457
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 20:32:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A21FF1534EC;
	Wed, 27 Mar 2024 20:32:05 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF9EE152E12
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 20:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711571525; cv=none; b=kb1KxFWk1dazrpV31DQmtBYrcBPUcwOuIQKr5YjA4zs+2Hd97vlkk9Qdt2e2gi0YQwuUK/UKsZk2Ydo0VDNW5kR9Ly5fuOqh/GvBXV8jAmFMzMlyspwbWqajWaRI55z55psFOj5bgCTRUX36XdBD2wtQQIWKucW74VXppF3hR1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711571525; c=relaxed/simple;
	bh=nRwlE/hA+5kIdWWS/56V+tZqn6E78CxeZd1m1w7AwQ4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=NUY4uuF0lEdO8fVCjiGETWHWrZHZOYCxNFenEISyGoH2qdbl/zoqbO5CjCy6wNhgbW5DHm0J3NFRMrCMtc4x60+u+RzK3tvvG+HsFzu6q9lrCQfrlrJxatIiG7EJka+J3OXvWFZRkTQvAboqJ3MAfgZnC8L4dmAUlYD6DExhmmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7cc0a422d43so23714639f.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 13:32:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711571523; x=1712176323;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GrIQKBS2v/d7YU14An08GRjqL5ZRUdHZeXnpNFfQdUk=;
        b=icMuBb7K5F1xjovTxQUYmiblK2Ms5fSswmWeclUFnbUfTQ3GqBkt0YEuAyYWVEutUJ
         KIY0ccfyoaK7cbLoNbWhkb/xn+1ljaGBB3vX76C1YzAdb+wtuaWeLjPT7YTKIhdlNJVD
         uSaDN+xkT+BnIXIkF2s9Vje7YMbovgHS2zel0vlPHgyQKSsJRaBvM3z9+DoOdCN9uY0L
         8kccWx20RO56kzcAqdWo+Fzg4heQhKzpZjlSvc4el1zatHIY5/alVieEtfUAm6mcCi6b
         ZdoineelfxctuesTxsPW4o+BYUUaNqpd4n7g+dkr3N/ixNLAS1eowbGsezzwgsB+KiqB
         M3HQ==
X-Forwarded-Encrypted: i=1; AJvYcCXaO2C2oDqFsNe+5WnMRGrhmJhENlRd7ON/Ge2JSOASuOwYdPPOmuTzQJDJzN7I3diLkUepTmU5yCtR0u+rVEy9ScL2+REsbx4z/mF2
X-Gm-Message-State: AOJu0YyhvCtLKlbtvjtmyoO9I5DI/+x63994SNdhY6dNoo+IPtG4K6KR
	8gLEbQnZzlvIB+uTE7JCn9MpmrxmHQNVG7hUGTRE8wkQYqNVHm8TFXXHRD7Z7k7nvHdcuw4bsd2
	aP5E9uTcYz0oRnRO4kFOXloiTNHQxPilsXexh9ottxBGXu/tkjW4P9h4=
X-Google-Smtp-Source: AGHT+IEv1GS0F1bIQIoueTKC7US/um1YmwFLw785Q/O0DHu40YUikpwnw4dFaz1J6Vc+zuxa3ZZur/MOvmSybjnXmQSPHjqMWXYb
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2d81:b0:7c8:c7ec:2b71 with SMTP id
 k1-20020a0566022d8100b007c8c7ec2b71mr4702iow.3.1711571523139; Wed, 27 Mar
 2024 13:32:03 -0700 (PDT)
Date: Wed, 27 Mar 2024 13:32:03 -0700
In-Reply-To: <87le63bfuf.fsf@cloudflare.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a50cbd0614aa4ceb@google.com>
Subject: Re: [syzbot] [bpf?] [net?] possible deadlock in ahci_single_level_irq_intr
From: syzbot <syzbot+d4066896495db380182e@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, davem@davemloft.net, edumazet@google.com, 
	jakub@cloudflare.com, john.fastabend@gmail.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+d4066896495db380182e@syzkaller.appspotmail.com

Tested on:

commit:         4dd65107 bpf: update BPF LSM designated reviewer list
git tree:       bpf
console output: https://syzkaller.appspot.com/x/log.txt?x=116d23e6180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5826764df8e788a7
dashboard link: https://syzkaller.appspot.com/bug?extid=d4066896495db380182e
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1593c145180000

Note: testing is done by a robot and is best-effort only.

