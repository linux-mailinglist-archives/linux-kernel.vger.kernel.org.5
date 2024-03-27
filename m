Return-Path: <linux-kernel+bounces-120606-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C6B688DA25
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 10:21:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2654B29C5C4
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 09:21:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1B17383A3;
	Wed, 27 Mar 2024 09:21:26 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CEC038393
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 09:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711531286; cv=none; b=NstJY0d7s8O6fBwc3Rg4EvdEzoh9JlP6mV0mNIaecTirArDPVOqUGXW+JsRpnj5WWXGPy/JbzF2S4UzNtTJEiowcuJWbQLPon3T/r/AxxgAK2XkB0e1Pgr6OjotUHh5NE+Zr/kBv1Ggs8coTbXXuyUTqMn526HSrNyPirjzQjnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711531286; c=relaxed/simple;
	bh=BTnJHFY/nt7PFY4PT3msCip+fzBmYxAGj/lUvuDySlw=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=CXlMfyN/IDECD8FXSIenTo9Whz/xPdDH+Pk4sA6w90/Dmu6OepPl9aE27oupjpz6kDbu3zWnrRpnpQ8cFHEUqG0YU0r40ZUyXvJ80xKfrkoELwyEaJE99wNr5rO46FUBY+wLsYvRs7O6RZWI0vKnyWk09sWDw30Ygsw0sGcwKuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7cf179c3da4so648521039f.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 02:21:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711531284; x=1712136084;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8ReOWwslIB13Fq9t7nccy52B9153T7KjTEtXzz+65A8=;
        b=Iio5ug+LTKawhME2XWGKYJ7F0qY6Upw+Wk9TMd+fuXi4kNZSxgAq8jVIyHhIYZo6f6
         IBS0urODPN9hr9kLkvVRsoHDaWWX4QeLpLAYgXdjlsZKMURJMvXDp1xmtkx0hQrsEnz7
         gSNRNExp8+8sMiEwFCuRfWdnDVf0/6GGJ/MTbghd+AzGJ8OMC9dim37mFNCbWHEh9V3L
         iPxk5Pq6IAoMrCRQvXKrjRROS/oCMQlecckyxHUjwft1MhAiulmZPBi9MApZsBWEVIHA
         H+hmZrd3gJ0DMAeNt4a62mMd18yBgYnFg8OVrmohw5ce/i6zw5gGRysKTEn+DeObOd2s
         Ck9g==
X-Forwarded-Encrypted: i=1; AJvYcCURRE68AkPBlqmGmg30Dxviggx2a0BpvrXamZOgnTz06+y/ImcaJsJ9wPc2DudXR+LcNYcmVh1V9gKc+oPgdDMkJ9u2Bb6+fSjcSWwP
X-Gm-Message-State: AOJu0YxLERRUncAqQi2xyfNYG205kmdEYGiT6tcrzklKe3k23Rl6VEKH
	pv5h4cs/ZLF+ZuH1RZv4Q9rRoD8sMCVfHrWaubspS0EOIaDQzh8yQo9zXvgw0tbVVxm6NUIAa33
	WmvixKwBM0wHmOngK0HcqxG9nqZFuGxaP/qS9BOq43G21rZznGgyWvOM=
X-Google-Smtp-Source: AGHT+IG2mSBwqqNlErV4Wnfic3Uyo2AfbnE/SxUf4IRcmKE1tix18e348CPFw2dnX/bz968AcHk7NtqOELZN8TZt7UniSbLlX0YR
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:628c:b0:47e:b8b2:dd80 with SMTP id
 fh12-20020a056638628c00b0047eb8b2dd80mr66686jab.3.1711531284151; Wed, 27 Mar
 2024 02:21:24 -0700 (PDT)
Date: Wed, 27 Mar 2024 02:21:24 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000036cf020614a0eed8@google.com>
Subject: [syzbot] Monthly arm report (Mar 2024)
From: syzbot <syzbot+listcb18b8c90f9e4d847c17@syzkaller.appspotmail.com>
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello arm maintainers/developers,

This is a 31-day syzbot report for the arm subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/arm

During the period, 0 new issues were detected and 0 were fixed.
In total, 4 issues are still open and 4 have been fixed so far.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 924     Yes   BUG: bad usercopy in fpa_set
                  https://syzkaller.appspot.com/bug?extid=cb76c2983557a07cdb14
<2> 22      No    WARNING in delayed_work_timer_fn
                  https://syzkaller.appspot.com/bug?extid=e13e654d315d4da1277c
<3> 8       No    WARNING in do_sve_acc
                  https://syzkaller.appspot.com/bug?extid=95ffb6a83b20ea7f4f55

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

