Return-Path: <linux-kernel+bounces-116815-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D14C88A430
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 15:21:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCB282E552B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 14:21:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 522C784A5F;
	Mon, 25 Mar 2024 10:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="DAVvZbnr"
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1606012FF78
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 10:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711361937; cv=none; b=cnlpHuusW0xVM0SkS3qKKMe8jlu5q4wqfX3ynW36hGLHPZkQ5XRvr2jpIu+tDxSfhRMcW7ZGucR0WxvYvH7HB2+hzYvZztjo3cPxR3/4xDriY0H2VVs+CIIR8GwlxHkqIcdLVk8CGVhqIR9iXsVUz+4cSreOXUokTJhgM3M5i8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711361937; c=relaxed/simple;
	bh=5HTu0ynpAiZeBVx0C9I+484Y9Flm1GXxQ913JM7G75w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eESKWaHEyjOnN8+9OKjM05jr1syXflUu/BHNirC/BI/JzczGZQZE6JjaM7lf8XoeMAwAKLCcHxiVL6WIhs5AOkC+JwBAKQXBbCf4q3vOoyRkbVV3gJvfbYnlf0b4x2iofTxve2k7VfVdWzrOECf8944w/nfZTk2zEGXDJ6rZD10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=DAVvZbnr; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id E868A60005;
	Mon, 25 Mar 2024 10:18:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1711361933;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s8/p+IkZ8xufk6L6NhUiqrtkEMLBY43oIUbGcbGu9kE=;
	b=DAVvZbnraPWkLZCfpdDcshPLU7zKUz7lx52bdxP1irC2Sag9IKmU3m64k7DGYAPDQ4q75M
	H/l1TdqNrRNV9dJ9KwSlVfDY/cMCESi0Cqhfl1sghENEtCylqjPwWijiMZcw39XHcDXcT1
	2tnwKfK4owBzBB4w9t4K1Qm3rtk2TnifKDFS5Q7sOa0DznEAwcpMsdS0aDbDNV3PX/OvVg
	E6qoOR2CYLC52dnFBmDDcWSzkzDTrW241L3nOGRpzIyYWTiZS5ZNblPwvGvJxcoX9XC47K
	zHOXSXloiqskx4WvEH+QmYs7RLaQznF35Xpe6uHySchhMhsc/XYfaYhrAzMhJQ==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Aapo Vienamo <aapo.vienamo@linux.intel.com>,
	mwalle@kernel.org,
	miquel.raynal@bootlin.com,
	richard@nod.at,
	vigneshr@ti.com,
	linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: mika.westerberg@linux.intel.com
Subject: Re: [PATCH v2 2/2] mtd: core: Don't fail mtd_otp_nvmem_add() if OTP is unsupported
Date: Mon, 25 Mar 2024 11:18:52 +0100
Message-Id: <20240325101852.262497-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240313173425.1325790-3-aapo.vienamo@linux.intel.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'fe0b8213c0129ff2419458343d8d8e716b1495c0'
Content-Transfer-Encoding: 8bit
X-GND-Sasl: miquel.raynal@bootlin.com

On Wed, 2024-03-13 at 17:34:25 UTC, Aapo Vienamo wrote:
> Handle the case where -EOPNOTSUPP is returned from OTP driver.
> 
> This addresses an issue that occurs with the Intel SPI flash controller,
> which has a limited supported opcode set. Whilst the OTP functionality
> is not available due to this restriction, other parts of the MTD
> functionality of the device are intact. This change allows the driver
> to gracefully handle the restriction by allowing the supported
> functionality to remain available instead of failing the probe
> altogether.
> 
> Signed-off-by: Aapo Vienamo <aapo.vienamo@linux.intel.com>
> Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> Reviewed-by: Michael Walle <mwalle@kernel.org>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git mtd/next, thanks.

Miquel

