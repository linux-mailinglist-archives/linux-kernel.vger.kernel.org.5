Return-Path: <linux-kernel+bounces-133013-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E27C9899D67
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 14:46:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4EB6AB249BB
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 12:46:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E2FA16D324;
	Fri,  5 Apr 2024 12:45:22 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7DE316C870
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 12:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712321122; cv=none; b=pqkdoXvp40LGY2DgHaHebt2JalEMqtYJixxhZhOrAf2gTZ6jarTs9afGOcnevrkj9RUft0yEkM2sEkG9PneB6WDP7+xsak/XsrxeSLJi6ShKkg6d3dxfy17M/OBqZIf0Qioqphz2ZDhM+2u2f/8aXbySExCg63cvnRZL/MJhynI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712321122; c=relaxed/simple;
	bh=Dphsl1wEb+tj7NHd0/4Ylex6ZvS9e5NcNE+l2QxlXTM=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=SfhnjSpBU8B1vXeL+SvdTGlXBvqFzbhKtXP9lPRQPc/I4VeIcFBYFYttkWaB+VMktymussMfJGLsOongAa+dWBtlscILWKPklF6YVGZI7lIjqbmvv4V91OVm+hCVLpyF5cgLUjUBIoMjMxvqUfdGjnpXqmiziqiKU1p/Yb558Ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7cbf1ea053cso197220239f.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2024 05:45:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712321120; x=1712925920;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rIDr1iAoSIhWICRRsyfBYTI+CbbsPmNqERiJNm4bnzE=;
        b=s4TM4PQrdi926wo2+nnho6GSmckbGU+4Sp9VC88Gv0+k4Q70tPzh+Mn4xHl0sKcndH
         xsmXYXXvzVxuSRh45G6njxoJR+yI1AgsAok8kowmfHk1/6DI3Iz13KL57efYAjLYdaRi
         4eWt1eXdOXxe3INAroqm5jqr5uuqGa/nms+bG+hhq7DRorr//V3HSPmpWBL6OUqZB7Hb
         Qatp2RpAiN4tqNRKD7zoEKj6H/3NE1/leOmXZJYEMdf0wleggTgm6UevNprW4wiP0+33
         KA+Km+Mzd2RhAxm3GGzGOnuqFnf6vinTLy15zMwZ9neutPglXJlPvR7ojV21TWyAVL8x
         JFYw==
X-Forwarded-Encrypted: i=1; AJvYcCVnHSVze/l6OUt/H2CZi515SY8WsV4LAmETzr1Qo/obMP+SzbZrNLh86hvnlAYRsfaCTmVeH7bJEPTmJRSL6ZzaGtHr8aXl+8cm+Ffg
X-Gm-Message-State: AOJu0YweuP4zR1olDnFSfgWtL9sbR8bmTfTq/SzBVHwNbTAlZjX8o2wL
	seeDUUBR18moVVNYIQDjlv6ryu/N+O/XyTLKSeS6ueKlZlG4VnO3kQLnV6qpOe0wza5JQ6a2IDz
	nw2b7xvgoRKL1DixaNCgVALGwhB/GeMnnJso35b7ozRGsJHDtic3YYrU=
X-Google-Smtp-Source: AGHT+IHI0E4ZS0sxatzkSZIyeEbtV/5q5IEz++DvGaVS1MOzYLVM19Xa53LLeDDXfYn9F4bNxqBd+BotKSUIedvm8jCsMHzyI3GH
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:3792:b0:47e:e557:ba45 with SMTP id
 w18-20020a056638379200b0047ee557ba45mr39982jal.0.1712321119894; Fri, 05 Apr
 2024 05:45:19 -0700 (PDT)
Date: Fri, 05 Apr 2024 05:45:19 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000017d4bb061558d4b2@google.com>
Subject: [syzbot] Monthly kvm report (Apr 2024)
From: syzbot <syzbot+list367f2137b2dd1518ad84@syzkaller.appspotmail.com>
To: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello kvm maintainers/developers,

This is a 31-day syzbot report for the kvm subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/kvm

During the period, 4 new issues were detected and 0 were fixed.
In total, 5 issues are still open and 113 have been fixed so far.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 147     Yes   WARNING in handle_exception_nmi (2)
                  https://syzkaller.appspot.com/bug?extid=4688c50a9c8e68e7aaa1
<2> 113     Yes   WARNING in __kvm_gpc_refresh
                  https://syzkaller.appspot.com/bug?extid=106a4f72b0474e1d1b33
<3> 3       Yes   WARNING in clear_dirty_gfn_range
                  https://syzkaller.appspot.com/bug?extid=900d58a45dcaab9e4821

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

