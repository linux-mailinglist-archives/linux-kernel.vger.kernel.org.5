Return-Path: <linux-kernel+bounces-66679-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DB2985600D
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 11:49:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE1C1282F6B
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 10:49:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 735C8133982;
	Thu, 15 Feb 2024 10:39:05 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C1E0130AEF
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 10:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707993545; cv=none; b=nyRFq+T7vY6hesdQo3YYrhAWFCQmgy2aNMmznZ++ICXmEnLHoz3wfCATa6NOH3iljgOyC6c9WDNzJNjdnHaYEcimX0i+zKvWbSpcX71buZ7MUV9dowlzahYOP+CT/Grzd1x6uRTsyAq2xmyuRsD72pRwMapA5mp8rq58o7lYY4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707993545; c=relaxed/simple;
	bh=H6KjjOJbPOIoFcUhn2gTmjGLxY59IrsqrkkssZ1B2Qk=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Gm123yl8Z6C6mf66iGgH8gRXyXi+q8HWz8Qq5uuIkUTb/rwx3qSD+E98rdamxoOt7lbgM9uy9WzbsRIjY8UZuKySMRtf6RioWI7a9gVLyiYddbVi4193qsFI1R03egtSe6r+q1X8EQ6ODO4cj0sN2JASHoQ2PkJb6d2BPgqubBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-360c3346ecbso4415535ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 02:39:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707993542; x=1708598342;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rpk4en3WxzhFfDMjLLHiNKFTg3k8zqQkMilegSEq4D4=;
        b=iEXmam8HnV9EFgcpkMf4vc2FBaul/ID63S0rrEuK2M0G8Y1Lp86YhciRGbe1h+MWsO
         tLckO58PZ9Qsn8Be8cbz95UgCtapN9MTNcDVJ6zy50hrTo1UBgjcdFUHRu6rVu90DvGX
         9iQ3e1KgJZVURy29nr8FwaFHKtAfVh9VhcT06bM8TTNNP/IP6noEqxI8LnxIYhfrhxbC
         Qb4eLdqRaF8jPTnztGUsxWgWUHPB1Fk3ILH5F6buRGH3gg4x6GHEW+UdaTOqoZGE9hQW
         uhua0zMXfoNMtWMAhQr5yq+NcDMHbXF2U+LcRIu6L/jYuzTDEay5HcYxLxzYxlWALW5Z
         l0GA==
X-Forwarded-Encrypted: i=1; AJvYcCV8e8ljbcJXUobHHy/IvRo1E7JD4L+yAPBv5cYVbVy1R0yq+w2p9HIUj1/vJjATYuQU7yAoqRKIqpuXsd/WZDuC6pFq6g5V7hW60I1g
X-Gm-Message-State: AOJu0YxBbscFwIr0W4Fnt0xFIsHLyQA6DMlvXMBJvUHaqS++oB4Zh/wG
	vvBMBNRVubPDKMj7mbvhqFKw0OwWyLa0AwxBTEHYzpMR9XeI+vxxZEsic35hBJObh5PZGpC+dd4
	B2JSP64zzjQA3VN52ahwh9D59LANll+6l9O4A69iE/xnAKPIhvl0NyCY=
X-Google-Smtp-Source: AGHT+IGzwE1yoS5VSl71yBVPWx6QESqs9jwHosoaPwYpKJGKQauE3jTTsFKrOMG4UG7XyY4qdxgekVlrSzSA8uQRs4izvOBuCBiD
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d1e:b0:364:1f60:e06a with SMTP id
 i30-20020a056e021d1e00b003641f60e06amr96062ila.2.1707993542818; Thu, 15 Feb
 2024 02:39:02 -0800 (PST)
Date: Thu, 15 Feb 2024 02:39:02 -0800
In-Reply-To: <tencent_4E674FD48DC125910DEA92045DEADDA11907@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006622ca0611693c03@google.com>
Subject: Re: [syzbot] [dri?] KASAN: slab-use-after-free Read in
 drm_atomic_helper_wait_for_vblanks (2)
From: syzbot <syzbot+0f999d26a4fd79c3a23b@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+0f999d26a4fd79c3a23b@syzkaller.appspotmail.com

Tested on:

commit:         8d3dea21 Merge tag 'mips-fixes_6.8_2' of git://git.ker..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=161f04d0180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=df82262440d95bc4
dashboard link: https://syzkaller.appspot.com/bug?extid=0f999d26a4fd79c3a23b
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=167a4410180000

Note: testing is done by a robot and is best-effort only.

