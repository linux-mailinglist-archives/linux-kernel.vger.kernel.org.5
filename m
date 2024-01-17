Return-Path: <linux-kernel+bounces-29206-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 57C3C830AE8
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 17:20:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69FCA1C265BF
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 16:20:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B547B224C4;
	Wed, 17 Jan 2024 16:20:08 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F36DF21A13
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 16:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705508408; cv=none; b=YdwUAFlrB6oB8u4CxE1ikwtI0xn1+C/MgNdlcx4/rUibT3gpHXCcSRiaMKKogorj2FYIvnU0g0HGCSoZ+lxICbrIwS+cTEvKcJJRr/TAeH2rBv+xS8zOGXud/4j6OKtm9XfPmnrs7WVdWDrRGvJv352fqP+UDY5zmnYyR6Nj6I4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705508408; c=relaxed/simple;
	bh=X9Tc8QKWPDLmksAWuVVFK0oDVNUWOymTX5v/tPTp/6w=;
	h=Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Google-Smtp-Source:MIME-Version:X-Received:Date:In-Reply-To:
	 X-Google-Appengine-App-Id:X-Google-Appengine-App-Id-Alias:
	 Message-ID:Subject:From:To:Content-Type; b=h6lhiyvqoTUwh7o2kxBTwu17N/bg2BxKRi9nNssadR8jL2HH3PGQH0pbxlTEFCY4KWYIlhXhu5sFz2e+OG6bROwgIarMwRoDtuvoJKEM82b2ccMwpxAogg0lLmJl/3EFRtA21i6OSwPoytNXcCLhKHgI+byi37lP+9311+MSNDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-360a49993dfso74870315ab.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 08:20:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705508406; x=1706113206;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CmRaJpPgBsO0jKDNyPLfd6NWiflAW4VynA5h/LQ9l80=;
        b=d/aVxpqNuzKc1UG/UDAux1ld+Yg8Z/PDYJnDTtDnvDmtM3BWUAq1V+kkHOcHZRXUuu
         PCVooKfSKx1JJ0FJ91xxUYS/eRx5ds1za/eIPu7D+4/eOcGU1GOqd4afEXwGRpAhWuki
         xMf8HHeTxnZjOgmP15gXeqKVDJ5oZ6mj9h6Clooi9InJ4WidXcsKjOu5QSqYe5UPJ6Dn
         t4N79aKIWr1GbWx4HtE0zWg3ZfKtrIYKR3ffaBnhR2F6zz4HDJUxYvHOa/WxPgccRnGH
         tBS0JgKIHPYTCkxeh8RiJ25hYnvNNv3E/m+UJPCLz8hZVM3YIqg0H3ovn/FSH8MuA/NU
         cY2Q==
X-Gm-Message-State: AOJu0YxPF/tMNN6/KlmfUKTcqoqk6qX/EC8pbmrHAOskOgKkoCjoUtJY
	ceeZQ8oUaNiUBwzyiYiSztZdoJG2YD+FurfBK2N7MBVjyiJX
X-Google-Smtp-Source: AGHT+IGX33jfAR+ozaz9MIu9nM7Eu3lo1Imr5ETdadokM97tBJl+NUXFtldShbDVPwhuIfi/hlO665PnGpajP6nGijPWQP5CBM+x
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:18ca:b0:360:2a3:7dc0 with SMTP id
 s10-20020a056e0218ca00b0036002a37dc0mr1332355ilu.2.1705508406145; Wed, 17 Jan
 2024 08:20:06 -0800 (PST)
Date: Wed, 17 Jan 2024 08:20:06 -0800
In-Reply-To: <0000000000006308a805eaa57d87@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b5b973060f269eb3@google.com>
Subject: Re: [syzbot] [reiserfs?] possible deadlock in chown_common
From: syzbot <syzbot+3abaeed5039cc1c49c7c@syzkaller.appspotmail.com>
To: axboe@kernel.dk, brauner@kernel.org, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	reiserfs-devel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 6f861765464f43a71462d52026fbddfc858239a5
Author: Jan Kara <jack@suse.cz>
Date:   Wed Nov 1 17:43:10 2023 +0000

    fs: Block writes to mounted block devices

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14ecbc83e80000
start commit:   2bca25eaeba6 Merge tag 'spi-v6.1' of git://git.kernel.org/..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=9df203be43a870b5
dashboard link: https://syzkaller.appspot.com/bug?extid=3abaeed5039cc1c49c7c
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1539e7b8880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16c6cb32880000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: fs: Block writes to mounted block devices

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

