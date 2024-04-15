Return-Path: <linux-kernel+bounces-144884-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C581B8A4C27
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 12:07:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 654681F228E7
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 10:07:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C392C4E1B5;
	Mon, 15 Apr 2024 10:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="cOWr2Axl"
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 872404594C;
	Mon, 15 Apr 2024 10:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713175621; cv=none; b=N40nWZDBKzziShilnI8ncbi/UKF44Z2A/s8053iLuEhDnMVleRc3zY+hh6muvx3JYz5P8efgLJoSkiQOgUG7V1gcpQqOIYrPv7mbPxMGHVIP1UtcT21VfhBwmNqzSGkBchhfKt4NasBkvSKYYNo+rTF2Sv3yVRBlTS5tNriBKck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713175621; c=relaxed/simple;
	bh=DEq4RsJYFmlY/fnzHUVsx5CUGkBc4SniXHFH8nLsvr8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MUFs4VufUOVXWT+24vBSjmPcTEFvJ4WFODF53r2s/Cn6FK2GAp7Uys3WGFhk0mwvugV2hpURJ/3bcDuUOAnNNvkrsqQlwBU0QXs0EJfaw7AErqS/LQ+oj+ZrP5fUZp+dr7iyYoA/fYzmNPE8a0AY3C7jZyns9OHuBjj5UkaztkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=cOWr2Axl; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id C746AE0009;
	Mon, 15 Apr 2024 10:06:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1713175611;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=g0cicJjCB0pYUGc3CIeWy4etjAY/rbc0DSqQlONwh64=;
	b=cOWr2Axlsxc5zgGlGL5N5xatr95AvVuW6dgEuNyElf/zq5gA7TuOwd8rl0xsEgqymaMxOi
	gGPKbMv71uTSsaB9dgzDp9hlULihjNB3YibaP5mIN8IbAEIWtwXjr/pFtIF0blYf/BNAIE
	eLjRtw3wSa7Hkvvul8FBOb8uA76/GZeOU55JYZ5ZQuDr9sLmN2UCnKqPcAg1mp4W5XlNoe
	w1VGS9cniLFZ0QaUOo9amESU1xMiGovK7C2lK//oHyBFzoONgOPJ1cJZ9UG13Tl1tUQ34o
	0zpCJobQJFwetpfu4lo4ygel0ZQdZGWS9F0hVfDtSlq436Pm7yV6MdZQITRvMQ==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Christian Marangi <ansuelsmth@gmail.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Michael Walle <michael@walle.cc>,
	linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: Re: [PATCH v5] mtd: limit OTP NVMEM cell parse to non-NAND devices
Date: Mon, 15 Apr 2024 12:06:47 +0200
Message-Id: <20240415100647.32028-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240412105030.1598-1-ansuelsmth@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'd2d73a6dd17365c43e109263841f7c26da55cfb0'
Content-Transfer-Encoding: 8bit
X-GND-Sasl: miquel.raynal@bootlin.com

On Fri, 2024-04-12 at 10:50:26 UTC, Christian Marangi wrote:
> MTD OTP logic is very fragile on parsing NVMEM cell and can be
> problematic with some specific kind of devices.
> 
> The problem was discovered by e87161321a40 ("mtd: rawnand: macronix:
> OTP access for MX30LFxG18AC") where OTP support was added to a NAND
> device. With the case of NAND devices, it does require a node where ECC
> info are declared and all the fixed partitions, and this cause the OTP
> codepath to parse this node as OTP NVMEM cells, making probe fail and
> the NAND device registration fail.
> 
> MTD OTP parsing should have been limited to always using compatible to
> prevent this error by using node with compatible "otp-user" or
> "otp-factory".
> 
> NVMEM across the years had various iteration on how cells could be
> declared in DT, in some old implementation, no_of_node should have been
> enabled but now add_legacy_fixed_of_cells should be used to disable
> NVMEM to parse child node as NVMEM cell.
> 
> To fix this and limit any regression with other MTD that makes use of
> declaring OTP as direct child of the dev node, disable
> add_legacy_fixed_of_cells if we detect the MTD type is Nand.
> 
> With the following logic, the OTP NVMEM entry is correctly created with
> no cells and the MTD Nand is correctly probed and partitions are
> correctly exposed.
> 
> Fixes: 4b361cfa8624 ("mtd: core: add OTP nvmem provider support")
> Cc: <stable@vger.kernel.org> # v6.7+
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git mtd/fixes, thanks.

Miquel

