Return-Path: <linux-kernel+bounces-117993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BFE188B216
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 21:55:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58EBD303F8F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 20:55:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AE1E6F50F;
	Mon, 25 Mar 2024 20:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="QNJKvQ8u"
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B3285D724;
	Mon, 25 Mar 2024 20:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711400050; cv=none; b=hfNQ3BNgiNaFyx5huQawg+MvFymUofsYh+80YDCbbpOKZxFsB9q0taX1qW6SaMpAbvSplw9JwLZ2MhBIc1GYezfXHwEYdOOPCr1oXCtiQ1d3ZL7awTp7Js6mWfnusW0tAtGLwwx8cmSVKf9AOcy9A3sTIeSOTHyoJqEoQR4JRDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711400050; c=relaxed/simple;
	bh=SfX5F5wjnqqIWfjdFxEyw5/3OVHvgRFvzKFulbi0E1g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VYbROnfiVW9QvAMW0z6sEfYJy3+NnexgJFrTD7NTrcE1RILDhvwJcPRnxGlT66zdfmtKVBa+liMb/MzbtYJFjRO5BvNGp5G6o//OtAIMeLG+Iwf8cSdkGH4wBK9Xev7OlJpRt5BWb6kOpCZen21wAbgUsOTouDXBqF1pBSrjeZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=QNJKvQ8u; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id 55CD5600D4;
	Mon, 25 Mar 2024 20:48:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1711399726;
	bh=SfX5F5wjnqqIWfjdFxEyw5/3OVHvgRFvzKFulbi0E1g=;
	h=From:To:Cc:Subject:Date:From;
	b=QNJKvQ8uRXDehHTTmYDgt+93IyAhVuRG/V/8t9yNxDfPpsHLRIBCtHfy4heUiKX/3
	 abUt73vg1jyAnmNnjnbKEhafUuvmESKt8E7PsPqe6hodLXvbLWK8UKygG/hUb4/IXU
	 Upk8Uwb883Bf8MrKKi1QpeZtAZ63UXErxVJaleuS6cMNpB27N6t1p2w+2/4BIC2WQz
	 HB1N68/02GEtxonjiGzauBUwt8LIgkV5KjNciM2sQBrlvp58j8npVlqNU/oSSC+4E0
	 +E4HVNiGHCIpZZ6hQMhxoJrS33ayxuPV+Z3fYmgm9bENjAfyFadimAbHc7UTvmeReh
	 qKsU5dA5+MzGA==
Received: by x201s (Postfix, from userid 1000)
	id 770DC20490F; Mon, 25 Mar 2024 20:47:48 +0000 (UTC)
From: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>
To: Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>,
	Jiri Pirko <jiri@resnulli.us>
Cc: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Vlad Buslov <vladbu@nvidia.com>,
	Marcelo Ricardo Leitner <mleitner@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	llu@fiberby.dk
Subject: [PATCH net-next v4 0/3] make skip_sw actually skip software
Date: Mon, 25 Mar 2024 20:47:33 +0000
Message-ID: <20240325204740.1393349-1-ast@fiberby.net>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

During development of flower-route[1], which I
recently presented at FOSDEM[2], I noticed that
CPU usage, would increase the more rules I installed
into the hardware for IP forwarding offloading.

Since we use TC flower offload for the hottest
prefixes, and leave the long tail to the normal (non-TC)
Linux network stack for slow-path IP forwarding.
We therefore need both the hardware and software
datapath to perform well.

I found that skip_sw rules, are quite expensive
in the kernel datapath, since they must be evaluated
and matched upon, before the kernel checks the
skip_sw flag.

This patchset optimizes the case where all rules
are skip_sw, by implementing a TC bypass for these
cases, where TC is only used as a control plane
for the hardware path.

v4:
- Rebased onto net-next, now that net-next is open again

v3: https://lore.kernel.org/netdev/20240306165813.656931-1-ast@fiberby.net/
- Patch 3:
  - Fix source_inline
  - Fix build failure, when CONFIG_NET_CLS without CONFIG_NET_CLS_ACT.

v2: https://lore.kernel.org/netdev/20240305144404.569632-1-ast@fiberby.net/
- Patch 1:
  - Add Reviewed-By from Jiri Pirko
- Patch 2:
  - Move code, to avoid forward declaration (Jiri).
- Patch 3
  - Refactor to use a static key.
  - Add performance data for trapping, or sending
    a packet to a non-existent chain (as suggested by Marcelo).

v1: https://lore.kernel.org/netdev/20240215160458.1727237-1-ast@fiberby.net/

[1] flower-route
    https://github.com/fiberby-dk/flower-route

[2] FOSDEM talk
    https://fosdem.org/2024/schedule/event/fosdem-2024-3337-flying-higher-hardware-offloading-with-bird/

Asbjørn Sloth Tønnesen (3):
  net: sched: cls_api: add skip_sw counter
  net: sched: cls_api: add filter counter
  net: sched: make skip_sw actually skip software

 include/net/pkt_cls.h     |  9 +++++++++
 include/net/sch_generic.h |  4 ++++
 net/core/dev.c            | 10 ++++++++++
 net/sched/cls_api.c       | 41 +++++++++++++++++++++++++++++++++++++++
 4 files changed, 64 insertions(+)

-- 
2.43.0


