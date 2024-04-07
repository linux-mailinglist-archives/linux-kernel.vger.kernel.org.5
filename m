Return-Path: <linux-kernel+bounces-134513-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C29BB89B262
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 15:56:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 619E61F21412
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 13:56:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05B5F38F91;
	Sun,  7 Apr 2024 13:56:05 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B55338DE0
	for <linux-kernel@vger.kernel.org>; Sun,  7 Apr 2024 13:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712498164; cv=none; b=Xmi2Gn0r/HHqryDMIRwYmL4BlyvRoJRFG1MjV1d3BUhaWaB2cyBFSScNs+TEFU7+Xi0f06J0HN/4iMS5HtoQ5s/yL++NlgRP6k5HnnklCYykWjQw4qhy73tCP+obeOfkuEHtfYKsxk/PPkF/IJvF3DpAHtM4kRQaBi8p2fR9Lc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712498164; c=relaxed/simple;
	bh=pIoR/Kz88manKuaFwUHe7J2vk4PEOZq0pXlOiRdp698=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=QdtAmaTjllx5hTo6Hg6VRv06KcmFTntR1M7u2PLJJ1vsvGdp8IFL87rF8LzIg9PS0ZeIGQXkdNDB8xzm+i8niS8Z40PeRZwOvLlOfDuXS9wXY2kjSOlfmbozGDqZQSvvcyh1wo8pRdu5HWBkf+36ixxkeW8Z6pnZ2DTkfiaUSPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-36a1e4a5017so3372495ab.0
        for <linux-kernel@vger.kernel.org>; Sun, 07 Apr 2024 06:56:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712498162; x=1713102962;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J/XPf3I6kqVM6/4fysfIoJRYSeBqPjvg1k0/4K5NNxM=;
        b=kWaJIluJyEZ56AC2OvI7w5qvsmdgiBpV+FJQN+tHzefx8JlL1TjIGbJoWdWsI46PCy
         DDEJabiCMIMgqJdbt8dv/W5T843PJyqM67Z2/6kIDbAHdXDh8kLAG3Cu17khN8CxjzK9
         GOxZpHMYFU5aWxXezPVZ40159Bm8IPQQDyB1BUfrQoI7SXSFIhGIar1x3HlZC/Gd1HUe
         MNi6diQfQhZfPADg7M6Yhtnv/BDocRIF5Lz2LuQazpJ4vojx0qH2LUNDwubmGHoErgvs
         XMVmGzoFG1PaE4AtVLA7F3iIIpBIuQWPiBKaAftRzCXR/y7PzlID75cV4hxkAnZmzsZk
         I/vA==
X-Gm-Message-State: AOJu0YyPW+klFqtkcBtAHhnIEhio2eeFVCpqVmwNzGEv0xTjT9GnFpts
	4rEwLVl1lEUhvBoWlFrEU6FiVMtxQc8sg99g29VufDIVS8WeJdnSG0s9Gl9se77MlQEOtY3gGlk
	pWtpUT+bmXsl7iwvZwjg/QvVR8s+KCdid+osKd2dyiIiORa+jLdtiafV2og==
X-Google-Smtp-Source: AGHT+IG4+c5gByYfl5QFWq0zdiVXC98i0NnEu8D3l9Kn2Sg8F7y3gThX1sQJetlon33gvtXfTyD/nhKhHT4w7XohH6KpyULpdrCZ
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c4e:b0:366:b246:2f10 with SMTP id
 d14-20020a056e021c4e00b00366b2462f10mr487447ilg.2.1712498162342; Sun, 07 Apr
 2024 06:56:02 -0700 (PDT)
Date: Sun, 07 Apr 2024 06:56:02 -0700
In-Reply-To: <20240407130203.26091-1-n.zhandarovich@fintech.ru>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a530250615820c77@google.com>
Subject: Re: [syzbot] [usb?] WARNING in vmk80xx_auto_attach/usb_submit_urb
From: syzbot <syzbot+5f29dc6a889fc42bd896@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, n.zhandarovich@fintech.ru, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+5f29dc6a889fc42bd896@syzkaller.appspotmail.com

Tested on:

commit:         fe46a7dd Merge tag 'sound-6.9-rc1' of git://git.kernel..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=1026a3d3180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fe78468a74fdc3b7
dashboard link: https://syzkaller.appspot.com/bug?extid=5f29dc6a889fc42bd896
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=16fc7e99180000

Note: testing is done by a robot and is best-effort only.

