Return-Path: <linux-kernel+bounces-41269-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E0F7983EE3F
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 17:12:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9578B1F22432
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 16:12:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 060A02C198;
	Sat, 27 Jan 2024 16:12:06 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D791224DD
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jan 2024 16:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706371925; cv=none; b=XJvwD/NTS6yVrwE7B8adj4dfkpTc75bY+tKJYO2N/+vcCtKVRWL69uZswnkisAlMD0UQRdR9i9FIoMAmI6xgCHaJkqYCivZ3LryhUYHzQSUpDn/VT9kGuM02OU6Sek8NGgdu9GricbYEmVEJUbPxNCFwudG8HjAXVufLe6pQ9cI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706371925; c=relaxed/simple;
	bh=Mbh52BZbCdx3tCagUL0smHoHhUomsD+AcDYk4SE06CA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=EXXWTFcbJlrVhviyYB1LMim5IuYEjP9fWD+jHNi5bc110UIdA1NiXL/3RYVK+SMDKsXMJxk7CEtoWmRWdQ1knyozL3riEC6zkzzDF1bvEVRXTEHksD6pFpOSyP+0LRubgl4yiJOixXlT+ewJGJseA/flJZWhMmjSclLMk+ie7HY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3627d99cbe5so5920345ab.2
        for <linux-kernel@vger.kernel.org>; Sat, 27 Jan 2024 08:12:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706371923; x=1706976723;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CobbQsqvBTFHX4fAZc4WxCoKNf7Qym9tUoc5Rg1pYJo=;
        b=MxUVItXddsBCWYNZruIg+QC92L3HN+7fp9MlZeGdEvvbiAahJI4Ly+r1L/AMMzx26Y
         HkkKciU/jZORCg+rjUh9NCd1UMZFx4YWW4fOqc+nqagOZ7Pz8A7asOnXUJ51jVR/Q5ds
         bBysylofhWjzQwXXCD+MT8yxlRoi5Ee2+/wwTp39lCXs6GcbJXV4wlZJ5FjOWhG+LdSh
         y/X5+csMg3C+z/b7JAxeoIm66ULxciaZI1cUYrNLT2wi1eLezIwUST/MRq4jVf7+25yR
         hT5dJLUinUDVGPCchy5wMfbN4uqzo7rWX97UzT/9tY+CcZABy/9VXHLZR1knwfTQ30bi
         aq+g==
X-Gm-Message-State: AOJu0YxwJuTPQiG13tkRSVynA2ko7rVSe5jQyUAyCdmam77Wh+3QsP5U
	HsvExhumRnKBNCBDBQImRaedUiDRLNT1FDk2Kk7Q9JoRGeLi3ArUVnQbmAwy/bbg2JpctC+Fdd1
	0yss8gDWEfkrFP7tiLcxdAec4xY1K2hYEyyrUNNCmEmhM1PoyTumSZgE=
X-Google-Smtp-Source: AGHT+IH20cR57PeOLe4lJa5m7Tyz2Wi4IuB5L9esa9+3ULbsHM3Ko4jBOeX9JWSudWdn9mqm9O9++1mU2FyboUkmpzO4cHV3jntD
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:cda4:0:b0:362:910b:2345 with SMTP id
 g4-20020a92cda4000000b00362910b2345mr189662ild.4.1706371923321; Sat, 27 Jan
 2024 08:12:03 -0800 (PST)
Date: Sat, 27 Jan 2024 08:12:03 -0800
In-Reply-To: <000000000000a213d505f1472cbe@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000582e37060fefac1a@google.com>
Subject: Re: [syzbot] [ntfs?] kernel BUG in ntfs_truncate
From: syzbot <syzbot+22e381af27f7921a2642@syzkaller.appspotmail.com>
To: anton@tuxera.com, axboe@kernel.dk, brauner@kernel.org, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-ntfs-dev@lists.sourceforge.net, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 6f861765464f43a71462d52026fbddfc858239a5
Author: Jan Kara <jack@suse.cz>
Date:   Wed Nov 1 17:43:10 2023 +0000

    fs: Block writes to mounted block devices

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=179a855fe80000
start commit:   bff687b3dad6 Merge tag 'block-6.2-2022-12-29' of git://git..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=68e0be42c8ee4bb4
dashboard link: https://syzkaller.appspot.com/bug?extid=22e381af27f7921a2642
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=175a9dbc480000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1542c884480000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: fs: Block writes to mounted block devices

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

