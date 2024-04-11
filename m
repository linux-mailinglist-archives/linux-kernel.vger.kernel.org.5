Return-Path: <linux-kernel+bounces-140289-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E64D8A124C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 12:54:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D71A61F27133
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 10:54:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B4B51487F1;
	Thu, 11 Apr 2024 10:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="PGhZUIoG"
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CED8B13FD9F;
	Thu, 11 Apr 2024 10:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712832826; cv=none; b=IbXddb7bWhTVpT+gk9I/HI2AEUq37iLNEOYaeTAtcryufToo7gVD3ejrGgtc5r2IiaLIX7LayHJpq1ONK9vFyXqLvBHaUUflKxjdJVpnqP7GjfB9tXpDCgRhj5yM7RONTrXQFLQhgXPGNP5hdB4zrCEG73TYlbF29/gqYwZmOjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712832826; c=relaxed/simple;
	bh=egO/vAh9sg8JKDmjwBGCeMd6eTlrmF10HvWiI4WWttY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UAyx/Usv8aF2E6OeptZb7hxHzz3L0/pQIJ56E6XutL1a2YhsT4EGAFtJeWK2n2lvt+fMaZkoXDQnKkHqFLj09dyYYrz4t5lWScC3jIJJmeRQkID3UFWKc3VWu2zEEdIPUpReGBKyDqaEFYNGoitNx7vEMUPfq3zZhfltWo6EEh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=PGhZUIoG; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id 69CCE600AF;
	Thu, 11 Apr 2024 10:53:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1712832815;
	bh=egO/vAh9sg8JKDmjwBGCeMd6eTlrmF10HvWiI4WWttY=;
	h=From:To:Cc:Subject:Date:From;
	b=PGhZUIoGBuJlwh5sgK+Obk/vnip+ESpDvITnd+y162h7XQ+ZZcwG+SjcJayGnh5iQ
	 CFK6Jg0xg4cuLsu3rU8tnmI3mqK3gB9c20dyX6AuxuV7U34SwDoawY3rVqozZ5ruX0
	 NQGN8Xq6Z5zferE36l9WraXJ+817a+RzW3ZBV68w/iFPPjKo4E46XIrMiU3rxWeuA7
	 LHPyrPmvgK7doIij/KUXfTYIrPXT9pv2ug4zl3b0lvVl09MsoKE849fYsO2WtDfiIo
	 vcD0yrbCga230QL36Ld5kNSvAkKJgjIt+JlwgwaUSw1H2UU1Ask0CDcLOjKSFWmG0d
	 X72dF3YB1qWHA==
Received: by x201s (Postfix, from userid 1000)
	id 404D720E2DC; Thu, 11 Apr 2024 10:53:10 +0000 (UTC)
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
Subject: [PATCH net-next v3 0/4] flower: validate control flags
Date: Thu, 11 Apr 2024 10:52:53 +0000
Message-ID: <20240411105302.112091-1-ast@fiberby.net>
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

---
Changelog:

v3:
- Added Reviewed-by from Louis Peens (first two patches)
- Properly fixed kernel-doc format

v2: https://lore.kernel.org/netdev/20240410093235.5334-1-ast@fiberby.net/
- Squashed the 3 helper functions to one commmit (requested by Baowen Zheng)
- Renamed helper functions to avoid double negatives (suggested by Louis Peens)
- Reverse booleans in some functions and callsites to align with new names
- Fix autodoc format

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


