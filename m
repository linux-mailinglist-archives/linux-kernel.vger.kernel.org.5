Return-Path: <linux-kernel+bounces-52820-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 38E9F849D08
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 15:28:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C18F1C24513
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 14:28:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 142EA2C6A9;
	Mon,  5 Feb 2024 14:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="PKnL7nW+"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9364D2C1A0
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 14:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707143289; cv=none; b=terh/4df2um/oLL3ZHzS5f/QbBO5BSfs0+AWBZBfB3WE7Tmsao8p5jaXaVb891h8GjAKmT1rgaghIclyrHfjYL16kTGQqmBGEUY2/I0Ze0QMKswUB5mHkg5+flv6jMNimCEPOpRvTRKqgGs12nsrQ74+cJm4gv24E72ZZw6c21g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707143289; c=relaxed/simple;
	bh=Hq2NNMT6MBsKqcxed74d9JB2FYrJZym2KKmRCRMtPlE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jWedfLZKJqk7huC0OE7Fv6R/5Mkoqp9XG3TOy0Y5P3vSLn+QN2MfiHBr4cFO08pGHPFzHEsIkduEdl6UQvh7xrhEDzqhSqfBCN6t2WKPhpKfAsg/oMRk9hu3eon2VdX4qEAPgaUt5forNgI6Xyu/PW7jGjbizG23sHxErsTrwQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=PKnL7nW+; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id D22BB1C0006;
	Mon,  5 Feb 2024 14:28:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1707143285;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yJ0MjnPiyDEXmv9y3YHY1Sk0uYIphio8FRBQUUsA6T0=;
	b=PKnL7nW+HFuuqYWfBpu+B2VJNgN8v65dQOqIs0KQWrPKjZ9F7aSeddtOAmXhX+3h5NlRnp
	pOqYD3Eur8MNoPLn7l9Q8+MLr7oGFzQJAUbUg4HmguGJGxyv2Iro8HtrGJbVNgccq9rfeQ
	IWpA6vlohjZAMS/1f4UTxJX9JMFBtyLXTu3wWlY9ElkcsV04fcuSmV0FBKmIQ8hdqlYVWA
	Pc7CteutqwmDPIqFtDPUaX5y6rNXW8kYO+O4Wu1aedOlKcoMPOGi57nUtnzNirBvw0FRro
	GHpctKCVLvLc0vIwgm93nMjdAKNZ34+nH7wYzxRIuxCeW8qaSr35QT2rJZEg/g==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Ezra Buehler <ezra@easyb.ch>,
	linux-mtd@lists.infradead.org
Cc: Miquel Raynal <miquel.raynal@bootlin.com>,
	Chuanhong Guo <gch981213@gmail.com>,
	Dmitry Rokosov <ddrokosov@sberdevices.ru>,
	Martin Kurbanov <mmkurbanov@sberdevices.ru>,
	Md Sadre Alam <quic_mdalam@quicinc.com>,
	Richard Weinberger <richard@nod.at>,
	Sridharan S N <quic_sridsn@quicinc.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] mtd: spinand: Add support for 5-byte IDs
Date: Mon,  5 Feb 2024 15:28:04 +0100
Message-Id: <20240205142804.466682-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240125200108.24374-2-ezra@easyb.ch>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'34a956739d295de6010cdaafeed698ccbba87ea4'
Content-Transfer-Encoding: 8bit
X-GND-Sasl: miquel.raynal@bootlin.com

On Thu, 2024-01-25 at 20:01:07 UTC, Ezra Buehler wrote:
> From: Ezra Buehler <ezra.buehler@husqvarnagroup.com>
> 
> E.g. ESMT chips will return an identification code with a length of 5
> bytes. In order to prevent ambiguity, flash chips would actually need to
> return IDs that are up to 17 or more bytes long due to JEDEC's
> continuation scheme. I understand that if a manufacturer ID is located
> in bank N of JEDEC's database (there are currently 16 banks), N - 1
> continuation codes (7Fh) need to be added to the identification code
> (comprising of manufacturer ID and device ID). However, most flash chip
> manufacturers don't seem to implement this (correctly).
> 
> Signed-off-by: Ezra Buehler <ezra.buehler@husqvarnagroup.com>
> Reviewed-by: Martin Kurbanov <mmkurbanov@salutedevices.com>
> Tested-by: Martin Kurbanov <mmkurbanov@salutedevices.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next, thanks.

Miquel

