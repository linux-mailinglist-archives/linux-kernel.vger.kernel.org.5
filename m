Return-Path: <linux-kernel+bounces-107172-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D030087F86A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 08:29:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89AF3282C91
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 07:29:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A49254665;
	Tue, 19 Mar 2024 07:29:05 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A91E53E02
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 07:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710833344; cv=none; b=lURiMB7Yxg9ChKWsbvZwwSb98R5aQbBmmSVbK5pAri2fc9Ok0RvpxVOqwAVfkSLdu4W9fs12RPRPqkU9fJaMdoq0rP6Q7FI82lsLBL3glE+5s9wZiTmQ0eByC9S/kwYssR/w2sZxVnL0PwZSazNEB7v23Amf5U5Upuu/YgXhAqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710833344; c=relaxed/simple;
	bh=MbubBF4OOdxSAOvHRjH5ajfiX1SHSXjJzvdpZHnoRl8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=fenAHXXtDhjm18U7BviDdEltx2DlyIG+fHGKeCR8cnjWiakadPusD0L77601l1o850wdJ5pDIN1oO5DOrB1vM07IEtD4MHcWlOoA5p7PAP5dVNYv2MhMiz2/9BN2TYZ/nw2PLYkqHxLz4xy4/vfxkNPOTSzz+mzuDyw74t8jjb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7c75dee76c0so384750239f.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 00:29:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710833342; x=1711438142;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8L0aseWHwJnObirFwX5gqtXx6gyV5KockT3blw0Mvsg=;
        b=FxAtly3cdICGZgBjHnBjs/GV3RrI4DsDX2IjC/FH52YCxuECVtaAfx112ZMbJD4avU
         dBCsxRYkg8RYZFITpW5nTQ+hko4UUqZ1BqEiKH6Z75lPhXk17nKB4vrEPDY3ZXH1Mvy2
         rD3txTFmy13UTMBVVpeF10qeNKZhkx4WraL6D5cNGr9Jral+YXNH+ulT+lTZjXNfUlKT
         k3R/ld3QWahXXno+TKe6dZi0B02ye3+WVBDZ6UWaNn6co3hWq127vR0dOkh8CA1agLoV
         hRVBDNnGvpUltqRM4YG7EFnPemS3kZZhr6jdaw0YffcLlKo+8+/gzYK0mK3iZEYlLplt
         BzCw==
X-Gm-Message-State: AOJu0YzhwO/fJHKqL8Vy8egOoWyS84SvvJwUThAZ0YvYbD54dwJ0ZdFZ
	a8E29yizYeWSt7/SOaWkO8GMWe4fvkrcZJFjaENTBp2weUx2SWbbDItY2djOYa1rAZA5/H1YXM4
	GGAt/b/LaXqTTyMUQ3s7rWXBtVTfCmw+777q6J9djR2In+TeBXxXSUYHNUw==
X-Google-Smtp-Source: AGHT+IFuOt8g0J3YH5YyydtBHLzKVsdkTlt/W3VPWw67mJVw8ke95dZuWdESpkTpZGQyT4tM1nJCntOtLyvWuFwzCcIIK5HexUBZ
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:2491:b0:477:307d:abd9 with SMTP id
 x17-20020a056638249100b00477307dabd9mr122731jat.0.1710833342378; Tue, 19 Mar
 2024 00:29:02 -0700 (PDT)
Date: Tue, 19 Mar 2024 00:29:02 -0700
In-Reply-To: <Zfj1-2Llw_NKqSzL@zeus>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a482ae0613fe6db1@google.com>
Subject: Re: [syzbot] [net?] [nfc?] KMSAN: uninit-value in nci_ntf_packet
From: syzbot <syzbot+29b5ca705d2e0f4a44d2@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, ryasuoka@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+29b5ca705d2e0f4a44d2@syzkaller.appspotmail.com

Tested on:

commit:         610a9b8f Linux 6.7-rc8
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=123ec0e9180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e51fe20c3e51ba7f
dashboard link: https://syzkaller.appspot.com/bug?extid=29b5ca705d2e0f4a44d2
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=13904c81180000

Note: testing is done by a robot and is best-effort only.

