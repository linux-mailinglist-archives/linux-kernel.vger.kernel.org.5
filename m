Return-Path: <linux-kernel+bounces-165250-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AC638B8A14
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 14:35:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 85129B21833
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 12:35:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3067085C66;
	Wed,  1 May 2024 12:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i8qBi7Mk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6183833DD;
	Wed,  1 May 2024 12:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714566914; cv=none; b=hlmd66/07AeFMvk4FsBdLbfz0GMpgVsQVHxwxNpaNppPE6y58Qk0pXqLloDyMrPVqUw5kp4+GXYejyfhFm6ORc7BdE6qklDKjdxT3fv/LtoUeXW92aub8wLvbAXY7eWhmWSNWDysHVBzHBFXZUV0bP3pg+Uo09uAKOovIbx94h8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714566914; c=relaxed/simple;
	bh=tyE8gtEWWuUzatqs+r9wa2o8BkKcol3pHFv6FYtwX3I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=guy4CtI+4fJN9h056jDaBj/iNrjek4GN2gEanvLx6m3ZUQ0htq2SmNYhgDveoyDrzxwHgmlaZ1ix0pYSt1oxU1LrV/1LCP8LmHBZFtWepsiTLx+6ji7jNnypAGBBexDaQXU63K1UiivYFe4kGxd0tyt9yqQNGo0d4mg+a9iTnng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i8qBi7Mk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CD49C4AF14;
	Wed,  1 May 2024 12:35:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714566914;
	bh=tyE8gtEWWuUzatqs+r9wa2o8BkKcol3pHFv6FYtwX3I=;
	h=From:To:Cc:Subject:Date:From;
	b=i8qBi7Mk/qesRXwRnwsmdiKrC67xK+x4bLd9gKjWw4LumzqRQ5I+qat2IIK/PCRoQ
	 HBybHkEyzPv+rQQMKrh6wyUebbKvbEsbV6PUcN57a+lm/dnsdBB7+vEDzHfSqxDdpB
	 XZ2O7j6fX6KimQmXZyhQIDe1IYBe4qEsIa1Jw2ZNg657yfRfoQ2/tkBCCpz9+kf2Dw
	 Bi1Okh8kizB0S3nI5JS82YaNC957i7TxkXjRAeP+RAf5BSuqSxY2LDEhWm49mwVEm8
	 t8cqz3US6U5HGmt80nHN51X+4YexqvgaEyc3G0UArOPTBmWkJbmGBIQf6dXEHhIZxt
	 J77ljFw8WXr2g==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan+linaro@kernel.org>)
	id 1s29B6-000000001kw-0F6b;
	Wed, 01 May 2024 14:35:16 +0200
From: Johan Hovold <johan+linaro@kernel.org>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Janaki Ramaiah Thota <quic_janathot@quicinc.com>,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 0/5] Bluetooth: qca: info leak fixes and cleanups
Date: Wed,  1 May 2024 14:34:51 +0200
Message-ID: <20240501123456.6712-1-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Here are two fixes for potential info leaks in the QCA driver and a few
cleanups.

All of these can go into 6.10.

Johan


Johan Hovold (5):
  Bluetooth: qca: fix info leak when fetching fw build id
  Bluetooth: qca: fix info leak when fetching board id
  Bluetooth: qca: drop bogus edl header checks
  Bluetooth: qca: drop bogus module version
  Bluetooth: qca: clean up defines

 drivers/bluetooth/btqca.c | 51 ++++++++++++++++----------------
 drivers/bluetooth/btqca.h | 61 +++++++++++++++++++--------------------
 2 files changed, 55 insertions(+), 57 deletions(-)

-- 
2.43.2


