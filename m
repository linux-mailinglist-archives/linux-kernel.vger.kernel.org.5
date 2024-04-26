Return-Path: <linux-kernel+bounces-159758-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 73D1A8B33A2
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 11:13:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A57AB1C2194F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 09:13:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 116CF13E419;
	Fri, 26 Apr 2024 09:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="gUG+t1E3"
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0413013D265;
	Fri, 26 Apr 2024 09:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714122804; cv=none; b=damxRR+B/IxKFw4rDrztbkdorz9LqQ8qBLGminCw8T9LTA1ds2X2LPQvwYq8vajQAo+TDMPJT+3WhJ3v/GjcFHnlx1r9gge9k6Pkc5pufrZ2E1GygCKH/8Hrd7OL97W/Dz/enH4rvwvwYddFawJ1QZwEXP+6k7LxWdjqzBWC848=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714122804; c=relaxed/simple;
	bh=zYNHv/2I1GsaOpoj5TYzpTtsAvLoHihfT4LrgFzxEwU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=N1E/jR/FvG3pCYtg8DDCgnqFQXXduDqIunNpCtNL/Fifp65MsKYHn4TYXSBv4BWGamdVQdI8KQK7OscTdntGQ5wH34Jx1mtbHKze7qaAPN6dZmgxlL5QL/JqU1vhbG0m1UnwLoLvrvUGDrZ2W6h9wdQ/Vh7pu3lX8S4W0Vk6NZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=gUG+t1E3; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id 81BB8600AF;
	Fri, 26 Apr 2024 09:13:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1714122793;
	bh=zYNHv/2I1GsaOpoj5TYzpTtsAvLoHihfT4LrgFzxEwU=;
	h=From:To:Cc:Subject:Date:From;
	b=gUG+t1E3T8i40vfURQFtPC9dEJSwfKciJnuLfv+hvxB9ZdHqE1fCtXtbsfGD5OHfk
	 KF92vPBEVtOpjXfKrCZ33WbARzzIaMB1w/CVY0SI3ZmIt/6Le5c/6+K5mM7hdpSQsn
	 lNjRuxysOCqiy59Rrux97wxPHHKFQUiud/SM995ZBxYDOS25oaEb3XFeWrsvIHiVv3
	 RLzWKw4elcQ+l5kjHe5tp8etWsgmXeADKEIP9nC/z/ZXi6qPDQVcuPQFqgM432SGHl
	 fyQvHbZAU89+jE/qL8XnBn+jkdeNzYPgiO3cd4aWERJfxnPWCbmFL+XGgQJcr+tLY2
	 HtaWqGw9MYA6g==
Received: by x201s (Postfix, from userid 1000)
	id D1713205831; Fri, 26 Apr 2024 09:12:27 +0000 (UTC)
From: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>
To: netdev@vger.kernel.org
Cc: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>,
	linux-kernel@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Ariel Elior <aelior@marvell.com>,
	Manish Chopra <manishc@marvell.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Pablo Neira Ayuso <pablo@netfilter.org>
Subject: [PATCH net 0/4] net: qede: avoid overruling error codes
Date: Fri, 26 Apr 2024 09:12:22 +0000
Message-ID: <20240426091227.78060-1-ast@fiberby.net>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This series fixes the qede driver, so that
qede_parse_flow_attr() and it's subfunctions
doesn't get their error codes overruled
(ie. turning -EOPNOTSUPP into -EINVAL).

---
I have two more patches along the same lines,
but they are not yet causing any issues,
so I have them destined for net-next.
(those are for qede_flow_spec_validate_unused()
and qede_flow_parse_ports().)

After that I have a series for converting to
extack + the final one for validating control
flags.

Asbjørn Sloth Tønnesen (4):
  net: qede: sanitize 'rc' in qede_add_tc_flower_fltr()
  net: qede: use return from qede_parse_flow_attr() for flower
  net: qede: use return from qede_parse_flow_attr() for flow_spec
  net: qede: use return from qede_parse_actions()

 drivers/net/ethernet/qlogic/qede/qede_filter.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

-- 
2.43.0


