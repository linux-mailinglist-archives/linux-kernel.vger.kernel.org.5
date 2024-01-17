Return-Path: <linux-kernel+bounces-28387-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E34DA82FDE4
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 01:07:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A77F28C46E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 00:07:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C79BEA5B;
	Wed, 17 Jan 2024 00:07:05 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14B1F17E
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 00:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705450025; cv=none; b=rEdV7tCyNXpGhyyK02gK4j92dRMaHV7ct0WTpiSRUj7gm6OCRO5m6lxVlHaL9YjFXAs9qnJoKAGjnfyP4spKF4J5fCmKwqDFsLBZINMbmCNd/UpMlr6MOtTCbQCcRreugaw+y1wTT+7QKsDGCxOY3qTxDPE7s/0xRWx/+YQT6Dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705450025; c=relaxed/simple;
	bh=/tcqdO53EdXfqW0OELgFT/QmOAc6RYeo7trY0MclCwM=;
	h=Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Google-Smtp-Source:MIME-Version:X-Received:Date:In-Reply-To:
	 X-Google-Appengine-App-Id:X-Google-Appengine-App-Id-Alias:
	 Message-ID:Subject:From:To:Content-Type; b=ZP0OWAmcv9vgCJm0U3a6A+ufER/RXTlXxCOjLnzQohQgKaF7bAieaEPQJv1tldOKbZBOOkFzaEdBrVTVwWt4wR7tv0GYrNYRC4D+qVgnw9SDuKoHPndVy8YOGPkSLc3RcBAsS3pUhYGGFRR0NrHjAdaPJ8wt+z4LXSv+eL2//qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3608452488eso85468945ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 16:07:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705450023; x=1706054823;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TlavUvMAdUpiOr4arKZ0pSY//J4vx90QCJcxBwABNio=;
        b=FEW7BuosRKuRGFZ+9qXl+fYTCM+VFAn3weh2ZH7mXWZ/Vb4Xn2S62v1oT8/NFzNsYz
         oB475iZVA/3GRoowh9zq4FUuj7L76ZJb9BTUJOUrb4T/JRr+/D2Me6C0mlHtFLhDuE+y
         AVJ0O+gYUgEyipvmUYCeoNm0BY4d91bTX3BrHUm5Ft+inbwKHlPg3204kieqilowo5iw
         tRDgIpHeeG9DxZJoJDDieXT8+3AYBem4x6h/z9xYkef15za32gz0C7LQsh6hnbpRNinC
         m6kz7DGT7MTkoyd4ZZkXNAqqCuE5BkTjSY+0VVO3ZJmUB+MNguUJW68jqSusqT1+pknw
         xscg==
X-Gm-Message-State: AOJu0YyFgDjUtca1KEQTqAxvxnQjpxqS1ufNSm0LiGhGWyx8nBzCoRKr
	YI/ow7dj4HoAyOvafwYX0OlQVur82M7JjZnNADqFqUcj+vH4
X-Google-Smtp-Source: AGHT+IEkpFYmbytpIqhwd1doRIHX/Gj50g1X8BedK7iVLQEUMWfCZTSu2xEHtDALyvBTcEkp9QZtU3Hr8jFD2nxE7jiMWlQ/UDXJ
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1baf:b0:361:94d2:6ecb with SMTP id
 n15-20020a056e021baf00b0036194d26ecbmr54961ili.5.1705450023356; Tue, 16 Jan
 2024 16:07:03 -0800 (PST)
Date: Tue, 16 Jan 2024 16:07:03 -0800
In-Reply-To: <000000000000af650105f0e7a9e5@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d31227060f190634@google.com>
Subject: Re: [syzbot] [ntfs3?] INFO: trying to register non-static key in do_mpage_readpage
From: syzbot <syzbot+0ede990fe8e46cb5711d@syzkaller.appspotmail.com>
To: almaz.alexandrovich@paragon-software.com, axboe@kernel.dk, 
	brauner@kernel.org, jack@suse.cz, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, ntfs3@lists.linux.dev, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 6f861765464f43a71462d52026fbddfc858239a5
Author: Jan Kara <jack@suse.cz>
Date:   Wed Nov 1 17:43:10 2023 +0000

    fs: Block writes to mounted block devices

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=102de4dde80000
start commit:   090472ed9c92 Merge tag 'usb-6.7-rc3' of git://git.kernel.o..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=52c9552def2a0fdd
dashboard link: https://syzkaller.appspot.com/bug?extid=0ede990fe8e46cb5711d
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13d4a3cce80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=160ec6e8e80000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: fs: Block writes to mounted block devices

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

