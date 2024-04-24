Return-Path: <linux-kernel+bounces-156904-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE1378B0A23
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 14:54:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F03491C24729
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 12:54:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E9FD15CD6A;
	Wed, 24 Apr 2024 12:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="CjwQSzW+"
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C594E15B130;
	Wed, 24 Apr 2024 12:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713963250; cv=none; b=RYTDONUFyJ2E9h1+852h687D3NVKpEF4fA3ogIiyC7UMAlbNhwzdRS65cxRvr+ZY+yIiHMbl16oTOddMaDY/alnfwt09wZWf81RfEAEunzrYwuF5J+69b1bEUQDu4ZOsHpLKz4b6zVnIMtrOkRnjAoniT0NESxKFycAMT9iX/Vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713963250; c=relaxed/simple;
	bh=B0CItmNwVZMxKbpgVBG0RmpK9cd1EvQwEV3s4X97mFs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QnWSu1uUP6VQMV4Jm6hJPkLZCrgz0ooMQiA2/K1MtKC5U0eBORPTViaiky1QB9R2R/AiDdTj9GHp3Ev9/U74BfmwlcZq/vwVEfPwklpweUz3/cQg7eDvNH2mDM0t0C/DlFMyxjfA8d4TJOwOlcrfbgwGJYTGi8YuY9Mhmc28+yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=CjwQSzW+; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id 85DBD600AF;
	Wed, 24 Apr 2024 12:54:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1713963245;
	bh=B0CItmNwVZMxKbpgVBG0RmpK9cd1EvQwEV3s4X97mFs=;
	h=From:To:Cc:Subject:Date:From;
	b=CjwQSzW+VeRNiJh+CPdV8Y2JSPn0pqVcCxi8ZHZthQn231jpF/ox9iepgyCW1pDJD
	 fetjgbQ1ct0QamfBLM3EgPzLAFDVOlOqY9QInLZnBwuvYle3sfEekycbFhrym7Epcy
	 6AB7EnmmUFS8TLwaXLllKmUAGfvN57pygai/OCoAWZB4lLwGfPy58vr8NUTHq3yLd8
	 Azg6M5YTAHbbPk+Rl82eAbjNThFAmXd7IjsiLEThAgAkYing/iAIZOoehzDPrd/y38
	 f1LACF4kfC7n2dJYePSpbnex0ZC5bL7DkS/3/v/m3sKWaC4DSuMVFa/EEgxopQZvyP
	 y1AiHw/6OOfTw==
Received: by x201s (Postfix, from userid 1000)
	id 786802044F0; Wed, 24 Apr 2024 12:53:51 +0000 (UTC)
From: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>
To: netdev@vger.kernel.org
Cc: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	UNGLinuxDriver@microchip.com,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org,
	Jiri Pirko <jiri@resnulli.us>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH net-next v2 0/3] net: lan966x: flower: validate control flags
Date: Wed, 24 Apr 2024 12:53:37 +0000
Message-ID: <20240424125347.461995-1-ast@fiberby.net>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This series adds flower control flags validation to the
lan966x driver, and changes it from assuming that it handles
all control flags, to instead reject rules if they have
masked any unknown/unsupported control flags.

---
Changelog:

v2:
* Split first patch into 2 (requested by Jiri)
* Added cover letter (requested by Simon)

v1: https://lore.kernel.org/netdev/20240423102720.228728-1-ast@fiberby.net/

Asbjørn Sloth Tønnesen (3):
  net: lan966x: flower: add extack to
    lan966x_tc_flower_handler_control_usage()
  net: lan966x: flower: rename goto in
    lan966x_tc_flower_handler_control_usage()
  net: lan966x: flower: check for unsupported control flags

 .../ethernet/microchip/lan966x/lan966x_tc_flower.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

-- 
2.43.0


