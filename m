Return-Path: <linux-kernel+bounces-83112-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CC72868E91
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 12:16:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B117B1F2706B
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 11:16:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7263A2E3EB;
	Tue, 27 Feb 2024 11:16:05 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 924591386D3
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 11:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709032565; cv=none; b=bR38Aa3b89ygsYReVf3zYvrBQf9nOi+q8Y0W1H9zbauwv57EJzFM5tmSNocDBE6Xs5nMe4b+ykpvBLgHpH7OEi+63ZX5j4UrSPcmHM5EsTlAv2dRdVkGsqc/VQqaxvNx5ZMVEkJt4uKfnDis3xY6cnjuApT5KyJFkubIfAy/MDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709032565; c=relaxed/simple;
	bh=7OecGUQhBHbN7Dm2Q/QH7xLRSwFK/plk849Ojtse7H0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=PbpCoBP0e09HSN2w4llGqNcPFPVpzDuKyXPKZjSYQWdFhHrmWE0NLUykyNv7yoelBV7OAE/5qIqLnv0QXKqtB8buBD5eQLHRmZpEH0apGk+oiI9G2U+ucJh3PfYLxzj8c+lGQVXZ8iBxu7tLNB7/kwBwFx3TY5sHIbt6h1Igk60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3659343e9bfso16941285ab.2
        for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 03:16:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709032562; x=1709637362;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rWmvpWlxS7seJRviuyIByiwj/YWfm4Ys5FDFYB2U+tM=;
        b=BF3qQbCObvNAGjdlIXch/tlvTBEv0L7I6CtzM2pWffpMrFxsaVmIxCP79tN1elzO+y
         QxqAm+pfM34BDIF/iCP3YsyfjlhZfPYdEkc12IabsgkBOxxepmp++WVVvyUMYgCEpQRA
         m2Vx7e9GnrDUGtIeMJR/mhFLhY4sHNixNGmCxXIg2fxTcrHTIBqLsB5NU9hSDjfxTTLx
         56p4ghtu6BjcU+8Zoek0e+Q5U6UVe9Vb3x5RfiutFBlIcRWRQScWnbS1DsPUinR3KoHJ
         PvVp6zGrZ+bmzFtjXZFazU1M2cmDd8clRuuRBFdhYD20nvc38eO5UAPjF3IFHxohzJ53
         w+9g==
X-Forwarded-Encrypted: i=1; AJvYcCXVsWJiFR8VMrNO4ZibVyITbkDaV/XydRFTBDVyXrlwB0rpk4ppHSUqR1XZRhJZsTDYX4fGJJXCn+vwYXctTYg31/WM6d8Fu5KNnWy8
X-Gm-Message-State: AOJu0Yy2urtDj5uBQvNFz3wAIpta7Q0zOcWdyEVldTzot/H1rXrdKxx7
	00iACQ52rKxCqknx7M3VUS2yBHtLeEpuhUckdsrk/T+gTQJhKs0spIUl58eq5EJK73F9qNuTLi1
	fZvI5dgPpl/H5Xdy3sJC0kLfkth9UWEhh6K7RpqKwIHZlAO7oBNjQAiI=
X-Google-Smtp-Source: AGHT+IFej/9kVwyuvByimchmMhLwlKOGI/RGbhRCr1goJPzlPQufuu9I34XOtvnwm0UQ4Z/eDQ3D4PSebQHWTwK1BGuE3pX0tOUl
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d99:b0:365:1212:3f0 with SMTP id
 h25-20020a056e021d9900b00365121203f0mr559529ila.6.1709032562688; Tue, 27 Feb
 2024 03:16:02 -0800 (PST)
Date: Tue, 27 Feb 2024 03:16:02 -0800
In-Reply-To: <20240227105301.1525-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000cf0c5906125b26ca@google.com>
Subject: Re: [syzbot] [dri?] [media?] inconsistent lock state in valid_state (2)
From: syzbot <syzbot+a225ee3df7e7f9372dbe@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+a225ee3df7e7f9372dbe@syzkaller.appspotmail.com

Tested on:

commit:         45ec2f5f Merge tag 'mtd/fixes-for-6.8-rc7' of git://gi..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=11500daa180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fad652894fc96962
dashboard link: https://syzkaller.appspot.com/bug?extid=a225ee3df7e7f9372dbe
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=129f934a180000

Note: testing is done by a robot and is best-effort only.

