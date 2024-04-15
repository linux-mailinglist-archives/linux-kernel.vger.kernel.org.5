Return-Path: <linux-kernel+bounces-144999-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 30BE18A4DE7
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 13:42:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AA216B22CF1
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 11:42:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3DE6657A3;
	Mon, 15 Apr 2024 11:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="crASQfuV"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0A0A605B6;
	Mon, 15 Apr 2024 11:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713181312; cv=none; b=pLyigkiz8m5lDzODwKFLXg92zIGwIYyWUeYxYdnam4fNz225TH3IO5BzAUn+e4S5ccrFn5NpHCImsI+Xl5YTqVJDSAQg4Al3Gc8bW84ON7IJgO7AHnGU/S1+SQIdxbqUH89psSFUMIA+bMAsEY2sR/gmquc7a63WRse0/xrBhi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713181312; c=relaxed/simple;
	bh=wCmMaeJS2OEoFDljYlRdvuz8/epY3LA+puq7nGe+MK4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RYZ1dahMVUPW10Q7s8L9t687da0M5Bt0AKHI2nkn/KpBxoB+H7jztyRjTADQZDuJmvGCbSRZaFdH/H6+kTR7hJSCsu4VB2iy65Tru5pJdQvhsi2bDrhwA84IIqZp2k6WTXpCu4JgHzwYraZwf4lKbby/iUzLQYxWO/mthRkdj4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=crASQfuV; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1713181307;
	bh=wCmMaeJS2OEoFDljYlRdvuz8/epY3LA+puq7nGe+MK4=;
	h=From:To:Cc:Subject:Date:From;
	b=crASQfuV6Lq5dewInjTCyMJylZq3pYIy4F0eAdEIQwAlOBZkAqD1SS2jQnggSijvQ
	 1rFY9ovIUoYMIQ31A8/Xs9MrPw7YGr+jubat2A1A5OXUtsoVmFuxRX75+QxvP6u4or
	 +foER+mbaj0HCOt/Ubwm/62KVJgDw1f3A8pSJBau/rhgUAj4zL7UV1i15VlYoaWziQ
	 a92JEPmB/cKujK6PiDZDzG8UN5FRzkL/rW1klD8y3jD+2IXkDRmvRv+FGA3eAZ0PCM
	 HAHGRAZ/xbASQCK2kO5w32xf6hwz5wAwP5S8yi033/eUaiVYTDU1MrNRAbrtsl/bbK
	 YS6JdW2Gio2nQ==
Received: from obbardc-t14.home (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: obbardc)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 2DFA33781FE9;
	Mon, 15 Apr 2024 11:41:47 +0000 (UTC)
From: Christopher Obbard <chris.obbard@collabora.com>
To: linux-kernel@vger.kernel.org
Cc: Daniel Scally <dan.scally@ideasonboard.com>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	kernel@collabora.com,
	Christopher Obbard <chris.obbard@collabora.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Fabio Estevam <festevam@gmail.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Rob Herring <robh@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v1 0/1] Enable HDMI output support on the Debix Model A SBC
Date: Mon, 15 Apr 2024 12:41:26 +0100
Message-ID: <20240415114135.25473-1-chris.obbard@collabora.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series brings up the HDMI output on the Debix Model A SBC.

With support for the HDMI transmitter for the i.MX8MP SoC now merged[0],
we can now enable the HDMI output on the Debix Model A SBC.

The pinctrl values were blindly taken from the downstream BSP[1] and should
be checked by someone who knows this platform better than myself.

Also, with a 4K display there were a drm error with no output on the
display, but this error did not occur with a 1080P display:

   imx-lcdif 32fc6000.display-controller: [drm] *ERROR* fbdev-dma: Failed to setup generic emulation (ret=-12)

It would be interesting to see if this error is present for others on a
different i.MX8MP device. I didn't have time to check this further and I
assume the issue to be in the driver rather than specific to this SBC, so
should not block this patch, but please correct me if I am wrong.

[0]: https://lore.kernel.org/all/20240227220444.77566-1-aford173@gmail.com/
[1]: https://github.com/debix-tech/linux/blob/debix/arch/arm64/boot/dts/freescale/imx8mp-debix-io-board.dts#L1025


Christopher Obbard (1):
  arm64: dts: imx8mp-debix-model-a: Add HDMI output support

 .../dts/freescale/imx8mp-debix-model-a.dts    | 47 +++++++++++++++++++
 1 file changed, 47 insertions(+)

-- 
2.43.0


