Return-Path: <linux-kernel+bounces-101729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 306DC87AB15
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 17:27:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCC292839F4
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 16:27:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 414F9482C9;
	Wed, 13 Mar 2024 16:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="OgTGHzNv"
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A07394DA04
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 16:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710347159; cv=none; b=iT+Hla3cQKEsNMbe/emCtVL6ItOhtchzH9bwtdn64S/Zw3SqjXbzgBFkfCRmehvICOXeVDFNImZ9hL+MH9A7rpbHMc3IKJC5zNw0VonCXInPIwiiP7V6c9TX5We+wTrKVNHcGdq4Vef2ATSNYsh96pYvoVm6jrpY6ZwcDCXMlIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710347159; c=relaxed/simple;
	bh=1+v+hX17pdDJJ6b6jYIIjDKh50fBpD8puF0YHUfUemQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wf6d14JZU4OHKYOjDrv5CH5vKh/SLshMqcD36UyUQYlar6sUA33lUYg87uhnN5cv3ddCqWTFgXR+N50DJ0nhC3hj1Mu43gaHqSCmq1YSN33nGbRD0fKuLuj9mXAzyfe2cX0FzjlkwdGrIDR6eXF6nHIiRWNrAQsyHNTXl6D4eVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=OgTGHzNv; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-42f13eebabbso33565801cf.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 09:25:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1710347155; x=1710951955; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zuZkoM/pNXkg3fwRgcPCCwXFIp95GZp6NoxUGsneVz4=;
        b=OgTGHzNv8DL7sPU+pYpZcazNi/0ETXxuLOa5V1z097C80bO+gxIi4ImuaAne7AgEpQ
         nB4wzP19UO0aWqwcHTrcpMWHYDVlQGzXbkKIIizx5Jq+Gb12ZZXplh+Z2efe0DDkFF8S
         9y5YSC5TB1e1PjQoTbMJtbTv7x3nzriddVec0+NWiojZ2Ivdlm4L43V19Rn3C90NHJpw
         P9D4utQNZM4ZSpJB27cafYC4MingLA1wHKTcVQa3hL/b+D0GorfVwRXMj5ajVo7KL0rb
         I2pxn7VQIZWUlia3hln/UUZDTHacIy+mi891u4BcLdfMqcfgI0kB+6We8lJjkCxXF474
         cOGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710347155; x=1710951955;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zuZkoM/pNXkg3fwRgcPCCwXFIp95GZp6NoxUGsneVz4=;
        b=KROG/FUYDqHsx8yTYc2jakwKXiEWySeAI7yeq7vxgSX267h0P4iiYQv1bqjMJUmBis
         IIuo5Z+WaX0x4D1hm63GtsrUVcnSw41H57L7LK8LufK2zfsOk7uXSenKAQwcxMZhRwMK
         q3cp5dIlf0wd5Adb7ipIx1VDZoi40aiincEKWfw5jHyoHB31JCbDmkdyOAUDWYYerIGn
         FaiZtD0BT11LcrjX+uSTpxD94WFWnYyES92bIuuoCRvU/X5TMEWtEwUR4FCBJ+yavi8z
         ssu/bcL7NW/q+D6CTk9HNlkPFBMWk5iuea6RUptl+o4EjXzy3iwnMYcbbPpMQugzfrAq
         ThpQ==
X-Forwarded-Encrypted: i=1; AJvYcCV/8iDwx7vmVeHsNJ7XwDJJas3zetkX7VmnZeLUwVESSwOC3TWf/2+nTZ+iugsYATas9zsBj8ow9AaCNYBONbpqsnJ+xqvJekDoiytx
X-Gm-Message-State: AOJu0Yz84pJVQZvJf7JR2utDA2NCNb1i/ZdwevtYWwWnGoHlwtqzU/L0
	2beCcOeaESKq1GasmNus53OpmyAf60zsa5qoADc2XrbfVAqnd2AIgbVeW+Ueie0=
X-Google-Smtp-Source: AGHT+IE4RSELlhIjyVIl9mdoB2c6/y2ghhFHfvK2xWIoar8kwAstJE8efv21r1w2Khjmt3u/eHzNNw==
X-Received: by 2002:ac8:7d55:0:b0:42e:7a9a:f13b with SMTP id h21-20020ac87d55000000b0042e7a9af13bmr17444916qtb.58.1710347155602;
        Wed, 13 Mar 2024 09:25:55 -0700 (PDT)
