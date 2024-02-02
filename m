Return-Path: <linux-kernel+bounces-49880-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FCA18470DD
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 14:10:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5077C1C24882
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 13:10:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CB6517C67;
	Fri,  2 Feb 2024 13:10:10 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6570A4428
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 13:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706879409; cv=none; b=h+xFXTEa5wkLJD0qJYubXZH+1SJQj61bkYUlFm7OiGQR266Sm+yTZW1fnNegF4/VJfCu/gpe+jehMbYCQyhczMu2CLh/GZpyrNwGMmPQ3/SkWwTWHmd1sxkjjChM79QCJ//ZttUUfD8YytXJFcEukAmFcvo7Ab/6BmweYGnjZK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706879409; c=relaxed/simple;
	bh=LBf8buy5poY+NS0GYvRDNK48Nk1TYBvdvQu6HaI3d/E=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Bs8cwdcrBJbR5Ye7X8pZKIguiXtYlGlODXklCi4+VhkBV4obGE/7L4Mxaa2HR5BUddBVns8Wh6CvI6RRNLcnxhXsOyBKb4/rLZzTLkUPqgTQcUyT7MetacvpfDlp/MDUZPRxG8nd02wteUs6aO24/6sxspSU/9AYm5NL1PCmHxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3639d04fd20so16315115ab.2
        for <linux-kernel@vger.kernel.org>; Fri, 02 Feb 2024 05:10:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706879407; x=1707484207;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Rn32f54FUWIaPwEWmlIiCl0R2R5Uf9C1YWuHoSmPevY=;
        b=lcDIVj7a+T0ge2ZNlfzVPLuErQdeam/Bp611YSf6sOh8MGG001HSGFytxHcOSCeinQ
         zURcn7vJFCJIHgN1wANK3PLGNKV14L6C+hNDldaMoIsJkpxWVr5qhvCibH8bG/Pi0QMY
         XyzRmopEcQWCcdWZrJL+5qbhwkc+dQiicTfxfjVu4mxFDgBXepVdZpfF+Fndm1gkYpdk
         a/B6oYZCA8s+qj5fOzu6qi5kNvIBXl79+R6dabDwaNiE3igDyFahk8Wli0U3ZnmQJnG5
         hIq5s9w4+fZS9EBvkcis2IQ3msPeL+mtKaIHyQQNKcKPH0mDcsqQbMivs4gsRlrxp7Sc
         9w7w==
X-Gm-Message-State: AOJu0Yw10kwUauZkg5jf4Lf6a42jwhZ4SuULnFPllGd91cSLxOGdJO/2
	mozOE5PN3nuvgRKwY8fUCCAlu4FdfqV4/um71W7A7e+3Xy41DcwiGlwqxMjPIy0XyhExwXUlZaf
	QHFol2+vmc+eBVQlPA1g3xLBREVdHlMcTuGGcm4X2BzbqFs7hWv8z8Hk=
X-Google-Smtp-Source: AGHT+IGGeGasBYLFJUuxEmv2dofqJ3OITk3AlWwSqLvyBEB3G9I9nzJmW6lobWupv1EPXyNtHNn4w+m/yjmIYuTsirF+Udq5+Rd1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d99:b0:363:93a7:8925 with SMTP id
 h25-20020a056e021d9900b0036393a78925mr707995ila.3.1706879407430; Fri, 02 Feb
 2024 05:10:07 -0800 (PST)
Date: Fri, 02 Feb 2024 05:10:07 -0800
In-Reply-To: <tencent_620E966237DC4A4C740B777367123CC53609@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c1250d061065d424@google.com>
Subject: Re: [syzbot] [netfs?] KASAN: slab-use-after-free Write in __fscache_relinquish_cookie
From: syzbot <syzbot+a4c1a7875b2babd9e359@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+a4c1a7875b2babd9e359@syzkaller.appspotmail.com

Tested on:

commit:         076d56d7 Add linux-next specific files for 20240202
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=1078ef2fe80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4eccd90d3ac887b2
dashboard link: https://syzkaller.appspot.com/bug?extid=a4c1a7875b2babd9e359
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=107ff390180000

Note: testing is done by a robot and is best-effort only.

