Return-Path: <linux-kernel+bounces-116817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7467988A432
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 15:21:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 125C21F342DD
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 14:21:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E506718BC4B;
	Mon, 25 Mar 2024 10:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="RTxv0fHC"
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F62312FF72
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 10:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711361941; cv=none; b=XFCynvFgmgfqjRvV6Tr8Js1NSLAQpPCk+uE5zOs/VsLj9PQiSoOLhMYc+kPePI6SU9FhweCTZdYwVj9Yf+LiyW3svXbYLxbBYUaNSuaUUELNqPdGUETn7vhgE2Gjdahl4qKxHVDzbkq0MaZEm5lHK9fPl9mVZUgb274cKwH+L0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711361941; c=relaxed/simple;
	bh=qLQ4niysCmxrcl3Jfuh3yTicqNG8mpmahvbrBwwe+X4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FtaXB8RCeFlM8NTSjWoamu0EHpsA3C6gU5UClqw4aR0/bOJO03g8L6TZKhfzAOv1AsTrCtiXoelibJGUoqMcVH2NMotLJ8zL+UWQ8avT+BxPjCYTJdMCSsKgbjhGly/zfhU1MLS26E7DfEDCbS69qEJ1D9tK+GpVYPzcmNPmWWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=RTxv0fHC; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id D2EEEFF809;
	Mon, 25 Mar 2024 10:18:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1711361937;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J9Jq7H/XBIyV3DIEw2B4dugvyjD/myGnixXMCD+39xU=;
	b=RTxv0fHCjmG3bNbQHP+5G90SdQSb2xtRR+szDcwe9UynwVYBjAAxSGXjB/My52UjS7mxpj
	x73nANsiPZLD56O3pxNBunMd8bmsYfYkKLJ4uZ9y5QIn1NIWAQ5vffim29k1ysrbjxWUxW
	zV1fIAWuMkIvkNQ7ZZHcEJX8Wex4mF3iChgRHG7Tzde9QYfILlQErVh76ti7QAklVX2bHB
	pyTUC/hT5ZreHyDJCkLYb1yA/r86Z5D+Abgzifo2ZQKfzDVFeIwEHffywu3c0mfWc2bOTi
	XwEbuuj83rXNZT+8ebpRKXuYXXHROgnPAM20feDvzP2pH2x+5y3h82t0L2SfWg==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Aapo Vienamo <aapo.vienamo@linux.intel.com>,
	mwalle@kernel.org,
	miquel.raynal@bootlin.com,
	richard@nod.at,
	vigneshr@ti.com,
	linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: mika.westerberg@linux.intel.com
Subject: Re: [PATCH v2 1/2] mtd: core: Report error if first mtd_otp_size() call fails in mtd_otp_nvmem_add()
Date: Mon, 25 Mar 2024 11:18:55 +0100
Message-Id: <20240325101856.262530-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240313173425.1325790-2-aapo.vienamo@linux.intel.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'd44f0bbbd8d182debcce88bda55b05269f3d33d6'
Content-Transfer-Encoding: 8bit
X-GND-Sasl: miquel.raynal@bootlin.com

On Wed, 2024-03-13 at 17:34:24 UTC, Aapo Vienamo wrote:
> Jump to the error reporting code in mtd_otp_nvmem_add() if the
> mtd_otp_size() call fails. Without this fix, the error is not logged.
> 
> Signed-off-by: Aapo Vienamo <aapo.vienamo@linux.intel.com>
> Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> Reviewed-by: Michael Walle <mwalle@kernel.org>
> Fixes: 4b361cfa8624 ("mtd: core: add OTP nvmem provider support")

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git mtd/next, thanks.

Miquel

