Return-Path: <linux-kernel+bounces-154459-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C54538ADC49
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 05:28:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 55E0DB23911
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 03:28:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 402EB1BF54;
	Tue, 23 Apr 2024 03:28:07 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7979015E89
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 03:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713842886; cv=none; b=XPmKnJT7BhM92uw4XyONya4buFGRzti/59AwdbaDW070GTBcV2RiIMy65sIFO3ZTErUPcWOgp5k6zzOoAGLt7jd2BV6siOGIKnl5mIAfh5DT/tlxFo63X97XoadzZ9wR4e/kp4ZiFaQLGLlY8Cv/778IFEdwp4GWhOztE8l9df4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713842886; c=relaxed/simple;
	bh=D5ciqGdFeSQggt45cK7G60COItW+ZvydHCOqoDA4sJ8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=T6E0MLIpdfPWLpkkBAaNUmpPuH3G8kF4WgXl+guo9F5SqbbIqaom3aUHwdRv/jaK3imS8L0ef+4dEbUgOX8syvDKcWNmAwqT9d62PRD5Ausq0zpx5kKZdvW3pumpQ1PmBimRf44jJMxn09v3eJruF3W7F6J1AQtYx9DLoFxm3K4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7cf265b30e2so667916339f.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 20:28:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713842883; x=1714447683;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KMls4jzTFq2aaFa5geaJXiDj/xAyYqk+EmXC2QNa7HQ=;
        b=rD65Bq96cCrE6XdZrANjCYUIbukKKiGLi15ptnVH4ITjapP+mO5ZwPtSYwCHVuPAxN
         vAr9hQxBC1bivxOPBdCEw0I5D1flKqNFLjTXQp9AxSqwujb08dIDUGyy/ND9m3rmSjys
         blcKeMg5oBYnOHMOA5hTnaA2O3kamYzHtQG7RcAxiV1kROR2PXiQuQdJ2iSQfopz8TGL
         VxeQDACwfW6ssmC0lz42rQlx2Ed/0nIRZ2YxXVF8ldh9wpQoIaIklmLJgLUGB1EimcQm
         sClG/D59Wl3XFmUW3RTAYaADvAsjsojSgUh1HfVhz44Y8iuM2z0fiDFd4qRakvntcQ8w
         RdLg==
X-Forwarded-Encrypted: i=1; AJvYcCW1v+0yfE9uiV6wgzfQHgmlTxUedTJ7WvJxsrAbmKhGxgzxrivBBNMs69yiuh4YidIkPKlyF/CSvQIHp+dv9SQOp9bQZgPqHdMaz1ks
X-Gm-Message-State: AOJu0YyvRzW2LbaXeM1eyt/srWIIk1hhDWi/oZy02Fcy9YMhYfxa7CHe
	6z6WLvHzKyrkQaQnBfOavt1GqBubjzoUXBoZUyQMhH69X2HUtcQ6lwN1S2uJeHfSmmVofTn1M78
	5KYwhgzIBYFR7TUGLUS1SkSPIITLPf1buFNTeJ1ZocrdvUStgpGEe34w=
X-Google-Smtp-Source: AGHT+IGkq03g3jNcwhjr216oqgH/1XiAAqU7NsSvpIdHlcEIb/lgfUni6J7+NAbFa5CSmIsxwabmWtP596C3kOzhkX2YVUQ/DgoY
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:1647:b0:7da:b30e:df80 with SMTP id
 y7-20020a056602164700b007dab30edf80mr193109iow.0.1713842883719; Mon, 22 Apr
 2024 20:28:03 -0700 (PDT)
Date: Mon, 22 Apr 2024 20:28:03 -0700
In-Reply-To: <20240422161108.83595-1-kuniyu@amazon.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004903cd0616bb249b@google.com>
Subject: Re: [syzbot] [net?] WARNING in gre_tap_xmit (2)
From: syzbot <syzbot+c298c9f0e46a3c86332b@syzkaller.appspotmail.com>
To: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, fw@strlen.de, 
	horms@kernel.org, kuba@kernel.org, kuniyu@amazon.com, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+c298c9f0e46a3c86332b@syzkaller.appspotmail.com

Tested on:

commit:         219eee9c net: skbuff: add overflow debug check to pull..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=1438fd73180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a19cdb0b4b41d5ec
dashboard link: https://syzkaller.appspot.com/bug?extid=c298c9f0e46a3c86332b
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=12dc1973180000

Note: testing is done by a robot and is best-effort only.

