Return-Path: <linux-kernel+bounces-166835-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4615C8BA048
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 20:28:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7765A1C22768
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 18:28:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B62BB17335E;
	Thu,  2 May 2024 18:28:18 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 061AC16FF58
	for <linux-kernel@vger.kernel.org>; Thu,  2 May 2024 18:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714674498; cv=none; b=e3vA0DsQXLThAOx3jvActitFyz0pth/R7YgJtEpsLgkxpWWtl50ksj0Bc5rpZuZ/SHezqZYADjgjQG2G6hU2n9XkZUH6gK9yKhEsRC4RYXA07paomwVulHmrqaXA7+/oZD/m/kTFaysAjnbrfYBcMGL07qBn8VOTa7ieWTrgoqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714674498; c=relaxed/simple;
	bh=UzKx2uEzqgslDAiwUDJyVu5c/uy6CYD26vc1Ic3/26A=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=BCH7xy9zpHEG+Na9hcAXHgk2hwpF2bMYaYVg8vVKNJqYNFbJ+lA/GGol6TSBifcBQWxipWgaHHU/mHSxEXdCUfJbvBZEC+R9r6hSQmgXaKlXcmqf1AYYHzQ8yFlxBDHhYZgUeB1B+UEnfx6Vxr2LPT2OyuqBZEQQaP4vwaV5gAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7decb47ceebso541373139f.2
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2024 11:28:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714674496; x=1715279296;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UzKx2uEzqgslDAiwUDJyVu5c/uy6CYD26vc1Ic3/26A=;
        b=XtXhyqJNU9TAtqKq+f3gWF0rjVlgcplA7dhocC9KRVsqDi1qBC/7m7EfnDToo2O3jV
         r69aLPQtsJ8wpobcXtYgfnO2xASkUcbqT0gFenF+h8O6yX/bZfZmyS6lK6W3y0S2bVfj
         vPwBNNijWdPkYxgr4sZ7yFNJyiPpi5qnoPe9oxspatkGr7ubtKYxTj+rkGvM/0INSh7a
         Ss8Qvn91hcH2TNyOAzu5vWICYFCoFqoS3BihH/qwgZw2RMLpDCN5hbox6gljqTpw7SgX
         TB7QaAJPN9hOtA1qOB/Hz0IanxyL5zYNrrFYsdZpt8Hs99Bx1ZTQkIcohE73HV9idZgI
         SMYg==
X-Forwarded-Encrypted: i=1; AJvYcCVu8dyu0qc5OxCa1oor6eqIjB4GvqKVqTG/7QKZoHq7G8ocYMFJ1BAQuH5pnXzld7iFIfPoCHN6jmeoQ4ZXFRxV0SscKY8SdieGx7ZW
X-Gm-Message-State: AOJu0Yw1NOpbxC5gbaDYipKl/7wbLBx73A/1InFh0N1noOqSkZC1bTtA
	45YDYSA0LbvGIMzcTePfHZDVIFFHOw7Hz+eUCnWP23uCHz14RrMaIgvG7/UjJMa1J8+6Y4AOwTY
	d907Vav7UUcnLDaa6WN64uLE9TMhsbOp2kGuksoerpobH3b674xRoUnA=
X-Google-Smtp-Source: AGHT+IHfvdUjCK5ourMvNUp/Sz8U8WrMGbVCskwFzb4UA2DWIV0LaNKUHAeAIsAIRgbjYbC4dLWbSyCtWhY+2ftEEIG8pt9kXk+H
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:4387:b0:487:591e:6df3 with SMTP id
 bo7-20020a056638438700b00487591e6df3mr5738jab.2.1714674496327; Thu, 02 May
 2024 11:28:16 -0700 (PDT)
Date: Thu, 02 May 2024 11:28:16 -0700
In-Reply-To: <000000000000a62351060e363bdc@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000042648f06177cc40e@google.com>
Subject: Re: [syzbot] memory leak in ___neigh_create (2)
From: syzbot <syzbot+42cfec52b6508887bbe8@syzkaller.appspotmail.com>
To: alexander.mikhalitsyn@virtuozzo.com, davem@davemloft.net, den@openvz.org, 
	dsahern@kernel.org, edumazet@google.com, f.fainelli@gmail.com, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	nogikh@google.com, pabeni@redhat.com, razor@blackwall.org, 
	syzkaller-bugs@googlegroups.com, thomas.zeitlhofer+lkml@ze-it.at, 
	thomas.zeitlhofer@ze-it.at, wangyuweihx@gmail.com
Content-Type: text/plain; charset="UTF-8"

This bug is marked as fixed by commit:
net: stop syzbot

But I can't find it in the tested trees[1] for more than 90 days.
Is it a correct commit? Please update it by replying:

#syz fix: exact-commit-title

Until then the bug is still considered open and new crashes with
the same signature are ignored.

Kernel: Linux
Dashboard link: https://syzkaller.appspot.com/bug?extid=42cfec52b6508887bbe8

---
[1] I expect the commit to be present in:

1. for-kernelci branch of
git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git

2. master branch of
git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git

3. master branch of
git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git

4. main branch of
git://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next.git

The full list of 9 trees can be found at
https://syzkaller.appspot.com/upstream/repos

