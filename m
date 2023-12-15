Return-Path: <linux-kernel+bounces-790-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 02F4E81460A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 11:59:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A46712858EF
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 10:59:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C0251C2BD;
	Fri, 15 Dec 2023 10:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="kPsg7CVA"
X-Original-To: linux-kernel@vger.kernel.org
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 920ED18C2F
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 10:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 6908D240003;
	Fri, 15 Dec 2023 10:59:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1702637957;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A8qtfB12y+BeC7a00boq7oM6tyk44zmBIpG8B8Z9lcg=;
	b=kPsg7CVAb2Q0DGiyKr7KZ1X5RvOk72SNcxZN6OIxuFygn/HGlDV7aDNIkKykzAwKXDTmhZ
	vRZwX8oGjo+/IV3stGRHDYvtJzpRPZdUbC15bknYGHaDI/Amq0W9UVm8wyrRu2T7MP2qU2
	Y8Gy4yMzZKoidog827Nd4aBFUQ4/IzM+IeVkSBHauQ87QlIhmmH2wKdWQI+N0X122kfdVt
	GYQuJQ4CubWn+/SwQuKZR+2u3ahyFvpfuEqkxBmrs8+Odf0EnN+0ubtHRWV7z8LLq8iyBB
	DcYheDr8uBh1li+aUw2y4Y/sTjMKdio00GSxDjlh4i4gjkKXkLcxhGayjenv3A==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Dinghao Liu <dinghao.liu@zju.edu.cn>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mtd: rawnand: diskonchip: fix a potential double free in doc_probe
Date: Fri, 15 Dec 2023 11:59:14 +0100
Message-Id: <20231215105914.499203-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231214072946.10285-1-dinghao.liu@zju.edu.cn>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'2b8aa4c3e6a5d41b10b53da2017852f647d0345b'
Content-Transfer-Encoding: 8bit
X-GND-Sasl: miquel.raynal@bootlin.com

On Thu, 2023-12-14 at 07:29:43 UTC, Dinghao Liu wrote:
> When nand_scan() fails, it has cleaned up related resources
> in its error paths. Therefore, the following nand_cleanup()
> may lead to a double-free. One possible trace is:
> 
> doc_probe
>   |-> nand_scan
>   |     |-> nand_scan_with_ids
>   |           |-> nand_scan_tail
>   |                 |-> kfree(chip->data_buf) [First free]
>   |
>   |-> nand_cleanup
>         |-> kfree(chip->data_buf) [Double free here]
> 
> Fix this by removing nand_cleanup() on failure of
> nand_scan().
> 
> Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next, thanks.

Miquel

