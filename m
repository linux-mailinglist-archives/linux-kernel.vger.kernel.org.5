Return-Path: <linux-kernel+bounces-151591-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBB818AB0D5
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 16:36:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9796228321B
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 14:36:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6156312E1E7;
	Fri, 19 Apr 2024 14:36:05 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A51722AE90
	for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 14:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713537365; cv=none; b=dJ+gzR6yTME0Sa29bJ/7JUxMsv7Ia2u5Cz7OS2fZ2fV6bp+wMcAxLEAtxAgbhCiZFiPMEXauuczOqS2F9J7XDxuhmZv0RdvjR8947jd9dccOdvl8ioR7sTndzactnpu77Z9fx0qa+kIuMCc9xprFU2o19fgdWY80BjM94k3bz08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713537365; c=relaxed/simple;
	bh=yQwX62+fkNLavk9lwd3yR8Hb4VgMPDhaim7fnFlPoxg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=RU+z29ywbpnmxfEf7va6EkJ/XhdhJ67uUrZNHqwaPp4sKRRjwI/Vb08ILPQPli1G0sO+mDtCm55X0vgnyL+05TYk69CdOO3KKMOa8bEM0E2LY+DdtjFtfIhNhdWta3Pc3viflCxul81ldFdnRnSyP1M0vFGyiL+bqqglp9oIgBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7da42114485so153947239f.2
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 07:36:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713537363; x=1714142163;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i6jj+8WQllJsp8RkVw4WKYnNbDq3wGsDrsk9JHqA9oc=;
        b=YPf7ph/mOQYVdPUQgvamW7yrC1Xm8sRAgllBhLApW7RolqYGmnXjhSSxeDWZN4Be4X
         aU8NLuqlZi5v7mbQr0SEBRR4cGAnA2BM1RaGdorzVCLFwTWtK1EaNa4mzas6CxxJPqLn
         fl51wQBkVIde9SjsZyg33gCD/MoaHgQ+o2v4/lRGCEXON72gEGAek/+0+tmlCyjqjxt3
         dCBeQB0lNQGqSMAVhkPe0rNQTwI0+eFnnQVaN6VSv4KSLA2ZPdn9zhMc/36VvzSxR9zr
         1zgPHx8Joiz4Qwfv4mw5Ih9jWUNtkQdQgpEVBeci+28/pQ8gICs6s+d+PixWOs0JYefN
         xBiQ==
X-Forwarded-Encrypted: i=1; AJvYcCWmB8+ZECaOgU5UzS4YQons2TW9i9pRJ/fSRmyvrf6Sjn7/UnEev6r/G0jlm/C1upYgwhPdYAtycb4Zjdbcs3+jbq7utfJlGmU/IMtT
X-Gm-Message-State: AOJu0Yzpu2s8Eh4Sg/DQO2ltIgLHHSWVTfiQAl9ilLsK2d40Ux7c7AAc
	RP4DN1peY95wK0oFzmQNOGUVOQwJVwNUy29QfTkSkXQbt57ybJnejCMeOvA7I7f41or/d9TM8u2
	NwfD0Vhe1y+EwYC88JoucrfY4XU3TlcZCv9CzwGyfsn8DXenv0QdTuPY=
X-Google-Smtp-Source: AGHT+IG87ZYSNHl5uEGhoklT2thUvKMjD4LwZ3+gcfueAZMKYx38BA3Rzg4f/UZhrSsz7b4D2iSexUfeZwl+97Zh4FSQx0dAEiV2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a6b:dd04:0:b0:7cc:66b1:fa95 with SMTP id
 f4-20020a6bdd04000000b007cc66b1fa95mr26354ioc.3.1713537362927; Fri, 19 Apr
 2024 07:36:02 -0700 (PDT)
Date: Fri, 19 Apr 2024 07:36:02 -0700
In-Reply-To: <20240419115410.2816-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d3af1b0616740146@google.com>
Subject: Re: [syzbot] [net?] KASAN: slab-use-after-free Read in unix_del_edges
From: syzbot <syzbot+f3f3eef1d2100200e593@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+f3f3eef1d2100200e593@syzkaller.appspotmail.com

Tested on:

commit:         7b4f2bc9 Add linux-next specific files for 20240418
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=11e892bf180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ae644165a243bf62
dashboard link: https://syzkaller.appspot.com/bug?extid=f3f3eef1d2100200e593
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=15ad594f180000

Note: testing is done by a robot and is best-effort only.

