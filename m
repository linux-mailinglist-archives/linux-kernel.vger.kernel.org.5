Return-Path: <linux-kernel+bounces-47423-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DB070844DBB
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 01:18:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A2851F214F5
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 00:18:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9448139F;
	Thu,  1 Feb 2024 00:18:06 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D705C7FE
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 00:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706746686; cv=none; b=A2goPlYd40fCP0mQuXwmdsXfd+ozv3kN0LG5kBgjGDTfnS4WS7pwIdO0Issajx0zT1JZmxsVVjwN7gksawbA/kmc5Ff8EuJ2a4jL9PyM/m0X2PTxpj5W/Lh3bHw0kqsHZmznyyKStzpW8uB7GLQaaR/qODQjPsZfUgU+VHilkvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706746686; c=relaxed/simple;
	bh=PIjQaauQrMJL4q0PQuX4YbhRIIJVN+zxU/EqvNO6d+w=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=VGt8j0ZAbMlQ/g5ETcMHkMj3/Fy8Cbcz/zYUHU2/bZ4go+HpsdZpMmmTiL5U79g4Qd3NFso7xzf1SvzAd8UVByj+q5WAdfHke9nNTEpRw44zERpzo36S59OPsN7wliDSfIu/gj2CFPA9etd3XuNdthrB7E9uLCEAJqbhonrpEEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-363922a1774so3565865ab.3
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 16:18:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706746684; x=1707351484;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ggd6dYJYh6eRAE6wjPnWP9G51S1L9GCu8ycel/OOJ9Y=;
        b=pLJpdNDcYNUB5YGguv6fKblI5PH2v6NXcieNNufUaBjRq5OsRDMTC5QRq2Yeph+GoK
         Vq2J90n4lMpfY5hp2ijd+XhOF8o/tuus3abPBjjvttAKYanOX/aEJIdXEw9EeoaDaDml
         pb0x/ZEBxaZz9z82mS3eWet1S65ppfDj9b5qqFkEza+fglakrfED5kbtkvNrdJvLfHy+
         Qwx94NxR/ORdnf51NCBI3P07qV2WI6oC2L65BKUn9O0IjBkRBAkNqxtY0MyRQRL3JfWQ
         c/52iFAvKw/CR2liv9twWatcxs8XY6VItD5Nag9UzUUN6RYnQ2FUwR2lscJaZUTea0hd
         Gz6Q==
X-Gm-Message-State: AOJu0Yxyxz5SGwJgVnmHhNP3EaCxQiO1k9KujM8Ml3XGYU0+tTPTI7G3
	sl8/a0ufQCBktGUFrg0yD82zkZiQ2UC148gSyZ6GhX9xsYGHFOQXI7zzHBNBW2qUwiYE+6Ooh4c
	r+q6IEfNBLH99p/hfWwnHoeLtqRs/K20iWOKgN+GCaHkvYSkCwgQGoV0=
X-Google-Smtp-Source: AGHT+IGIVTSZRTe7N09LDAX5sYY3Q1nahbA9DirEhlxXvrhYtZ2wcE8SqmtJXnwnMcFT8wwJgoQoa2+/qWeuZHpJ6Rf5QNCBG178
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c24a:0:b0:363:80ed:b213 with SMTP id
 k10-20020a92c24a000000b0036380edb213mr51452ilo.6.1706746684055; Wed, 31 Jan
 2024 16:18:04 -0800 (PST)
Date: Wed, 31 Jan 2024 16:18:04 -0800
In-Reply-To: <00000000000024d7f70602b705e9@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d33080061046ed47@google.com>
Subject: Re: [syzbot] [udf?] KASAN: use-after-free Read in udf_sync_fs
From: syzbot <syzbot+82df44ede2faca24c729@syzkaller.appspotmail.com>
To: axboe@kernel.dk, brauner@kernel.org, groeck@google.com, hdanton@sina.com, 
	jack@suse.com, jack@suse.cz, kernel@collabora.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	shreeya.patel@collabora.com, steve.magnani@digidescorp.com, 
	steve@digidescorp.com, syzkaller-bugs@googlegroups.com, zsm@google.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 6f861765464f43a71462d52026fbddfc858239a5
Author: Jan Kara <jack@suse.cz>
Date:   Wed Nov 1 17:43:10 2023 +0000

    fs: Block writes to mounted block devices

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=11282540180000
start commit:   55cb5f43689d Merge tag 'trace-v6.7-rc6' of git://git.kerne..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=e5751b3a2226135d
dashboard link: https://syzkaller.appspot.com/bug?extid=82df44ede2faca24c729
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12dbd63ee80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1534bed1e80000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: fs: Block writes to mounted block devices

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

