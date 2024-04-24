Return-Path: <linux-kernel+bounces-156275-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BE72B8B00A1
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 06:39:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58E161F25956
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 04:39:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0C8A152DEF;
	Wed, 24 Apr 2024 04:39:05 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12EA028EB
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 04:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713933545; cv=none; b=L9H6l/O+/Az92pKOjb+fM4ywvGSJohtVbSwAt0WrryWNFpUK86jW3EBdXbNu1ZNxxrQ2rwZJRNdoUeZlZKl68nqGRzpMr8wMIjd3xPCCyV0nSK4WbPuiczGUUMcDCcqhNVirb+8CZR0n/bsmiGpeqEYwbjw1J12EkksFVdIOpss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713933545; c=relaxed/simple;
	bh=6bo6Jig61ZZCIU5J7x3qwj47MQJu0RKDeR286H9eSLU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=mD3fRoXHXKC3ZoSiiIFf3KdPKMFU54dQR6M9PPjaRH70ouBLq8sQMiipmvA4UzIYJhSkg0CaoUdb6X8RCKZha8VBo2XmusiEuj0gypUrcRdcqu6wv4+c6Aq6JyliMbhEO1xCzK1EpnQl3f1s9VpRuMfggoORV+VCJrNUicSDpWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7cf265b30e2so798682939f.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 21:39:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713933543; x=1714538343;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=583gPbLGfT8mhblQAJ2r4WS0t+mL2pM/YOuNVsdTr+Q=;
        b=npm1G41RBGInZzyKwfXe0lu+NEq7LOGQf8RpgkNNTt5DAO8EWPV0c0AIWytEmWKDLz
         5Hjqyo3/RMMjg0JnS5PeLuCxpND8AMsxjVvecTNfUluFY/hSuhJGEqblbLvgM21K6BbO
         d7Y/M3Mjg+duSBjqzkx6PYUvBbWQCvoIoCwRR7ZDi+t9HkdyRvhCqs9vHvkvsLbplOM9
         MESriy1UuwXahxpyECehnDBIkUMp7hMoYFt68ixbiKPA5l+VDgtwE5TlpW4oEa3mv4xN
         H+H/Dk91gSGZeLW+yhPxqnW/JN0nqxQGjjYLyATiw2tzauVEYYrXz8e804HgHojUMAaL
         WdHg==
X-Forwarded-Encrypted: i=1; AJvYcCXvdRsXgtrruMRRAWO4iwBbQwAAK9lVbI7sAV6x3t1OzHv8H0Ki5fHq5C+tl/+PXSRFHeX4qbkW7y318G+x2Wm33o1y2cRp9GZgRu4e
X-Gm-Message-State: AOJu0YzTumFqZdSPvtGVfU4ssW8aN6B06r7e+lBEw6LsdGIGMCY9c2r0
	TOKTmFp6/3fXrK0VRyGZ2pQsq4llNa1KS40iXzalbx39pfu+Nio4uCILWjcsOQO4yR4Dnfc6Xs5
	lSRU3MjzmYvXYALR4Un3iNGUa712jd6cctpekMFknrE6AeEXk9bb+0pw=
X-Google-Smtp-Source: AGHT+IEMkBI8oYl3C884wbEfomfOmPamxslbo+PjOB10Xaz3B5Z9HgDgnuPVgrfBKDf4U6vXMe+/twaV36o9PFYBm+/AV+2pOKRo
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:8716:b0:485:986:6102 with SMTP id
 iw22-20020a056638871600b0048509866102mr179402jab.0.1713933543374; Tue, 23 Apr
 2024 21:39:03 -0700 (PDT)
Date: Tue, 23 Apr 2024 21:39:03 -0700
In-Reply-To: <20240424041156.45729-1-aha310510@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000590220616d0401b@google.com>
Subject: Re: [syzbot] [jfs?] UBSAN: array-index-out-of-bounds in diFree
From: syzbot <syzbot+241c815bda521982cb49@syzkaller.appspotmail.com>
To: aha310510@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+241c815bda521982cb49@syzkaller.appspotmail.com

Tested on:

commit:         9d1ddab2 Merge tag '6.9-rc5-smb-client-fixes' of git:/..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/ master
console output: https://syzkaller.appspot.com/x/log.txt?x=13b29a80980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5a05c230e142f2bc
dashboard link: https://syzkaller.appspot.com/bug?extid=241c815bda521982cb49
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=17b75ae7180000

Note: testing is done by a robot and is best-effort only.

