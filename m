Return-Path: <linux-kernel+bounces-89673-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEDF186F3FF
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 09:30:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B4BA2826EB
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 08:30:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A397BB651;
	Sun,  3 Mar 2024 08:30:08 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1239FAD53
	for <linux-kernel@vger.kernel.org>; Sun,  3 Mar 2024 08:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709454608; cv=none; b=Xma73EvBNMJWvq1R+2oBQQpMVs5u9juNpi5dbHjeOfmEaRJqz2xo0Buq3Je6zFZLZ3e10xu0R+dxShU+0Y7Z9lVQHr3s1xanVNybGN7cZhC4KCkRNijQOSmAeXdr690TNKxyZKEw/fdNgyXsSeaBoYIT6DSrzTva+eOgkQUzFAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709454608; c=relaxed/simple;
	bh=ZN6/uX4Tx0/Y6hxHxujw+cQxS8rTAmYY0DHz938FZb0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=k9ukpQCCOtpNCjeAcsOAfoKye71pC/BlG5Hh0vpIgSByfRLvriltR9XXm6KHQrwpmK/+WL/21wnEMr68YXfEm874wQf3lYWDjjtjZkHPFI+9ozehMhn3P/d+wjse9WFM7pOeNnHrOkuRBV2GGB1wfW+lz8y7hy9eNv6Lz+Tr0Qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-36512fcf643so42994095ab.1
        for <linux-kernel@vger.kernel.org>; Sun, 03 Mar 2024 00:30:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709454605; x=1710059405;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Cw6wOjMgK4MwRpjPkZeZa5isVmvzXm/3D1T3RvcQvyU=;
        b=rO+UOZX1NidmvZA8pN3E3k2Hh9wE3LOS0YrC36O9q1Z0p+X351hbwu6D/UZRV4WPJ4
         r3ih7DoiNU/1UjSZ6RekJAGHm767cpHeZQs1Xs4O5QXl8+4ywcqDqTMYSkrLYhmQTqdm
         yMcsRH3QEfRABlbUSNybH/DiGqczFUXApwNkTBrdnt26gkNPK0azozjsNx1wURHjnpLl
         TEa8RNhpz6eYwACSclemZ5WTurzit8nNbFLb6+kbNgKk26eWctLzc+16UZ+RZNUhtYAB
         6GbYe7leww/y/XC3CUFDU+hwKOSPeS+ByoqOXl0asVgkEWfGw1arejfvKCJUVz9q8c2Q
         RY1w==
X-Forwarded-Encrypted: i=1; AJvYcCXXYP847YrtzuwZdK4FIMPrlyXx75A9KWORh/dDKDZfo+TTvs1BC7auz8H6b4voeeAQSOB0dgoNhLeimHDSrxD6hWVUqwr+euO6HAIy
X-Gm-Message-State: AOJu0YxAXk4UBwAJM0ovAxpwkFd/7ctGDawAEY1ndKZoPg1puHGANupK
	BBuJffyvmicaJpQuLLYZuQ0XWWRYuglBZ/VQhclwEEu3tlE+jNweTbEJgxzujwjyMEeriQSdNrG
	ukG7qIFCVFlagi+b3e9GW8Efu0BVfiaTF2KfgR1vkfqB8DaXwe00wSLU=
X-Google-Smtp-Source: AGHT+IHR9m9OWQf2a5daMm1kcCiAq5nUoCcInX4EAJ7d/KyuNCP7k69rkgu5tuf8PQMAEmm1FSHLXoo6Fad5z6jCDdAWcrsKdxpo
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a48:b0:365:2f9d:5f04 with SMTP id
 u8-20020a056e021a4800b003652f9d5f04mr488751ilv.5.1709454605217; Sun, 03 Mar
 2024 00:30:05 -0800 (PST)
Date: Sun, 03 Mar 2024 00:30:05 -0800
In-Reply-To: <000000000000c29dab06004a752b@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000080f93d0612bd6a5e@google.com>
Subject: Re: [syzbot] [fs?] UBSAN: shift-out-of-bounds in befs_check_sb
From: syzbot <syzbot+fc26c366038b54261e53@syzkaller.appspotmail.com>
To: 20230801155823.206985-1-ghandatmanas@gmail.com, 
	88c258bd-3d0c-de79-b411-6552841eb8d0@gmail.com, axboe@kernel.dk, 
	brauner@kernel.org, ghandatmanas@gmail.com, gregkh@linuxfoundation.org, 
	jack@suse.cz, linux-fsdevel@vger.kernel.org, 
	linux-kernel-mentees@lists.linuxfoundation.org, linux-kernel@vger.kernel.org, 
	luisbg@kernel.org, salah.triki@gmail.com, syzkaller-bugs@googlegroups.com, 
	syzkaller@googlegroups.com, w@1wt.eu
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 6f861765464f43a71462d52026fbddfc858239a5
Author: Jan Kara <jack@suse.cz>
Date:   Wed Nov 1 17:43:10 2023 +0000

    fs: Block writes to mounted block devices

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14b5e754180000
start commit:   8689f4f2ea56 Merge tag 'mmc-v6.5-2' of git://git.kernel.or..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=15873d91ff37a949
dashboard link: https://syzkaller.appspot.com/bug?extid=fc26c366038b54261e53
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14237dc2a80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13e34d22a80000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: fs: Block writes to mounted block devices

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

