Return-Path: <linux-kernel+bounces-144096-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E3418A41BD
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 12:12:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 93E54B21127
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 10:12:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A43A2421D;
	Sun, 14 Apr 2024 10:12:06 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C0DB17BAF
	for <linux-kernel@vger.kernel.org>; Sun, 14 Apr 2024 10:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713089525; cv=none; b=PAQJjpfz0TKaBdEQl0hgQAvQ48q19nfZpV7imqFXs+FYZADuKJ0uwSju5JkbQ5dAqnJ5kQi24/8VGMUKUQaAQQuXmWFquiu+MLi/z6zYHVLzvJbLJK1FC84tUw9L8pfFWBm0daJIsz9QIG4Cn8389cTHa/J9BfM4+eplXxpu6ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713089525; c=relaxed/simple;
	bh=YIX7OM3oHydLOWP2gWSChD/ieliERf9pyMW6uWbpbks=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=npsjU2h4WKsdTGjYmq1fr3llCOyAHaUvLjmJd2KPI2+bQexyG2vFSeNU172XVvRIMfWLZu+zMn7SghpKxK2iClpotOW1RGlXn+SaspbIlldPHhyVczX3JuMoCepshG6CJ92mlu30hhwOH6eLNjiR1QnkeLzyMurMdUAUfnhbmWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7d676654767so282548039f.3
        for <linux-kernel@vger.kernel.org>; Sun, 14 Apr 2024 03:12:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713089523; x=1713694323;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bG7kg0fN38/sfFq5FZp1OQO5fMSlZiVQSGbLzHrYAVg=;
        b=shMvXV+/DVtimT+BwmWsJnU8hl6XhftL+M6GrBuWzSlZMLGPhQdwuDFjUoAcDXVOFa
         FAnYO78njtH4b83QtX3KLTMY8a6gDZ/ZUgnw0uhKFlH7Dk1voNWMNwBER8DsA7qwtvB4
         QRRW3Wl/K5wSOrBx9buudw8MBvQtzjOv532h8UcIZfP+4ETxFWiMyPF+DgoD/F3fltiN
         tSa0d3cfrnwmP7U5F9B5txvxOWwnCjndL+wjq3QG3TEBcdjpizPHAT9oEGGzgljxk/6B
         3mfThGUTvOBRH27XQmxhAFump9ECyoPXeWIOFhXKlLvRHHkh7gJHjceGJ7uLljm6jqhQ
         mrVw==
X-Forwarded-Encrypted: i=1; AJvYcCW9e2P4hqyBDQDaNhnWnEAt6lqGkzXdrZOS2ZJ5u6S6bpCJbeueR8GaPfEVvQTmqPwvQRPYi269mL8iJcFv780lUzoN8rQzC0GRF3Pc
X-Gm-Message-State: AOJu0Yy78Q9BQeTztvrmX0ImqBfHk4bhzuRfHE0BN7V+aW7MHp7YyyQw
	1a3M7j311taycKcrU+KJymntUZdeOIaYjgXtq51nVFjgS+ZLy3XHmYaDWH/OH1NLFXr+2ehSmPW
	n3DPIOLyh02lAqwiOrv9GyZomblFYiyLK0+edonxParvCxWDU16X6lCY=
X-Google-Smtp-Source: AGHT+IEwmFE1QWB2oesLgAytv39eNv0OwUfz6AGPiMiIxaGW0BmxKhq+xkROYvjCYQ6hxz5xP6+f/lq/Yb+kkV7kVndEKsxc10Qf
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:174a:b0:369:f7ca:a358 with SMTP id
 y10-20020a056e02174a00b00369f7caa358mr583377ill.0.1713089523595; Sun, 14 Apr
 2024 03:12:03 -0700 (PDT)
Date: Sun, 14 Apr 2024 03:12:03 -0700
In-Reply-To: <tencent_555E4AEA752577B167583CAB36B696FC3709@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000085ced306160bbc82@google.com>
Subject: Re: [syzbot] [sound?] inconsistent lock state in snd_hrtimer_callback (2)
From: syzbot <syzbot+8933e1c7c07fe8f2dcd3@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+8933e1c7c07fe8f2dcd3@syzkaller.appspotmail.com

Tested on:

commit:         fe46a7dd Merge tag 'sound-6.9-rc1' of git://git.kernel..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=114423d5180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=aef2a55903e5791c
dashboard link: https://syzkaller.appspot.com/bug?extid=8933e1c7c07fe8f2dcd3
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=16af402b180000

Note: testing is done by a robot and is best-effort only.

