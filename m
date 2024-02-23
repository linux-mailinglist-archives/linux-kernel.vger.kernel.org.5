Return-Path: <linux-kernel+bounces-78511-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CD44861453
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 15:43:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DF931C22E3E
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 14:43:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9A1B81AD2;
	Fri, 23 Feb 2024 14:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b="XFLmFEuu"
Received: from serv108.segi.ulg.ac.be (serv108.segi.ulg.ac.be [139.165.32.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52ADB6FDC;
	Fri, 23 Feb 2024 14:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.165.32.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708699313; cv=none; b=qPyVnx82mVuh1cXif8XBXTRLE9tO5bhkwuF8si7Lj1RZWKjaS3cyBnTA0zUnwpD8TwQ/jkKfdXKVb9RLOTXIgHENbDIkI3NH0icq3lruYWBVXZHzl4t0nhlLIpI92x+Ms+4sYPP5XhR7Pa+UPLtSErMo/2SbTu6mghekI6n1fiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708699313; c=relaxed/simple;
	bh=/JcSM0WTV7+8E0Yf8AvjaUDob74tp6fzNZdZsrbefaw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JsRKJ8azJEKfsLx2Cff9uhe33/U8SRnqTVJIYckEgdKjB+9W9EkxW2oppJiHYdqmRQsJVKisCy+1U6n++7SrPfpGAV7ObKmvYtkU0bOkWTyTL+rS0N8WTcKhFiAFCBQeCwfv0B4YTlNdvud67FP+NVlWrzlyBqGelZ9xaqqKTRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be; spf=pass smtp.mailfrom=uliege.be; dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b=XFLmFEuu; arc=none smtp.client-ip=139.165.32.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uliege.be
Received: from ubuntu.home (125.179-65-87.adsl-dyn.isp.belgacom.be [87.65.179.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by serv108.segi.ulg.ac.be (Postfix) with ESMTPSA id 2E8AB200C980;
	Fri, 23 Feb 2024 15:41:43 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 serv108.segi.ulg.ac.be 2E8AB200C980
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uliege.be;
	s=ulg20190529; t=1708699303;
	bh=DjWlF26RJa1uFPKMIHBU+D8WYD3flYCoUtp5JUvKq/g=;
	h=From:To:Cc:Subject:Date:From;
	b=XFLmFEuuzHHncrGUClCDI9FO/J/LBG7aCpV4uby7FlWIJv90ZVfdzq8TzYCZrQDww
	 A0oa9FkFKQ6giQr2LdBxNIdgukV4dWFHCDb4ByHpZYjXkXPrplYCFPxrWPGhU3MPgz
	 LxPxX/pioMUL6v4XKvWGeOu/Tc8Q1x/5BPpBpr8pQ7sdMQFLz/iz4ffxUXgp/tBvOH
	 TfZHBuxNKQ2SI8zBSmteHMIUjck4R7UkuOl+KNvT1kwxPkf/S0YgWDqtlQM5l+NPEQ
	 8XU9IctLR8ORgUnhMtLjcbYDQQcUUVPK7OA40LvcnxMxvHXNEA8Z1f6Ja2SXwsb/Ru
	 92x8CUhKe2zPA==
From: Justin Iurman <justin.iurman@uliege.be>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	dsahern@kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	justin.iurman@uliege.be
Subject: [PATCH net-next v4 0/3] ioam6: netlink multicast event
Date: Fri, 23 Feb 2024 15:41:32 +0100
Message-Id: <20240223144135.12826-1-justin.iurman@uliege.be>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v4:
 - rebase on top of net merge
v3:
 - patchset was mistakenly superseded due to same cover title used for
   iproute2-next equivalent patch -> resend (renamed)
v2:
 - fix warnings

Add generic netlink multicast event support to ioam6 as another solution
to share IOAM data with user space. The other one being via IPv6 raw
sockets combined with ancillary data. This patchset focuses on the IOAM
Pre-allocated Trace (the only Option-Type currently supported), and so
on IOAM "trace" events. See an example of a consumer here [1].

  [1] https://github.com/Advanced-Observability/ioam-agent-python/blob/netlink_event/ioam-agent.py

Justin Iurman (3):
  uapi: ioam6: API for netlink multicast events
  net: ioam6: multicast event
  net: exthdrs: ioam6: send trace event

 include/net/ioam6.h             |  4 +++
 include/uapi/linux/ioam6_genl.h | 20 +++++++++++
 net/ipv6/exthdrs.c              |  6 ++++
 net/ipv6/ioam6.c                | 64 +++++++++++++++++++++++++++++++++
 4 files changed, 94 insertions(+)


base-commit: a818bd12538c1408c7480de31573cdb3c3c0926f
-- 
2.34.1


