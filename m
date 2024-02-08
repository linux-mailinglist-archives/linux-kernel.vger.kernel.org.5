Return-Path: <linux-kernel+bounces-57374-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4097084D7A1
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 02:37:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA9AB28568D
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 01:37:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0AA71CD19;
	Thu,  8 Feb 2024 01:37:06 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CE3314F7F
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 01:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707356226; cv=none; b=L/SojQBOTTtGpIiS8mPQxLskqdCeEIsYY4Fg+YYBkktO1EIga21kT0o/4aFi+21WYLhYmLlf8t6a6TAFgUrmnwfJ0fxFmt1Gv6P67+IZGkYJS9OTZClJivIP8k6ud6YkqCpVf3lppBFD14dwWR30hm5wuXiRUKPCSUc8uFYT61I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707356226; c=relaxed/simple;
	bh=xgQeGtwhiz1kNDMXYvT6rIzUl/N74wXv5puaJBsQ0jM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=qzpHSW5N/tSu1g7SL3YHjb0lluD54Z1YYB3GewE4eq+zlGUknwWptBBM3k69S2bCt+wWlFxr5fWQPrgIc7xuzBbODux4VLBx3+fAwIunUjgQ+PWVVb9+hRuBwN8k3hmKxPsc1KDGRLBhiEmu79KyclfA6m1qp2B0mKWctEvwxfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-363b161279aso10310855ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Feb 2024 17:37:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707356224; x=1707961024;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uDra3diawU6yneS9QkOQgrR5Tu//609hVN+5+vXi9e4=;
        b=OrrxKvDirYs+P62np0AXMUEXw1lADoYtkPqiRMk0qrkHj/VJ2qjs7sg0EOEv/rND36
         U2fpEao2Ex2Ki58mTIse3DCwaDsFUk1RkSMn3enUwxLnGHCE2TgBDXc8A9OdPDEmAbcy
         I5c5TFHBBPLeuubldGOfXzZNxk9MqJnOs3Kv22Y9wB1Zro7PD7Ym71cZcnscOiqIJcvK
         4fRVHjo9DC35+HVgJiOetT+mmBi3BpRNRaMopWzrIAxxhmEK9z3Wpp0OxQO3rZQ9LuYF
         2xhQYgXrissYji5QOP4/XWZbxWrIUj5b/jrmKZ1iFxHa4rdcOwM5lkV2WknfbBEr5FYS
         z1bg==
X-Gm-Message-State: AOJu0YyVp3jp/Hej49SA/UYy/qlm2bGhf7VEVHLrLPBq71MJPhxeqAS/
	+ZFbPGr1rrMZ0lW2wTC6/S86OWbc46FCfAduam09/TqCEWFUDCOzAWxXQDWB2L4llT6JdYqXN3M
	HPzH3THEMnp3nYPtvYv5kGBYnipKg8ZxSyc3iiIUWoGdSXvKNfCXBm2g=
X-Google-Smtp-Source: AGHT+IGkdjyMt30qMBjP6bUDJieLzpUFX7ff5Ux+iDDbfouJtIymChV4ggxDfMIUmcPnGFMFTKIZwEY9jNGwxF6J/FSGS0myhCOn
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:cdad:0:b0:363:d720:a9d0 with SMTP id
 g13-20020a92cdad000000b00363d720a9d0mr336511ild.3.1707356224150; Wed, 07 Feb
 2024 17:37:04 -0800 (PST)
Date: Wed, 07 Feb 2024 17:37:04 -0800
In-Reply-To: <0000000000008e23d405eec3a7c4@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003ee25d0610d4d916@google.com>
Subject: Re: [syzbot] [fs?] KASAN: use-after-free Read in sysv_new_block
From: syzbot <syzbot+eda782c229b243c648e9@syzkaller.appspotmail.com>
To: axboe@kernel.dk, brauner@kernel.org, hch@infradead.org, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 6f861765464f43a71462d52026fbddfc858239a5
Author: Jan Kara <jack@suse.cz>
Date:   Wed Nov 1 17:43:10 2023 +0000

    fs: Block writes to mounted block devices

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17ddd29fe80000
start commit:   01f856ae6d0c Merge tag 'net-6.1-rc8-2' of git://git.kernel..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=2325e409a9a893e1
dashboard link: https://syzkaller.appspot.com/bug?extid=eda782c229b243c648e9
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=179d6e75880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=124b96a7880000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: fs: Block writes to mounted block devices

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

