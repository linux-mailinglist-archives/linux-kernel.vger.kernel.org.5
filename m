Return-Path: <linux-kernel+bounces-149454-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 950928A914D
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 04:51:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 23538B21FD4
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 02:51:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5149537FC;
	Thu, 18 Apr 2024 02:51:06 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 286F351C5E
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 02:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713408666; cv=none; b=sWoWLELS660W/bVLg/+P2xuIsw2tOsdGx96HFh1WyG1RkP9JO1WmUI/8u4yuAMoBWoNRo1DX6QDuJmWB6yVPTXS6aRFPQXHjpq0lkpT4y5T0twhnNXz/pSgHOuVy3p2bBj7nVp8/63cvFB++F1cXjDV9HYpX7n4XjWjhusJ2FdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713408666; c=relaxed/simple;
	bh=kemaksdsrlIR1S57gG0m03aOcevlas0sdvRbHQ9Py28=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=R5AWx8aXkDE/BU7RsF/ej2kRaJH3MwU06W5iDpgqFl42OKuU5YEWpk5n66sX0rLEYbnfM2+W7kOwJcTUqbsf35oYaXRmTQuxeAA8ky4tYZRPQXdCwZwkcylaWmqUAnFcG46EguS7iP5diuE+dq0jADeHQDG60qmq04fiTf75YYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7cf265b30e2so52596639f.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 19:51:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713408664; x=1714013464;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ikh/8IxQiRxUmOZmfpOtSXJ4MJQsJVrq/VyspE2r/6Y=;
        b=j0FJpaWMgetaYxyznODUxDDGl6EhJqD/Ie70O83994ElvSlyLSiT0h3GN33rXXanH9
         Xhz9AsQKPIjSeRDmqjCao1Hem65tN3M4kvj/RYhIsZHMx4JfdS4RT7GVFmUJsKHe1n4l
         jkCPoXeOPQNacifgHU5Wh65B7zhjXLnVo0Tql9PB+RpcPgKqCyDguLRgrYgKbUf99ms7
         6bj91LABxu+30dK7xyOn7ROVjgdKR1C+uIMoaBjTBlCP472tMSPu0MZiV7ESOcKcDfEt
         DeedbEj7Jkk/LmHJbUPc1TD7ladnjfylFg3Y0qfTsq61Gex454LUxLCzxpef9R7jPu6d
         gYdg==
X-Forwarded-Encrypted: i=1; AJvYcCX2cNQeyCGp2gl7Vzxq6OaxBVDGH3QFH8SQiXlmN4FQtzcHV6dTQxAhbgIGMrEHPPdl4kZVMb4IdU78AdiEV/Rv5VC4YS3ClGgYSosP
X-Gm-Message-State: AOJu0Yzxyz/GET+015z3mTOohDanDEN5SPi5919JRMiVnWdnZ0c7h6FG
	VO1W2xQV7E4jf2wbVcgpDDYe8q+F+xGA84SXA2nm1GpTcp0EtGi+zoHJr2X8Wa0YfbeibNkYWJn
	YFDUM44Z+uD26e/71ooOlOmVUKZ7Vlb+BPEZaYbdxIII0l8xeiVYrgiw=
X-Google-Smtp-Source: AGHT+IEH7hcoKAZspDMi2dP3VJIZw+p013dekRsehXW/X7ylh3IrZDuqB98iGe7Y8ncILxLfuz6GLvx/hTAlufONhdsfcuPNRCmR
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:378e:b0:482:f06b:70d5 with SMTP id
 w14-20020a056638378e00b00482f06b70d5mr77102jal.5.1713408664122; Wed, 17 Apr
 2024 19:51:04 -0700 (PDT)
Date: Wed, 17 Apr 2024 19:51:04 -0700
In-Reply-To: <871q73vlvj.fsf@toke.dk>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c7cac10616560a93@google.com>
Subject: Re: [syzbot] [bpf?] [net?] general protection fault in dev_map_enqueue
From: syzbot <syzbot+af9492708df9797198d6@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, davem@davemloft.net, eadavis@qq.com, eddyz87@gmail.com, 
	haoluo@google.com, hawk@kernel.org, john.fastabend@gmail.com, 
	jolsa@kernel.org, kpsingh@kernel.org, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, martin.lau@linux.dev, netdev@vger.kernel.org, 
	sdf@google.com, song@kernel.org, syzkaller-bugs@googlegroups.com, 
	toke@kernel.org, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+af9492708df9797198d6@syzkaller.appspotmail.com

Tested on:

commit:         443574b0 riscv, bpf: Fix kfunc parameters incompatibil..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git
console output: https://syzkaller.appspot.com/x/log.txt?x=15d5b33b180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6fb1be60a193d440
dashboard link: https://syzkaller.appspot.com/bug?extid=af9492708df9797198d6
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=12bfa653180000

Note: testing is done by a robot and is best-effort only.

