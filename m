Return-Path: <linux-kernel+bounces-63431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 15D0F852F20
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 12:25:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 483241C21FAE
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 11:25:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D50A639AC3;
	Tue, 13 Feb 2024 11:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="VzqN+8Yr"
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF4B338DDF;
	Tue, 13 Feb 2024 11:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707823316; cv=none; b=bzwASqMXMj7bB+iBiL8F2/Di+FHz+RtwcAvEbgklpl/npX4asFSgWouA1yc0Cmtto6B3JcNOfVzIc6QCCGj+2VgR8UPVQbxFfJ52ToA23LPrjo3HFHT51eavJa+lSXZFzuWPZzdLijIXFjIdkJqbQK1o+lccRDhvYLWbYqm6UaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707823316; c=relaxed/simple;
	bh=ePi7b1L8+8ZVCVaSbDzz3it0zkxtnGBp2AkmJlONslA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=j3ONPnwgXeRLMvJjgbQgeYX/gEPlsUuAZnzthM3UPP1214TGKL+6pQScgbdv/WZM3+nHh/vf0BqYg+7wRtRhlnPV4sHjBevNSRCUPOJXBULVjeedDxHFA0iz4L3SCycghOmF2A2d4U0Gxgl9ZMrzhggoTYdDpOXPYmzH0Vcan9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=VzqN+8Yr; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb (unknown [5.170.16.17])
	by mail11.truemail.it (Postfix) with ESMTPA id 1BAE620FCD;
	Tue, 13 Feb 2024 12:21:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1707823311;
	bh=ePi7b1L8+8ZVCVaSbDzz3it0zkxtnGBp2AkmJlONslA=; h=From:To:Subject;
	b=VzqN+8YrhaAH5gFOKOiKHNv5ot8N4b+dQmpn+TsRdwQGqy6O1k5ZUsoSKz3UMjTHd
	 QqqIJfLJEuzkYWXjuz2n9Z66RzE/7dfkbD6ceGdl9rOkTAJ6NtevIfzQDgzvpbacrE
	 PrwZ0DY+V2cezvwDxhUyYfFD3XToC7llcOYXQZFOBcMWA2wYRezDTHBAl08Dv1mVGQ
	 Ym0xDPQdScBccV/LX/96IftYdMGlfeyWOuq/OWSfbEkJ1CMnUszGZRA6SZUA137h0t
	 b9XEFTeofAMWBAKsbpYeYrhDyvG1DtUnVqJSNlSkjP/Ntp0H3kXLha9yvNfPhNvk+Y
	 633QCgKlW2Ziw==
Date: Tue, 13 Feb 2024 12:21:46 +0100
From: Francesco Dolcini <francesco@dolcini.it>
To: Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Alexander Stein <alexander.stein@ew.tq-group.com>,
	Shawn Guo <shawnguo@kernel.org>, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, regressions@lists.linux.dev,
	Max Krummenacher <max.krummenacher@toradex.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>
Subject: Regression, i.MX7 boot failure, Linux v6.1.77
Message-ID: <20240213112146.GA5874@francesco-nb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Sasha,
kernel v6.1.77 introduces a regression, with a boot failure, on i.MX7,
with commit db30f469ae8b ("ARM: dts: imx7s: Fix nand-controller #size-cells").

The issue is known [1][2], changing `#size-cells = <0>` is formally
correct, but do not play well with the firmware that are deployed on
those embedded devices, leading to a boot failure.

A mitigation was implemented in the Linux kernel,
commit 84549c816dc3 ("mtd: parsers: ofpart: add workaround for #size-cells 0")
that was merged into v6.3, the firmware was also fixed, however existing
device using old firmware will not boot anymore if updating to a newer
kernel.

I would ask you to drop such a patch from any stable patches queue and
not backport it to any older kernel.

To fix v6.1.y I see two options:
 - backport 84549c816dc3
 - revert db30f469ae8b

What do you prefer? Should I send myself a patch?

[1] https://lore.kernel.org/all/Y4dgBTGNWpM6SQXI@francesco-nb.int.toradex.com/
[2] https://lore.kernel.org/all/20221202071900.1143950-1-francesco@dolcini.it/

Francesco


