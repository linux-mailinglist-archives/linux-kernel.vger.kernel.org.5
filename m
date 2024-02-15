Return-Path: <linux-kernel+bounces-67282-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D93FC856924
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 17:12:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D89C1F258D5
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 16:12:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09D0E135403;
	Thu, 15 Feb 2024 16:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="AHg9AR2O"
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48CE713343F;
	Thu, 15 Feb 2024 16:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708013203; cv=none; b=TmkRnGdCO37fJ9h7Qy7dXtx/P1x3+tN4PugsQHpmqwIDoDutDeeNhtqIxaIxV0Qzse87nAZPuGMih9u02rN6q+JNt36wED+aOCgzxiyVca8kbQtDiJR3bz5SkZ2YTlrdvkv8WI6qlG0wx0O09vjLIDzL3ZXTgZJv4glZN5Ylvas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708013203; c=relaxed/simple;
	bh=a/rV8SSxM9OUnBiZhdQjgb607ZE0A5Lcd/T5aUn9od0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=uM8N8IgKPihOAOPm8HAN53Dl6tt08Xy7USwtIIN4lZMIeKnV0HcxkNj42Mp/SIaa/0vXmQedBVcK9pMXtadExbLMjD3PMO3BM9sR7ZNIuQjRM5X+Bis1gMc8MV+tgV+wez4RpEB0oXEOLsk8tSCfL5+ifCX/Pg3Ky0WTkRWzTVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=AHg9AR2O; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id 125FB6030A;
	Thu, 15 Feb 2024 16:06:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1708013196;
	bh=a/rV8SSxM9OUnBiZhdQjgb607ZE0A5Lcd/T5aUn9od0=;
	h=From:To:Cc:Subject:Date:From;
	b=AHg9AR2O05BEXVIq48uAoumuULMkas0wiJJSGSU+hDvjyrtlrZbby1Wgq0LHKktpW
	 5ZWAc3yerXcj88vSkPCpysgp//RIpg4BfEskDDkOADxto5ZoBr/WFwmyWNzE1k4QVE
	 e1e2DSEr1yHiqjoxJT/bbMR7sz3GHj6XIcAdfbQB2oBP4IZeB/yHZPIY6trFVipqce
	 /iQmoM3NS3KqkS+VeblIOwhxtIKgepO9zjNNc+nMjCuBK+IcfQu7p2l4FfhRXuKy4f
	 QZtgDZWzfFDuM0NJbaogBBH36mVmLKfNgaAxnYAPj1mhiA+TLMDJ7WZTUsqoG/bG7f
	 J8eSMAIZ+H+7A==
Received: by x201s (Postfix, from userid 1000)
	id ADA5D2004F9; Thu, 15 Feb 2024 16:05:24 +0000 (UTC)
From: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>
To: Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>,
	Jiri Pirko <jiri@resnulli.us>
Cc: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>,
	Daniel Borkmann <daniel@iogearbox.net>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	llu@fiberby.dk
Subject: [PATCH net-next 0/3] make skip_sw actually skip software
Date: Thu, 15 Feb 2024 16:04:41 +0000
Message-ID: <20240215160458.1727237-1-ast@fiberby.net>
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
prefixes, and leave the long tail to Linux / the CPU.
we therefore need both the hardware and software
datapath to perform well.

I found that skip_sw rules, are quite expensive
in the kernel datapath, sice they must be evaluated
and matched upon, before the kernel checks the
skip_sw flag.

This patchset optimizes the case where all rules
are skip_sw.

[1] flower-route
    https://github.com/fiberby-dk/flower-route

[2] FOSDEM talk
    https://fosdem.org/2024/schedule/event/fosdem-2024-3337-flying-higher-hardware-offloading-with-bird/

Asbjørn Sloth Tønnesen (3):
  net: sched: cls_api: add skip_sw counter
  net: sched: cls_api: add filter counter
  net: sched: make skip_sw actually skip software

 include/net/pkt_cls.h     |  5 +++++
 include/net/sch_generic.h |  3 +++
 net/core/dev.c            |  3 +++
 net/sched/cls_api.c       | 24 ++++++++++++++++++++++++
 4 files changed, 35 insertions(+)

-- 
Best regards
Asbjørn Sloth Tønnesen
Network Engineer
Fiberby ApS

