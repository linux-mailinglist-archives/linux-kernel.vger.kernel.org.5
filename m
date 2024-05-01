Return-Path: <linux-kernel+bounces-165688-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C68398B8F9E
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 20:36:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 572B81F22115
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 18:36:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F41CB160792;
	Wed,  1 May 2024 18:36:04 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45E141304A2
	for <linux-kernel@vger.kernel.org>; Wed,  1 May 2024 18:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714588564; cv=none; b=dkrp7awmcDhrdCse57fXnR7bnbDe159xHSHUqez/CWQW7RNXU4EyqeOkfOU7RcgWsYMqzz6gyTuToj0jamn0c2hEL35bb1ySUTdPChNnt9lkdcFETljCM78JQ5QQXIplMf1GAr2sNX8uGo42XVYytKwXs5cFJw0VRyLr7ADwe4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714588564; c=relaxed/simple;
	bh=uAEpvoLH0jQ5ezR311PMWtuGDjVxTc8BEw/OMCS2IiM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=pdA+yY2GGiiK2AL65oU+gw+ViveZFblG5CxX/1Ygfkw/IGKh9oNLq2TU1Om7Al3ZKLPwLdsbFVy7v+rU86Q6Aq9ZLTTxsEURTDyBWBFLjaminiqJXhz9Fp003uZrwbA7dc5N+yA/adcJBjRrA9wpzs2FfqbwqZnaGXbwzYUAyCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7dee48ec44dso169533939f.3
        for <linux-kernel@vger.kernel.org>; Wed, 01 May 2024 11:36:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714588562; x=1715193362;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+4YE8smK0Bxs/BTvCre0VgQbgMbKQ/27ijIitPKyX+8=;
        b=vfinfkJVVUP8gV2rFS7HVbcg1xDlk232+7c0Chlt2M5EIKrcTkPVF9hu+OF3ysNPc0
         0wMxCQLHSlroD0oZAT1uulFGZ8aKE2aajFxzlySZc/hNch0M0zPR04aX6wq4F2kBg33b
         /68awBQZ0eYJFgVXs451Y97KxTd9ok5y1w5YislNe8Hk5p1S+uk3xL8r6eR13mvfv9SQ
         FZsvQk9C0pOM5MTO0E8XoclIK7i0NNxB+J/NP0JjvIlkuIl67Fml08ip79tJFWRzKfyx
         zUvZlLHZTlFU9WAXKLzDfSo9zURp40OhGseWW74bwmhqGR1QTv9m6zQ8wPV29WEHXIRt
         pJuw==
X-Gm-Message-State: AOJu0YxR5ylSQ07tOiFZCd/KnvDril2Sw6itMpcBXaLKFGJp4FMLqeMI
	RF4IYfqzYfRg95DL+M8/NEh9hpnsOm3Bv2xpGYaeIUF8BmIM/Os6p3R2dWGFb0DkW6T32afl2nL
	TI4djrSD8a90zZPdv+bZPpKoUwRr9IIbrPS4NC+wDN5M+Et6TreNBRa8=
X-Google-Smtp-Source: AGHT+IETbrT9yPmHc4B/nh2WytEruGd0WNUvaj/I7mLz8e5MJSnRSJXuRKzv3584yVZI2OvjxZDvX9ECV3d+CVOKcWksVWumTl7Q
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:cdad:0:b0:36c:4b17:e05d with SMTP id
 g13-20020a92cdad000000b0036c4b17e05dmr159555ild.4.1714588562466; Wed, 01 May
 2024 11:36:02 -0700 (PDT)
Date: Wed, 01 May 2024 11:36:02 -0700
In-Reply-To: <ZjKDQp4mfBSYpfFj@zeus>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000033bf07061768c282@google.com>
Subject: Re: [syzbot] [net?] [nfc?] KMSAN: uninit-value in nci_rx_work
From: syzbot <syzbot+d7b4dc6cd50410152534@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, ryasuoka@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
no output from test machine



Tested on:

commit:         01066798 Merge tag 'regulator-fix-v6.9-rc6' of git://g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=143fe537180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5e7da3ffba7152e6
dashboard link: https://syzkaller.appspot.com/bug?extid=d7b4dc6cd50410152534
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=13f565e8980000


