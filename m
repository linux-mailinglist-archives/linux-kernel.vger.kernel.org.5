Return-Path: <linux-kernel+bounces-127852-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FAAA8951B0
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 13:21:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 264901F28551
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 11:21:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AF37626A0;
	Tue,  2 Apr 2024 11:21:35 +0000 (UTC)
Received: from mx10.didiglobal.com (mx10.didiglobal.com [111.202.70.125])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 19F6B604BB;
	Tue,  2 Apr 2024 11:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.202.70.125
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712056895; cv=none; b=fbxFy63flNCAvbNmNohAWMiD121uF8l4V+IT7BN6wZQ98clBJVh0bMlLQ4OuJ3rJmwT/dioT5mY8Mqh5DEJjkKeBrdN55JY0eoUc7vMdIjsTnsEsrKVT0tHv5I6TSHLOE0gW7IvaFZEPbJjHbONaryKI9HtP49je4y/zCmaRB5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712056895; c=relaxed/simple;
	bh=gIE+7/6wqpyt6IYxNKkaCiQY+GCr5s9o467ORrHzAmo=;
	h=Date:From:To:CC:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=SOVjVOHocBKlMj46Myr8AdKus5XLUPNy3hKCFNxE7XRj5CqzgBaZSc33BCikSDNuULuVDiYXxOlMpdMmCew9kN8VnN7FIhj2FCcCzxJ/ti1iwKkM1M4AJz2ja7tr1QK4x72qqJuysTcra5mha2afaxF4nJrgq5zdLycbyofxo2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=didiglobal.com; spf=pass smtp.mailfrom=didiglobal.com; arc=none smtp.client-ip=111.202.70.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=didiglobal.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=didiglobal.com
Received: from mail.didiglobal.com (unknown [10.79.65.12])
	by mx10.didiglobal.com (MailData Gateway V2.8.8) with ESMTPS id C4A8118097DE69;
	Tue,  2 Apr 2024 19:21:19 +0800 (CST)
Received: from didi-ThinkCentre-M930t-N000 (10.79.64.101) by
 ZJY02-ACTMBX-02.didichuxing.com (10.79.65.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 2 Apr 2024 19:21:19 +0800
Date: Tue, 2 Apr 2024 19:21:12 +0800
X-MD-Sfrom: tiozhang@didiglobal.com
X-MD-SrcIP: 10.79.65.12
From: Tio Zhang <tiozhang@didiglobal.com>
To: <mingo@redhat.com>, <peterz@infradead.org>, <juri.lelli@redhat.com>,
	<vincent.guittot@linaro.org>, <rostedt@goodmis.org>, <bsingharora@gmail.com>,
	<corbet@lwn.net>, <akpm@linux-foundation.org>
CC: <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<dietmar.eggemann@arm.com>, <bsegall@google.com>, <mgorman@suse.de>,
	<bristot@redhat.com>, <vschneid@redhat.com>, <tiozhang@didiglobal.com>,
	<zyhtheonly@gmail.com>, <zyhtheonly@yeah.net>, <fuyuanli@didiglobal.com>
Subject: [PATCHSET] sched/delayacct: get task SOFTIRQ delay
Message-ID: <20240402112112.GA17370@didi-ThinkCentre-M930t-N000>
Mail-Followup-To: mingo@redhat.com, peterz@infradead.org,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	rostedt@goodmis.org, bsingharora@gmail.com, corbet@lwn.net,
	akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, dietmar.eggemann@arm.com,
	bsegall@google.com, mgorman@suse.de, bristot@redhat.com,
	vschneid@redhat.com, zyhtheonly@gmail.com, zyhtheonly@yeah.net,
	fuyuanli@didiglobal.com
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: ZJY01-PUBMBX-01.didichuxing.com (10.79.64.32) To
 ZJY02-ACTMBX-02.didichuxing.com (10.79.65.12)

We can only get IRQ/SOFTIRQ delay in total now in Delay accounting, but
getting SOFTIRQ delay and IRQ delay separetely would help users reduce
such delays in a more convenient way.
For IRQ delay, we can tuning irq CPU affinity or using threaded-irq.
For SOFTIRQ delay, we can tuning rps/xps or using kernel threads for NAPI.
And this is an example stack a task is delayed mainly by SOFTIRQ(delay
by receiving packets when sending packets):
	...
	ip_rcv
	__netif_receive_skb_core
	__netif_receive_skb
	process_backlog
	net_rx_action
	do_softirq
	__local_bh_enable_ip
	ip_finish_output2
	ip_finish_output
	ip_output
	ip_local_out
	ip_send_skb
	udp_send_skb
	udp_sendmsg
	inet_sendmsg
	sock_sendmsg
	__sys_sendto
	do_syscall_64
	__libc_sendto
	...

So this patchset tries to make SOFTIRQ delay observeable in Delay
accounting and available in taskstats.
(also update tools/accounting/getdelays.c)

Also for backward compatibility, we dont want to change the meaning of
origin IRQ/SOFTIRQ delay, instead we can get real IRQ(interrupt) delay by
the origin IRQ/SOFTIRQ delay minus SOFTIRQ delay added by this patch.

With this patch, the example above results by getdelays.c:
	# ./getdelays -t 4600 -d
	print delayacct stats ON
	TGID	4600
	
	CPU             count     real total  virtual total    delay total  delay average
                 	3973    10700014780    10698803222   312345815813         78.617ms
	IO              count    delay total  delay average
                    	0              0              0.000ms
	SWAP            count    delay total  delay average
                    	0              0              0.000ms
	RECLAIM         count    delay total  delay average
                    	0              0              0.000ms
	THRASHING       count    delay total  delay average
                    	0              0              0.000ms
	COMPACT         count    delay total  delay average
                    	0              0              0.000ms
	WPCOPY          count    delay total  delay average
                   	40         266859             0.007ms
	IRQ             count    delay total  delay average
                	13450    17756373906          1.320ms
	SOFTIRQ         count    delay total  delay average
        	        13450    17639154300          1.311ms

We find out SOFTIRQ impact the delay most, then tune RPS to reduce this.

