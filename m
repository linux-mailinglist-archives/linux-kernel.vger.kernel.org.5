Return-Path: <linux-kernel+bounces-165153-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A095F8B88BF
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 12:47:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E5C11F234DE
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 10:47:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0C2954FA1;
	Wed,  1 May 2024 10:47:05 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36E504F881
	for <linux-kernel@vger.kernel.org>; Wed,  1 May 2024 10:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714560425; cv=none; b=O+CTY4Hs5cFn+D39sqAC9Y5MIpDrW4rkI7ORrNveL8YQAXiTkU7Rwgz2+cZiuTWyxWI/9b/KhpIQi8+E0Gv+pGBiqjNNwMbwel5HXDHhBt3tMiYTt7PvHzWBVQN/pqGx8ZW+Ddw3T+7MT+Nce+8SkDD3xbaYMn+MleH1OlmIBTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714560425; c=relaxed/simple;
	bh=gkbRyda8zW0MP3mpUt902qgZZ1p08AshalbW4SjCNig=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=DuhzqH47jFckpP6NfFtQB5w9PaJYeb06IqCSXFyo5dVrLqm1rs/NTViO2iwXsLROz2J6l0v7NWF5xrQWIEKkx+8yuw9vF/nExVEKmGQH3G5HElVWjPOKJ2CqoGbhMty7qZfb3fkivH+CrM2M51FuY8g9/J7bNmC1gYmu/V2Rnnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7dece1fa472so319526639f.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 May 2024 03:47:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714560423; x=1715165223;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/MN2pQmBAI1MACi5nYgPI4fn+xYIdQ5GZOyyAVmwxQQ=;
        b=vQpinkeI1mumY6tWpAd9VI4TojBM25DFjsjmTP789aqwl4kmkOeAmDA/1ojrYads3p
         nIUgAdZLsosM1AuyEzyY9W5KFDqKAr5+5BExYXgxfET332VM3J/QXP7V3XURgKCY5YeR
         I+BHYiMAVSKzjDzPPqrPZBZodDNcBtW2a3YOegDSNZTX7/z04lNSRJErncsYFqAeDA5L
         Cgn30KD3u01np1E6LXi3740rbmk9A9UXTZ3FpnfAeO1kRaBAYDE1tX+aKTEKAjziN2Lx
         dhh7fST0GXbswMCUXqtjdvGsdZWkKZxa3KENIDw1eR0/y+xsrv+ZbuwEtqoqbcd2EKEr
         rAmA==
X-Forwarded-Encrypted: i=1; AJvYcCX9S9vsbcFfz3nqzKxhoOwqsRnMx1us2EVEdClcLyqP0gfcwDo/KU9Zi5oDGH8nWVi8xzcBYysV9jpyVPQfzRIx1Nnrdgquq4Dn3DMW
X-Gm-Message-State: AOJu0Yx02CgRdOQmR6yp4dQKIlnUqCd7BXVI6e3zYf7WIIS3q/qZ3YVK
	5Ujyru/dSPNAK3jwnrKHCEv+nZbV7OLsEHwRxqE/y5f+mZ2yo2oQK1NH9hRFleUNffaY5VNDb4Q
	l3H/fgO9BxqmoOXC7j2/LdkdonbWxlcTDebwvZt4a38WLBLAY/ji4TM8=
X-Google-Smtp-Source: AGHT+IGM00MGZGP126Ta25UPKJwO/gsxkhbokR94QKrj/l5WkJ+zQKowfaGoz4aSMnHUZiigrcaHg5ipNbori0QtF2WplnZLYWeF
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:1b04:b0:487:3a77:e6f5 with SMTP id
 cb4-20020a0566381b0400b004873a77e6f5mr60491jab.4.1714560423401; Wed, 01 May
 2024 03:47:03 -0700 (PDT)
Date: Wed, 01 May 2024 03:47:03 -0700
In-Reply-To: <20240501084853.1748-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000fbaa73061762345c@google.com>
Subject: Re: [syzbot] [bluetooth?] KASAN: slab-use-after-free Read in skb_release_head_state
From: syzbot <syzbot+d863bc2d28ef7ff42984@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+d863bc2d28ef7ff42984@syzkaller.appspotmail.com

Tested on:

commit:         50dffbf7 Merge tag 'for-v6.9-rc' of git://git.kernel.o..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=102a40a7180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3310e643b6ef5d69
dashboard link: https://syzkaller.appspot.com/bug?extid=d863bc2d28ef7ff42984
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=15d3bcf8980000

Note: testing is done by a robot and is best-effort only.

