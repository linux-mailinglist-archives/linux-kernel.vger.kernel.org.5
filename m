Return-Path: <linux-kernel+bounces-28553-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D2617830009
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 07:14:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D40C4B24014
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 06:14:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9749CB677;
	Wed, 17 Jan 2024 06:14:06 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDC72B656
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 06:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705472046; cv=none; b=MLaciBWpp4hWk6eUoADZVBrFut71Q7HR4vZJ8NikFnjkUS0qnTEFQeEFX5r3gsOssSls5f6G/xkuWK0giYsAjSnoImhgAA26kzb4O9WIX58fVRciPGHVbm7gFw02IAbjhGe5BR+87lMxCuDmxunbf1RVwWVMXt748TJGGMRKxMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705472046; c=relaxed/simple;
	bh=pPzg9tthJoAOu+lQEXZAgjDm2WofgFPBzt3dvf1Hr/k=;
	h=Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Google-Smtp-Source:MIME-Version:X-Received:Date:In-Reply-To:
	 X-Google-Appengine-App-Id:X-Google-Appengine-App-Id-Alias:
	 Message-ID:Subject:From:To:Content-Type; b=O7zppngiOW6zWhi/BBuKezfYZ7nakq0y0R/jsamga6j5sAdTPBTdqAj0vsPN+OZ4K87edrXbkY5tUGAxWqMtVu7Gah57AXFz4Pa0zg3f/Nt5VzKwp2u5Kyy7b/Mp1YbUNH7Vvy+9HvuqTJOo+qc8mdT3cOpqe9chANDnofh7t1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3618a7e0ab9so13896585ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 22:14:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705472044; x=1706076844;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gpeqYO1STVuhEh0ZMGXqHdVeIyqAb6nGsjatnQ9D3hw=;
        b=D0NFroGKVteMk6+YYoLCQ1kzQLunE9VGsR/YLEmeOMWhjgfIRGY6Mc/plZvLQeDbg1
         oq6XmGltO5ljlln8Rkl74lsDHyY7AeIjuYYqaiOdy8l9jyLJlw8YjqHGEi3vmchHulKo
         ekWKDSjOt1LB6ePLzzqVilKP1sVYGNaZ/d5L9+PWEYCJQqcbwnSHSoNIAO1wq/aP+0PX
         Pxuvcxz3XUzEOgN5dckuhPPzhImkee1jRNukQdoLGiHm66suQ2g+Q0BNVrOGl1h2eLea
         sU87U1pHEplkIbCc5VHTg0UeykEiwnk+UHyenpeam2NRPwqupCn2IyinJRBPkL9yvovj
         RzPg==
X-Gm-Message-State: AOJu0Yw/v2Pnj8YO6wP0Mr16PbAry6rTVqs+JfnyW8LeXynaDQAb4CNl
	scfyW74vSwOaqmtuYEyByr1hwnKM498GeEf/Xd+IRYIuz273
X-Google-Smtp-Source: AGHT+IGN7SG4q0ov8Gm69KwgEdQrZp/D6GBRSwOctE4czBCjRhOMpDnSIEUqdZEUJccRhRMSF6joNkP+ru8b8flHBUjGWg0VX4VK
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:b2b:b0:361:927f:17ec with SMTP id
 e11-20020a056e020b2b00b00361927f17ecmr183829ilu.3.1705472044160; Tue, 16 Jan
 2024 22:14:04 -0800 (PST)
Date: Tue, 16 Jan 2024 22:14:04 -0800
In-Reply-To: <00000000000007728e060f127eaf@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005ddc5d060f1e2730@google.com>
Subject: Re: [syzbot] [exfat?] kernel BUG in iov_iter_revert
From: syzbot <syzbot+fd404f6b03a58e8bc403@syzkaller.appspotmail.com>
To: Yuezhang.Mo@sony.com, andy.wu@sony.com, linkinjeon@kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	sj1557.seo@samsung.com, syzkaller-bugs@googlegroups.com, 
	wataru.aoyama@sony.com, yuezhang.mo@sony.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 11a347fb6cef62ce47e84b97c45f2b2497c7593b
Author: Yuezhang Mo <Yuezhang.Mo@sony.com>
Date:   Mon Mar 13 04:38:53 2023 +0000

    exfat: change to get file size from DataLength

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=12bd5ba3e80000
start commit:   052d534373b7 Merge tag 'exfat-for-6.8-rc1' of git://git.ke..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=11bd5ba3e80000
console output: https://syzkaller.appspot.com/x/log.txt?x=16bd5ba3e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7c8840a4a09eab8
dashboard link: https://syzkaller.appspot.com/bug?extid=fd404f6b03a58e8bc403
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1558210be80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14d39debe80000

Reported-by: syzbot+fd404f6b03a58e8bc403@syzkaller.appspotmail.com
Fixes: 11a347fb6cef ("exfat: change to get file size from DataLength")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

