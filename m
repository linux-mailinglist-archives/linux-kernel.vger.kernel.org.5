Return-Path: <linux-kernel+bounces-138260-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BEEA89EEEB
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 11:33:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B05D1C21401
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 09:33:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B15E156235;
	Wed, 10 Apr 2024 09:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="lxkrNuMk"
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAA7C155742;
	Wed, 10 Apr 2024 09:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712741580; cv=none; b=pL1mn5mpsMiF3lgpXh6Kdji0Ku/H4YHYm0mRaHTfBW2MftLx+oByY7CGk2atW0y3kBYAgLuIg3pvdZAkfRmLByWJAQottPINWuu0KI+Tvs5MmotwT8cZoHwb+RFHaf12kiQDuXVqtWePB622U7SYwnmXSIeW5KWteMZsU6s2Odc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712741580; c=relaxed/simple;
	bh=+d1AdDm9YNTOECFXkko3yrbbp3Uo3WWCiKu2CBfk21M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gZODerQj2a2xVqiE22XAa5MtCpdQ9Z1NOIddoCVwHDw03SnyLM2ywBuOFS5v/JM3btfWUlUjrLOEtGZkHgeEpf4XrR0VFGVBxAgV6g3+Rlfg739layw5XgiO0bzXNZjDmYP/U83Pimo+fueB07NlzHJ/HySzdJ4RkTWME+DIo6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=lxkrNuMk; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id C3D5A600A7;
	Wed, 10 Apr 2024 09:32:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1712741569;
	bh=+d1AdDm9YNTOECFXkko3yrbbp3Uo3WWCiKu2CBfk21M=;
	h=From:To:Cc:Subject:Date:From;
	b=lxkrNuMkQNXzTQBNLnGEdrnhuDRP63ETAeSjDptbxalCc3rVyt/RNb9CNjug/GgLF
	 JcKYL/QLnUqwb96xtaiRRh0dYXo/um5dlv/5asUE0pf/WMWY53Lwq12rWoimv082xO
	 nCFGBDx5e5NDFeo9lRInB6of4wnKoU6FWBNfnXxPnVn+rLvGmhdfoaaoU9jMIcowye
	 7ggvBJHipY0fvLWkwP3+1D33jkANHckxn6KhnxjoumztpIfR9L8+w/48Uc+roJi9IK
	 ykRWR7o9NIuHpbeaHLfUE6D6leuRCd9COI9+invrC7JEtAW+Aus2RhRURl3jGaT2G3
	 KlzXJNFkVqq2Q==
Received: by x201s (Postfix, from userid 1000)
	id AF5642029C6; Wed, 10 Apr 2024 09:32:37 +0000 (UTC)
From: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>
To: netdev@vger.kernel.org
Cc: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org,
	Louis Peens <louis.peens@corigine.com>,
	Yanguo Li <yanguo.li@corigine.com>,
	oss-drivers@corigine.com,
	Taras Chornyi <taras.chornyi@plvision.eu>,
	Woojung Huh <woojung.huh@microchip.com>,
	UNGLinuxDriver@microchip.com,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Edward Cree <ecree.xilinx@gmail.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>,
	Jiri Pirko <jiri@resnulli.us>
Subject: [PATCH net-next v2 0/4] flower: validate control flags
Date: Wed, 10 Apr 2024 09:32:21 +0000
Message-ID: <20240410093235.5334-1-ast@fiberby.net>
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
- 6 drivers using flow_rule_is_supp_control_flags()
- 8 drivers using flow_rule_has_control_flags()
- 11 drivers using flow_rule_match_has_control_flags()

v2:
- squashed the 3 helper functions to one commmit (requested by Baowen Zheng)
- renamed helper functions to avoid double negatives (suggested by Louis Peens)
- reverse booleans in some functions and callsites to align with new names
- fix autodoc format

v1: https://lore.kernel.org/netdev/20240408130927.78594-1-ast@fiberby.net/

Asbjørn Sloth Tønnesen (4):
  flow_offload: add control flag checking helpers
  nfp: flower: fix check for unsupported control flags
  net: prestera: flower: validate control flags
  net: dsa: microchip: ksz9477: flower: validate control flags

 drivers/net/dsa/microchip/ksz9477_tc_flower.c |  3 +
 .../marvell/prestera/prestera_flower.c        |  4 ++
 .../ethernet/netronome/nfp/flower/offload.c   |  6 +-
 include/net/flow_offload.h                    | 55 +++++++++++++++++++
 4 files changed, 65 insertions(+), 3 deletions(-)

-- 
2.43.0


