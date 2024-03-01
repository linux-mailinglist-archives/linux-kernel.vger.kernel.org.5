Return-Path: <linux-kernel+bounces-88851-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 683E486E786
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 18:44:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2151C287D8A
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 17:44:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCCDB11C88;
	Fri,  1 Mar 2024 17:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fbKApwk9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17D618BFE;
	Fri,  1 Mar 2024 17:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709315048; cv=none; b=dYwqgbL5V1U7pKptV2mtMLruVPDa7gt/iIMXmqprvJBQszoRiVP73JSSnOeIcvuSPwSirGo9qBeGSKx7RheJ/owjlGDMbtQVYafSa9+D04xQRmUDo1M13DWSzdKatqBlMoiwgUz6ie6GNBevzVTI8jQ82Atax0XR1PSMhee/bq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709315048; c=relaxed/simple;
	bh=RgiwHjq99te3mxoQlvDzBcgnm4t11h4M4CZ6qM0UMzg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=gKANyEK3PGTyxCf94l+MwQIRNmMgpe+GTyKPsLK/sqWPV4uhznZ5VytSLpsNsxxqBYufbaJexq2QMARkhkj+N8RE/AmeN9kkNigxddPAaOY5Qtpp1lp4ALZy3Jr6dZAFdVVYhZ4Pzn4pfnpc0XILSC0jibfBmPNIyqwWAHAPqmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fbKApwk9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4B79C43390;
	Fri,  1 Mar 2024 17:44:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709315047;
	bh=RgiwHjq99te3mxoQlvDzBcgnm4t11h4M4CZ6qM0UMzg=;
	h=From:Subject:Date:To:Cc:From;
	b=fbKApwk9uFBe2y7QbpIvRChKVGAA1yHjFD0pB7CGsh/ocmoxGxIxBQBpq2k8jx983
	 hcg7QeLO8nFd0FrKiI/gg0BVRgKLmEfMOqJvni43dp0PubaGYQeJlc22FofQ3EVR2J
	 fN6tU3yLu2S87QViIxorsvmz+klN227O79S728Eci4RIrnSTTuBHGNA/uJWH569j+G
	 VHgtNHOSy9Zp+sjNxOlu6EP0db8TNXSeIGCfXgxYyDie0hvXknzCbfhifS//fQek74
	 hdj5XTkAnmgsL3JO2vXlIDHLDq6LkEznxHfJoDICOGbO5ZpNPp0h8y6ffVi5dPIb6/
	 WslRENe+3dXqQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH net-next 0/4] mptcp: add TCP_NOTSENT_LOWAT sockopt support
Date: Fri, 01 Mar 2024 18:43:43 +0100
Message-Id: <20240301-upstream-net-next-20240301-mptcp-tcp_notsent_lowat-v1-0-415f0e8ed0e1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAM8T4mUC/z2NQQrCMBBFr1Jm7UCaVIpeRaSk6agDNgnJVAuld
 3cQdPEWjw/vb1CpMFU4NxsUenHlFFXaQwPh4eOdkCd1sMZ2xpkWl1ylkJ8xkiir4H+as4SMyhC
 TVIoyPNPbC/a9CX48uckeHWg4F7rx+j29wC8D133/AGaUTxOOAAAA
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1913; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=RgiwHjq99te3mxoQlvDzBcgnm4t11h4M4CZ6qM0UMzg=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBl4hPgrxAKiEvYIdh99Bb9o9cPkISVwJlwcQbPS
 SyVSTC3hfGJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZeIT4AAKCRD2t4JPQmmg
 c1rmEADlqVg8qBM6qIczmltAqyTRPHTnLk+3iDAgupkCS1dPQzoBqhokX7GxmrRCjET/U5jc5RQ
 QxzGHwO/qBjXckl+XIt1Ui9zC661kOi6WXOU/Rf/FnHOjkAiTbVb2D4iRzr7kj+WmFxEbQQTazb
 nmbYxdB2Q76mx/ZrcBhcnwAeRStsMzOl6DRRhZCm4M7X0q8MK0u5Nszy4MCD9WjaBYCXcTVRjr1
 Z0HWzVQ8pgp3zRxSkaoBJILX7yEqQVXR8IwIcSwL59OiR5NadnzGfuv13O9hWDUGVYOzeotnrz7
 d7GoKqpO2uAw0H0VTPijIzx0JDunlPiDC88FeuhmV2Ay084XaopFUvu1rn0/U+zDJ87sVnszTJP
 xJH9mDNJF6skfiF/GqTrU5Ki7OEkqG4+hg10Q0aa6h7jVyC3E6pPN/o6hrrIlIgey9PfiSrjesB
 2aME0EtxuKBRFyyGRPp6HSWogxYPBXAyEaJr/rdvzT/+GDc/pRzmr5egDD16ATiWP7prB+V4i6/
 1bz+NyUGCxiEiun3o6iE7d6y/zMLkT1jQJS0Tw92Parq7Zlndb00mYunFdjPGr4TcRUTPFbVDJE
 lYHfWSggOlKnSOC/IJRs5Fe1qeM967D8oBfuTBZq/8ywMFvhpWttFwRwmwkr4TFI7PVfTKPTtnc
 7eHm+u7QGHoE48A==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Patch 3 does the magic of adding TCP_NOTSENT_LOWAT support, all the
other ones are minor cleanup seen along when working on the new feature.

Note that this feature relies on the existing accounting for snd_nxt.
Such accounting is not 110% accurate as it tracks the most recent
sequence number queued to any subflow, and not the actual sequence
number sent on the wire. Paolo experimented a lot, trying to implement
the latter, and in the end it proved to be both "too complex" and "not
necessary".

The complexity raises from the need for additional lock and a lot of
refactoring to introduce such protections without adding significant
overhead. Additionally, snd_nxt is currently used and exposed with the
current semantic by the internal packet scheduling. Introducing a
different tracking will still require us to keep the old one.

More interestingly, a more accurate tracking could be not strictly
necessary: as the MPTCP socket enqueues data to the subflows only up to
the available send window, any enqueue data is sent on the wire
instantly, without any blocking operation short or a drop in the tx path
at the nft or TC layer.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Paolo Abeni (4):
      mptcp: cleanup writer wake-up
      mptcp: avoid some duplicate code in socket option handling
      mptcp: implement TCP_NOTSENT_LOWAT support
      mptcp: cleanup SOL_TCP handling

 net/mptcp/protocol.c | 54 ++++++++++++++++++++++++++-------------
 net/mptcp/protocol.h | 42 +++++++++++++++++++++++--------
 net/mptcp/sockopt.c  | 71 +++++++++++++++++++++++-----------------------------
 3 files changed, 101 insertions(+), 66 deletions(-)
---
base-commit: e960825709330cb199d209740326cec37e8c419d
change-id: 20240301-upstream-net-next-20240301-mptcp-tcp_notsent_lowat-770cab93d253

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>


