Return-Path: <linux-kernel+bounces-89331-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA3DB86EE7A
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 05:13:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60F981F218EB
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 04:13:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B3281119A;
	Sat,  2 Mar 2024 04:13:06 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD54D10A05
	for <linux-kernel@vger.kernel.org>; Sat,  2 Mar 2024 04:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709352786; cv=none; b=fsUe02+ORMgP2F23khMzsyJWbET55xeT3kklHYmw/d7HbfmInX5Ukyt4Goq9YDzurwW32E4WsMaueRHddkOuduWG13UMqrthj6nOGCUx++mCCWZG8SXzWu4wT3svsy3FYviGbMjw3LcxIYKfcvTLyvyyTFOmmkU32k9c2XfH6kQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709352786; c=relaxed/simple;
	bh=xXL3eGNtx4fKbLGwUddCJ6Z89zxBZxOIhwZ1upx7U7o=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=ZMhwv6iHl1v9ictgA9QSxDsZ/ppaR3sWb85m8q5T9C3MwnxTz15sxiHDrHywz0WnTYazL8VscpEaM8+xAcVQj/RgwDCpeW3hvd5wwkSYwag5pQ+BtYpWYgCrCUA11sOWGi+IetEf31WlkPNq5/fwh6nu8PQbpTB/glRaVsKvuMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7bec4b24a34so344458139f.3
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2024 20:13:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709352784; x=1709957584;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IdmhwINwWJtxlnecMtQfHBtNVjXurznaLwVzNHPbLS8=;
        b=rZTqDvKfls2YjtzAwZBdbGPT/0LhEL5S5OBwR+Jeo/UYF1IycvVZCyC9MzeTwwZ/ek
         9uEQth1YTe2dFS/04y0YHmKNLfbY/TAHmuM4BSp8I/ciMCutq7rQVh9bLI7ahHFSQeVY
         Y5UT88hYjRmHXrJKsYkRcN0aaar+Z59jh6WOqJd27skumqYLD+gvX2QWEpSJkb8crZ/Z
         Bl9Vy1nFUllYk6nEe8010T9aPwW7cR3CravxGOdPjy197BVF3sYLDO4psQoUMNnSfrAt
         shQj1/CUjUvfzVuYVRwk58OWuAvKdm5YSojBExppp5zp6o/hzImxk8yYibQ8KEpPdgB7
         3S9g==
X-Forwarded-Encrypted: i=1; AJvYcCVT+0/gg4IzRRBTc/MzX0Q/mEQyhAXSm5uDu7i29VVRHb+D1KcPNDfA7UhFsN01YjDcJYDI+JQrnV11VtLxbT3dO58NoxRZKI2HuhlN
X-Gm-Message-State: AOJu0YxsVFS1MAe/bSFH2Jbd4gJsBSzxbZ/CgeZBPF6OiphJHvY08xEO
	pKvlKKi+eQaxnx8RTbrwz3e3DVptcSc90znFKK5DjAjvxdNzAG6pyjIdFZgg9XvDZPO7ecgbeoX
	WwO1t7RKzcKvIHBOJYDT7TQSyqO04UZplXNRvg02l9fZ/fQLglOUrwBM=
X-Google-Smtp-Source: AGHT+IFeNymewDoQQ2b72fsvKz5+EwmHM6NPkihOCvhrd4QX5nncJm2ScXvMMyOAUFsw2cegVJkFRege49tbor9AsksLq7WQhdRg
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:411c:b0:474:d1b9:10d9 with SMTP id
 ay28-20020a056638411c00b00474d1b910d9mr140269jab.2.1709352784115; Fri, 01 Mar
 2024 20:13:04 -0800 (PST)
Date: Fri, 01 Mar 2024 20:13:04 -0800
In-Reply-To: <0000000000009a7f2105ff02d381@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007e3d4a0612a5b5a7@google.com>
Subject: Re: [syzbot] [reiserfs?] [mm?] general protection fault in
 unlink_file_vma (2)
From: syzbot <syzbot+7fbdbd17a5bd6d01bc65@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, axboe@kernel.dk, brauner@kernel.org, 
	jack@suse.cz, linkinjeon@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	reiserfs-devel@vger.kernel.org, sj1557.seo@samsung.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 6f861765464f43a71462d52026fbddfc858239a5
Author: Jan Kara <jack@suse.cz>
Date:   Wed Nov 1 17:43:10 2023 +0000

    fs: Block writes to mounted block devices

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=12d80bba180000
start commit:   547cc9be86f4 Merge tag 'perf_urgent_for_v6.4' of git://git..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=2cbd298d0aff1140
dashboard link: https://syzkaller.appspot.com/bug?extid=7fbdbd17a5bd6d01bc65
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13a58757280000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=134a0f1f280000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: fs: Block writes to mounted block devices

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

