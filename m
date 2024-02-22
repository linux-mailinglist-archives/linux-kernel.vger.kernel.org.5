Return-Path: <linux-kernel+bounces-76616-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10EA385FA0D
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 14:42:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA8A928948C
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 13:42:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 145CD1350CA;
	Thu, 22 Feb 2024 13:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b="alL3mJKy"
Received: from serv108.segi.ulg.ac.be (serv108.segi.ulg.ac.be [139.165.32.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31C4F58ADF;
	Thu, 22 Feb 2024 13:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.165.32.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708609366; cv=none; b=Ulkrk1mwjTNzrK6wh5IyYFyUSpRJPVkEcDyr/8lTSpiJMrxFVoqIRJG0YA+/gY0wz3WMloaA4JZF5vBeJkLRz2JuA0iaSS9MU/1s9nRtVLJNp9/7UpF53smg5rpBWm+iGyzaWA5vXI0xzpDGphHs7/EWK9GFf549vidzpsW81IE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708609366; c=relaxed/simple;
	bh=lwnlAO7c9u+0K1jucUMfAoJX22hwHotbpeTjB3+g+d4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=K2CVED0d1WK2Fko4abZeZZf6CetWM4twfzw4axCT054Xw+kFYN+QsC+iQZ2jSF0C+3ugJxXnUb4yaH7HjH9im6gG3v/e2jxNvs7I27QpZTkMdbKTggu4a8v/EZiygNMhNCOnR28sx8peL5QGRjAa1PomxyXylF8NDKNsCWlUJ8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be; spf=pass smtp.mailfrom=uliege.be; dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b=alL3mJKy; arc=none smtp.client-ip=139.165.32.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uliege.be
Received: from localhost.localdomain (125.179-65-87.adsl-dyn.isp.belgacom.be [87.65.179.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by serv108.segi.ulg.ac.be (Postfix) with ESMTPSA id 19900200DF87;
	Thu, 22 Feb 2024 14:42:37 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 serv108.segi.ulg.ac.be 19900200DF87
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uliege.be;
	s=ulg20190529; t=1708609357;
	bh=w0PXW9Mpe4efPO58dpK4qjFFHJ4r0fyGOsTF5HF5Ajw=;
	h=From:To:Cc:Subject:Date:From;
	b=alL3mJKyEI2GeBWtFWqbK4XW+QbJ5qZj9OxXtzTRF3h+KTcAa/gzVDhT0WcpFRocU
	 DDzoUR1yCINrtjghlJilfu/a14IXvc7iuCNCbZH2K5Dl9HY/uFn7Rp2YhPc6/4gWeC
	 WiC63oeUY0G8UX3EeJMj3mMA3DN2UAFAknBVMqk653biu+y57t1WTTqfDHGnVHny3g
	 R5c/tNsS3q/EpFxvBPXPsSteRCeFNWaTnm1SySLiRLJDN6Bjo8xMlaNQboHqz9byr8
	 RNy2PO51ElNvnlOG1iBEUyopEvxKQWrORajliHQDf3ylPXBdhOIllC/wHWYxDw96wd
	 dntHv7ab2XahQ==
From: Justin Iurman <justin.iurman@uliege.be>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	dsahern@kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	justin.iurman@uliege.be
Subject: [PATCH net-next v2 0/3] multicast event support for ioam6
Date: Thu, 22 Feb 2024 14:42:17 +0100
Message-Id: <20240222134220.16698-1-justin.iurman@uliege.be>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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


base-commit: a6e0cb150c514efba4aaba4069927de43d80bb59
-- 
2.34.1


