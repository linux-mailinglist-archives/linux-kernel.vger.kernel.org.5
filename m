Return-Path: <linux-kernel+bounces-31959-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FB7183544F
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 04:17:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72D591C20E6E
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 03:17:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53D423612D;
	Sun, 21 Jan 2024 03:17:05 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A824C2EAE1
	for <linux-kernel@vger.kernel.org>; Sun, 21 Jan 2024 03:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705807024; cv=none; b=aFsnd35LceHKr8PrZ4TSmvwMoxs5KTlOsI67xNmOiasePqQsvoVaArdYqSql4PzjbzdE4zeZXux2znqvOcaG8qI+GwRid4Lb2hhT5m9xB691niPyeG8aWyRuu3+okovg959SDAuYbP/Q7TMXmBDwS/jmU8hDQZoGUvvTLU0Ntq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705807024; c=relaxed/simple;
	bh=Y3U3gmSoBpPBqejzWBvJi7czCL1r6vTqCtRFhtN/0lc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=F4NC99S3N0jvoP8dB+CuY76Ceb03HgrVye1KZA4DMXHsiim21wMNHcPxbuRWwZQYPfQaHOmsguctYejeO37bQAjgZyNhplp9r/PvtfGoH85J9VEL5I3NkoY4tPVngbKX+/giS/xJOcYvjUagYS1JPN6e43nHq5P69xzORoAsTEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3608dc76b97so27484315ab.2
        for <linux-kernel@vger.kernel.org>; Sat, 20 Jan 2024 19:17:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705807023; x=1706411823;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O5EGxrXRJliwproW9XKS8xWAASP6Q517tHhuqRHfHFo=;
        b=fny4fmT1PfI+xhn+HzGJAToFvGpnfi1rbWUnXMGcDyJltgxihAp1wVeQgYLjueSnOu
         HC8mTtwTED0vN4111v8rGwFJZ4zDU7C4DKGi+tDvv5a8Ll8NyQFcqydxKlwhD1DqKSk3
         qCt7CuVob3kp5t+7IAPuQLgfQ/7ino8UWNyRqsSwxiL3wVZZF0+41Hd4usNIgMeiQRfg
         b2HuIa+z7kd+fX1pGYwymZ0/FGl2FUje2Bl8JVNYRXdB6WD9mNImJIJTKFF/YVtp9B2P
         SBib7xAVBdKPOgYsD3NPW8HbX9Rf2A8xVxAzYY043kmFyO28jJuc1ql6quu3r3L53XBT
         aPeg==
X-Gm-Message-State: AOJu0YzcLhtQrxncb6d5RnIuKcspowvVgmiOxAjXySABc18NCzwxjajX
	5yJm7o/ZdcyKM2Y+PntczIYCB0i0gVlnvqtevwb/3SOhvwG+My8uuHMwUOqyM6kSIiUPJnDpJid
	xLvZRstJc+D8t00AK3+IL1oCwiwVh/E/hH+9HP09JnAu1mQqjOz3nTTo=
X-Google-Smtp-Source: AGHT+IGRGmSbpZOAandnep2TjFNdtBtmS5GbpJlBkr8Y1TPC2FaHN1DScWFyE7Braf3ZajxeC1wTuTX0WO0vt0Bcv1KhDuzrh6nD
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d88:b0:360:d7:186b with SMTP id
 h8-20020a056e021d8800b0036000d7186bmr274095ila.0.1705807022976; Sat, 20 Jan
 2024 19:17:02 -0800 (PST)
Date: Sat, 20 Jan 2024 19:17:02 -0800
In-Reply-To: <0000000000001eae4605f16be009@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a8f68a060f6c259f@google.com>
Subject: Re: [syzbot] [reiserfs?] kernel BUG in balance_leaf
From: syzbot <syzbot+6a0877ace12bfad107fc@syzkaller.appspotmail.com>
To: axboe@kernel.dk, brauner@kernel.org, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	reiserfs-devel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	yijiangshan@kylinos.cn
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 6f861765464f43a71462d52026fbddfc858239a5
Author: Jan Kara <jack@suse.cz>
Date:   Wed Nov 1 17:43:10 2023 +0000

    fs: Block writes to mounted block devices

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=10cc8ee7e80000
start commit:   88603b6dc419 Linux 6.2-rc2
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=9babfdc3dd4772d0
dashboard link: https://syzkaller.appspot.com/bug?extid=6a0877ace12bfad107fc
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12bdb82a480000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=108acc94480000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: fs: Block writes to mounted block devices

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

