Return-Path: <linux-kernel+bounces-81461-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC11186763C
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 14:15:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE7D71C289F2
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 13:15:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FD7B128832;
	Mon, 26 Feb 2024 13:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b="znmh2kds"
Received: from serv108.segi.ulg.ac.be (serv108.segi.ulg.ac.be [139.165.32.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 013A480049;
	Mon, 26 Feb 2024 13:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.165.32.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708953278; cv=none; b=oOUHdHhz8psLNsOp5/rYlMX291oVYm3m2x8M1LWmoO+QJDNH0o2IXtawQDwXq0YFAW6D10TnPuCKt/sVcl0s1WrPAspGaRvVG8WrBM5PR74RjGZizkCRZG9jElLoiTZ9nOzPC8uUaC5cJW/UEYGogutn3XbLjl/Fs6oJHvS2V+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708953278; c=relaxed/simple;
	bh=onOjtn2OCXKp0syCfFOvRuRw1qC76EXl3R0ojQ20wSE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZtZP2y2oUJHzgbPD4U6ouigG1ptZ2MxL+WIYC/6x06BDzTWzfR4A1TZD6DX/EDxJ5wdEPaGDjmAyfPususVFnPacMieGscC8BNsZmbX++KB9dPqSGUa+ocFMtM3E537fFjClxJ5+zgRQuR821KS5Px02v99McgHAnF8nFYREzGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be; spf=pass smtp.mailfrom=uliege.be; dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b=znmh2kds; arc=none smtp.client-ip=139.165.32.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uliege.be
Received: from localhost.localdomain (125.179-65-87.adsl-dyn.isp.belgacom.be [87.65.179.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by serv108.segi.ulg.ac.be (Postfix) with ESMTPSA id 36962200F806;
	Mon, 26 Feb 2024 14:14:33 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 serv108.segi.ulg.ac.be 36962200F806
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uliege.be;
	s=ulg20190529; t=1708953273;
	bh=Fki2M93IyamHdksa2ApChFnQ2IumATEN8ucI+urLSi8=;
	h=From:To:Cc:Subject:Date:From;
	b=znmh2kdsCw38+VooS2xI7VpDOH6xrY2IwLT8NZXhi5tz4UlROuNEAo76sBmuxYb7K
	 7RG1c70Xq+JbN7AwZC8oFshHoVvNtKWBIZ7y2KfhxocKTEdtF0dm4wwwYIy83OxE7Z
	 pqm9G1VwEfX3eao+u8ydLZa+Far4QHTOnTibl5jIYOrd1E8JEHtWPSTu7iQOB9S7U4
	 IHCwZnt1BBP1Kprzq203f81XOg7QVkuP/3jrzwxKJbJ94+Fpi8VAtc/zcSijLkU/aX
	 KdJwdHWAVbobw3X/NPEPY8yls9pBVnKLRJiQe6ci8C5lX8xueQ1EHvKB03EzEyoghy
	 B2eg6gq/gJjMQ==
From: Justin Iurman <justin.iurman@uliege.be>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	dsahern@kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	justin.iurman@uliege.be
Subject: [PATCH net-next v5 0/3] ioam6: netlink multicast event
Date: Mon, 26 Feb 2024 14:14:09 +0100
Message-Id: <20240226131412.10214-1-justin.iurman@uliege.be>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v5:
 - remove the "must be the destination" check before sending an ioam6
   event
v4:
 - rebase on top of net merge
v3:
 - patchset was mistakenly superseded due to same cover title used for
   iproute2-next equivalent patch -> resend (renamed)
v2:
 - fix warnings

Add generic netlink multicast event support to ioam6 as another solution
to share IOAM data with user space. The other one being via IPv6 raw
sockets combined with ancillary data (or packet socket, if the listener
does not need the processing of the IOAM Option-Type, since the hook is
before in that case). This patchset focuses on the IOAM Pre-allocated
Trace (the only Option-Type currently supported in the kernel), and so
on IOAM "trace" events. See an example of a consumer here [1].

  [1] https://github.com/Advanced-Observability/ioam-agent-python/blob/netlink_event/ioam-agent.py

Justin Iurman (3):
  uapi: ioam6: API for netlink multicast events
  net: ioam6: multicast event
  net: exthdrs: ioam6: send trace event

 include/net/ioam6.h             |  4 +++
 include/uapi/linux/ioam6_genl.h | 20 +++++++++++
 net/ipv6/exthdrs.c              |  4 +++
 net/ipv6/ioam6.c                | 64 +++++++++++++++++++++++++++++++++
 4 files changed, 92 insertions(+)


base-commit: 5fc3903c46a743781cd35fdecfdd889c522e2c3b
-- 
2.34.1


