Return-Path: <linux-kernel+bounces-116814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3830C88A42D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 15:21:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E67FA2E538A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 14:21:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27AF9132C15;
	Mon, 25 Mar 2024 10:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="KB7EBpxK"
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E1A012FB3D
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 10:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711361934; cv=none; b=TAMy/mFDoFSB7i9jyrSnP6ssUa8bPitOKO0UMR6Hm/ZrWiEZLH3YNoUA98ft9IxXpTGDJZdiZDR3jKF8JaEx/3cRoSCR3dwHvBKWiSrKP6gATAW/tGjOFs9hz5/ae90rHmdK6/XlvkcE6SlboM/YhALiAar/SRaDGwyw657uR4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711361934; c=relaxed/simple;
	bh=GVHQhp9rhkLHtDl2HzRv9RdkmY4aiP1Z3zDs9NaQdAI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BSix4Ttb6b6aZi7TumEBOkfLs6s6iucwdzi8RsjecV1xA6XBB/J5Tn0itc4I1kQ1ev+VoLnSnx/J/go816iixjmJ+UDFBS96wgF8rimLj8k9tx8n8RwkxYmuZbQtsVp/K9LbLG1WIveVLVR4OVsAS/P0O07R94p4cHgXault/QM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=KB7EBpxK; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 4291DFF80B;
	Mon, 25 Mar 2024 10:18:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1711361925;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+fYpIswoyUf/77da/e8+AFgNqj1S3IPZlB14Z5/zv28=;
	b=KB7EBpxKVXlxzcEmFit9EC+eJ5OE/bihBkdkNq2JDR0EAJVSUxHL8GfrpQFud5eml2i1hz
	P5D2K8GcVCi4EZGqr80eEzQYzti5+bghIa7WImvVgygqTTsqoj6ROWAidrHsH8tospjjl/
	ZZ2A7IK5Sez6SE/R2Pde6umhnmIL6zGbxhna5SZWSr2HLL9FubKscdFw4SfZv0wPl5qTuy
	XhGpY4gi2iG0G/ZKvVs6UyP39R2FDUHMbL5xW+yLOSFB2TdKDfSX+/AMUEMVvPQog0IRSc
	OzPP/e8Oko9t9RfGi5KcsblxwKx1F/ovRUOL0uAseQGf6BzMcv1rNgwFiSwQ4Q==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Denis Arefev <arefev@swemel.ru>,
	Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org,
	trufanov@swemel.ru,
	vfh@swemel.ru
Subject: Re: [PATCH] mtd: partitions: redboot: Added conversion of operands to a larger type
Date: Mon, 25 Mar 2024 11:18:42 +0100
Message-Id: <20240325101842.262419-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240315093758.20790-1-arefev@swemel.ru>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'1162bc2f8f5de7da23d18aa4b7fbd4e93c369c50'
Content-Transfer-Encoding: 8bit
X-GND-Sasl: miquel.raynal@bootlin.com

On Fri, 2024-03-15 at 09:37:58 UTC, Denis Arefev wrote:
> The value of an arithmetic expression directory * master->erasesize is
> subject to overflow due to a failure to cast operands to a larger data
> type before perfroming arithmetic
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Signed-off-by: Denis Arefev <arefev@swemel.ru>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git mtd/next, thanks.

Miquel

