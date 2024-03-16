Return-Path: <linux-kernel+bounces-105117-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD05A87D950
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 09:32:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B01991C20D23
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 08:32:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8BFFE560;
	Sat, 16 Mar 2024 08:32:05 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C749A1879
	for <linux-kernel@vger.kernel.org>; Sat, 16 Mar 2024 08:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710577925; cv=none; b=eOhD34BpBXKEVErZTEYgJiml+qgtcSLAeQzX7BqFYGays7VT5bRdMn/WLBM/5Jm/sDG8r1jLR3xdxg8VSN3PpbZ8IKHWh2kbz+Qcp7MLd1jwZiLhXsQyOnFrRSGhGWPI5GNC7rM+zCPrEPM2D2xoo6JMSrYg/dRCPs8xwqdseN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710577925; c=relaxed/simple;
	bh=Lt2eP9/c5Xz6PrJa8OJcjMmWMTC8u7DMn1v4js28QNg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=ZHs9QkI2EPMql6DB1KCrtn9ddEvPDUxk5O0w8bK23giyowgiDZG4qwNx32YxQcVxUNTcJMvg90/K/w2sO3LSsJIx4pluGY3jisWwkOOsH8O7FXmwKc5KLuDZJvU8jCDtoJY+BhVF5ET9RW+ia/pwGZL8NhsjY0zLKOSqGNIcP3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7c846da7ad2so226475139f.3
        for <linux-kernel@vger.kernel.org>; Sat, 16 Mar 2024 01:32:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710577923; x=1711182723;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VF1C9fGBRrrNAXaJB7p9yc6H16ewIef60FW4AbNQtC4=;
        b=kWHVQuf1X1GsyWDjwX2MTQIPO78i1nT5fLfu+zJgGCB+jFvpilD92zNc1ZFTJmkDHb
         F3ER6dt/75i+pRgJ/s/PMe3O4p4CDCRxVolRJMk9Ibf/s5bQBKNa2wgp7XFML28KzxMp
         U6kE+/+TVENN5Ho3uk+gV6ls+vq5eBIVrltWcUBlOlZHu+EhPoa8nHDL3yAFrrZBXLcz
         rfAzcSuaxAOVQ65TS9tRyFn+A7asryv/ezU/ST7Nwf0AG3JpdhmBMnB2RCsu+maBzEf/
         m7OrVh+xMP2sa3guh5QmP4wKqg54AckVRUuUex9ipkwfnTsk8e9Tr7JtOVEYyhRswSXv
         kYlw==
X-Forwarded-Encrypted: i=1; AJvYcCVQ/1cVX1X8l5b1msUndxmAJP/Z3gWfAuINZlapYU6N94+gAvnZN6PXyuUab5p+gFlmGHbEKHn1NKb4RP9AnzAQcM+UKKCjHAoXFLj3
X-Gm-Message-State: AOJu0YzClfEc4w0t8jAcGfHLSzy4i/AQdfPn+J2l8dgw05bWByjgXWu5
	bKqfnWDpq25akrWStb3R55FjeIDRSmhIkuDdHA/+6sW9hLoYbDiVy8iYuukpQeE59dQh69OqdeP
	87wWqiwLaXETlDlk+LpEud8106B3PydlRfQgfIF2jDAzIpmjpIbftzZs=
X-Google-Smtp-Source: AGHT+IHztSffPF7NCJ8UY7T9v+E8zhHIllmUq2x4IdYIaTWeDPsk3GFHkaZmyp9wOOA7QITBgIID4yaTMhzh7UPbilPOAl/CXLpc
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:2403:b0:474:f25a:6fb with SMTP id
 z3-20020a056638240300b00474f25a06fbmr433810jat.3.1710577923064; Sat, 16 Mar
 2024 01:32:03 -0700 (PDT)
Date: Sat, 16 Mar 2024 01:32:03 -0700
In-Reply-To: <20240316081347.1763-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007716da0613c2f59d@google.com>
Subject: Re: [syzbot] [sound?] possible deadlock in snd_pcm_period_elapsed (4)
From: syzbot <syzbot+28c1a5a5b041a754b947@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+28c1a5a5b041a754b947@syzkaller.appspotmail.com

Tested on:

commit:         fe46a7dd Merge tag 'sound-6.9-rc1' of git://git.kernel..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=15c227b6180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4d90a36f0cab495a
dashboard link: https://syzkaller.appspot.com/bug?extid=28c1a5a5b041a754b947
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=11aa1d66180000

Note: testing is done by a robot and is best-effort only.

