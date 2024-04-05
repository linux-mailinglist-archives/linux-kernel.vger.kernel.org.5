Return-Path: <linux-kernel+bounces-133001-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AAB8899D25
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 14:37:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B19C128B099
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 12:37:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46EE814F10C;
	Fri,  5 Apr 2024 12:37:23 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 607E41DFE4
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 12:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712320642; cv=none; b=h8xsgp3e131atxw84JFh71cRNJZAqljN6M+iI5DZS3FHgdEQ1SG1Ro7aTyijuBg3DUfhQpJjegGt13uPis1qDp12C/OY95v4kiGX/xRfEpix6VN370M9fRAjw+HbezrWSzpP0CWLHz2GdD3il/EWBUXuoytR/UXWX3rhtRHJ7mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712320642; c=relaxed/simple;
	bh=9S0nffQfzMQzrZD9egIw6XDyNBRGO6e4q+B8Gu88/ek=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=c2Az5wBDAfDoN4Z0VoqhlCSjcTQgFvukv8GN/6XGL8rNuF5POtBQD70Y1Gr9HADHJM7pTiogmOhuqKtI+TblHZQx0l3ez2EdK7+GfU7VyR0/FdQ00b4YhMVoHx8w/aIM1CVA/va2VgNx6LSOmCsrMWQyEHECSkIofj+uBTAa/OA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-369e1b1411fso21529425ab.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2024 05:37:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712320640; x=1712925440;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=usqeiQ46dvRHd7TYIxVFZ8q+qxSgYxpfbjtyPxDw7bk=;
        b=BaUMEzNK+4YV9FdzLjU8npI9v42czcTc6Dy8jCF5nnQUwa6CqRTvStkbh+i8jF5sim
         FXUr4Bbxii4NDK536uRynZokc/bysqOy1QhM1clXV6UH4hJUL1azYWEo9laOOGiApvHz
         42Xb79zwi2bZnLj81hdBNkZ6E48szkHXzua51dZhmqn4tHtHKtf9Vhh+hXERgcSB3q7D
         PdRaJNat7cy+b+jLlYJvpYmjwzXL1pbL6yNUtK5w5NTg810nPI42+bbc3Emgp16lTv+B
         AjSwe9E3GnGKGyC2VcqLwemHUsrfCBP0R28BaSUeJUW4gGjVFJKdID/xZFPiS8agsiS0
         aRdw==
X-Forwarded-Encrypted: i=1; AJvYcCVK55JeI9lBk9rHBhQiGuDRl+nXMCVV+VSzo4vzXNjaXCFqoGKwQ8T1oRWlwUdWfQgvslRIrNeQe/Lem5HGUtQMrjtXMv6Dj5miep/L
X-Gm-Message-State: AOJu0YyioepyOT6J7sLVdlkGnCNoB8jEWui6/iGZgBemiNuDRT8O9d2F
	LQ/3SaOtE8x6YS4b0GsStSEIRHnP1d2L/4814L7tlVary98lYzWEpSu/LcrCxgUKPiQ7Lr5NIjK
	4cMIxiC31O8DctAjv+pW1bcWGStTdUzeku0B2lfVg1rlXrvrj5ok+X9o=
X-Google-Smtp-Source: AGHT+IFdRoFOGLXAFd4/eVQ4oP7Lx6MmTcmclZV0mno1Zoa8al40vtT7YpNk8VcKtwIv0RMDBjXogmtehn5ptGOwh7GyeTDq7pHz
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:cdae:0:b0:369:e336:cc57 with SMTP id
 g14-20020a92cdae000000b00369e336cc57mr74622ild.2.1712320640523; Fri, 05 Apr
 2024 05:37:20 -0700 (PDT)
Date: Fri, 05 Apr 2024 05:37:20 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000852f2e061558b748@google.com>
Subject: [syzbot] Monthly dri report (Apr 2024)
From: syzbot <syzbot+list1b4290a8a6187ed4d6d9@syzkaller.appspotmail.com>
To: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello dri maintainers/developers,

This is a 31-day syzbot report for the dri subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/dri

During the period, 0 new issues were detected and 0 were fixed.
In total, 19 issues are still open and 31 have been fixed so far.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 428     Yes   WARNING in drm_syncobj_array_find
                  https://syzkaller.appspot.com/bug?extid=95416f957d84e858b377
<2> 235     Yes   WARNING in vkms_get_vblank_timestamp (2)
                  https://syzkaller.appspot.com/bug?extid=93bd128a383695391534
<3> 192     Yes   inconsistent lock state in sync_timeline_debug_remove
                  https://syzkaller.appspot.com/bug?extid=7dcd254b8987a29f6450
<4> 126     Yes   inconsistent lock state in sync_info_debugfs_show
                  https://syzkaller.appspot.com/bug?extid=007bfe0f3330f6e1e7d1
<5> 14      Yes   kernel BUG in vmf_insert_pfn_prot (2)
                  https://syzkaller.appspot.com/bug?extid=398e17b61dab22cc56bc
<6> 9       Yes   divide error in drm_mode_vrefresh
                  https://syzkaller.appspot.com/bug?extid=622bba18029bcde672e1
<7> 4       Yes   divide error in drm_mode_debug_printmodeline
                  https://syzkaller.appspot.com/bug?extid=2e93e6fb36e6fdc56574

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

