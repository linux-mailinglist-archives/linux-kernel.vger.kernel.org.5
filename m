Return-Path: <linux-kernel+bounces-30835-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78F3E8324D8
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 08:05:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32480283FA9
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 07:05:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7403EDDB7;
	Fri, 19 Jan 2024 07:05:10 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAE23D518
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 07:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705647910; cv=none; b=DFtzR8PfURN+pOqUnrwTZFvyQ9FbRspWBTPU5G7ttBOnIGSQTJce0u4edeXL24lcbJDxaVwbboWzcm45ePtQN2qTfeqiXO+ldkNZmM0WJ+5fOC+R+JA+wxNL9P3nJuZRgvV9Etsc/rmkd/i/joY5GGyvnmKZ6PWCIWOcZnhzT68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705647910; c=relaxed/simple;
	bh=PRCcc6n8SezOmBcjJ1w6ADI1y4YbyE6RB38U2xwAsw0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=HayM/PclFloYLWqZhMkHyj9Sqe2g0WRP40xCembtusxAnyag62dgyFuMy55+zKIldtZEXdbVYx9HEpm5RQwaENjfq1sTaUpiQQvKWfcv0Zxv5Qr06t+tauJhJ8LUGBdD4o+BM2Z6n7EnbyLmhTLF+awPqyJUSRbl1rWFQj/GWS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7bf0305ded5so74164539f.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 23:05:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705647908; x=1706252708;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cHAoXMaxOaUZ8hGAc5thrJTPKmiHqe68fKrRjO5mByM=;
        b=HAbffy4uiElzgfovQMNEYtdXDrUnF+uC6hLn9GoOy5PQuyqeHnvqwbOG+g2WXSS29H
         +AH1GCDdwihIeDOxoth0A4mV9WED1lnRe6n46sb1J1u5+qyYJZ0O8mNrSEkF1nBXwNDt
         1D9n7PZWU7TR1TBPSuPmWXL9X/d1jY/wtL8EC030uJZUtL1+LwchBHlFmzNYYeALFk0f
         RQ9lF+Rwl5EEiBKyUJKERJ223nZwHzUmanYu+EUQfEqLOQJ9KEOFCe2d9ZUNufPkm/nh
         lw6WZ21UqN26WJVUC5Ws/g9EsxR4TfE4ldiR36G3gh7p4VtYGF7QlTK4V5oR5eKoMkkk
         k21Q==
X-Gm-Message-State: AOJu0YxixKhB9irnAThVPj1IhmHU16XqWy2pMCzydzUPch4sUEMfQRIa
	ryI53jlSBbacqBrMq1H0l/Si9hOZ+grKhgrodM7JMqy3B96fXUrKZXhhh2U3YJ2uV34QC4yd64K
	EpHEemruMCSE6mmBPwLhkBbbkhRTTbRIzz4yrWqtO9FFb7vQxBns4BwE=
X-Google-Smtp-Source: AGHT+IFxmbK7qK6jiqTPmsRka4RwZvaBVbSkxnFcVZuSGO731Si1AsheewJm27UvDyBlCoamByT9xUL0ORVqiICJsAtkOp3Q6aS/
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:1a8e:b0:46e:6716:e6a3 with SMTP id
 ce14-20020a0566381a8e00b0046e6716e6a3mr7025jab.3.1705647908011; Thu, 18 Jan
 2024 23:05:08 -0800 (PST)
Date: Thu, 18 Jan 2024 23:05:07 -0800
In-Reply-To: <000000000000e38e4105e9d6e741@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ab49d0060f4719a4@google.com>
Subject: Re: [syzbot] [jfs] WARNING in ea_get
From: syzbot <syzbot+5dd35da975e32d9df9ab@syzkaller.appspotmail.com>
To: axboe@kernel.dk, brauner@kernel.org, jack@suse.cz, 
	jfs-discussion@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, shaggy@kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 6f861765464f43a71462d52026fbddfc858239a5
Author: Jan Kara <jack@suse.cz>
Date:   Wed Nov 1 17:43:10 2023 +0000

    fs: Block writes to mounted block devices

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=12b95fdbe80000
start commit:   49c13ed0316d Merge tag 'soc-fixes-6.0-rc7' of git://git.ke..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=ba0d23aa7e1ffaf5
dashboard link: https://syzkaller.appspot.com/bug?extid=5dd35da975e32d9df9ab
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1173d7ff080000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16a2ea70880000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: fs: Block writes to mounted block devices

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

