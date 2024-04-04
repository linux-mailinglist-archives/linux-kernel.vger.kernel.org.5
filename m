Return-Path: <linux-kernel+bounces-132193-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9795A89912C
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 00:19:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51E742864CC
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 22:19:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A636213C681;
	Thu,  4 Apr 2024 22:19:06 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCC8B13C3F7
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 22:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712269146; cv=none; b=TwK2yzkeltPYH5z8DAnL64w0JTaxPLd8vamZruAgk6AETGu/GGF8uSYji7Al7SHrMxMhn6U/EprL0M7h5q1eAfN4SP+to9tQXAliQX4ZnfznK6gOJAuhsrW6PBw3HO/wHQ7MK3N3kTYLEW+kVyOgzYLdtpJ199eyzF1lMw0W0M4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712269146; c=relaxed/simple;
	bh=7NODJhpqCiBUARlC13M54J4ioWC06Fj/ZFd6ehYpxNM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Wt7A51zapx0UpQQsWgiGwoOga4Yo0CzaqKiUCxwgHEWknHuRREiVClqDpE3xkf1PeMMx7WShhuYfrxaxSggO7jjdFkudMn0iZKWzfFVRrTY2o3MEFPvOQjG6fYbw0p6TC7EhXYafou466J1lHqz84z/TWO6PTUYruZYadJifP2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7cf179c3da4so169852939f.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2024 15:19:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712269144; x=1712873944;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eYo+XKJ2eT3bRygBT7/7KHEeMg1adnKVOy5tKf7Pnec=;
        b=UtAI3Jbz0lVa2ZofLWO+sg2y+lHvutSsylqXCdcMTllQiwSyz68X+bqm6vTWltS//V
         3v5k4M5UDqSdRizOnJzc7Qeh8xBhtUwcswC3LMvxDW/HdXZS3N0cMifkrEOJaq6FQd/7
         lkbkYOhdAafVX58y9MzEf5eW9NgqQFVIT1ngCYPHz36C9QMUD8SYpYGF0UN7NDZoo523
         PgIbNJ9v5ZG1ob6eM9p4O8Woh4gdBnHI+hZVDsL+xcBNvDwX4QDnUM2XV8ttTxwW/1q1
         E5pbj9xmT14LBJjd2RnH/elK0GdgdFPj5X+ept/UMuKjyFMsKH8gmtiQ/85jfGIvgPeN
         MIzA==
X-Forwarded-Encrypted: i=1; AJvYcCWdMiJ1xVwSToi743EVu0dJTUsk5K0ZXO33BCB3QoRF3d2xQV8Lg7SbOcMsxAJZZtwVKtnGhqdCZTKSVGFRAAoN3VjgXfS7qGqFRDGD
X-Gm-Message-State: AOJu0YxM5JTTeK+TSG7IOULhQAZJ28eCW+2m7zUmu4yUwptq2ACKfzng
	RTqqW5l7Up4Mb2+wVmAo5ZrJ5vnZ1Nj7zcPVa1sTQSigjBklPrgbmyKBYvRf/rMJ5p1z6+x/CH1
	yGwHVs8j+rx9ExlvSqDYnO8HpHhwN7BGTkTo2/X3DVIBuEoZ9Z4bXSdA=
X-Google-Smtp-Source: AGHT+IGPHH8NJNv4WF/pRNJQT+K+9g7osvDp5eNffLwt8hxhiTLGjNVK34MAUhoVW6vkJpBz/aP6CUqkcY7+5SAUkhr076QfkQ0C
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:2102:b0:47f:1061:8851 with SMTP id
 n2-20020a056638210200b0047f10618851mr56561jaj.2.1712269144032; Thu, 04 Apr
 2024 15:19:04 -0700 (PDT)
Date: Thu, 04 Apr 2024 15:19:04 -0700
In-Reply-To: <20240404114450.4136-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000171a3f06154cba0b@google.com>
Subject: Re: [syzbot] [mm?] WARNING: bad unlock balance in madvise_cold_or_pageout_pte_range
From: syzbot <syzbot+c641706ad4e9688cccdf@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+c641706ad4e9688cccdf@syzkaller.appspotmail.com

Tested on:

commit:         727900b6 Add linux-next specific files for 20240403
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=17446b3d180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=afcaf46d374cec8c
dashboard link: https://syzkaller.appspot.com/bug?extid=c641706ad4e9688cccdf
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1268c903180000

Note: testing is done by a robot and is best-effort only.

