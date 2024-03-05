Return-Path: <linux-kernel+bounces-92676-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF3B8872416
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 17:25:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BD951C21E6E
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 16:25:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A95B112C536;
	Tue,  5 Mar 2024 16:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MvgGRpxH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB443128370;
	Tue,  5 Mar 2024 16:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709655745; cv=none; b=aKWVl91GPXhg9wnNjb/qZax8y22OLfdPv40Ftp2vkYy/drdxzgIWT0UUG90HusTz9dkfLcPB4lvc96Ql8kKERSQhHelaYxJ0+u+QmD1xDUgUHyGPCuI3oCiSFwUKxF1D7bCNNC0WfrbaTwSzCBXpjQt1sT28+hlxAV005xX3w8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709655745; c=relaxed/simple;
	bh=r7/IWaIhvfgMc2GIzTjgzs1RDsbeUNsRCGkfSkbm0Oc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=JBRcCMlYdZhj8mdtrPoZAMkckKmJAU2FCqljaiYxDsysnR4JGc3tt76cdSOyaLVZXM50gr+L+bpsdMbnEDdO4S9Oy4RDm9a0FQ+z34RR6LLJ2y9bw5MwN3lOHJRIRPzF+/6FxYS66OVcrtaAWYOSYO21+nGSTonJHGiIcnfiwew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MvgGRpxH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 94919C433F1;
	Tue,  5 Mar 2024 16:22:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709655744;
	bh=r7/IWaIhvfgMc2GIzTjgzs1RDsbeUNsRCGkfSkbm0Oc=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=MvgGRpxHL2K/dsSjVkZRzY4FVyqR3ymYL7mkdNDQTiVGlNLfBGpTB5Ccb60EmIREc
	 sWZ9n0anUJ7xooUqgydO7w3cG6eBRfgPlRGT0MnXjcYvsI2Xv7FnZ9IP6rQArjS5QT
	 UQttRDjOKkBDJQYuSDKcJPJbwEWXt0WKeOB+DYxdEr82AO6q88ayx7jTrb1CEBxbks
	 Z+Sht6CxcVoQeebLOyNo7aZzkaMRuXwfk1lp7ipi3lDIwe06rE+ic9jSIpdyavjSmr
	 qV/+9TUmGDQugWMwupHC0jJhW0z+tig1hIRR8vHGR9pM6EHiPGqq2VVI3sc7fg7f3w
	 JCB1g94mskzrg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7944DC54798;
	Tue,  5 Mar 2024 16:22:24 +0000 (UTC)
From: Yang Xiwen via B4 Relay <devnull+forbidden405.outlook.com@kernel.org>
Subject: [PATCH v2 0/2] clk: fix mux determine rate logic
Date: Wed, 06 Mar 2024 00:22:22 +0800
Message-Id: <20240306-mux-v2-0-92a5fa461fd2@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAL5G52UC/1WMQQ6CMBBFr0JmbU2nFBVX3sOwoLTIRGFMCw2G9
 O5Wdi7fz39vg+A8uQDXYgPvIgXiKYM6FNAN7fRwgmxmUFJpqbAS47KKkzUXU55RV7WE/Hx719O
 6V+5N5oHCzP6zRyP+1n8/okDhjFG9aUu0ur7xMr+Yn8eOR2hSSl8hlQuRmAAAAA==
To: Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>
Cc: Maxime Ripard <mripard@kernel.org>, linux-clk@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Yang Xiwen <forbidden405@outlook.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1709655743; l=920;
 i=forbidden405@outlook.com; s=20230724; h=from:subject:message-id;
 bh=r7/IWaIhvfgMc2GIzTjgzs1RDsbeUNsRCGkfSkbm0Oc=;
 b=X7LxREwss3jp2LQPdavfWvW4OWeg4WPSZwTYjzwflVjrADoP+Wd1HKqPWR/bIpucKjskTeOIH
 Ko4GNR26KgbDxYNNyDWNu2ZWo7nBNn36oAGYyp35qELQW08PlRG6NpO
X-Developer-Key: i=forbidden405@outlook.com; a=ed25519;
 pk=qOD5jhp891/Xzc+H/PZ8LWVSWE3O/XCQnAg+5vdU2IU=
X-Endpoint-Received:
 by B4 Relay for forbidden405@outlook.com/20230724 with auth_id=67
X-Original-From: Yang Xiwen <forbidden405@outlook.com>
Reply-To: <forbidden405@outlook.com>

This is actually a v2 of [1]. It's tested in a mmc host driver.

[1]: https://lore.kernel.org/linux-clk/20230421-clk-v3-1-9ff79e7e7fed@outlook.com/

Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
---
Changes in v2:
- cover letter: remove statements about unittest
- add fix for clk_test.c
- s/privide/provide
- Cc Maxime
All suggested by Stephan Boyd
- Link to v1: https://lore.kernel.org/r/20240215-mux-v1-1-ebb2fba31d49@outlook.com

---
Yang Xiwen (2):
      clk: set initial best mux parent to current parent when determining rate
      clk: test: use __clk_mux_determine_rate() and remove FIXME

 drivers/clk/clk.c      |  4 ++--
 drivers/clk/clk_test.c | 18 +-----------------
 2 files changed, 3 insertions(+), 19 deletions(-)
---
base-commit: 90d35da658da8cff0d4ecbb5113f5fac9d00eb72
change-id: 20240215-mux-6db8b3714590

Best regards,
-- 
Yang Xiwen <forbidden405@outlook.com>


