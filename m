Return-Path: <linux-kernel+bounces-72050-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 934B085AE42
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 23:18:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FB6F284ED3
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 22:18:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 364D254FB3;
	Mon, 19 Feb 2024 22:18:05 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B4B554730
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 22:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708381084; cv=none; b=siFo5g34j+ncq/yH/UjB6qYRLbRjzqaF7Z9CUJ45NSYnJ0jebWtVTvrrbVjIAe3H59pU+RLDZp+O4PJLibLOHDsm+Rl1yKqev2Z0q0xGTXB7CE4XxWZhu/LUmGn/gCI92ce4f4PuR39BpJ5WIAL4oLB60zvqaOTZPCPUgzJZYlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708381084; c=relaxed/simple;
	bh=c+0qPs8TPZcmXIQHMEQ1YzES3Yy34XuavJSQTscSXBY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Rs1J17Bzr1tvyeS8C/2vpVK4BBsRP+wCEx5TcMgO5W6wQr8G1focstgzb4xbCABR9MrLHx6vjtSXDDW66Kg6tm3IVPAj/GTnPSh6xgQ9CH+ud+vjxFhdD3Z4YiMJgIpeJXuskshBzNCZRbqsoGB8W7ibLTQtHxdclGuZ6Gj0Cmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3652d6907a1so14592425ab.3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 14:18:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708381082; x=1708985882;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4t2paFm5bNQPj52rT++RcxCOeC7mO3UVObeCBKBufjo=;
        b=AKuNZeraxWLzIfyHFnFbkZasqZ7IeY51js1jz+6CtEVrEnbkuHYX0eULiEwN+FoLHa
         nqFmgXqXql2BHM5hWYq14NCfZYnOwwwn8odPTk34aUwhv6w+aHRG3WTdzzNBDlkl+CyM
         uR2o3CDB4IlLS/RehyAl1qBluRoARknr6dbcyroemKqYqrLoPFRBOykNmejAQGMbCIvv
         MJ/NIMQcxzhtFknvy/dgiobH/6uDXO/irHVxgaMYnMnRDmGReTHCKrJbkTfJslKGtZdh
         Y7teSGF1NDcjjnorKBg0Ovl+s2fNJ6q3y+YYkHiszAjn0WEFARp1t/s4/0xNxZKeRcXw
         ObNQ==
X-Forwarded-Encrypted: i=1; AJvYcCWm3dFHmreAdlY6aY6DIpqE+NUgwXFWoIx+vrTSsv8KE0oK08k1vCqIOE9lbDPNyVdT/2BWgZzvOlnNeMUv1+CTBk6aUcB1tQHjJRgf
X-Gm-Message-State: AOJu0YxYj5jH+oZ4YZ6nvMFFaP1Y7rSE3e0EuN9S1E6/iU8Sgdng1eho
	wR+WqcBK+RlBgusuFPxVSGrCKkuuyRVxaZW+0k/n1y41XeaiEZ9WsBrzBLRgSZZD3fbrwMfAnqT
	CZZlggZwCy+KQ2Y8z2pyqw0OepipIt0W1XNP9knyLu/1EMYSgnSAuLZc=
X-Google-Smtp-Source: AGHT+IHNZ6BqQ00QXj4UQF0JzF8saHr7WBqtNu9rPtVFrdB+5HO6tIDSXWfK6Rsne2Np8ab/YzyIPk0B0OVZ7io32bkJWQ3CGOpF
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c26a:0:b0:365:1957:551a with SMTP id
 h10-20020a92c26a000000b003651957551amr646218ild.4.1708381082710; Mon, 19 Feb
 2024 14:18:02 -0800 (PST)
Date: Mon, 19 Feb 2024 14:18:02 -0800
In-Reply-To: <0000000000002f18b905f6026455@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000937d8c0611c377f3@google.com>
Subject: Re: [syzbot] [ntfs3?] UBSAN: shift-out-of-bounds in ntfs_read_inode_mount
From: syzbot <syzbot+c601e38d15ce8253186a@syzkaller.appspotmail.com>
To: almaz.alexandrovich@paragon-software.com, anton@tuxera.com, 
	axboe@kernel.dk, brauner@kernel.org, jack@suse.cz, linkinjeon@kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-ntfs-dev@lists.sourceforge.net, ntfs3@lists.linux.dev, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 6f861765464f43a71462d52026fbddfc858239a5
Author: Jan Kara <jack@suse.cz>
Date:   Wed Nov 1 17:43:10 2023 +0000

    fs: Block writes to mounted block devices

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=11390158180000
start commit:   022ce8862dff Merge tag 'i2c-for-6.4-rc6' of git://git.kern..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=7474de833c217bf4
dashboard link: https://syzkaller.appspot.com/bug?extid=c601e38d15ce8253186a
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11bd01dd280000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13678475280000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: fs: Block writes to mounted block devices

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

