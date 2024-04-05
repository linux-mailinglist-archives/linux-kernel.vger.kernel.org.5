Return-Path: <linux-kernel+bounces-133700-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F7C689A783
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 01:02:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 08611B2568C
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 23:02:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2205364A4;
	Fri,  5 Apr 2024 23:02:05 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0374225779
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 23:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712358125; cv=none; b=b3DKurO+dubxXXkXTvOnFLN4H+NG/fnn3RdyGXNVN0HDhIk+SI6S3MfZTrF5jLbUFDeqkxE2vR+69Q1tPlRYzFFKJxQjztllpBIpS5qYcmNdOwXuT0YopKbVT4VaRpAEqs7HfWQXZjVKts2ntG8wUgymbgEKh79cuYSTIsJqw/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712358125; c=relaxed/simple;
	bh=ixrOE1SteyEnz12erCZgFZg0wXSm7q3sHKY/LrJW7K4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=U0nDiXbZQjQKAgQBeiM4UV9PERQHAxpx2QsrzXJaAORvdFx5XRulbnAdGCQy2g056N1HgqkWQJYdJmIynXFMHlgh/EiOHMz5bAPpcxUMY9JEcdazZck2au/c3o4AREm5KAkJIdpzSgX1NRU/kIV6RxCcI0RvPQwu3RFr7C6pUqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7cc7a6a043bso265313039f.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2024 16:02:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712358123; x=1712962923;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nIwAMlPYWnbrCpP6glioa5GwkPMn9lFHEV3xwqckWtU=;
        b=ovGoIEXlUBHAc15avWXjwyYeB/XCG8y1zaEeILwGGcjxyqM+hy5nk8Px2crOV4M/xx
         QpB6z2/8B3BMHsSnVB0jMk95OUiheXerCQclGJkTSsKiI0u0jmyynK84wwGtLMcs1qtp
         4BxPxmiwBTW/cwyxZQDukA5QbeWzVVvVjXF5AM3kHo4EGgybOao3CZP3v/qqx5utSj2z
         aDrRuYxRCrPXbBnGhMV3FrFBvB3u7t37e2K1KTEZ/1pzRgPf8nhC1fJ/m5/dPhNBQDhF
         ZGOHUQayk4NnjDWD9yQolvaYG2Xz0ECz8cbm+LAE5zCtrSmzh0gueN9l6HYh5t5cc2MJ
         BXAA==
X-Forwarded-Encrypted: i=1; AJvYcCUk2hlb4lsHhq7z96Dh2haMCFoa03iowCQoDpK4xItjqyxzXyHCb1Kla31LWzyKBB70LBOf+F+S9ADasCMZeNg1a0CjftHuZwmoDJRU
X-Gm-Message-State: AOJu0YxaOlaoBulVPoIOy2JNnsDzchumBPPO4N/HVLqlN/zsYVk9zVU4
	bFXm2lz9l9o0xx8Z67GqXu9g8uvuDen/RBQXxTMeloy1wvB/pj2KbHez9LJNkgi6DcZDJvtJJoE
	iYObDlwd46OxK4juFhoIJ2inhtxHhMgv0QXgf+hKhCk5YrmPsMRFGvB4=
X-Google-Smtp-Source: AGHT+IH14j+9SKXJyYvXoxFIv6JlU/C3pwwhqd14JjDzLBTmx7M0FFSfzkJ5SELv4hHpWgNni731lY6okuqjM4diTdbhsrDqbXUz
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:1587:b0:7cc:2522:f5fd with SMTP id
 e7-20020a056602158700b007cc2522f5fdmr48743iow.1.1712358123207; Fri, 05 Apr
 2024 16:02:03 -0700 (PDT)
Date: Fri, 05 Apr 2024 16:02:03 -0700
In-Reply-To: <20240405230034.1015-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a98dc7061561716f@google.com>
Subject: Re: [syzbot] [kernfs?] possible deadlock in kernfs_fop_llseek
From: syzbot <syzbot+9a5b0ced8b1bfb238b56@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to apply patch:
checking file fs/overlayfs/util.c
Hunk #1 FAILED at 639.
1 out of 1 hunk FAILED



Tested on:

commit:         fe46a7dd Merge tag 'sound-6.9-rc1' of git://git.kernel..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
kernel config:  https://syzkaller.appspot.com/x/.config?x=4d90a36f0cab495a
dashboard link: https://syzkaller.appspot.com/bug?extid=9a5b0ced8b1bfb238b56
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1591ee15180000


