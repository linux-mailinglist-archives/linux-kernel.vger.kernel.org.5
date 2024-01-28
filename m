Return-Path: <linux-kernel+bounces-41942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 764A183F9D0
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 21:14:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31A462832A4
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 20:14:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 923A352F8C;
	Sun, 28 Jan 2024 20:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="E5w0/h86"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF8E345BEA;
	Sun, 28 Jan 2024 20:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706472701; cv=none; b=qw48/o06MEPv8Dn31wIdukX8ESYCgkpchZ5oyP2/auhCSgMVnxpHyc3j22Vdo9srqnNhNMSyGTgcShgrNTR+qgH550p6QXsf46hd6VWvWGOqRuU78wptoA16abhn4WaJ01nd9chpMT9V8HT3BiJ0uSoNrCCGoRYPjT77iuzpGFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706472701; c=relaxed/simple;
	bh=qomwzeZ0+VdI6mZ2yu+WT993r+YiIAfvdX9TkSDmq08=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ypl4v4tkw+h65b0dcb1ZtXJpuT6oy1zORVQuxyhh6kv4vfs/jsJD8dupUn90u0TFzObVJZYzmYaVzKwDWuf0ngLzlgMCjWXOcXcxwsYNMbqTKXtnF4ac7XKKMR0giVcI9mVA2hpfr5Aq7II8yhr8DdMm+SZ6mwJgk7+16C1CZU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=E5w0/h86; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
	s=s31663417; t=1706472685; x=1707077485; i=wahrenst@gmx.net;
	bh=qomwzeZ0+VdI6mZ2yu+WT993r+YiIAfvdX9TkSDmq08=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:
	 References;
	b=E5w0/h86kgKM+pPZP60JZkKNqdUVjJj8gvX+i37JI+u/d0CVWVh/ohcbOC8IWPwp
	 ujD3buEPmemNz79K11vLkwH9A7oWFMwEj4zh1DzPYpjiNt3rs9m9yJavdTPhvlBvF
	 nt/lK3od5c9kShy7ECSlzDtzlT1u94dacZokaL3UoEjEWT/2zN3jFmGlL0sJFLHG/
	 z+Bwe0rFWxYVpXTmhfUneUc/lJZ3L3RSCZ2oxurNaVAwFGuPszzn2Xbha2GJHJLEm
	 h500/jgvChpINTAROrYJaWXmBAepi8IOxuIEIX0c+ZjPuMLO1HkYOZE6R8vUui3n9
	 I/cmChHDy/xqV0BrcQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from stefanw-SCHENKER ([37.4.248.43]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MBDj4-1rLuHz1BT4-00Cj4W; Sun, 28
 Jan 2024 21:11:25 +0100
From: Stefan Wahren <wahrenst@gmx.net>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Lino Sanfilippo <LinoSanfilippo@gmx.de>,
	Florian Fainelli <f.fainelli@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stefan Wahren <wahrenst@gmx.net>
Subject: [PATCH V4 14/15 net-next] mailmap: add entry for Stefan Wahren
Date: Sun, 28 Jan 2024 21:10:58 +0100
Message-Id: <20240128201059.6259-15-wahrenst@gmx.net>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240128201059.6259-1-wahrenst@gmx.net>
References: <20240128201059.6259-1-wahrenst@gmx.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:6f7TV1aAKo0U0E1wOpDbkUEDEgpYbTr0D+yMFV6k4LWK/x1cpT6
 9rQb70QUJWxdrreJ/ScTIauS6tOWB4w2bPTYW9Awkw6Uhxqx4KxSZ9hn3LV8mJ5WKMbw2v0
 9wtl17zw/G60UHcnDN1BbaTc2TwSPRaek3rNkvXDxdSWjFpphyoI5kiIpruJkAIcMZHVwh1
 nB1uNUKtJ/iiX3XgfrdGQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:3P9hcsEIbjA=;k7vNDQcKfYHjKoxTtuU0wI5t1ms
 ejdxHLh5JflPbTAdKJghHs3gKnB/4tM2qZOKJ0b7Nw9UPF5IbUkcqr1s/ZN6V5FS3BnWxQb7u
 6akH+8SUBL3oVdHjZx+Pi4K/gRGrpth3bgT+xPWBSugbKjdsgjR0QKiQfOGpvjv1cxKHvtIpc
 HVrnCws2Ifsc7mbXFlhodBSlGGw3RKwZCfQJJ0fe0BlkGWFcSMMJBB8On0o5fVmCTkZwOD+ef
 MnryCPQKDLsv8iNC6mtg1MMKQQjtIPwDC1TETD4TwH2Z4l1fRrloX2CSMcvFGXBumb3QuFZxO
 txA5fRS0pjTq3mMxI9G94lT8xmwv8BbYKQFBcaDQJKcKy9Z67PB5Gvm8/8RZmEd3IauzT1blA
 jM5PcSDkv9hsdl1eNeksjcCgCp7eenzyVXNHGLHuhouKYeqvWdrm83SxHIpFV9v2mGPMXC9dV
 7ab9nnIXMQCgDtMgpop609Jl0rddOfK1GWGIi/6/1OKqJX63QWDqna3J5EsNvA8VZGGLvFQ55
 SzpC0wku6aD6XIr77Dzq3+MmHJ7hTr2bQktOVrcYe11Le9H+SWA2PY3pC2l/PA8/9URF5yevU
 kRSf4Sz7VSbyUlgkPgulA3RfZZbXw4ABO4PxFpBhXAq/fIMMc4D9/wGb9bWsHSJAnXSph53jJ
 k5Bdy/ExrT7b4r1CHT0UvdfrwZaSqmxKMHx4vxJpXLrWAY1ZgMuv4U1L3Hbh4hCpLEKqu2LDJ
 cMjvtLnIWPS3qHfpYFNUM/qBBXwbdyuuislFfLwjIMe1ngEqirlIrlX1FAgVJyIFQt8cURmVP
 qc7tyOh8kAKPFNzQmolvH5zhBBpAhqDSlswnXRNJ1Eei12QqFe/a88dF2AnOsRURGlnjzd1jb
 Q88QKoUzHh+yn+DDJolZs0NtOxKuRFziQP4q8n4dmX8Gw8+QefrRyKRecH61863P8N4hzo7Oc
 pUMG4w==

Add a .mailmap entry because my old i2se.com address will be
deactivated in the near future.

Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
=2D--
 .mailmap | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.mailmap b/.mailmap
index 04998f7bda81..95b4fe465cc6 100644
=2D-- a/.mailmap
+++ b/.mailmap
@@ -568,6 +568,7 @@ Simon Kelley <simon@thekelleys.org.uk>
 Sricharan Ramabadhran <quic_srichara@quicinc.com> <sricharan@codeaurora.o=
rg>
 Srinivas Ramana <quic_sramana@quicinc.com> <sramana@codeaurora.org>
 Sriram R <quic_srirrama@quicinc.com> <srirrama@codeaurora.org>
+Stefan Wahren <wahrenst@gmx.net> <stefan.wahren@i2se.com>
 St=C3=A9phane Witzmann <stephane.witzmann@ubpmes.univ-bpclermont.fr>
 Stephen Hemminger <stephen@networkplumber.org> <shemminger@linux-foundati=
on.org>
 Stephen Hemminger <stephen@networkplumber.org> <shemminger@osdl.org>
=2D-
2.34.1


