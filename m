Return-Path: <linux-kernel+bounces-133941-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EEF0289AB32
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 15:55:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F7B71F21220
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 13:55:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD927374F9;
	Sat,  6 Apr 2024 13:55:06 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D17826ACA
	for <linux-kernel@vger.kernel.org>; Sat,  6 Apr 2024 13:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712411706; cv=none; b=u9YBYbDGLRMKDpJyGbPyVPR33UchIe7D6y7bp4uhKv8lwRSRZelD5+0zU8B34ArviXDfVwPTbnRlXzpa4IO0T6IY3fNmHmGwkBU4+0kYsv7vxWeGRGdJAV5D1zwNDzgocutdwKNpZhN8ZwBTpPfI6tEjWV7d2WrY1mSsDt/s1fA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712411706; c=relaxed/simple;
	bh=vcoaY3CtY0IFaacTZ3dkjzpnNHyEL6WspH+Fx5cQcoE=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=unewr5gaoPxM0D063GQPC5iobL0jpO4Dq7qxbU8ITKdurJmhFCY755Pof2WLoSUo46DKYDg67djTt+6ZOQjhxAo1ArGrU1Rkgvom545ziF7lrXqeVD3pnrvJQXCms6ujBBYlCMH8Bxjm6tdhjlS3f3UAZgFWEoZ7M/Veve2USPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7cf179c3da4so340671639f.2
        for <linux-kernel@vger.kernel.org>; Sat, 06 Apr 2024 06:55:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712411704; x=1713016504;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NFIOWEE4j5HpTVxpWwlC8qsl/hBN4DEgXk5YnZ56XK4=;
        b=kZ21fX6Lp2+z6X7lrbO02UsvgExtH6BHoJpT0aFL9ebuVL3GShrNrNYHkZd0CteRw3
         6JSMLi8fEsDQoxAXes7mfNq0YLwhhNt6WSF1DLBT7jpRXjsm1yoRCESmEzpL2SoudXJu
         2tSrgmuPkdw+Rsb1hXwrGR9K7UT1n9I3feGuyLQZkSaN4JwcAWUucsksMBSZg5sAc3yR
         tKPVav0b+joSdHCsNSIOQNz0hgD5FBpvgwbn+Uu1kFbLsojK5dtXoGSAHpl8IVa9NHy+
         X7rVvI0I9KCueyuEHMQvKUFCC/kZpsYanMugi+L608D4YKY8/HrDglI8hrbQjMfa55mJ
         IeBw==
X-Gm-Message-State: AOJu0Yx5lYtTp0VE1TJ9aeLgte6XfISIEvsUTWmt/nUpx3Gl72FcurwR
	4+F7gF7zhHKw3KEzLZKZcVfZNKA9ha5pptjDLW6w8sKeJnYcGhSdd818xVPlT3pfhsNrYHSL5Mr
	FHbeRAKlq/lCLpPIS85kHoaWReBw1RaA1XBF5WIfHxOkDIQoXpnM60nzntw==
X-Google-Smtp-Source: AGHT+IGrGyIlgn+YfUXfCk0Zugnb8U3nyG0YURCOJ0MKtlJX5ltp875xXHacU2ndpsbDsoKuP+QfiiwiVgJg/6O62REUEZR/xFdg
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:1501:b0:480:ee35:85fa with SMTP id
 b1-20020a056638150100b00480ee3585famr253502jat.1.1712411704325; Sat, 06 Apr
 2024 06:55:04 -0700 (PDT)
Date: Sat, 06 Apr 2024 06:55:04 -0700
In-Reply-To: <20240405110449.20217-1-n.zhandarovich@fintech.ru>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005888ca06156debde@google.com>
Subject: Re: [syzbot] [usb?] [wireless?] WARNING in carl9170_usb_send_rx_irq_urb/usb_submit_urb
From: syzbot <syzbot+0ae4804973be759fa420@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, n.zhandarovich@fintech.ru, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+0ae4804973be759fa420@syzkaller.appspotmail.com

Tested on:

commit:         fe46a7dd Merge tag 'sound-6.9-rc1' of git://git.kernel..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=10626b3d180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=cd30da9bf40834bd
dashboard link: https://syzkaller.appspot.com/bug?extid=0ae4804973be759fa420
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=11dc3af6180000

Note: testing is done by a robot and is best-effort only.