Received: from debian.debian ([2a09:bac5:7a49:f91::18d:37])
        by smtp.gmail.com with ESMTPSA id k10-20020ac8474a000000b0042f1c348853sm4948440qtp.21.2024.03.13.09.25.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Mar 2024 09:25:55 -0700 (PDT)
Date: Wed, 13 Mar 2024 09:25:52 -0700
From: Yan Zhai <yan@cloudflare.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jiri Pirko <jiri@resnulli.us>, Simon Horman <horms@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Coco Li <lixiaoyan@google.com>, Wei Wang <weiwan@google.com>,
	Alexander Duyck <alexanderduyck@fb.com>,
	Hannes Frederic Sowa <hannes@stressinduktion.org>,
	linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
	bpf@vger.kernel.org, kernel-team@cloudflare.com,
	Joel Fernandes <joel@joelfernandes.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>, mark.rutland@arm.com,
	Jesper Dangaard Brouer <hawk@kernel.org>
Subject: [PATCH v3 net 2/3] net: report RCU QS on threaded NAPI repolling
Message-ID: <c8c7a84eca24c900c154f4b284067b13520fa37c.1710346410.git.yan@cloudflare.com>
References: <cover.1710346410.git.yan@cloudflare.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1710346410.git.yan@cloudflare.com>

NAPI threads can keep polling packets under load. Currently it is only
calling cond_resched() before repolling, but it is not sufficient to
clear out the holdout of RCU tasks, which prevent BPF tracing programs
from detaching for long period. This can be reproduced easily with
following set up:

ip netns add test1
ip netns add test2

ip -n test1 link add veth1 type veth peer name veth2 netns test2

ip -n test1 link set veth1 up
ip -n test1 link set lo up
ip -n test2 link set veth2 up
ip -n test2 link set lo up

ip -n test1 addr add 192.168.1.2/31 dev veth1
ip -n test1 addr add 1.1.1.1/32 dev lo
ip -n test2 addr add 192.168.1.3/31 dev veth2
ip -n test2 addr add 2.2.2.2/31 dev lo

ip -n test1 route add default via 192.168.1.3
ip -n test2 route add default via 192.168.1.2

for i in `seq 10 210`; do
 for j in `seq 10 210`; do
    ip netns exec test2 iptables -I INPUT -s 3.3.$i.$j -p udp --dport 5201
 done
done

ip netns exec test2 ethtool -K veth2 gro on
ip netns exec test2 bash -c 'echo 1 > /sys/class/net/veth2/threaded'
ip netns exec test1 ethtool -K veth1 tso off

Then run an iperf3 client/server and a bpftrace script can trigger it:

ip netns exec test2 iperf3 -s -B 2.2.2.2 >/dev/null&
ip netns exec test1 iperf3 -c 2.2.2.2 -B 1.1.1.1 -u -l 1500 -b 3g -t 100 >/dev/null&
bpftrace -e 'kfunc:__napi_poll{@=count();} interval:s:1{exit();}'

Report RCU quiescent states periodically will resolve the issue.

Fixes: 29863d41bb6e ("net: implement threaded-able napi poll loop support")
Suggested-by: Paul E. McKenney <paulmck@kernel.org>
Reviewed-by: Jesper Dangaard Brouer <hawk@kernel.org>
Signed-off-by: Yan Zhai <yan@cloudflare.com>

---
v2->v3: abstracted the work into a RCU helper
v1->v2: moved rcu_softirq_qs out from bh critical section, and only
raise it after a second of repolling. Added some brief perf test result.

v2: https://lore.kernel.org/bpf/ZeFPz4D121TgvCje@debian.debian/
v1: https://lore.kernel.org/lkml/Zd4DXTyCf17lcTfq@debian.debian/#t
---
 net/core/dev.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/core/dev.c b/net/core/dev.c
index 76e6438f4858..6b7fc42d4b3e 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -6708,6 +6708,8 @@ static int napi_threaded_poll(void *data)
 	void *have;
 
 	while (!napi_thread_wait(napi)) {
+		unsigned long last_qs = jiffies;
+
 		for (;;) {
 			bool repoll = false;
 
@@ -6732,6 +6734,7 @@ static int napi_threaded_poll(void *data)
 			if (!repoll)
 				break;
 
+			rcu_softirq_qs_periodic(last_qs);
 			cond_resched();
 		}
 	}
-- 
2.30.2



