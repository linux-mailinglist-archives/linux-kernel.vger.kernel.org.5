Return-Path: <linux-kernel+bounces-68637-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CAF3C857D9C
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 14:23:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E40F61C246EE
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 13:23:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E16DC12A143;
	Fri, 16 Feb 2024 13:23:22 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17BA21B966
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 13:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708089802; cv=none; b=e+sGxBet2j6Roohj6pVWws1YbSER6cYbOwJj7R2N0Ft83Gp9PFk3X3F1s2sor4KO4XJ5qxiGgeUyVWG+bMCypdrP2jS/o6nPOtSOi0X9OHhSmjcmHMuxB4RGxG6rzoIkwDyhAHIXZwUR/j0Hnxbg+QYRer64bqe3oatY+cj6fhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708089802; c=relaxed/simple;
	bh=FqSWe7JHiE+uJcy2YTdzs/EetirgcQbQTZpnVkzmo8Q=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=U7z69AChDVJD37wowEKDrGqQ5cHoQrhdmUX2kJ7fwRoGscd1u1HFj2M8mW0EKMVSmrqH+1VEVlTQObuh5nnYbg8RC1HEGZb+EbTyscJpKkQfJeCiNAWD9STbFb7FfwW/ePkheP+C2L++7HnmuF1cxJ1Zu9J4ESL94QrNlrElO48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-365067c1349so8472235ab.3
        for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 05:23:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708089800; x=1708694600;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pui2IuVeVwTnvL6WtkW/nNwS2Ezf2FXXIiCC2gR7PNI=;
        b=A4YTvI6xcgwYBUS2YcDI7sdNHtWpAt7Hu+p/7hxyAqItcbbkilfsooVJYyPe2dsYzv
         ugspd+kH4migPcg0YqVEmxxepU+QimYSVsHBwlh421z8tqaG+Odlb2It2TMezErhhXO4
         9tS8J3GSbfXn5Y04Ox0nAiHjBMdiwaFfg26a3Zp674VPnNVuC19Pb+hk4Wnf1ZLV8Hub
         VreH2f3VEmzXC3JAQeX3by2oSG+fN6b0U1C9tYprSyf/za/G0pUAq63qt5YHg+viuKuA
         gNnUHdK/S9BjrnsxRhS5UfYs5UjZDY8E5kheusy+XJE6MVTKZRm20KquJrT6Vp98V0/H
         Ua0Q==
X-Forwarded-Encrypted: i=1; AJvYcCXsohNMjS3w1yo7NtvEhwTMkT9jImL/Qt6h8mQ5PTwNAfv12bP1lyEtN0k/0bxa4LVFAW8sC1w+Yu6VwH/VTajtzGr9PGWp6nqJ+fy6
X-Gm-Message-State: AOJu0YwDqqRushC4APJLBvr/4IRcQ0wMe+jIHoYxbY50HtZ6nqnnY34j
	sQKi1Syj1/ufNFp1JGZ3OiAcMs/CE48ce4HZUzDeOxuAnKSI3M+XAZAuQYTHQE1tWDSJlQA+8IO
	HOOE5oQ25sCU1IRjYUAzeSR0+8N4Rs8lJWV0ArXzcCwQFebt9IPIYaug=
X-Google-Smtp-Source: AGHT+IHP3zirBrdpmR87Ieqf/kCU11sHaFTXhByBqF1DIC5U6wixLWGetyvp0XpBzZg6W+D+cSFdv2yl1SN+mh8JUPbcqnKzWsq0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:154f:b0:363:9d58:8052 with SMTP id
 j15-20020a056e02154f00b003639d588052mr368389ilu.2.1708089800292; Fri, 16 Feb
 2024 05:23:20 -0800 (PST)
Date: Fri, 16 Feb 2024 05:23:20 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ca829f06117fa50c@google.com>
Subject: [syzbot] Monthly v9fs report (Feb 2024)
From: syzbot <syzbot+listc76971b2e26402bae4ab@syzkaller.appspotmail.com>
To: asmadeus@codewreck.org, ericvh@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, lucho@ionkov.net, 
	syzkaller-bugs@googlegroups.com, v9fs@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello v9fs maintainers/developers,

This is a 31-day syzbot report for the v9fs subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/v9fs

During the period, 2 new issues were detected and 0 were fixed.
In total, 5 issues are still open and 26 have been fixed so far.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 1611    Yes   WARNING in v9fs_fid_get_acl
                  https://syzkaller.appspot.com/bug?extid=a83dc51a78f0f4cf20da
<2> 265     Yes   BUG: corrupted list in p9_fd_cancelled (2)
                  https://syzkaller.appspot.com/bug?extid=1d26c4ed77bc6c5ed5e6
<3> 9       Yes   KASAN: slab-use-after-free Read in v9fs_stat2inode_dotl
                  https://syzkaller.appspot.com/bug?extid=7a3d75905ea1a830dbe5

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

