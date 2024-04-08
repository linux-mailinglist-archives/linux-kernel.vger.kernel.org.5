Return-Path: <linux-kernel+bounces-135428-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FE4789C1D7
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 15:24:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A51821F22644
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 13:24:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40DD585C5D;
	Mon,  8 Apr 2024 13:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="Id7iXKTX"
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1140C81751;
	Mon,  8 Apr 2024 13:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712582416; cv=none; b=u80iUl325B3IcBtIvB9cmCB8g1BkO7ZxEfVxY/r2wGe6u9qOT0RQpv/8PhKa/Jypqc3O+joJEG0wuHafXCmHQjuNV26kJpf9VN2nRRoftwL7+LSk2Ciz22Nl61dYusYixe468mIaGt1Kng/dQTE8nDrrvtL9zM8mhVtQb9zaHf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712582416; c=relaxed/simple;
	bh=74BQp+QZEt52EbEIHiebD1Hx7WP7XpuqHyEEfMZoggA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gfxurNQcGaDSxDETZdmM8HZK4+DTUwUyEd+/EW7tHRyulKD2czLnxuQgV3ttos3/IRCLxxtyKnbeFGyAqqZnEc5GW0OzsD53SN+IW37AW8Xp9B1gZTuJaEzzJuSdAp9A7xkX9AdjvzSNLJiIOAATEnuW77dAOHrxOt2U+IJuomI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=Id7iXKTX; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id 8C328600A9;
	Mon,  8 Apr 2024 13:10:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1712581838;
	bh=74BQp+QZEt52EbEIHiebD1Hx7WP7XpuqHyEEfMZoggA=;
	h=From:To:Cc:Subject:Date:From;
	b=Id7iXKTXfwMFB8wguFS5+yCiChwgmKuJe4GqKSjloYg8oINLF/k7S40xH9N64xQ3r
	 RS0jY7bxsCjUd5AFKhE0NcwXdfI4uARQ+/P7JQ1FgGW1IKOTNhkgT8mi51oUxr+cdA
	 Day8I6efxwUC2JqC537nZ/gWO4EC/iFux7EJEezkfD54Tscy2WkAzH1dMQQ9xD+YCR
	 wCdVnogKmFEe5g1eUE3E0oXfStpGN2tIYLlTv+m66WbywLP8zd2CxAiECePa/mVr6m
	 QS5lhsELKBuL8YSQjW3w/xfv3VXH1ROsO5YM24shbFalicbPFgA/o4aSX+NVjIdJ7y
	 IHg50Iyv9c8yQ==
Received: by x201s (Postfix, from userid 1000)
	id 21A71201CE7; Mon, 08 Apr 2024 13:09:31 +0000 (UTC)
From: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Louis Peens <louis.peens@corigine.com>,
	Taras Chornyi <taras.chornyi@plvision.eu>,
	Woojung Huh <woojung.huh@microchip.com>,
	UNGLinuxDriver@microchip.com
Cc: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yanguo Li <yanguo.li@corigine.com>,
	oss-drivers@corigine.com,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Edward Cree <ecree.xilinx@gmail.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>,
	Jiri Pirko <jiri@resnulli.us>
Subject: [PATCH net-next 0/6] flower: validate control flags
Date: Mon,  8 Apr 2024 13:09:18 +0000
Message-ID: <20240408130927.78594-1-ast@fiberby.net>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I have reviewed the flower control flags code.
In all, but one (sfc), the flags field wasn't
checked properly for unsupported flags.

In this series I have only included a single example
user for each helper function. Once the helpers are in,
I will submit patches for all other drivers implementing
flower.

After which there will be:
- 6 drivers using flow_rule_no_unsupp_control_flags
- 8 drivers using flow_rule_no_control_flags
- 11 drivers using flow_rule_match_no_control_flags

Asbjørn Sloth Tønnesen (6):
  flow_offload: add flow_rule_no_unsupp_control_flags()
  nfp: flower: fix check for unsupported control flags
  flow_offload: add flow_rule_no_control_flags()
  net: prestera: flower: validate control flags
  flow_offload: add flow_rule_match_no_control_flags()
  net: dsa: microchip: ksz9477: flower: validate control flags

 drivers/net/dsa/microchip/ksz9477_tc_flower.c |  3 +
 .../marvell/prestera/prestera_flower.c        |  4 ++
 .../ethernet/netronome/nfp/flower/offload.c   |  6 +-
 include/net/flow_offload.h                    | 55 +++++++++++++++++++
 4 files changed, 65 insertions(+), 3 deletions(-)

-- 
2.43.0


