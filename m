Return-Path: <linux-kernel+bounces-92553-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D77F872216
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 15:55:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A855B1F24144
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 14:55:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B6281272D1;
	Tue,  5 Mar 2024 14:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="PEnFEDr+"
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49146126F09;
	Tue,  5 Mar 2024 14:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709650509; cv=none; b=AMvgHTxTv7ds2j9SCmg20SwAk+WBTueAqeYvWIFSnYREiBfjaJnX3/9if5z7gdSOP1Gz5unWDlEDGUEBIQNFrMVVNNmLLHyQfQ8o7/+Um65UvhEJXybuvizeYXfrThrgfCF5T076ONYrW+QoSKVhwBpaloaeWtl1YsMhQgebZAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709650509; c=relaxed/simple;
	bh=Q5UUfJDjrGrdHCHpViOdOzibqAZfW1sh2Z+5l0zVKm8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=oDXWt+PGtzCHEXHSHRpnUM9u6uobDc1jVfF9GjfEdR3XorDtBSa5kKzUTzqPfH9R2OvbTCoGLVdfLmcQ+NdPB12O4PlI9HuqNbGAI36oRy6mwSY3vmSXbP8YjZNKcFEZnIBRi3Xej3e0TDXWh1+6iH4nTl971XgfzukHLLUh9rY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=PEnFEDr+; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id BE13A60315;
	Tue,  5 Mar 2024 14:46:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1709650004;
	bh=Q5UUfJDjrGrdHCHpViOdOzibqAZfW1sh2Z+5l0zVKm8=;
	h=From:To:Cc:Subject:Date:From;
	b=PEnFEDr+lf25mwBZVHqHaRkjyBM6A2Fu/rAeege2bTJJyKLJpFDd/HJ+BBkf32WmH
	 LpTssFyw3bXVFTkSBA/iQ/Ndyy1UF6gZ+t9YBeuzJi8K3n0fAp7D4OJz8iEs5zFsZx
	 OiC0+kZjb/fMpsi7iwrh6Jq/ScI7W884cFjB5JBnkFnV7Saxub01L2QsIeuFLwAZeL
	 5ulIVlhvfK7f7HSY5tuPMXxFyORa8452Hi5mCrGqtuJY9QmWNE65dzaMWrkisDgh7Z
	 q2HQV4pdP60Nvrn6gCoDDUJtP86wf/TWHpp+1AikW3cVfgwDXfkTF7NuWT9pu5Wzyv
	 OH+pa719hcrpA==
Received: by x201s (Postfix, from userid 1000)
	id 3E3F9200A5A; Tue,  5 Mar 2024 14:44:28 +0000 (UTC)
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
Subject: [PATCH net-next v2 0/3] make skip_sw actually skip software
Date: Tue,  5 Mar 2024 14:43:53 +0000
Message-ID: <20240305144404.569632-1-ast@fiberby.net>
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
 net/sched/cls_api.c       | 39 +++++++++++++++++++++++++++++++++++++++
 4 files changed, 62 insertions(+)

-- 
2.43.0


