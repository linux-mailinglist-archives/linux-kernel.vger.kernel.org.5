Return-Path: <linux-kernel+bounces-151637-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F2828AB168
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 17:12:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2048A1F230F1
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 15:12:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1AB412F583;
	Fri, 19 Apr 2024 15:12:05 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0663F2B2D7
	for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 15:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713539525; cv=none; b=VlOi3RfJy3X3rUnBxXxD8yT5ka69lIzZN7jKHL/aKgqBeOOO1/3+me8oShXDui71C2Ian5fTRN3Fqs2zQFRV+fPPCgldiQkQUavkbHQ1dQe/+cR2N3T6FQ0g8VfuUQtc+S4mhbeVwuans3RHpEfpYgspePPVZJ7okLPyjQRtuHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713539525; c=relaxed/simple;
	bh=SsRXqmSy8QE5aQWsa/dxGQN61BUt2U+6H4yE+UF7QYM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=d2dHUdj1/ilxt4iqmCc7ZYoCYkyqASg13aUDCMe78+RiY/ydKN0qGFdTSCkTQzwDwUXnhNyFyf+quDElscuBaEf2GARUMInQ6CQep7/ep2XFH9oQRMHgehDYw1DFcRDEEKBSlaFe6leOXI/yv8Q69ze/72mKjltBXodFHHT03iA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7c7e21711d0so203265839f.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 08:12:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713539523; x=1714144323;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/56F3mnA51IOOTUzAKWSkjYtV4LEcdvzPccLISekmdU=;
        b=BjWDI+uPhE01x8RUqECRUqab/YPBxRXhaji8EV4FX0qRTK7ptDwKOpXRxw4M7P++A/
         ylvm0OW9HJr9r0YLx6cS39i2nPb3dsltrQPVKy/FnmKvLKcRJzqLg0IGmLvXGjn/BKnZ
         5LCXXuRQ2XUs66oCpf0ZGsyw7mGUtelvOD250HW3HxEgBa0HuIuCSILpXBNWxbbEAJei
         peAVJ26G+XMuCOjX8Sr2+egfICZKZX0bRY9JffUHM1kEkU7/46TBVDOTqrfdGT4vN9ls
         FosT5jj0vRvO0CePiEsTKvM6d5wZ9t3LnX6i2oSOo59aaC9OA+vH+wL9XIGLr23XGDW7
         c77Q==
X-Forwarded-Encrypted: i=1; AJvYcCWczu3aW27u2DrleBSNpoyGAxJ6qtZLsMg8IWe8GIZHdPISCOLqVbPjq/jYnZGg/xhsQYUTPGhmKjQ9FeatOHETbMTkTjKHqy21glpf
X-Gm-Message-State: AOJu0YyOeiq2U2SgeVtDbndxtwBQ8Fi4jCrrRI4SZr0PL6H8GuL2tukr
	cZ+oEeqF3pDt2mmYlkXurO2N+kf668yzdM0m1NKlG/KaqwqEMIMtK7Dug2btARQINiq6Q+JbUyK
	9d82ByFcOTbvCzavOsDy1yLqSqNC7aGdjSMAjay092Rr9p3BycsXw6VE=
X-Google-Smtp-Source: AGHT+IG/Xj+10nIXjImfs8+rkUgpqsFX0J27Q6dptJ/rtHlcGYh90Aoz8Me2JNAvKn5PYZhhREPsz8zGTNWhWA6psYPEeDPArH+K
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:4410:b0:484:e666:215b with SMTP id
 bp16-20020a056638441000b00484e666215bmr45801jab.4.1713539523225; Fri, 19 Apr
 2024 08:12:03 -0700 (PDT)
Date: Fri, 19 Apr 2024 08:12:03 -0700
In-Reply-To: <20240419130312.11392-1-aha310510@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009738e9061674827b@google.com>
Subject: Re: [syzbot] [net?] KMSAN: uninit-value in hsr_get_node (3)
From: syzbot <syzbot+a81f2759d022496b40ab@syzkaller.appspotmail.com>
To: aha310510@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+a81f2759d022496b40ab@syzkaller.appspotmail.com

Tested on:

commit:         2668e3ae Merge tag 'scsi-fixes' of git://git.kernel.or..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1405f520980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=87a805e655619c64
dashboard link: https://syzkaller.appspot.com/bug?extid=a81f2759d022496b40ab
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1341bcfd180000

Note: testing is done by a robot and is best-effort only.

