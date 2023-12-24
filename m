Return-Path: <linux-kernel+bounces-10763-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AC66881DB71
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Dec 2023 17:40:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6234C1F21689
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Dec 2023 16:40:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 451EDD27A;
	Sun, 24 Dec 2023 16:40:08 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4473CA69
	for <linux-kernel@vger.kernel.org>; Sun, 24 Dec 2023 16:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7ba74d90a71so459903539f.0
        for <linux-kernel@vger.kernel.org>; Sun, 24 Dec 2023 08:40:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703436006; x=1704040806;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BQ3dtE3cEj3t8PX7zTCW89boYQSV2gt5/WlGrjv/hRY=;
        b=UILGtpSatrGV01vP3FFyzvPLieIOyfRdxkDby6oh2taP+wYUR1JrUM0I5oAijPxcuZ
         WATEXkMrldsARuZ78Qp5lza47k3f8IAI2pf1IbvLa6YcaIFVPFSjKKTgVOiIzo0HEspE
         rcq6rBuy3be6Vcz8kf2QBvEX3/9bgvwnj6sRVEThnQIJ10TGgwP5BULxgRj8N2DxtULX
         NNsTYW9uE04CvzA2boNMZZFIGvLtvOAMaSGMfuAIMxzNlaZPvzL2wLp2uRJ87cXVoSDw
         zmB+a0T3ZzsgWC0Lt/WxCxTx+Sq2L9hGVV/UM2YIHX7fyYyERm9GSzSiircIeQYk5cGu
         BzYw==
X-Gm-Message-State: AOJu0Yxd7EjZG7jhFAET6E1w0B2/GTiM4GRWz/AMZPTpnwf/tYe/MQ0g
	U8esB+0sH/hV9iYZ+hS7dRU1cE3ImCrENvGSPNL7KCSJpVI+
X-Google-Smtp-Source: AGHT+IGqnCO5KaDzC+K+VNi8UHEk7h8wMbFhPswwONHLgmnp+xNRwaClUzAiR+nZ1ZcaM+sXms963MDU7uiovAIF+D1+ROqCLdKG
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a02:cb1b:0:b0:46c:fefd:bb37 with SMTP id
 j27-20020a02cb1b000000b0046cfefdbb37mr120454jap.4.1703436005920; Sun, 24 Dec
 2023 08:40:05 -0800 (PST)
Date: Sun, 24 Dec 2023 08:40:05 -0800
In-Reply-To: <0000000000001825ce06047bf2a6@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000007d6a9060d441adc@google.com>
Subject: Re: [syzbot] [reiserfs?] possible deadlock in super_lock
From: syzbot <syzbot+062317ea1d0a6d5e29e7@syzkaller.appspotmail.com>
To: axboe@kernel.dk, brauner@kernel.org, chao@kernel.org, christian@brauner.io, 
	daniel.vetter@ffwll.ch, hch@lst.de, hdanton@sina.com, jack@suse.cz, 
	jaegeuk@kernel.org, jinpu.wang@ionos.com, 
	linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, mairacanal@riseup.net, mcanal@igalia.com, 
	reiserfs-devel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	terrelln@fb.com, willy@infradead.org, yukuai3@huawei.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit fd1464105cb37a3b50a72c1d2902e97a71950af8
Author: Jan Kara <jack@suse.cz>
Date:   Wed Oct 18 15:29:24 2023 +0000

    fs: Avoid grabbing sb->s_umount under bdev->bd_holder_lock

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14639595e80000
start commit:   2cf0f7156238 Merge tag 'nfs-for-6.6-2' of git://git.linux-..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=710dc49bece494df
dashboard link: https://syzkaller.appspot.com/bug?extid=062317ea1d0a6d5e29e7
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=107e9518680000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: fs: Avoid grabbing sb->s_umount under bdev->bd_holder_lock

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

