Return-Path: <linux-kernel+bounces-119792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 18B3688CD0B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 20:21:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE0311F8637F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 19:21:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25CCA13D247;
	Tue, 26 Mar 2024 19:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="cFtA1suA"
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C8B513CA97;
	Tue, 26 Mar 2024 19:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711480899; cv=none; b=WQpK2jXsdxMaosMJL9OvjErHT8LNEP6xh17Y22v5f5VMOSs1rY0zQ3Q/ikWMuql/m1EKo6SjqXtjONVYswLUHDk+7sNTpIurHKNub6XvU7JYfQDRGoNpVaec5HBPNa5JlG5R0dDNYyHG029ofzUHs8nWUh6IPO8Hn/PJPTy5H5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711480899; c=relaxed/simple;
	bh=9cMdp25ctdfhNNQ3gPYgKEDh8nmaWQPkPt5E1ShuDcU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pemcN73idBd03eDuz/jbObWzxZFR6TzNOfAXZEZp+7Z0jsSvQ5vajSG/y8iuIlBiOcywreksRhcUNBGQ1d1E4eCtpEE6+lL5CTxRSZLHwDpK4taugs4XICpf/EOU12Bv5/Ixn8SWfz0iCGFZYA52mTPpiVptBzC+PXlw7s28yWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=cFtA1suA; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=KRx6xhqOOORiOklZAX/rJevdrE9krXtIhdBikCk/TbI=; t=1711480897; x=1712690497; 
	b=cFtA1suAv3JDXj22rGo3kxk0B3PIT1GAZf7srlsO1ZtvlIfMBgcDO3kwUAEa1PjKXEGJN76Ux+/
	BefOmMAyifP9Z7BOVvP0I1zeIkpJqpa4pZvb4OjE19V2bXOMD4+PoBDw3ROxMLe52HvvWZylCCQ5C
	exacA4VZuuMQNAN+wIPf4wbu0gpPSjZwWmFhK9lSZ8KMEetYSYIduUDqpaPE35wlmddhEKE6ndqNX
	5X5Z7PmiBircsga7/8acYYu9nT0z1wmPeCRVs1laarSGxTt6Gm27MKVoJs/LNTkFpd6e1jVMp+LsX
	+XLacla0a44P5yaNk4vMyUlYdjRTGNgcgj1Q==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rpCMY-0000000FvLV-3S2K;
	Tue, 26 Mar 2024 20:21:35 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-kernel@vger.kernel.org
Cc: linux-trace-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-wireless@vger.kernel.org
Subject: [RFC PATCH v2 0/4] tracing: improve symbolic printing
Date: Tue, 26 Mar 2024 20:15:55 +0100
Message-ID: <20240326192131.438648-6-johannes@sipsolutions.net>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As I mentioned before, it's annoying to see this in dropreason tracing
with trace-cmd:

 irq/65-iwlwifi:-401   [000]    22.790000: kfree_skb:            skbaddr=0x6a89b000 protocol=0 location=ieee80211_rx_handlers_result+0x21a reason: 0x20000

and much nicer to see

 irq/65-iwlwifi:-401   [000]    22.790000: kfree_skb:            skbaddr=0x69142000 protocol=0 location=ieee80211_rx_handlers_result+0x21a reason: RX_DROP_MONITOR

The reason for this is that the __print_symbolic() string in tracing
for trace-cmd to parse it is created at build-time, from the long list
of _core_ drop reasons, but the drop reasons are now more dynamic.

So I came up with __print_sym() which is similar, except it doesn't
build the big list of numbers at build time but rather at runtime,
which is actually a big memory saving too. But building it then, at
the time userspace is recording it, lets us include all the known
reasons.

v2:
 - rebased on 6.9-rc1
 - always search for __print_sym() and get rid of the DYNPRINT flag
   and associated code; I think ideally we'll just remove the older
   __print_symbolic() entirely
 - use ':' as the separator instead of "//" since that makes searching
   for it much easier and it's still not a valid char in an identifier
 - fix RCU

johannes


