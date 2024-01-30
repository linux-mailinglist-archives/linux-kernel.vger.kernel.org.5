Return-Path: <linux-kernel+bounces-45102-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68493842BBA
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 19:24:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24B77282A7E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 18:24:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 644E6157E82;
	Tue, 30 Jan 2024 18:24:10 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88CB4155A39
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 18:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706639050; cv=none; b=qB4l/UfZ20v7NNe9D3OfD/RHI84EJxbSBvdXXli9kk1BpzeyztJeBytmrpVwjXlSpXAv5VsGertAnMhSafpC4bUJTpqpyS82DBkTyiqLRJH++FfB3XQEHUhV4JNqQ71f8QlfslStEwlLy98vYFIX7e/PaH1QHGcmTRAYlzmY6MY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706639050; c=relaxed/simple;
	bh=uoKI6RDYxfXNZxHDf7INMQiHroMYFz/pgjAqVLrTRsg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=F+X1jjMzP5WciI9zTJrGhFWJxgCNWMJy5z1HJ16GNjyN/iuLyP/lyTPtPYxdv3OWTYVjbcJtpu4prJBH5eP8lllVrXpMmeSJF9LIadRxtbFbKFhQoHE6+fxnCLYW5vh3n71qyyqaZQViV0Wd0SWo4ClfBTChqjoOohkSdHXLa1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7bf48e0f513so335263039f.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 10:24:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706639047; x=1707243847;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CV5aSs+6xluhqn1Lle8bIA3VgXMJZ5IHasZ7SG6Dftg=;
        b=XbC+9AA4fLFo4nQteQwPSy9MlyiKHlgV1Gch0naE9QSaLq+2YCk32Jl2LuJA6i4NgJ
         3XGZ4ru3pMMNN6wm+lgBOJFbWdpvBMP/u6ZM1rqvh5OGXl+gZbpRTBU4+q3r6a3nX1m5
         ZsU5LEouuy9HrPvNfEiVDRyvqd5IVYN9IHxzVz517lyE/k++Srxhq6SUlPZzKfndAflP
         AT79FJiQvMKp3fX5sstsArfiKWucPLlpS2RIT/nMRCAdHyiSdRbG9IdSUrxfywloAP7z
         wwLRyP7z5qVY672gVyUoRrE4gmWh08QD5Qg6N0kUVYdbP7b1KAk/y0owyrq1f8BTK9Md
         BGhQ==
X-Gm-Message-State: AOJu0YxGSvdauu1vLeEH6OLVJg9cO2ylUIQosx+YVkEfDhWI+EH0pe4V
	ZiOMHAIVSQJQQqzWgpHxpfPZRIZlcxTqGhtb3jUTB0MOSSwbpjnlai2uPVfXKXSSBdPK0YiiJu6
	q85UcZU4cbVLpwBWZeHpx3Z/ACHMoVXY/xmWK2g9Z1thtoDyBFrcfHr8=
X-Google-Smtp-Source: AGHT+IGqPlnfA0jiwGiQvSw21UNGIJNql4jllxn8DVhRbkrpiczcaQWyBvCfi/ZU+uSb6Zzyo1VSLAsavb7KAC9C/I/4wKiYZO18
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d95:b0:361:a961:b31a with SMTP id
 h21-20020a056e021d9500b00361a961b31amr855839ila.5.1706639047616; Tue, 30 Jan
 2024 10:24:07 -0800 (PST)
Date: Tue, 30 Jan 2024 10:24:07 -0800
In-Reply-To: <00000000000014b32705fa5f3585@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003172ac06102dde5b@google.com>
Subject: Re: [syzbot] [btrfs?] general protection fault in btrfs_orphan_cleanup
From: syzbot <syzbot+2e15a1e4284bf8517741@syzkaller.appspotmail.com>
To: anand.jain@oracle.com, brauner@kernel.org, clm@fb.com, dsterba@suse.com, 
	johannes.thumshirn@wdc.com, josef@toxicpanda.com, linux-btrfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit a1912f712188291f9d7d434fba155461f1ebef66
Author: Josef Bacik <josef@toxicpanda.com>
Date:   Wed Nov 22 17:17:55 2023 +0000

    btrfs: remove code for inode_cache and recovery mount options

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=103f19fde80000
start commit:   1ae78a14516b Merge tag '6.4-rc-ksmbd-server-fixes' of git:..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=50dff7d7b2557ef1
dashboard link: https://syzkaller.appspot.com/bug?extid=2e15a1e4284bf8517741
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1255f594280000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=165b28f8280000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: btrfs: remove code for inode_cache and recovery mount options

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

