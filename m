Return-Path: <linux-kernel+bounces-70617-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C4391859A28
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 00:02:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C1B72B20BA0
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 23:02:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D6E171B27;
	Sun, 18 Feb 2024 23:02:06 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79D9612B91
	for <linux-kernel@vger.kernel.org>; Sun, 18 Feb 2024 23:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708297325; cv=none; b=Ho439ERE0aMuQeXEik81xvOL826XHrAdg5m5BH/9i1w2HTRpOCIeYOrD/UQFJqHKWV+V0aW9D3Pm7n/NBo/lHecUv3PMoA5yqYbWRmErKIQsIHXEoTLueahoyWJJMrLPNvb7f6OAa1F0WjcZlv0pIfwNfFfvet/NAmP6bWI5wvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708297325; c=relaxed/simple;
	bh=gx08vrFga24mpJKJ6CkD8XwWwRlSzoVynbkz6tjlUdU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=NFYu411FtI7UBLI46PLXVF221aFzrbIbAX5lqjMt7fS/3Da9a28i33HTZU2sp1yI4RbtsPbc8Trzonzby78urGgdjdxROd6hpBHqyRlAwLECMFnKwroJT12euAcezlrbI5vT6QLDPtlqDY24IaNEggEF4X7kdtm2wCplo+a98gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-36531d770d1so2535315ab.3
        for <linux-kernel@vger.kernel.org>; Sun, 18 Feb 2024 15:02:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708297323; x=1708902123;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jbqMO01/H/iqr4yf8kLtqB/zmeOqiP/DRUeUMAwyX08=;
        b=g6qFol8sgNTGp7nKEA2eXQ7GdaNkJEBz4VPDszj5YURuLKjzqowiVz++3/CoXojf8O
         s3BOcqha61y5exVZuUtv8+4hZaWJAvccIkVTroJ4lQk6bZcq9f43soqNR9jUsGhQ5Eqj
         EpdkvxYJrMOWNGT5UxfWAoAshyVHSb0Fl6DSZ6RfAOtkRh0SZ4tpFjQmpmZQw6OwPe2b
         Jc2xt2MoBWYkRZCyP1sePbbUB5b8WNz+5s6cL0/XQBdwhai+1Z6n5EB+qqr7/b372/Im
         /8z6hIH/5VG6ZrpfSRh5jf4hUftpdwvDhnBPRZL+5xagDGSBh9M9YStX7ibvQrM8EOUn
         4AvQ==
X-Forwarded-Encrypted: i=1; AJvYcCVRYap0VDU4gU3L/7RmS6AILnky8Nl2w0e61AhegO8xk/kWy5GXxlcgYIlIy6oXakbfzeeBHBbkzHVGAXG60R/nSvFDfFqWbt9Bg26w
X-Gm-Message-State: AOJu0YwiES8aojNKQaAK3sEkRg5+pxxcmDKtnzTDtZlp1WQLb0kN1JKG
	rXo7B7bGwDUInKx5qHVNx5CPuYR/qJmuYBI1JOs6IW9V2sDKx2yvGNcaTBhltoIUIrauUaPY1+3
	iGdv//07/zMHtajt9XmCvso//c2rVosSnUk7MOuJXGpaX5480tNUjI2Y=
X-Google-Smtp-Source: AGHT+IESg5nnX2NxCKLcT/j7td4ev2NPLuE2YZ2CwDqs2gyjCZhR5rLABe2T5nq7AHEkvwhfpPGVVoAbHx10tudQ9hnZVE8Tt9ji
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d92:b0:365:21f4:701a with SMTP id
 h18-20020a056e021d9200b0036521f4701amr328766ila.4.1708297323738; Sun, 18 Feb
 2024 15:02:03 -0800 (PST)
Date: Sun, 18 Feb 2024 15:02:03 -0800
In-Reply-To: <00000000000081dba605f19d42dd@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000026ff9b0611aff742@google.com>
Subject: Re: [syzbot] [reiserfs?] kernel BUG in reiserfs_cut_from_item
From: syzbot <syzbot+b2c969f18c4ab30419f9@syzkaller.appspotmail.com>
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

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1272f362180000
start commit:   88603b6dc419 Linux 6.2-rc2
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=9babfdc3dd4772d0
dashboard link: https://syzkaller.appspot.com/bug?extid=b2c969f18c4ab30419f9
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14edd048480000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13a5c50c480000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: fs: Block writes to mounted block devices

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

