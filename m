Return-Path: <linux-kernel+bounces-48091-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 44A13845718
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 13:13:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5CF431C25122
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 12:13:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C08615D5CF;
	Thu,  1 Feb 2024 12:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NGOjVKGI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C50615F335;
	Thu,  1 Feb 2024 12:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706789547; cv=none; b=aV6TsyioLM4eKIi1DUfQEA2FREieBkGMDr/bRummzNXl5Zm20XHE8lb7Jv4zcqp6kdQydBIln7ptBJiLRZdV0Qma8qJIk6FOSxy0BqfcgpJHAVaxX6RloWwIxA8C9wls+wL31xTjaFehYEzh5PK6g1lqv+vCpBQwDWZ5IC62XJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706789547; c=relaxed/simple;
	bh=YgVhkjLkWt+OxImNDowylzh5svuE5ASKJUM4+3H8B3c=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ogCts9GVEvafZUiwn0oF4WCAtIz3IyZOhwT2wT5kMlu+LgvgZHbMdiHlf6MFYHlI2DW1gtHxEUvgzilBkwua3gdxDKP/mK4y+3WNPi43HQb+hQQyYo1xWL+IKDn+BkWkvFs40XdgJfFjWmdMWUNCmpg8R0h+tdFVpHkgnN0WyrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NGOjVKGI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04C4AC433A6;
	Thu,  1 Feb 2024 12:12:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706789547;
	bh=YgVhkjLkWt+OxImNDowylzh5svuE5ASKJUM4+3H8B3c=;
	h=From:To:Cc:Subject:Date:From;
	b=NGOjVKGI1DaRJCOlLQyDkQsRcZYlbPCdTkiI5duqHbBgodDgTAS4YarCeq+eeszay
	 8gXXsd3bDADDmrmOzbJnepnfCL7tnSwfej2CIiU2OqYLiVWuQNfq5rDAC3zm9H2EbQ
	 od0hMbOZUttah5DuITDHDoXB5z2aAH2GP18sHWzfz0dfzDKJxvF8blK6WVbjhC2PMe
	 huJS4PxEHBPklVMV8tRq8ooc+yYgg+tSNgPMdLUqAu9Lb8cAWKUkGYvEstG0BOq/Zm
	 AeEevsDBrRSPbK5v8Ed6R9Zr7C0CCNSVUpEK7BH1DjGt0bIH5IJGQIe8x3bcJcpcM+
	 5hHN9Cfa7jQUg==
From: Roger Quadros <rogerq@kernel.org>
To: Thinh.Nguyen@synopsys.com
Cc: gregkh@linuxfoundation.org,
	r-gunasekaran@ti.com,
	b-liu@ti.com,
	srk@ti.com,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Roger Quadros <rogerq@kernel.org>
Subject: [PATCH 0/4] usb: dwc3-am62: module removal and errata fixes
Date: Thu,  1 Feb 2024 14:12:16 +0200
Message-Id: <20240201121220.5523-1-rogerq@kernel.org>
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
This is sent as a separate series [2].

[1] - https://www.ti.com/lit/er/sprz487d/sprz487d.pdf
[2] - https://lore.kernel.org/all/20240201120332.4811-6-rogerq@kernel.org/

cheers,
-roger

Roger Quadros (4):
  usb: dwc3-am62: call of_platform_depopulate in .remove()
  usb: dwc3-am62: fix error on module removal
  usb: dwc3-am62: Fix PHY core voltage selection
  usb: dwc3-am62: add workaround for Errata i2409

 drivers/usb/dwc3/dwc3-am62.c | 55 ++++++++++++++++++++++++++++--------
 1 file changed, 44 insertions(+), 11 deletions(-)


base-commit: 6613476e225e090cc9aad49be7fa504e290dd33d
-- 
2.34.1


