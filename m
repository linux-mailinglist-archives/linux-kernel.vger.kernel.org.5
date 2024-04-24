Return-Path: <linux-kernel+bounces-156844-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1C678B0909
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 14:17:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F324282DA8
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 12:17:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4431815B11F;
	Wed, 24 Apr 2024 12:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="iVCChsq/"
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7901515ADA7;
	Wed, 24 Apr 2024 12:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713961014; cv=none; b=JRnwKCyZoOL8QIrUwR2Blto4GNJ7/57Gj4iqa7hjwyhXq9EEzw1hiEiuEW9iTtP7Kti1nnUsInZ34bEHjvDgyW1HPv1yyvzCMI7QsoPtdQZPTxaEEcrxOLayReCDSfapYlmQZ1NKfnTF0/WJ5LBkDS0NCTxTcXtMqqX82PN3P2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713961014; c=relaxed/simple;
	bh=PJ0CzHqB5rokxbMzRyma4HaJ9uYEAg9hicxRy4R6kL0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LmGY8/+MuGsMDDnczV21v44vPM3PETnemHu4K7yR4H8+hbniaVqleIIBrkVq/764YQAp+UWvH0oofIAwnGIc09++si9apzTMPrv7JucPat6zbUaZZu3ADd/B6LgPBDe40/TjTlvPmAO0OBcvi28Jd171Cy6bMA+BNcWJK0ay0UU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=iVCChsq/; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id 08B87600B1;
	Wed, 24 Apr 2024 12:16:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1713961004;
	bh=PJ0CzHqB5rokxbMzRyma4HaJ9uYEAg9hicxRy4R6kL0=;
	h=From:To:Cc:Subject:Date:From;
	b=iVCChsq/jXVH+cUrfMJr5PWDGOkRubmamTZ/AZKRLIsRLW5T/4zOyXIv3gEUSDouB
	 ve42GV5naBSDS9+nSHvq5Vbc8SxYF5ci1lDigOffovf5vhEw9AD9QAs2q5N82TG1fy
	 qnJ+1MxdKbBbmPl+1xL7KEGJ9l/WXu7ATP8i4+tyrW3U3eABZMbMNQ2dTB3j8IhM+s
	 kWggGd0nzN6Bl1YQXfnMyqgRJMUdSAUFGQiVwmja1VGABbe9yLrbKKZD6oqjuA4gsC
	 aTshduVJs57zHNJMFgzQBdywB0uTmYUMZ+QYv65pXFUMRllXLa2jAPtpPqejKY0sLY
	 LNEbG59p+zLNg==
Received: by x201s (Postfix, from userid 1000)
	id 55AD7204B37; Wed, 24 Apr 2024 12:16:35 +0000 (UTC)
From: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>
To: netdev@vger.kernel.org
Cc: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>,
	Steen Hegelund <Steen.Hegelund@microchip.com>,
	Lars Povlsen <lars.povlsen@microchip.com>,
	Daniel Machon <daniel.machon@microchip.com>,
	UNGLinuxDriver@microchip.com,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org,
	Jiri Pirko <jiri@resnulli.us>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH net-next v2 0/4] net: sparx5: flower: validate control flags
Date: Wed, 24 Apr 2024 12:16:21 +0000
Message-ID: <20240424121632.459022-1-ast@fiberby.net>
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
sparx5 driver, and changes it from assuming that it handles
all control flags, to instead reject rules if they have
masked any unknown/unsupported control flags.

---

Changelog:

v2:
* Split first patch into 3 (requested by Jiri)
* Convert a missed extack usage (noticed by Daniel)
* Added cover letter (requested by Simon and Daniel)

v1: https://lore.kernel.org/netdev/20240423102728.228765-1-ast@fiberby.net/

Asbjørn Sloth Tønnesen (4):
  net: sparx5: flower: only do lookup if fragment flags are set
  net: sparx5: flower: add extack to
    sparx5_tc_flower_handler_control_usage()
  net: sparx5: flower: remove goto in
    sparx5_tc_flower_handler_control_usage()
  net: sparx5: flower: check for unsupported control flags

 .../microchip/sparx5/sparx5_tc_flower.c       | 20 +++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

-- 
2.43.0


