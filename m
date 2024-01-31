Return-Path: <linux-kernel+bounces-46431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 23054843F8C
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 13:40:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D400328356E
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 12:40:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26B8C79DB6;
	Wed, 31 Jan 2024 12:40:09 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5151A79DA3
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 12:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706704808; cv=none; b=hcRJRX+UtTbfr1kw/MS5SUpMZvvVXMqOsn4883W67V5JZBxozDJUan5iF/3tjSx/twQIC/JMfZCTRSbQ3KEwU+b8dHmj9NC0tUUlQfLz5DbPZsJ0jlN5HBvBv+0v/pjRW8C9YN1jTaVdbHiaeaYecioYUpyQ+8Zgb7yD7OMjy2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706704808; c=relaxed/simple;
	bh=cza3oR9CMwBgTSGiRNGHlnNFJ3XePvp0UL/KhPntGow=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Drrdrqsogb6jtiMEq7xWr1MWfTp9WTeqMXiv2plozwH8EQwRfrfolsDagCfQc3I+GBE+xp/yQ+hENiuiDuU0DOIViRi5HPfcaNWnq4I4EMckJSnMEm8/WicgsSFrTMc7UFCGusMn7gmSHsN2TNQHII8uRYgSylz8Gbcsvp5Ivlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7bf48e0f513so402424939f.0
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 04:40:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706704806; x=1707309606;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BZpev8tZuvYra4GXPqvMYom1CH6GH5aiScB+H5mfbM8=;
        b=e3+gz9AAC4ExovhPmvGYnbin/pisa2y20ydjFuPNbTzikd2LKBVqlxihP5R+BtVLKY
         R1lM4YBnuIZxPlEskh0X0KV/4maGZZoFTe3QgURSAv6DKBMhju2U61M+GedLA1cS8ML4
         LcOyyte3Tx4FCUazE22H9GzGbTeEwxncUtDgmZqty3/UFMdzEg/jH5MKETIytvq3pCwk
         MBZTIIyZsi19PF5fDFkCTDQBR8jEkNasvOiKKeQd9w2LortFUFYUbIBmiTZkGfnkt3iX
         U6OUjtPmTLF+RpYeEG3F2IeDyp+OGdFa+hbRVlqD5RvKB3kIYRe+hlBRJK6kOB0x4w6W
         HFjg==
X-Gm-Message-State: AOJu0YwP3zimoQw+mwky0wvd3S3cpDM21KrzncDAdg9jJAPnTaL/EmSD
	T4VhWVYUVFTQnxBHFPl6onoKS3MT5s0DMIpXpOmoPMRrJBtWwdOqUmHeRfBRxxvgvBqhfMZROcT
	dSJw9Q1whvnlHG7JouSCIhocs2nIX8KuLun5+AGBPZ+1g8Xd2RKGLIAk=
X-Google-Smtp-Source: AGHT+IEYEwLEAYrC/gsFUDYlvKO7t5LieezDOY4HJOFj/BKwDooO5WoUVWdA6o1oFygRKuZ0YqP8RVwh8NmA5vRwmCu3ilL1Mwgv
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a02:cf9b:0:b0:470:a920:8406 with SMTP id
 w27-20020a02cf9b000000b00470a9208406mr7420jar.3.1706704805851; Wed, 31 Jan
 2024 04:40:05 -0800 (PST)
Date: Wed, 31 Jan 2024 04:40:05 -0800
In-Reply-To: <tencent_9DB87AFA6C9C2D756D849410E9FEEC26CF0A@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b078ab06103d2d11@google.com>
Subject: Re: [syzbot] [block?] [trace?] INFO: task hung in blk_trace_remove (2)
From: syzbot <syzbot+2373f6be3e6de4f92562@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+2373f6be3e6de4f92562@syzkaller.appspotmail.com

Tested on:

commit:         1bbb19b6 Merge tag 'erofs-for-6.8-rc3-fixes' of git://..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=13adc87be80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b168fa511db3ca08
dashboard link: https://syzkaller.appspot.com/bug?extid=2373f6be3e6de4f92562
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=145135fde80000

Note: testing is done by a robot and is best-effort only.

