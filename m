Return-Path: <linux-kernel+bounces-117901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 30A1288B117
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 21:15:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0D6A2C2E3E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 20:15:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3087145953;
	Mon, 25 Mar 2024 20:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="ChieTWp3"
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D8D843AD0
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 20:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711397583; cv=none; b=LVQ5OE4vWKqWna8aA5ty+E7TETSLfMo2A3JQHo/ssZfKzWchV9pgZKbZpGq5aAU1SAzSjITsV+VByQrTCn7m21RdqufcR25GTfS7E9CTE5R/4kWvXeF3Cb13SGppAvhzqWCtGnCt1ksEinJWKUlAJHwvKSepZhKbB71ko6VvW/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711397583; c=relaxed/simple;
	bh=V7aKXbN3DlGu09kRkwO6uymGc8ey53+IGTKai8U2UNQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JOzUKGZof7wSQPFLi22Oe6NICvFe58HstJpY1sOjrI7MOH7kxXrNilDinPhltOImf1zYE6d58c9HGdrUoiuJTCFL/LBDHmVa44O4xqbo/KPuMZBWT2xZwHRw2lrnzy3gc4sU3MYZ5GdryaMhxglbOA5AL4iOiSWHHIiYn0KExyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=ChieTWp3; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from tundra.lovozera (unknown [31.173.84.243])
	by mail.ispras.ru (Postfix) with ESMTPSA id 9973740737D6;
	Mon, 25 Mar 2024 20:12:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 9973740737D6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1711397572;
	bh=70xDSlODvyErA/E79roNIAXAkZo47twuiyaYdPOjtsw=;
	h=From:To:Cc:Subject:Date:From;
	b=ChieTWp3TPNQnCP/+2QKtq7t8L/iCJiLaXFfdyO+lAD9Y1VIY1VmH40KiJ6/HL3Ma
	 4cH9D/HhVN8V+v+ElozCXGHTFf3+nZndy9n52ukCYumoIeSw2HbTBO8HIVi8BhklPx
	 EMDUWRlNaOrGOhsgNYZioF6cyQuP/FeG7JM13fmc=
From: Mikhail Kobuk <m.kobuk@ispras.ru>
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Mikhail Kobuk <m.kobuk@ispras.ru>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	=?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
	linux-phy@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org,
	Alexey Khoroshilov <khoroshilov@ispras.ru>
Subject: [PATCH v2 0/2] phy: marvell: a3700-comphy: Minor fixes
Date: Mon, 25 Mar 2024 23:12:48 +0300
Message-ID: <20240325201254.54445-1-m.kobuk@ispras.ru>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes in v2:
- Replace hardcode and ARRAY_SIZE() with definition
- Link to v1: https://lore.kernel.org/linux-phy/20240321164734.49273-1-m.kobuk@ispras.ru/

---
Mikhail Kobuk (2):
  phy: marvell: a3700-comphy: Fix out of bounds read
  phy: marvell: a3700-comphy: Fix hardcoded array size

 drivers/phy/marvell/phy-mvebu-a3700-comphy.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

-- 
2.44.0


