Return-Path: <linux-kernel+bounces-94302-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 21725873CC6
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 17:59:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C1849B22BBA
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 16:59:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0913C13BAFC;
	Wed,  6 Mar 2024 16:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="aUXi9APT"
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61926137921;
	Wed,  6 Mar 2024 16:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709744340; cv=none; b=nChNfiuUIBMfyi1qHHsp8VOxlKH9km7UDCbXReBAl112BNNOS2NM270yWrjYqHYN3uFHwrV89+EG1S0TttI6ofJELRoN6T3VG28zCiafplB63RFxpKK1OThyEhFIqCllX4ajamFyUM+7UPyl8O47Gs+CSijAvY1ZQwz/QlVxqzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709744340; c=relaxed/simple;
	bh=7KcwAx8GomKY81dwdLlPImImGc1QY46ZYt5n12Z+btk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=anpmbO2fPD8Smsg0TQ6DQljOy5o/pXboynLzB5WV6XM2l7g5lpnm8Y14W2yuzcDQR3zVzB5IROVGeakEfVs4toRHxCzQ3YvgyIT1E3gKafukUQoFLIJ9d8eLRJ3jiT3TQUNM/chxrKx5OxQ/yDyoh94GGApQGRFji03uKLn2SKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=aUXi9APT; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id 041CC60311;
	Wed,  6 Mar 2024 16:58:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1709744335;
	bh=7KcwAx8GomKY81dwdLlPImImGc1QY46ZYt5n12Z+btk=;
	h=From:To:Cc:Subject:Date:From;
	b=aUXi9APTa+3aMxCc+bghaMIHksFhAiOf+0Q44BI032sdjEFsMhOAyzOH1z4mw3NYq
	 S5AysNk3v+sJoNEH10usqETy2TYf2WRzOGfeKhKAHOIfcavZLnYdPOu22lepbIGkKg
	 Hqxgxiq421HAiVP8SFS3mp7MZdxJxIMTdIZcsBxAUI2afGLSv2/P0Bn8ZtH6v/Q1bV
	 Wzk18copaP/LGRTPESOt2sJ93H7vZebw3PZIR6St2IdPIOV0HRx3iD1MOVtDZ0OH5T
	 YuIuo1DkYwjQ/e2n2ugHXqp4e5O/L/Q/TQwOx387Yel+it+goJTwNgLPVZXUpYCjCk
	 JpCB60+05UDyA==
Received: by x201s (Postfix, from userid 1000)
	id 7953E201D3B; Wed,  6 Mar 2024 16:58:22 +0000 (UTC)
From: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>
To: Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>,
	Jiri Pirko <jiri@resnulli.us>
Cc: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Vlad Buslov <vladbu@nvidia.com>,
	Marcelo Ricardo Leitner <mleitner@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	llu@fiberby.dk
Subject: [PATCH net-next v3 0/3] make skip_sw actually skip software
Date: Wed,  6 Mar 2024 16:58:08 +0000
Message-ID: <20240306165813.656931-1-ast@fiberby.net>
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

CHanges from v2:
- Patch 3:
  - Fix source_inline
  - Fix build failure, when CONFIG_NET_CLS without CONFIG_NET_CLS_ACT.

Changes from v1:
- Patch 1:
  - Add Reviewed-By from Jiri Pirko
- Patch 2:
  - Move code, to avoid forward declaration (Jiri).
- Patch 3
  - Refactor to use a static key.
  - Add performance data for trapping, or sending
    a packet to a non-existent chain (as suggested by Marcelo).

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


