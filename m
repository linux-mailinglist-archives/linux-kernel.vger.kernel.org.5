Return-Path: <linux-kernel+bounces-151557-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AA3B8AB075
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 16:13:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 86866B26FB4
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 14:13:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E52E012F38E;
	Fri, 19 Apr 2024 14:12:06 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27CA912F37B
	for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 14:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713535926; cv=none; b=jZZDpAA0JnPqLo8WP5K9MNIfiEnNV6nsjyQIoO18ggVaPf/FQdbivL6Euqspxlfc7t/qU6KAxmA0IvJ+xCbAgtrIlGBvSXSzXE9AIYtM47SnLRbS4mYjJV58AHfnmt2mlZaaiyVlRckkvzQ5DiUKpUxP+bQcWCzTcNqM+c/yYGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713535926; c=relaxed/simple;
	bh=46y3x5EWoVuB69pyK9QfkYMfZnM7ZAdihmSrxiU/+mc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=JyQ9IEC+RvWGQXI1kp27J6XU40h1E4EBqus8snefinbNjWpxwA4TKjhaQ3bVRovIlkDgy0TulzoHAcsiQof7beweq6i4TWbyx+lH+a9F7JyqU++mdpiVEpPVTq27eJTFFfVW50yNsIzWi0XWVSb2DaQHa9+xLf1+CD4WJ2CQjXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-36b16d8e3a8so24900745ab.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 07:12:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713535924; x=1714140724;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Mf4pVk6DxwZlOW4odxz6a9Mou1xgG6wgb7Dnj4fE5Gk=;
        b=CRC9NZh+nyNI745k/vWfee9Og+rTa4Yd7schUWRpwqmBVsoyqgoX23Wylp2EVEIs32
         0jWTu90n7LBoh+UO2skXrfMP7HMXoSwxIMX/2VfrjnSJIg80mBONFN6YHNZxtyFZrmos
         eCouVyLdCXOawBy06iEFWujKJFWeks+tTD5tFZcecn15vtzaBLt581KKGo0PeIszo0D0
         r40eUrLlNOl2PfjZh6fBMiQDGWvE/Hv8NXixRmmObtcBkc7yrJtRhZMqdrUOfMt67uzm
         qZxZGwln++k4qtkAtRg5CXgi2BYbpYsJDsr8FpO8iGhiD+RcaVaRLSu29WnNgF/aBa03
         iR6Q==
X-Forwarded-Encrypted: i=1; AJvYcCWhkh0H2f5QJdGaEFZmE6fxUPU1g3qsRBnvsX9bM15/o9y9mq22u7CBjgSSUmXPMF/2Rcj4/31XsyC652NUE05c0vy51eLokQCAksz/
X-Gm-Message-State: AOJu0YwcO95YjZ3OVG56uKJvRKAbHo/Zr1QzfniCTox8m7/nuSRFCgUa
	wOl5vPWMeq61uMAKevdQ6yw8NgM0lr005mFNwQ5LOl2WtWO8Nfi5nTDtkrT8dvIVHYstBtja0fT
	U+y+BV1IiYV+jgDsYWJu1ZC63tt+6BoRVjbIcadkfUC0aXelayuUAnvg=
X-Google-Smtp-Source: AGHT+IEBVTIGhfpnXkbYsFFjwBdZaF9jJn2BgyjdO2j+nWs49CEX6Zp+nsAeDjZeje76zPJv7ad9PRYl1mklngOi/hq4ONIs7ijn
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:216a:b0:36a:190f:1c93 with SMTP id
 s10-20020a056e02216a00b0036a190f1c93mr134602ilv.5.1713535923682; Fri, 19 Apr
 2024 07:12:03 -0700 (PDT)
Date: Fri, 19 Apr 2024 07:12:03 -0700
In-Reply-To: <20240419104438.2747-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000a94b3061673ace4@google.com>
Subject: Re: [syzbot] [bpf?] possible deadlock in __stack_map_get
From: syzbot <syzbot+dddd99ae26c656485d89@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+dddd99ae26c656485d89@syzkaller.appspotmail.com

Tested on:

commit:         f99c5f56 Merge tag 'nf-24-03-21' of git://git.kernel.o..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git
console output: https://syzkaller.appspot.com/x/log.txt?x=1710ae6f180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6fb1be60a193d440
dashboard link: https://syzkaller.appspot.com/bug?extid=dddd99ae26c656485d89
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=105a7ec3180000

Note: testing is done by a robot and is best-effort only.

