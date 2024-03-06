Return-Path: <linux-kernel+bounces-94661-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60F198742D3
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 23:38:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D9B09B2171B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 22:38:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DA611C684;
	Wed,  6 Mar 2024 22:38:05 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67C041B806
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 22:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709764684; cv=none; b=BYGetvjBGLVIvR0msOZmO/eZKz9tg5m2zyE5fEy1SV44VCzkxlTb0DG7FHwRyDgOxQrG89nw8PG8X7AmKMvKt+5IcYr5ErWux08vPPZiAF9dTfVArRK4VXIGsQNrhLnJR0s4e9ePJU9tD1/S8vpnI78HfOIle9ZfTQiETgbaYoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709764684; c=relaxed/simple;
	bh=aONfvMBLi+nGa8z5RQpjQsVQe9F1v8fIwL3IxZQZEyI=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=AI1kEr4EV5eS84oPZ31kSY9JR4tqqN+1Pqr5RJXfDZ92eYZ7REalaK8q4J4xaVBy1Bjc227C9mJ/zFlVAyaZoK6C042ve6xHQxaROVyn8M3UYvfw1LV5T+k84tLkj6qCWY2OzL0NzZ8FCmWTrM4yVR8Z+R3lOVdLMEToOBfdyFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7bc32b2226aso32368139f.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2024 14:38:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709764682; x=1710369482;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oQx8oyVkoBQfTgwpCDc5Joc1fA/0UhEcaF4wgBQJJZ8=;
        b=OmM96LOYl/ou4c0+qjoq77OxmR7vl/vq7HEMtwjv8GkfdDK409HolI/IsVYQUnr0Rl
         hHFvyXDNEQzxO+aymyx3he/MJ3tqzluYVM6EsoVz2LxK0GN5dKu0ig7j97XhATG8rP2I
         kMRXgoHx6hgWU1t36dEyUQ5Ij8dXsDS48yBYQ+pyJYn5TB6TB9x5MtcPMiv7fZ6J63Oq
         D5xQWcAtJo76eHaVw1vbekFvnOZstMMRgItmpoDq76c/OL+H9PRHpoC02ibyCVHYtzdI
         SAnIR59fBaJi++nlApuMvr7Qjo8W8xQTG6OiPEXDiqX4wzDcEndZFtuxVpOQ13OfhD/U
         hOTw==
X-Forwarded-Encrypted: i=1; AJvYcCXPmKPFFBNqgr2WfUyWqAhskYSjVlU4vpoI3wIkS7slN+D0Cw0z8ub2S6/skxNOwyfqZ4V+XwO62BuyqlcatXbDpaQcLGQXyowWAuEp
X-Gm-Message-State: AOJu0Yy4QnAgS/1ISQvO2HPl7k0y+qiaToviijoGhSSYbod5qHQNAevA
	uVbHmhc92mMv4XMc8cRkH09w8jtKb6mrIfjkmwgmpCVnW9UNhYenOuUOSyBwVYJCYND/pFCMh8U
	nwqQHDwEFe5tM02IeWHb2zUrkZEsnxU9wbLe7/dquQn6mosUwV+A2cJo=
X-Google-Smtp-Source: AGHT+IGUeFlmZ563e7wj+Rf7wOdbVjqxtWnT0cqDf2LCScDa5TAdV8QLnpmJdPdM1DX82HvmD30tfAYPKrbIiXL+LIblSWlVilKs
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:2181:b0:474:c5e2:384c with SMTP id
 s1-20020a056638218100b00474c5e2384cmr727865jaj.4.1709764682541; Wed, 06 Mar
 2024 14:38:02 -0800 (PST)
Date: Wed, 06 Mar 2024 14:38:02 -0800
In-Reply-To: <0000000000000c439a05daa527cb@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008d7cfe0613059c97@google.com>
Subject: Re: [syzbot] [netfilter?] INFO: rcu detected stall in gc_worker (3)
From: syzbot <syzbot+eec403943a2a2455adaa@syzkaller.appspotmail.com>
To: bpf@vger.kernel.org, coreteam@netfilter.org, davem@davemloft.net, 
	dvyukov@google.com, edumazet@google.com, fw@strlen.de, gautamramk@gmail.com, 
	hdanton@sina.com, jhs@mojatatu.com, jiri@resnulli.us, kadlec@netfilter.org, 
	kuba@kernel.org, lesliemonis@gmail.com, linux-kernel@vger.kernel.org, 
	michal.kubiak@intel.com, mohitbhasi1998@gmail.com, netdev@vger.kernel.org, 
	netfilter-devel@vger.kernel.org, pabeni@redhat.com, pablo@netfilter.org, 
	paulmck@kernel.org, sdp.sachin@gmail.com, syzkaller-bugs@googlegroups.com, 
	tahiliani@nitk.edu.in, tglx@linutronix.de, vsaicharan1998@gmail.com, 
	xiyou.wangcong@gmail.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 8c21ab1bae945686c602c5bfa4e3f3352c2452c5
Author: Eric Dumazet <edumazet@google.com>
Date:   Tue Aug 29 12:35:41 2023 +0000

    net/sched: fq_pie: avoid stalls in fq_pie_timer()

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1338df0e180000
start commit:   d4a7ce642100 igc: Fix Kernel Panic during ndo_tx_timeout c..
git tree:       net
kernel config:  https://syzkaller.appspot.com/x/.config?x=77b9a3cf8f44c6da
dashboard link: https://syzkaller.appspot.com/bug?extid=eec403943a2a2455adaa
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1504b511a80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=137bf931a80000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: net/sched: fq_pie: avoid stalls in fq_pie_timer()

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

