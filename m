Return-Path: <linux-kernel+bounces-154392-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5067B8ADB8A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 03:31:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0956928515C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 01:31:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28B7F17BB7;
	Tue, 23 Apr 2024 01:31:06 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 700E0171A4
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 01:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713835865; cv=none; b=f8HnfMRuRiDYZP8WjGRBx26DxTLqOaYkSZz9E/S4j03naPYGHccnhrkck1SMMsD5jx/B/V2G6jabr89KcX9vdK06z6B6mCGIoYx6ueveWB+nsFirGGmb+keIPdgftUdeYYFvuaSrOKbO1quFUUNL/200obkUtkpGkpBqK219kV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713835865; c=relaxed/simple;
	bh=22JucIr333S5hWoQojYq8sDzxWaVqwg8jNiaohfDBE8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=SJFW2xNbUViebnsUD5viB7GjOpPn6mT40U/I3jiThIqCaAyz+NImrAR+cf/uXqEe1ZFVL6ViTBIQNhu/PUxHV8G1Nzw5zCmGhN0BPprLEgPvHVz6AoThMbOpODedYXMsMkohBGvm3UhwvuFO4D6pd2qJkXnRbyQvjmssYzxZxy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7d6bf30c9e3so698890539f.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 18:31:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713835863; x=1714440663;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Cz3oNrlg/tZ0pVKzc2WrDO3+pRPfzflWiDsR/M727fk=;
        b=LfuKDqsDKd0zzv0JbtPyYtG/EsF7k54+fdLxm+3xpqLVOdu4xJD0mQwvUVcFI/dgx6
         ITclzkh6aDguGw3yj8o3PU7ZJnEEYgyrafilOhhH5pUQK5LexpZLTlSHs7JHZcXLnWMy
         GGAGmP5dXqbutNkmEXJvwT4jMi6JMmYTMlloiNqLoiRllSRtwqg3dgooF1BbCxyAesj6
         mkvkxaDKe803BaURTmN4LpWAS8AO3fvUheyq9u3VBimDB5MxQFXY0LgvD7LLPi2zspeA
         PqGRHFixkLO9MeL8C4a4PIvwHPfYI58vxK70rhqCr44px/6POuTLetgRT9O9nnZ7vWRa
         r9Zw==
X-Forwarded-Encrypted: i=1; AJvYcCW4q/nRiGu61VdQcRdplqDFS3YmvZsOQ0l47qGI+RoCsGKtjqQjrvOQDW3wCnvDSvVUfGrmSZYIa0AOaxap+gIjE+tnaagDAkJB07Pg
X-Gm-Message-State: AOJu0Yw20DPkxS/lXL6Z+FsmgNkKMavMuyX7y4eNQ8Pm7MkoEqZcEc6u
	yqjT+YdXI1ruBULL+XSZwBdqu+XKhN5JrOPeAaAOYxc1Mv+alkxC9T1vVU5GMryo+W3X3u5sQot
	+ShAdzXW9aksoZTslx1CQ9pN47mBO6uu0CsPUG3NMc7F7Vb9uh7uLii0=
X-Google-Smtp-Source: AGHT+IHodPS3M1cJI0kzh6PKVQhHFuy5lI2gp/FKCQIK5MUvSHRJwKXkmGBl7t3+5hguQZybcRaW0A0Oqr+8oMCpedZQCN1uEESx
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:4126:b0:485:6cb9:9a79 with SMTP id
 ay38-20020a056638412600b004856cb99a79mr103537jab.0.1713835863671; Mon, 22 Apr
 2024 18:31:03 -0700 (PDT)
Date: Mon, 22 Apr 2024 18:31:03 -0700
In-Reply-To: <20240422101622-mutt-send-email-mst@kernel.org>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000db97ee0616b981a2@google.com>
Subject: Re: [syzbot] [virt?] [net?] KMSAN: uninit-value in
 vsock_assign_transport (2)
From: syzbot <syzbot+6c21aeb59d0e82eb2782@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, mst@redhat.com, netdev@vger.kernel.org, 
	pabeni@redhat.com, sgarzare@redhat.com, syzkaller-bugs@googlegroups.com, 
	virtualization@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+6c21aeb59d0e82eb2782@syzkaller.appspotmail.com

Tested on:

commit:         bcc17a06 vhost/vsock: always initialize seqpacket_allow
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git
console output: https://syzkaller.appspot.com/x/log.txt?x=12b58abb180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=87a805e655619c64
dashboard link: https://syzkaller.appspot.com/bug?extid=6c21aeb59d0e82eb2782
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.

