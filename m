Return-Path: <linux-kernel+bounces-82294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5F0E8681F9
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 21:36:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A077428F295
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 20:36:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9AA8130E3A;
	Mon, 26 Feb 2024 20:36:04 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5BD61DFC4
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 20:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708979764; cv=none; b=S7kcAj2lP8QVOfVUbSNCwU8OKUvGsl3kWIgxODRRq6eS1FsxazVaz+/8RbIap58+Ef9151RzHFm5ar0MYynioEWAiuw12g+198NFZGeB233w/9Q+Dv6DayJ6syPA5ZupCl0Et5c77clEtxGJb9K3sVj8IlZmSjPrDmsJ7cU2BbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708979764; c=relaxed/simple;
	bh=BOEgMivz/1Rmd9k9sx91BXGVLpMCPHRTptOTwKap2IE=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=EfWXeZkzFtPnEY9SsjWXk5kxKjlUd6NR27UOdCqn3rBWKrYY7Eh/937g4uZKiyB1BOp31u14OHt6fFtu04rxXdWfl1jmT/eywVGWYZLpgRLuf/og5Wl2UY0x9AXGOiGykMPD9x2cplBicGPkmEnvmwe0FCROuqHnhYLt6k/PZ9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3653311926bso23015045ab.0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 12:36:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708979762; x=1709584562;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SHBxOxrj9OB5gH5hKB3+4qa+fyj8XGTAPshoc6v4MfM=;
        b=cmgbcmd5RhesAwiCinfFPaPpt2HFPx/OpP8iFGf2pLUkqOxV9DX04Ht1qZjArgnivI
         DNI5EefWPJ/jYydxX8IcEV4U1J1Pp6qEzVfBdNmM2Yn6TajhwaviF62G5KOt/kOxJg6t
         MVpjv578S59TjaS8bMg87zN7PJloPZ1SfjC7oU1YJ7cT8dNmluv5gVm3nvf2ZZEUp7VE
         f0bXtKrXh6IGznmC2ppEaG6A5/Z88VepjKDfMSzfHlOJh4wwmg3uucLXkzkZpcTEETBF
         vCavfPZgVuTYbzU/eF3i17C8WD7AfCJldL44DguJq+2b79+w719Qb+f1m5tKz823RZPI
         Lp1A==
X-Forwarded-Encrypted: i=1; AJvYcCWiaODt+j+U9AnY9FegLlLLz0e6KUwK4UhRpbYnarxKuFPmfkhQPSV/rPuCjZC1v7G9+A3IKS+0R+1hstXkt5Lr/0N4Kgel81HHwIz+
X-Gm-Message-State: AOJu0Yz+oIdYjtAGsTk5lOTv+uqWNjbpmr+C9StQKNy/6QwakQaHFTZ/
	oVzaZHJDDPwv+oR9xcgss7RZvUIA+YAkx07Wqkrqi4PXorKC19VKizOg+qMn1v3lF0M9TwEdi0u
	J/UTPKYQ9Ots8TbQVsbKXo9yeEQtyeddxrytXoFfD7OKf2PLQMDxBmzY=
X-Google-Smtp-Source: AGHT+IGtnwxp3RnWyZGGR7Do0uKiVSBxo/NJeOMseplwOOWIl3jc0RvUIkBUNaLcVHUV1PEvQjpqhCWQHN4lOAuyylN+vXTAD3Ei
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c24a:0:b0:365:23c5:1bf7 with SMTP id
 k10-20020a92c24a000000b0036523c51bf7mr404754ilo.0.1708979762213; Mon, 26 Feb
 2024 12:36:02 -0800 (PST)
Date: Mon, 26 Feb 2024 12:36:02 -0800
In-Reply-To: <00000000000065139305f0564e37@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a7bb7506124edb52@google.com>
Subject: Re: [syzbot] [reiserfs?] INFO: task hung in reiserfs_sync_fs
From: syzbot <syzbot+4dadbee41d087d9c6234@syzkaller.appspotmail.com>
To: axboe@kernel.dk, brauner@kernel.org, hdanton@sina.com, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	longman@redhat.com, penguin-kernel@i-love.sakura.ne.jp, 
	reiserfs-devel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 6f861765464f43a71462d52026fbddfc858239a5
Author: Jan Kara <jack@suse.cz>
Date:   Wed Nov 1 17:43:10 2023 +0000

    fs: Block writes to mounted block devices

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=111c20ca180000
start commit:   692b7dc87ca6 Merge tag 'hyperv-fixes-signed-20230619' of g..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=24ce1b2abaee24cc
dashboard link: https://syzkaller.appspot.com/bug?extid=4dadbee41d087d9c6234
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1208ab97280000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1359d897280000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: fs: Block writes to mounted block devices

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

