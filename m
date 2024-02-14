Return-Path: <linux-kernel+bounces-65617-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D4AD8854F71
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 18:09:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F8C5281493
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 17:09:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5223560888;
	Wed, 14 Feb 2024 17:09:06 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8383F60867
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 17:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707930545; cv=none; b=fpdMwB3SB4p/FF6e1UpXbTY6Swjoa6tjNWIXiVzCwuftdl2FEEdqepGdRaGRnTPxmzl5YCsFZQsbCKux8ucOb+sMHcOrjMGs1IWR1GwwjB2hivlPtz9uC89+r+RGRpprm9Hy8tRyWfJkoVwNx6beBwrvNaL2pA1PsIN/V5zboL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707930545; c=relaxed/simple;
	bh=BPw4aT0217go/+fjHAnJwpzYWlfdPWlbSH4+dr61yM8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=aJLI7mQifc5vmDSVfV3WdHtx3dv6PIsvR1ruVjku0wtLPM+N8Y4J8n5bqnAinScXcOo55T75Y+bOGmB2B0QZ7UYXd/lWaWdd37hSWRx9rFphwMrceFf5GGRtJwHmwoggm9seM2nXq0uJ/icBVdcuzdGUnw588xb+7V7QdCWub+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-364278061caso14551755ab.2
        for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 09:09:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707930543; x=1708535343;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YZ5YoZTIkOkfK1+4m3Vu2kUgkzdMHFQEsvekeqW2hXs=;
        b=jBSkiRFEp4ux4bnmfV08MFntHC9ZV7MKpmwm3wHM3S5YyVzAeWp8/DOuhTQDwJzfVk
         nbRuuE6WluNmEKSC1nZuM1gX6RgUs2Ur1lz1q9bYtrRphuJJAEeMLZg/q4WmikvbLzo8
         MV5m4IU2o1rfrXwtb0E2Vjv71I8BUAgLyqZq1Gv3wzRISDP5Oy3hOuliyCx+g3j8nknB
         g1Fu+vDTuI3rkCsdMuJ98SY+uU0kpekAnTfOyYfU1Fw7lTYDVcM3G43oa8Xn+5MSGqUv
         qNGvsqtqxhO/pMCZCTZDS/l9GWxkd7Ee9cSw7ktrqkuMCCdcBCNf7FKVnkhs6klTfGMH
         8Fxg==
X-Gm-Message-State: AOJu0Yy9coOxEUGqqTM1ZFNwTm7bGB5YMpH7MFoos0ajo+NKkcCeCZZg
	VdhDcNRAwszN5Hg2ixQOJcZnwfaaz40N7AjQXEGLq+SsMJDCzpqdG5UbKDRFWDNZMfAL9xZQGI1
	ww70w7lsVucMYTlJ9wE8SbrXeAkW/f0kQYJMyJCSz4DJhB3SCAVSFcU7How==
X-Google-Smtp-Source: AGHT+IHyKUw3s9RmIp2rbtSh+7fOoy0yViJnO5KqMbP+y7k8aUR679Z4zFz+y6WoHKb6lD3rN+IdwCTnG6cNQujrwXi/kp9W9t28
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a2f:b0:363:c25b:75e4 with SMTP id
 g15-20020a056e021a2f00b00363c25b75e4mr256301ile.5.1707930543712; Wed, 14 Feb
 2024 09:09:03 -0800 (PST)
Date: Wed, 14 Feb 2024 09:09:03 -0800
In-Reply-To: <20240215.000350.2097273261001750837.syoshida@redhat.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005bf1e506115a91f9@google.com>
Subject: Re: [syzbot] [bpf?] [net?] BUG: unable to handle kernel NULL pointer
 dereference in sk_psock_verdict_data_ready
From: syzbot <syzbot+fd7b34375c1c8ce29c93@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syoshida@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+fd7b34375c1c8ce29c93@syzkaller.appspotmail.com

Tested on:

commit:         e37243b6 bpf, scripts: Correct GPL license name
git tree:       bpf
console output: https://syzkaller.appspot.com/x/log.txt?x=11ef9c0c180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5e23375d0c3afdc8
dashboard link: https://syzkaller.appspot.com/bug?extid=fd7b34375c1c8ce29c93
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=17169634180000

Note: testing is done by a robot and is best-effort only.

