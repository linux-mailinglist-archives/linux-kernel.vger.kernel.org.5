Return-Path: <linux-kernel+bounces-32400-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0643835B3B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 07:50:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0F321C21782
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 06:50:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81818F500;
	Mon, 22 Jan 2024 06:50:09 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D84CEF4EB
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 06:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705906209; cv=none; b=ZjcE9zs55SLMxzu1qTj/nGaKwjBPily2pyLTp0QYsPk4cpWqsWSvvuwH/zHJK9zuBBoAfxBdMkUfsXMY5zVojYHA3MmyjD0Pt+W/Ar2MJn3ciA+KoXX/rEDIO/c0X9I6RYVRegKeyqVdvJyUGpzC/JIWlRjxww49LIlgUtiAfPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705906209; c=relaxed/simple;
	bh=ZNCIKLQEQFGsic2RjrQPVaLzVgS9Tt8BVI2Rn+vmqUQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=MTkFlKeOCfVh5EADz+uxwPjmPuRkH9mYpiAB4Fn/Ug0ar2RbGpKU72wGiCy8UtC5jXMY9AaiX2yGaoi2iFUF8+qhc9bHyT7A2cj9od4DzWV8fyTASSW+3zCzXT6G75+ZD9nFNFXWePgUmJlprIbK7z03LysBcAfoqpkGyg7Dduo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7bf356bdc2fso341445939f.0
        for <linux-kernel@vger.kernel.org>; Sun, 21 Jan 2024 22:50:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705906207; x=1706511007;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=62+6nYYyAs6Ox07Br1+G73BX/3Ka6lr/DQIh5W2PwXo=;
        b=uZIb6WosYN8XzfrRExQLwpYbbgzYIVQztbFmp4Y0SyQzIu3u1wGLg0LXKF7ifdnpV1
         zzdT2z271Ht2KdDTfG3qXkbPBUK2H7XbfJY/E3Doon2EudTHb1oWdboQHUgRDSBMd6Tp
         qIU3PiVqCd00mAsLw5ZIQEGJ25uezjNSWYUSJG/YzuwcMa1KsHV33bzkNiumdWMnBIpt
         Q0awBUsPYk/fZ0+6GTBZ9HXp+0PhuCMhmjYpFtPRoVeFJSUMvZqqkLTssmB1vb7Eovn5
         Qcjo8yGk57YXTcjNNWGwib6KLTUYjJHV+1ctUHayoPrJpMVLqGbmTFFrbO0t3lsaCVTV
         tppg==
X-Gm-Message-State: AOJu0YwVIsUKdoskOKrxlcelbK1HWN7RWKU1l+u8N0V7XwoJKHAWFHcs
	abssNcUdcLXul7nt7+dqLV/pMop8STgy5wUo/rRnXNk6Z9vS7R2JnpQUkGkCuuZvjX/ZmZc0YE+
	TWhAw2PdSV+NFouWXxscSr1EvfWMmPELR83HMn8SoH1bNnFM8F6UCJe8=
X-Google-Smtp-Source: AGHT+IHmmpRYnbC9RjGiatJ65//yxpDKFLrXAEftFofBE16N6J8xl8jzpdDZHhwmGKWTqh7Prpnp0h1Y9qqdPwVzL8DuT1uyy2Pg
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12e3:b0:360:96fd:f542 with SMTP id
 l3-20020a056e0212e300b0036096fdf542mr552967iln.1.1705906205535; Sun, 21 Jan
 2024 22:50:05 -0800 (PST)
Date: Sun, 21 Jan 2024 22:50:05 -0800
In-Reply-To: <tencent_5A768367E63CF5373E97AC37C24A2A748509@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000066b9a6060f833df3@google.com>
Subject: Re: [syzbot] [hfs?] INFO: task hung in hfs_find_init (2)
From: syzbot <syzbot+37463f2a5b94a8fdabec@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to checkout kernel repo https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git on commit 610a9b8f49fb: failed to run ["git" "fetch" "--force" "--tags" "4d52a57a3858a6eee0d0b25cc3a0c9533f747d8f" "610a9b8f49fb"]: exit status 128
fatal: couldn't find remote ref 610a9b8f49fb



Tested on:

commit:         [unknown 
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 610a9b8f49fb
kernel config:  https://syzkaller.appspot.com/x/.config?x=7c8840a4a09eab8
dashboard link: https://syzkaller.appspot.com/bug?extid=37463f2a5b94a8fdabec
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=13675a3de80000


