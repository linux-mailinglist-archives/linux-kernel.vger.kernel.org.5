Return-Path: <linux-kernel+bounces-70033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 03545859218
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 20:33:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE2F21F238E9
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 19:33:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E605E7E589;
	Sat, 17 Feb 2024 19:33:05 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C95B4431
	for <linux-kernel@vger.kernel.org>; Sat, 17 Feb 2024 19:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708198385; cv=none; b=cZ7SbbOA/gPpWOloJ3QCsmev8CJP1ZzM3+4kDHBi3VFurr7JeEGpcwWhJOCQr7SuBvnVp8nl6+xqGsGpjNL1V/Dr3t/Shz9lPJ+TQp2o0986HKqjyMuRQw69/GBf3DQzg1XUwhvYM1zSGjcmaB3PkdjjelF3y8NOnhlADzPhzWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708198385; c=relaxed/simple;
	bh=7+NRhfY3XlQPeEVnAjDcYEqgsGjBLuZWk7Egl9VMI6Y=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=VPCCsr4EAAZ8CACEtvBERmqZg1yw4HDT9hvZvWsKVEKRF/GdiSOtvDryKT2ylZma12CxaRD9tQuKlrQ3xQZnxTWL/qi4lvU/rZxmQsBRq/NykWGwoTgiExViuBeAQkWm1N++lHBv5uC2TmuoS9+VQHxtzi+EdzQOifUxDWHVGWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-363b161279aso20246395ab.1
        for <linux-kernel@vger.kernel.org>; Sat, 17 Feb 2024 11:33:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708198383; x=1708803183;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LmuT+4Y3ckag63fBQNN2TnIvWbyVruW93vdFG08DOgM=;
        b=FX3BUo5PCLbxiK5fiSQb1SLYJgFbenXiofog/FGvR0CskIxvwNIL4ezasqxekMQQgx
         Cj4Nn/jDSeKQA+GSRPh9L/2z4f4zM/x/G3Fbyl5oJJ+IJ0Xjs5wxqsIEWv2QrR1XIlkY
         dOIPAR+ZUrj74VT+zYo/KZGln00bKKuKph0tAmpP29a5OEApXJ0996ppiFABOWzy8Twv
         Zni02GIi7IIP9OnCNBetjjbch1arF+r9HngbvxEjrxI7N+pDEAoE0znK5mjtEvdsggaX
         VBrGkwH+kv7z5fe3Iz0wlfQp8T2CLWQ/X+ljxB2rrzJHS5HcsBO85aihIW03cWqtQ4IT
         X8Yw==
X-Forwarded-Encrypted: i=1; AJvYcCXyS3r+g0/x8vRSNlQFNn8fl/ng5I2BdGAEOSDNgu4Ir7hiuCvbTqmTVImIxqqdmz1huEYmue2C4t0wi48idISOOERtY4eT0ItAfsKo
X-Gm-Message-State: AOJu0YwHv1Ch3qkCE3lXDacYal0UxVdmS0Ck/tPElA7buYxj1gD7U3HP
	iqnQqcms6RUDOTHxq+UGVrk4reGWgWLzNYOvY580sIxT63Rdy8+9cdquyYUsbxOo7C6WHC4AcLg
	B5e6AswVueeShEkZyLskdLpv069fK/xKeFNcTittyconwOBaEzKhgfIo=
X-Google-Smtp-Source: AGHT+IGH7w2UlxjmTBe0S2g/UvpEYqwDqYdy4smaGKdctO4xILFQWdMYdl/msB56jEw7naxLG8BtUPMPcT4hWagCelVq5kX/pLYc
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1988:b0:363:d720:a9d0 with SMTP id
 g8-20020a056e02198800b00363d720a9d0mr608264ilf.3.1708198383284; Sat, 17 Feb
 2024 11:33:03 -0800 (PST)
Date: Sat, 17 Feb 2024 11:33:03 -0800
In-Reply-To: <000000000000e69b5a06093287ec@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d77a69061198ed40@google.com>
Subject: Re: [syzbot] [bluetooth?] KASAN: slab-use-after-free Write in
 hci_conn_drop (2)
From: syzbot <syzbot+1683f76f1b20b826de67@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, hdanton@sina.com, 
	johan.hedberg@gmail.com, kuba@kernel.org, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, lizhi.xu@windriver.com, luiz.dentz@gmail.com, 
	luiz.von.dentz@intel.com, marcel@holtmann.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com, verdre@v0yd.nl
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

syzbot has bisected this issue to:

commit 456561ba8e495e9320c1f304bf1cd3d1043cbe7b
Author: Jonas Dre=C3=9Fler <verdre@v0yd.nl>
Date:   Tue Feb 6 11:08:13 2024 +0000

    Bluetooth: hci_conn: Only do ACL connections sequentially

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=3D132137fc1800=
00
start commit:   2c3b09aac00d Add linux-next specific files for 20240214
git tree:       linux-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=3D10a137fc1800=
00
console output: https://syzkaller.appspot.com/x/log.txt?x=3D172137fc180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3D176d2dcbf8ba701=
7
dashboard link: https://syzkaller.appspot.com/bug?extid=3D1683f76f1b20b826d=
e67
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D1765258a18000=
0
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D16c27a58180000

Reported-by: syzbot+1683f76f1b20b826de67@syzkaller.appspotmail.com
Fixes: 456561ba8e49 ("Bluetooth: hci_conn: Only do ACL connections sequenti=
ally")

For information about bisection process see: https://goo.gl/tpsmEJ#bisectio=
n

