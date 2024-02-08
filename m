Return-Path: <linux-kernel+bounces-58288-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E96484E416
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 16:32:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 257A1281E10
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 15:32:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95E577C0AB;
	Thu,  8 Feb 2024 15:32:07 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5BA07B3E8
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 15:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707406327; cv=none; b=DZciJ3ODstix0pDu9lAZAlJUwCIzkHdIYPoKCLrxyiEWdMY7BNfDoiyjUdcpoCPjCXgZjBr9yf4d2j2eO9XBPvXzKqiXHWhlkhDnvFAHztTYYGRAKD/EMa+TtJQKSc6IixAnSnsqcjIKwQ44f4fiJlcEUUpeB9DMDHyd9cG711U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707406327; c=relaxed/simple;
	bh=fjsov3uRgEiW3nYU2LA5ZmDxMOxNF1PFM1P2zKSNJWE=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Y8wz+eWDSpiDghQtzocd6nzHFVZLkw7S/gbO7y+w6uIYV4GFyvUNC7s18z4GbM4ATq5t39oMlj7PVEKX5NecR7e5w6DVyXAJEYJixAB2VMB+wMVLFJhp63/UADPrvAPTC6dXqaQyeQbrhAma6be+rGnGWo/FTfqorcbxzR/LL2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-363cff2c5ccso15546135ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 Feb 2024 07:32:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707406325; x=1708011125;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J13MMIPfh9m7LdVejmcRDcZr7MHiXnjkLGh32J/ubZA=;
        b=iFg49mn3KF8GQw92pC2HTPyLWxCHWrbcElbfnbYle+nD1+uBCZJLda8EgwFgL/lkbw
         UsSsfwlAFt+3vuO2ARlk6EnmfxG8dmbYXSvEMKRYOJUVM/o3Z6iiWHlrEHJH7TtvydSx
         wx2jJgszWPwp3+njOFDvDQB7r9a7Vpn/nnlwi1pCK2X40smoUYv1rYOZOfgdX7JCWre8
         oNGRliHV/gYqg24kbjnNiOkGUp941oG+LITQt5d87JqnMo1c0t++urqgYCRPPSE54spG
         nW7+Lq/Xu52YvxJn4gawUIjITPD2QDPJYKDjUl7WqLDU5wA0Pq2UYTpPPj+13ImuVCyA
         6UGw==
X-Gm-Message-State: AOJu0Yx6OHec7v65uzs+tkAS60lwViQ7VSyI7sgEmDwkGlWwCc/4F3z1
	HC9/DChEe3OnhrNHSmxRVNHhYVtz6hKbxE0plk9sviE3z7iCiWdq+aKztrHJOETQaBWWx9s4wZO
	OAZ2liRoNcnys3qi6A4eHvoEyGzdCsnHryPjh+N4/MHOWmMS9aG7Tfss=
X-Google-Smtp-Source: AGHT+IEXxARntCtqw9oujDkbqJu9ADvKd22NWzIad3D7h/2PbUtbLKRNZ1E6fc45LDIqWXP+mEWNhrOSFdMlCPfWKUfh+NZCzaLl
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c87:b0:363:b51a:7e59 with SMTP id
 w7-20020a056e021c8700b00363b51a7e59mr638787ill.0.1707406324981; Thu, 08 Feb
 2024 07:32:04 -0800 (PST)
Date: Thu, 08 Feb 2024 07:32:04 -0800
In-Reply-To: <000000000000b7b62e0610db6b8a@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007cea730610e083e8@google.com>
Subject: Re: [syzbot] [bluetooth?] KASAN: slab-use-after-free Write in __hci_acl_create_connection_sync
From: syzbot <syzbot+3f0a39be7a2035700868@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, johan.hedberg@gmail.com, 
	kuba@kernel.org, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, luiz.dentz@gmail.com, luiz.von.dentz@intel.com, 
	marcel@holtmann.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com, verdre@v0yd.nl
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

syzbot has bisected this issue to:

commit 456561ba8e495e9320c1f304bf1cd3d1043cbe7b
Author: Jonas Dre=C3=9Fler <verdre@v0yd.nl>
Date:   Tue Feb 6 11:08:13 2024 +0000

    Bluetooth: hci_conn: Only do ACL connections sequentially

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=3D154f85501800=
00
start commit:   b1d3a0e70c38 Add linux-next specific files for 20240208
git tree:       linux-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=3D174f85501800=
00
console output: https://syzkaller.appspot.com/x/log.txt?x=3D134f8550180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3Dbb693ba195662a0=
6
dashboard link: https://syzkaller.appspot.com/bug?extid=3D3f0a39be7a2035700=
868
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D11d95147e8000=
0
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D107c2d8fe80000

Reported-by: syzbot+3f0a39be7a2035700868@syzkaller.appspotmail.com
Fixes: 456561ba8e49 ("Bluetooth: hci_conn: Only do ACL connections sequenti=
ally")

For information about bisection process see: https://goo.gl/tpsmEJ#bisectio=
n

