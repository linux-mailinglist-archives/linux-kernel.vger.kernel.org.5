Return-Path: <linux-kernel+bounces-109560-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B719881AD5
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 03:09:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E1DF1C20D07
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 02:09:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 941EE4C79;
	Thu, 21 Mar 2024 02:09:06 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A58F51FA2
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 02:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710986946; cv=none; b=icHxJ8aXFuumSoxN2ddw5zQk9MVzpXmQMQwO8whhmamqe88VteHDlEFzUQHNl9SHiXrF2+81t8kfl4ZglRm4FwziTJd2cdgpempFV9Gj/wQVwPnhRcX4TQnxgBD5kNN67mFIlQCgXUvccueuG0emDZeqJT+A6cRfu1I8L5rkaCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710986946; c=relaxed/simple;
	bh=vSvbMef2W12WKIfpbtZGJI8WCZUpiNp26esTyEx9MVQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=EcFYzcjXJDNjNXBJuysjy17npgZKQdinM+W0BvDEBB+X5YBtiXBvke74vTVANSnjaHHbbdHeASRa26TOhf3LOtHqh7I+tUD0mNO9j6LizVChRGPnBbc8LXr91Mh93ebHDjgfQLoSYUWdJJp6lrWGRlm7XllOoRKennrEEFFvhzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7cbfd9f04e3so45857839f.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 19:09:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710986944; x=1711591744;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ig9hN30HjAaXtMYb0qA028JMfJqY8uMsaSG23kQBshg=;
        b=MU/4iybX1UYcuTj5N/ilst/374hkZ0JdSK7UsDrv2dSAwSGemeaFn/DVTyM1yNxS7i
         dQQLUwkR/68btZXgVv9IZAwbA50Rlz50rlES+8PFGFXLKxHybVkeqAVoaxvohwNL3EGT
         Zx727OY/bKSWJ6L4BiQQ9qLL7fqAeSYmIQdwAyOPVamAjGZxaEmOo6LfApWcViOBnimm
         jFIQaZMHU6WdwSDrp4EHliIrEnQvqS15BfErzlEOxX0IUW0B8D7EfP0wTnHi4pgSwdZu
         7s7Mx8NZa8ykQDfviiZV2LQd3kHcEKl1/zG4uIv3otTs6KgRp57mJTY/R7SubcQJ+Zu3
         7RjA==
X-Forwarded-Encrypted: i=1; AJvYcCVJnJuM2Ds1BG5//rgzgtdmbwkJnWJfkexxlRTVuRCMXV0lsH2uEkoBWbzP1Oy9kIZOztZ5NfuSAgOG7DcS+pbyy+k1SYIOb88nO7Ot
X-Gm-Message-State: AOJu0Yy3wT1LpGdVIorDZ28wF9JmX8bFYWwlUKT0ihvn1BTzrY5aZZ4v
	uOmHnQAT1j7h8sTsP6oqz5X7lSTWqhLWVGWWeNIeWK3SXAz1mr+hmloJ9f2SWVvN38D9XsnJkQW
	SFTucKDTqRrZtKBP4I6FCRNIV9pEFiu/5LPwXAhQh+2ZxbyYY7OiXbwI=
X-Google-Smtp-Source: AGHT+IFbnjqWtGzFywO8qVf46fk4/z2sPzmY7XDcXreJRZDqRyJFGxoiUr5nOWL1CxwwboBMwbNyGXL+Tr4rlrqVq6Lz3dwuyuSH
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a6b:c891:0:b0:7c8:ca99:b30a with SMTP id
 y139-20020a6bc891000000b007c8ca99b30amr14547iof.0.1710986943899; Wed, 20 Mar
 2024 19:09:03 -0700 (PDT)
Date: Wed, 20 Mar 2024 19:09:03 -0700
In-Reply-To: <tencent_38BA83BB7233789ED71B8B4B181BD325F208@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000001bd790614223129@google.com>
Subject: Re: [syzbot] [wireless?] [usb?] UBSAN: array-index-out-of-bounds in htc_issue_send
From: syzbot <syzbot+93cbd5fbb85814306ba1@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+93cbd5fbb85814306ba1@syzkaller.appspotmail.com

Tested on:

commit:         a788e53c usb: usb-acpi: Fix oops due to freeing uninit..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
console output: https://syzkaller.appspot.com/x/log.txt?x=1714bbb9180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=dd8c589043bc2b49
dashboard link: https://syzkaller.appspot.com/bug?extid=93cbd5fbb85814306ba1
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=16944006180000

Note: testing is done by a robot and is best-effort only.

