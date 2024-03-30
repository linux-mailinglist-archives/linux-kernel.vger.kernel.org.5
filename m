Return-Path: <linux-kernel+bounces-125774-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4291A892BF3
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 17:11:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFA49282F45
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 16:11:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9924E3B19C;
	Sat, 30 Mar 2024 16:11:04 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B77858467
	for <linux-kernel@vger.kernel.org>; Sat, 30 Mar 2024 16:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711815064; cv=none; b=iQOHu1gSW9RarA4PXLMyJiYn8oNBqc8H6SVO/n7IGVFpr5UCvf0x+rOTAzd31xHiGOA6zB5FHngYxIHfrSWDmYg8WNYApALznjcsMu9Capk9+DYgze1rDA4gN0effBUPkqVta03Cf9elkwYF12J1Mp7D7q9kaS4HKN5UKdpPLyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711815064; c=relaxed/simple;
	bh=rE2LBeiZADv3SPsON3g22a6O6pbML0OUkSm0NmmX6BI=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=p2RL3NwWkoy0BEM9OQk7nlPYg14o4w35aFp+LvLqjZjuCDU/e1q1dxH9sDGnxXUSIhMh+0TRVsSdk9jjPW5weZbSGMh6gknUK8YvBBeOFuIBPssbKgWzflyJSDPtTg8dTcdheQOEXxTkX5gRmRY7SgD14lwJOD5wqy8QF6Nh0qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7cf179c3da4so310489339f.2
        for <linux-kernel@vger.kernel.org>; Sat, 30 Mar 2024 09:11:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711815062; x=1712419862;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SN2ssS1+q+7kuSgUtH84Kti919a6osQ0S5/hE8tq+PA=;
        b=TqYbEd+UoXs3s9m/zFYgdlFbjdGXjvBhkJK05Jxcm8Msw06hPWttYfighXMf9fvwJ9
         k1EHvPcr7Nsov2sR/obdvQtDr28IEKtL8lYC37t/Wv8XQvSyehhAPcMJQgxDaPE+hXHc
         WtCYo/V6idXZDbGSGESC9yE55uECNaPuOEj+wR3hE68MQhYYCHUSynDttYP/ZHi94EEs
         dDvIEqmTKNtSWiNLq1mmU0cUquEpcutqQL+Hwxg/vI3vc4McwJJiMQuKMifd4hTjUSkK
         iEcfr76YmsCKi8+H10FgIiN338HI8/LwmO8MCqAtsovfQitIYMH0ek6NxQc+oyr6zrOA
         R7Yg==
X-Forwarded-Encrypted: i=1; AJvYcCVa6n73nd006t1KG1i4oABRPSqrg7GD+HSt1Pdjw1c3sM5Q22Dcd2WKwRUx09H8KGbA43iV70cDp6G8nw2Yrv/nHw3v2htV8qV1zjfb
X-Gm-Message-State: AOJu0YztZN4BKRQpWyVSiU+SoPl7n42Biq78JUgczVkIEZB53x+AZW4r
	9uqh/cLdK9O+WSAQ5PCaRj7JNzLYtCCshynq3ETNMLohvRt6xxvQOzovceFzY39KddNaTv4rkSS
	ajadH5tkmjICz85WBieBwZMSJOQm1TmGFGi2GMsfMvtycxpyZHDG9LrI=
X-Google-Smtp-Source: AGHT+IHJP+qkQU+ci0caUHT/HSO/xAGTU1HUHf/RmxEVfnxn1UdeI6snMx5GmwjRSJQH+H7pIQpVhTjSgxAxpUjh3CEbtDeWZbRE
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:20c5:b0:367:d6da:8dbd with SMTP id
 5-20020a056e0220c500b00367d6da8dbdmr305231ilq.4.1711815062040; Sat, 30 Mar
 2024 09:11:02 -0700 (PDT)
Date: Sat, 30 Mar 2024 09:11:02 -0700
In-Reply-To: <tencent_BC992D4F930DA4A5930D8E92215DF05D8A07@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b1c50c0614e300c2@google.com>
Subject: Re: [syzbot] [bpf?] [net?] general protection fault in dev_map_enqueue
From: syzbot <syzbot+af9492708df9797198d6@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+af9492708df9797198d6@syzkaller.appspotmail.com

Tested on:

commit:         443574b0 riscv, bpf: Fix kfunc parameters incompatibil..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git
console output: https://syzkaller.appspot.com/x/log.txt?x=12df8ffd180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6fb1be60a193d440
dashboard link: https://syzkaller.appspot.com/bug?extid=af9492708df9797198d6
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=16742f45180000

Note: testing is done by a robot and is best-effort only.

