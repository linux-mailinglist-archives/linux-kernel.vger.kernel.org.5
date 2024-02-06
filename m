Return-Path: <linux-kernel+bounces-55140-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 78B2584B853
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 15:49:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36750284D4D
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 14:49:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99694132C24;
	Tue,  6 Feb 2024 14:49:08 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7EC5A59
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 14:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707230948; cv=none; b=kdV4JGSRRg9jmzPSeKnp/mPT/AU8HuonOylxEQgdhcjnGK064eSz7AHUNS2iVikN1osX93LEnfv0bc9yp7n+9DvRL8n++67y15MJQtx0nIqGeKRF2WMpsddaohQeH8yMdT0Dh31bPfFw8XTFS/OtaODUSN3QZzwcZgAmO3LlkYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707230948; c=relaxed/simple;
	bh=ZYhM25AzuOO8uiA+4AJts7dxWvnoP0sziHlbTBDdgdU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=T9tzUqnlCZiBvT1KW6mvvRNWxIyLJ+YjmwW6NldAt7ssJbZzwGeXRQZWNtMdPQHoPSi1Tsr2nb3vdHB+15HgedKNY19HzLZZdjn2JEIwdrc5TX1VvbcHb1OsKcdCeMVjU7RZd3n2q9Br/dcfUIb3QuG3hApw6hHNLWejU8QqLP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7baa6cc3af2so619694539f.2
        for <linux-kernel@vger.kernel.org>; Tue, 06 Feb 2024 06:49:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707230946; x=1707835746;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kSrsdZ/RuKV0gEG27LOO5dIr8YmZtFDZ3FYa41rVAQo=;
        b=Dw0CEaXxySdgyu9DqljxKK/uwRKy9XoC+XnP7IB3IU7ueVrejYLVqU9kJcQzg9oInu
         k3vT72pdPMOfcAj2/qvSM/3O9lMSDhJNQ8VHBJ9VFyUrbj9NmdTZY4Eypu7jNoqA0ssp
         jA6i5SKDmzRbw7ioiZ5JN0ElJuO4tFYt9+KPSJpUIXGbhRM2Dn08XWBSlDPtScoAphAz
         5ThhOnF9+Xx8RNUjUQcT6/AsGnyC8Im6TP10+K/dtxbIiz/Gcxr9N88qBVmTMUkHmmF8
         WRJihZv9hrvP50CVaD6HBw4g3HoWwjfTRp2RmEkeCtHqqQTQ7A58si5YYPW5UVX15OSB
         kGxw==
X-Gm-Message-State: AOJu0YwZHd1mesP4udBChR0ToE3U8yf6+D0fe5Ga/i07zgQ2orjLbNwl
	ZVYVtNO5R07VKj3eEiZLNjJxbPqmsNO/KNvYBfwjjSpiaO0kqq79hbUCs/w1ZEBQp2waV/z6EaH
	8Q2jF569XL/uD7bfFAHuvqV6GH3l1dKvFIu08zpqib1WvJQWuEPxlpfU=
X-Google-Smtp-Source: AGHT+IGyJ27bMyWH8/GynoFXTjuNU5g+uu1OXbn98nBQ0bYYkpj0BC/KPVZdYE7KwK+zDcXtX/Ot0QVWkk9m9WuMvI7pjKLzBruq
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:154d:b0:363:a059:670b with SMTP id
 j13-20020a056e02154d00b00363a059670bmr186965ilu.4.1707230945919; Tue, 06 Feb
 2024 06:49:05 -0800 (PST)
Date: Tue, 06 Feb 2024 06:49:05 -0800
In-Reply-To: <000000000000332a2505e981f474@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000014c9ca0610b7aec6@google.com>
Subject: Re: [syzbot] [jfs?] KASAN: slab-out-of-bounds Read in dtSearch
From: syzbot <syzbot+9924e2a08d9ba0fd4ce2@syzkaller.appspotmail.com>
To: axboe@kernel.dk, brauner@kernel.org, dan.carpenter@linaro.org, 
	dave.kleikamp@oracle.com, ghandatmanas@gmail.com, jack@suse.cz, 
	jfs-discussion@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, 
	linux-kernel-mentees@lists.linuxfoundation.org, linux-kernel@vger.kernel.org, 
	lkp@intel.com, llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, 
	oe-kbuild@lists.linux.dev, shaggy@kernel.org, syzkaller-bugs@googlegroups.com, 
	syzkaller@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 6f861765464f43a71462d52026fbddfc858239a5
Author: Jan Kara <jack@suse.cz>
Date:   Wed Nov 1 17:43:10 2023 +0000

    fs: Block writes to mounted block devices

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=13767e8fe80000
start commit:   bee0e7762ad2 Merge tag 'for-linus-iommufd' of git://git.ke..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=b45dfd882e46ec91
dashboard link: https://syzkaller.appspot.com/bug?extid=9924e2a08d9ba0fd4ce2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=152bfc22e80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1608f4a2e80000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: fs: Block writes to mounted block devices

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

