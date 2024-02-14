Return-Path: <linux-kernel+bounces-65669-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 90E0285503B
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 18:28:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C36661C23009
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 17:28:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE34F12BEA7;
	Wed, 14 Feb 2024 17:23:04 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19495127B4D
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 17:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707931384; cv=none; b=dHM5p0gC5VulV6QLwnB5B/6cJODnrCPgyMrD4QWF8++m1OP+d/kc6NyfyllhebB5Pjp2cNytJZYBbQXTZR4YV5p+nJAN4at7MyBkZ7sAgDscpCsyOQFVTPCzwRYULJeO1UF3y8f8ELh9c8pI2iW6tII1c9EY+G84GJ1M6q/htNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707931384; c=relaxed/simple;
	bh=iMGoTg6WEz486MqlOHjjKJ3ktS/OpL1McrdKCWDVNgQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=IX2bfKS89pITf/95Hb6yxFt3o9lXIImUc53wShfwZWK8moVv+ArKgCEvWm/sr+0HSucl9CNahyFQG+u5WmR7mnrn6EQONq8k0xqDeHdTlaUgGQpVJo2K6i+3vjVo3OtS6NXrMcW/3MPU5lxx+HebpUFhkQmebYMlZzPJnG/6uz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-36424619e67so12637635ab.3
        for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 09:23:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707931382; x=1708536182;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zmB5bxuKgX56B/DRWOjJqVlGZsVZnX89ddcUcXcLX+E=;
        b=Zq4o0rax7OhPwLdprcxsjLk0XLYVI5904Z6AMtUiI6irie9kbjbtLHfhGuZ+gYJBep
         OZC9OjFty8XIhw/JPqUZhRDwqkW0ysqvvVH9YJTqQkpW40ooV2BOFCOCFZvRRwgzZRoe
         joLzazTApibhbM2WBOLwVsqtGlRMyRFDxkBRI964jJw0MppS1THHuTOGf9UQw2CTSJxB
         OmVqEXHrp4mHUnBUHBUY53cYRvb4dFIwC1ci5rfEwc/paE8+JWJzUVjawcCOLDVzCqqS
         +muaUACEsncMYePSdujdWEptwSp2QJzzDejiBBW4LqOT85yTsJGWLPdnxgYuHitNFczU
         7nOQ==
X-Gm-Message-State: AOJu0Ywj+L4whRD6NoQKVGSrNCJtEgnmPPIuwqlVOHFoFnhkPGsTo2KQ
	W6V7UodKcLQrfpz8mfvujZkSyfw/p4KPRXV6rlp1ue4RHYMUXlVPi05gLnf7oVcXkXnw9LS7H9T
	hfQAxil83DTEOCcZykp9Y4umM4ompJBa9tdtfzkeLI9ujQ2ayNnBOFgQcHw==
X-Google-Smtp-Source: AGHT+IGNgfX4MwQU4iaqnlD7V/j83ajuxOF+vlkhal7Aiw+tI0u0lQNfdolg2Zkau+hfMFr50hKyIFdBmSS4w+CxMGcIqzsDd6x5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c2b:b0:363:e232:23c6 with SMTP id
 m11-20020a056e021c2b00b00363e23223c6mr246130ilh.5.1707931382371; Wed, 14 Feb
 2024 09:23:02 -0800 (PST)
Date: Wed, 14 Feb 2024 09:23:02 -0800
In-Reply-To: <20240215.004450.2191980850029726116.syoshida@redhat.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000058de7c06115ac3e5@google.com>
Subject: Re: [syzbot] [bpf?] [net?] BUG: unable to handle kernel NULL pointer
 dereference in sk_psock_verdict_data_ready
From: syzbot <syzbot+fd7b34375c1c8ce29c93@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syoshida@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+fd7b34375c1c8ce29c93@syzkaller.appspotmail.com

Tested on:

commit:         e37243b6 bpf, scripts: Correct GPL license name
git tree:       bpf
console output: https://syzkaller.appspot.com/x/log.txt?x=136b32d0180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5e23375d0c3afdc8
dashboard link: https://syzkaller.appspot.com/bug?extid=fd7b34375c1c8ce29c93
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=15054968180000

Note: testing is done by a robot and is best-effort only.

