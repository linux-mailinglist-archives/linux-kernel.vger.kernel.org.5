Return-Path: <linux-kernel+bounces-66575-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC2B9855E82
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 10:51:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D77861C21C3E
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 09:51:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A01F612EA;
	Thu, 15 Feb 2024 09:51:05 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71530612D6
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 09:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707990664; cv=none; b=HxEvxtkrjBAjqtzyYz0Tw+EV0SJ60r4OB723pahAkISoTnV2IRuvLpWdnyVXH+TinwGCCsINXA4ezSvym0mADRt3gIRRZZDqh5aUEV+qxb0Q4gPCeTKeNN/HBAol2xG7PzoUcTSkplUEdW4NpUfGTb+EG1Mmkn1W+gqbOrFkwjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707990664; c=relaxed/simple;
	bh=3pnpxJrgXaPw63XsnoovsLWPftnNYLm4AyzUw+uvUv4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=e00SUR1NWZHdK/PUiyD6BzviBPXr722mghsN+KGKMGaeV1vXgTnZGdryBC7geZToz8J/EMe9S82OyL4jgrU9BcYEjM0EYaBHKzSAS00a88hA9UTtXf9cugZaHYu8Hq1j78msrtIohf06KxyWfAAYSYsSLGdU+hlbw60KyOKh77Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7bff2d672a5so46259039f.0
        for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 01:51:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707990662; x=1708595462;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gmxKKjFO5/6YnIW8zYibxXfGgyjlYdgyjimnQ1CFG+M=;
        b=dxhjUPmlfDtY+ZGcj9RssI96Dohmyi9mR7Y/lKb/ZYexvZMfUcNiPZPkikmnR/hftC
         uoN5by8PFwxGk6dAK919j8vK8UiTuvnpq7uA+xFsG23pzh2+1+vwDD4VSj6We4mkionw
         BPw40nXD08bnjSgIhslU1ifNdrZu5tY8+cWCmmnFPvj5CUOJ7rbWtTBjMOHSxc69ZfAg
         lkH/8p0wK2rqyGgmK2FZKsySAwSqbJ41QH3TTOww0ao//pSENpNXiq3LHz7KBi/jtDwk
         vePXUCGZzzgamlFngs1GFmb5nKwkZeWYAGgWXoG6LzKPyI4T2YQXR729GQZ8ye+iqyVR
         2Ftw==
X-Gm-Message-State: AOJu0Ywjstuo5wJF3m4mOQwvZaK0eZVFO3eNEzMALu0AwGuFzQcSDDy2
	Oz1vc1/ziL89e7L9MWuhS4CWROMcnXitEf+w+cx4kiO9F8PNtZ+oymgmyHM4QQmq6LZDkRcww01
	4za+6MGHURWyvqvJEwd/B5T9Repp4ye7EJZmu21F77pYcgT9BJiVvHthudQ==
X-Google-Smtp-Source: AGHT+IHZN9wSznPWL/mQAhMGTWR1w4jHvemlP9tI1IVEnYA7/sUK5Ri2i8uX9CKus2ygXSi8V6BzSI/y2lnqjx8Te1G6xSyXkamf
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c26d:0:b0:363:c8ba:ea5a with SMTP id
 h13-20020a92c26d000000b00363c8baea5amr71520ild.6.1707990662597; Thu, 15 Feb
 2024 01:51:02 -0800 (PST)
Date: Thu, 15 Feb 2024 01:51:02 -0800
In-Reply-To: <CAHpthZr+VHsntmc5QRrL+viRKDu4sWJcX2Yf+oauEv9FghyB0A@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b9553406116890fc@google.com>
Subject: Re: [syzbot] [net?] KMSAN: kernel-infoleak in __skb_datagram_iter (2)
From: syzbot <syzbot+34ad5fab48f7bf510349@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, ryasuoka@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to apply patch:
checking file include/linux/skbuff.h
patch: **** malformed patch at line 8: diff --git a/net/netlink/af_netlink.c b/net/netlink/af_netlink.c




Tested on:

commit:         8d3dea21 Merge tag 'mips-fixes_6.8_2' of git://git.ker..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=f3f069371247b697
dashboard link: https://syzkaller.appspot.com/bug?extid=34ad5fab48f7bf510349
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=15ddfa78180000


