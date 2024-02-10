Return-Path: <linux-kernel+bounces-60439-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42CBF8504F5
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 16:32:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0588E283E56
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 15:32:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 291995BAEA;
	Sat, 10 Feb 2024 15:32:06 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50ECC5BAC9
	for <linux-kernel@vger.kernel.org>; Sat, 10 Feb 2024 15:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707579125; cv=none; b=k4cdwhxvN13Fu8i8r26b8qlajTEX7Hc5IoNRz71tuPduIrNGKtbfvRzwg/Q9uaI9NAcY3a8Z3TEF5vmp57oTvueGA08AzL2xcQTlx9orRvDjOclu9mqiB6MSBsyTBoHpT10VmQ5f93jq19zO6xSxw+3FE+6o3G72oEbVqj1F6Nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707579125; c=relaxed/simple;
	bh=yd5Q1bNL3wVsXKQVoggLF1WFQ+ztPWjj6nCxqsQAfPc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=YnBjSbBikE7rqJagDN/7sQj5Be1U7asft8ikSGQQBN/sgZGO93+yGDibB77r7TCKBWpjO7bJxVDBqCuowqjXXXcecvliqv97Vt995oe/G6KG7um9gG7fSx+XSuTT+AjiEl5D4kdPm372UO1BLXxxrP3H4TXgnQ+udiFgynEXBtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-363ec32bca3so14451705ab.2
        for <linux-kernel@vger.kernel.org>; Sat, 10 Feb 2024 07:32:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707579123; x=1708183923;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iW/fdzhN655e76oqp6FV6OT5SDqBKN4BWEe6vzxQRIk=;
        b=FhE5P391hjOURlnRqtLGe1icD8/keZb7ReSQQ+4KiKFQByQcpGNfXrZHkhJHKycDVH
         i2kSFwvVH6gz5FHvAjzshhJueCh9WWAl7+OZfPYJu26MiGKoIppyfGTuBCIVJCWTCah6
         05OdPO1A19qc8h2lxQxLKgSu1fcDsFtTZfdj6naeP4tLx8B7/jEKEUPvs7gNj1ckb/OA
         G3Szxrwgb97IxGkwrzwtJV3q8fKIYRydHthKW8PxNM57+8i+kCEGV0SPymnRWWdKHwRN
         a9GmAHlHa1/2DXXRPlyx7mp9gF80xx8opgpgLHvKYRpeOFVrNJdywR3RJNj1w8xFhpxS
         qn+A==
X-Forwarded-Encrypted: i=1; AJvYcCWjlUWxEJoHc7UPfjgvofHkY7wTqK4qhVRkO2c9nXJxMQ6azo4JiitMxqGTkGOQbX3mnNmfGSCJ/FIzWntGry/ByrCyRNC+qwv8QD4T
X-Gm-Message-State: AOJu0YwJmTvgA0ieUdXQBLpsHd+yqC2zRq+lXBDH8tV8UWlnKx7Z3JwJ
	Hmfg2aTME444en01iqtvvnsTW1B3UGHiKhUo+TS6Q2To/qO6q4ycKNi7e+S5WwCjB7uBpXlSD5S
	aMbJ6xALI+BklFx3rMiJcbDNjhCH/bLI15z/YRat331V3jUlQvUtiH1I=
X-Google-Smtp-Source: AGHT+IFaNAgr90nVgqByDRoV2YWYs+Q6Nvsd3PVBvPhWzfpkYUQjEDRjvU3oAgaTUkssN1JVEVSmjwAwnfWSvE+EplRu8KwdEHs+
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2162:b0:363:cc38:db1c with SMTP id
 s2-20020a056e02216200b00363cc38db1cmr136461ilv.6.1707579123468; Sat, 10 Feb
 2024 07:32:03 -0800 (PST)
Date: Sat, 10 Feb 2024 07:32:03 -0800
In-Reply-To: <0000000000008ca4ed0610f6d017@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001493e2061108bfd4@google.com>
Subject: Re: [syzbot] [block?] WARNING in bdev_file_open_by_dev
From: syzbot <syzbot+96f61f1ad84e33cee93e@syzkaller.appspotmail.com>
To: axboe@kernel.dk, brauner@kernel.org, hch@lst.de, jack@suse.cz, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit e6d7c6cd8e6aeb8b4add207d31dff240680ff573
Author: Christian Brauner <brauner@kernel.org>
Date:   Tue Jan 23 13:26:20 2024 +0000

    block/genhd: port disk_scan_partitions() to file

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=15805cec180000
start commit:   445a555e0623 Add linux-next specific files for 20240209
git tree:       linux-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=17805cec180000
console output: https://syzkaller.appspot.com/x/log.txt?x=13805cec180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=85aa3388229f9ea9
dashboard link: https://syzkaller.appspot.com/bug?extid=96f61f1ad84e33cee93e
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=178b1e20180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=143db9f4180000

Reported-by: syzbot+96f61f1ad84e33cee93e@syzkaller.appspotmail.com
Fixes: e6d7c6cd8e6a ("block/genhd: port disk_scan_partitions() to file")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

