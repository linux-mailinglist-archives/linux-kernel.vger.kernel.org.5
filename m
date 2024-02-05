Return-Path: <linux-kernel+bounces-52789-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E2FD849CAD
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 15:12:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 431351F25CB1
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 14:12:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0837B24B50;
	Mon,  5 Feb 2024 14:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PYRzJgSV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D8912C18E;
	Mon,  5 Feb 2024 14:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707142348; cv=none; b=pNX0vmJ/E5gtBt38qy0Z3ekip/MzqGXH+eBP5z73qnCTY7iYOhiy4dWCxadFof0h3Ie+iGW3BUzUKBgGDhfUBQYj8AWJg9ctRqiTTEgbONlDmpXAKKYACTrOJy2oSuIgWCTAAYosaW3CHCMUsh8KoQ69q7R9n8MGZfIgUkZM2qM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707142348; c=relaxed/simple;
	bh=Z7UE+UjmnElfbXTukoN7uu9PUfOC/LbXaWbsCBJt50Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JmmTf2OhYK2UxTE8UPMFIxpekyP/WIe5LMfkxtMBoSQGm2aKVIFFTu0TDJ0O8/Pe7UdwMxB5jFM7Xob1JlTcS8B5KgIdXYyK+3DK7uqJOdESn0355LSv7wQrqiis7czuMQiBVAft4GSUTJcsZ9JE0TT050TA9tk4b29gAddM0yY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PYRzJgSV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45B7FC433C7;
	Mon,  5 Feb 2024 14:12:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707142347;
	bh=Z7UE+UjmnElfbXTukoN7uu9PUfOC/LbXaWbsCBJt50Q=;
	h=From:To:Cc:Subject:Date:From;
	b=PYRzJgSVYyc3jDL7sDkRouoNvnBhd2I0OncuQSl4QJMsJ5oEADz016+edOqHCRaes
	 YHwk/e7qTmMQKzuE0283U/gAPc0LBq6zW5hfSqm2YJoAap515AQdgE+hZaAnJZDLso
	 7EzqRMXJqNW1R0h6P/aH4SahOt+Oq3b3p8ekPTPR1v0jCNy30UxXv2R4qBYkzkhnk/
	 g9oQTqxjmX0/vLZvgYT6DBXmM7fYYbUQtPMwLqsUwK1++7bd5tX3UpWU6iMXG3WlX5
	 NUewxboMPCNx+Iuxhl34PPIqeys404GVd/tsD2SQ0qzX2LssreRE2KxlkIJkYcEDWY
	 GBMfAW1pYXy1g==
From: Roger Quadros <rogerq@kernel.org>
To: Thinh.Nguyen@synopsys.com
Cc: gregkh@linuxfoundation.org,
	r-gunasekaran@ti.com,
	b-liu@ti.com,
	afd@ti.com,
	nm@ti.com,
	srk@ti.com,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Roger Quadros <rogerq@kernel.org>
Subject: [PATCH v2 0/5] usb: dwc3-am62: module removal and errata fixes
Date: Mon,  5 Feb 2024 16:12:16 +0200
Message-Id: <20240205141221.56076-1-rogerq@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

This series fixes errors during module removal. It also
implements PHY core voltage selection as per TI recommendation
and workaround for Errata i2409 [1].

The workaround needs PHY2 region to be present in device node.
The device tree patch will be sent later after the DT binding doc
is merged.

[1] - https://www.ti.com/lit/er/sprz487d/sprz487d.pdf

Changelog in each file

v1: https://lore.kernel.org/all/20240201121220.5523-1-rogerq@kernel.org/

cheers,
-roger


Roger Quadros (5):
  usb: dwc3-am62: call of_platform_depopulate in .remove()
  usb: dwc3-am62: fix error on module removal
  usb: dwc3-am62: Fix PHY core voltage selection
  dt-bindings: usb/ti,am62-usb.yaml: Add PHY2 register space
  usb: dwc3-am62: add workaround for Errata i2409

 .../devicetree/bindings/usb/ti,am62-usb.yaml  |  8 +++-
 drivers/usb/dwc3/dwc3-am62.c                  | 47 ++++++++++++++-----
 2 files changed, 41 insertions(+), 14 deletions(-)


base-commit: 6613476e225e090cc9aad49be7fa504e290dd33d
-- 
2.34.1


