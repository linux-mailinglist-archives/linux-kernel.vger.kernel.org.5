Return-Path: <linux-kernel+bounces-134524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A38D089B284
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 16:39:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10BC91F21B7A
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 14:39:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA04239FD0;
	Sun,  7 Apr 2024 14:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=poczta.fm header.i=@poczta.fm header.b="gJAYZ3mk"
Received: from smtpo52.interia.pl (smtpo52.interia.pl [217.74.67.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6703712E48;
	Sun,  7 Apr 2024 14:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.74.67.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712500776; cv=none; b=L0jznBRerPB6KQx/Jf0dOlH5LE7N2KBF80OKG3W1vWbA5WAYeXUOy3Ge0B3f3LlwyfB2mUnue28Tq3e39KkzX9QYeJB2QZA+tst2RVK2eSeBCRy0YXCC5z1FmayYyKOW2nPWcfrshTPSJQYRdMw6EvVstrjDopp3ob+P9gCfMzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712500776; c=relaxed/simple;
	bh=q6ZKLD0/3PttaudyNoTRoIEre1rVHe5MQL1qF1V5O40=;
	h=Date:From:Subject:To:Cc:In-Reply-To:References:Message-Id:
	 MIME-Version:Content-Type; b=ZPvP0rKvf4Z7AKhBv+eq+JfdYZi8wZDxpon4opHLi/y7jdc+RX/VlIQeER/y0EdpL2C7ID1zYTQxoLIMZY8i/V3fRKB6gvUaiJOVX7sSf1H7H3GbGSTIH0aeSyvKQxScIGQmpwc0+3BqpvdZ81owD5D3T9lOpaZAYnfD9/9WJkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=poczta.fm; spf=pass smtp.mailfrom=poczta.fm; dkim=pass (1024-bit key) header.d=poczta.fm header.i=@poczta.fm header.b=gJAYZ3mk; arc=none smtp.client-ip=217.74.67.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=poczta.fm
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=poczta.fm
Date: Sun, 07 Apr 2024 16:39:25 +0200
From: Robert <777777@poczta.fm>
Subject: [bug report] [spi.c] Kernel panic - not syncing: Asynchronous SError
 Interrupt
To: broonie@kernel.org, richardcochran@gmail.com
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
X-Mailer: interia.pl/pf09
In-Reply-To: <ayfsrumlsnahjdwqaxup@toma>
References: <ayfsrumlsnahjdwqaxup@toma>
Message-Id: <ifedbvikmbqyhofqcart@ycoe>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=poczta.fm; s=dk;
	t=1712500770; bh=JXD+odRD32hULhTBzmjEZPvRxgaOdSJKnC5mTIPZrdw=;
	h=Date:From:Subject:To:Message-Id:MIME-Version:Content-Type;
	b=gJAYZ3mkk3dch8NROiLMktqquhG3K9e8OTzKH+1CbnUQsEmfd0Uyx8cUQimt7jp8j
	 vxB2nj0S3WrtIVoM6LUcWQ9ThksvssTfLQkdACd7m2THBcgKljIcdoiZkjDLy0th8U
	 Kvh2mKmSUjpqiEoFlbQ8nuOC69ZtI5fEMcfPfft0=

Working on OpenWrt kernel 6.6.23 with enabling/checking SPI 

root@BPI-R4:/# echo "help" > /dev/spidev1.0
[ 131.681610] SError Interrupt on CPU3, code 0x00000000bf000002 -- SError
[ 131.681623] CPU: 3 PID: 1306 Comm: ash Tainted: G O 6.6.23 #0
[ 131.681630] Hardware name: Bananapi BPI-R4 (DT)
[ 131.681632] pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[ 131.681637] pc : mtk_spi_hw_init (/home/openwrt66/openwrt/build_dir/target-aarch64_cortex-a53_musl/linux-mediatek_filogic/linux-6.6.23/drivers/spi/spi-mt65xx.c:356) >>>>> >>>> if (spi->mode & SPI_LOOP)
[ 131.681646] lr : mtk_spi_prepare_message (/home/openwrt66/openwrt/build_dir/target-aarch64_cortex-a53_musl/linux-mediatek_filogic/linux-6.6.23/drivers/spi/spi-mt65xx.c:450) >>>>>>>> static void spi_remove(struct device *dev) {
[ 131.681649] sp : ffffffc081d7bb10
[ 131.681651] x29: ffffffc081d7bb10 x28: ffffff80c1b46780 x27: 0000000000000000
[ 131.681659] x26: 0000000000000000 x25: 0000000000000000 x24: 0000000000000000
[ 131.681664] x23: ffffff80c112a000 x22: ffffffc081d7bc20 x21: 0000000000000000
[ 131.681668] x20: ffffff80c112a000 x19: ffffffffffffffff x18: 0000000000000000
[ 131.681673] x17: 0000000000000000 x16: 0000000000000000 x15: 0000007fabeef6c0
[ 131.681677] x14: 0000000000000000 x13: 0000000000000000 x12: 0000000000000000
[ 131.681681] x11: 0000000000000000 x10: 0000000000000000 x9 : 0000000000000004
[ 131.681685] x8 : 0000000000000002 x7 : 0000000000000001 x6 : 0000000000000001
[ 131.681689] x5 : 0000000000000001 x4 : ffffffc0808df408 x3 : ffffff80c112a540
[ 131.681693] x2 : 0000000000000000 x1 : ffffff80c0966000 x0 : 0000000000000001
[ 131.681699] Kernel panic - not syncing: Asynchronous SError Interrupt
[ 131.681701] SMP: stopping secondary CPUs
[ 131.681706] Kernel Offset: disabled
[ 131.681707] CPU features: 0x0,00000000,20000000,1000400b
[ 131.681710] Memory Limit: none
[ 131.689561] pstore: backend (ramoops) writing error (-28)
PANIC at PC : 0x00000000430048a8

root@BPI-R4:/nvme/work/oled# spidev_test -D /dev/spidev1.0 -v
[ 117.280573] SError Interrupt on CPU2, code 0x00000000bf000002 -- SError
[ 117.280587] CPU: 2 PID: 4597 Comm: spidev_test Tainted: G O 6.6.23 #0
[ 117.280593] Hardware name: Bananapi BPI-R4 (DT)
[ 117.280595] pstate: 40400005 (nZcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[ 117.280600] pc : mtk_spi_set_cs (/home/openwrt66/openwrt/build_dir/target-aarch64_cortex-a53_musl/linux-mediatek_filogic/linux-6.6.23/drivers/spi/spi-mt65xx.c:453) >>>>>>> static void mtk_spi_set_cs(struct spi_device *spi, bool enable) {
[ 117.280610] lr : spi_set_cs (/home/openwrt66/openwrt/build_dir/target-aarch64_cortex-a53_musl/linux-mediatek_filogic/linux-6.6.23/drivers/spi/spi.c:996 (discriminator 1)) >>>>> if (spi_get_csgpiod(spi, 0) || !spi->controller->set_cs_timing) {
[ 117.280616] sp : ffffffc085ecbc00
[ 117.280618] x29: ffffffc085ecbc00 x28: ffffff80ca3d2280 x27: 0000000000000000
[ 117.280625] x26: 0000000000000000 x25: ffffff80c1fe21c0 x24: ffffff80c1fe2188
[ 117.280630] x23: ffffff80c0d9e800 x22: 0000000000000000 x21: 0000000000000000
[ 117.280634] x20: 0000000000000000 x19: ffffff80c0d9e800 x18: 0000000000000000
[ 117.280639] x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000000
[ 117.280643] x14: 02971e346eefd562 x13: 0140fc4c1b8dc750 x12: 0000000000000002
[ 117.280648] x11: 0000000000000000 x10: 0000000000000400 x9 : 000000021a0d78ed
[ 117.280652] x8 : 0000000000000800 x7 : ffffff80c0f9dcd0 x6 : 0000000000000000
[ 117.280657] x5 : 000000021a2fcdfd x4 : ffffff80c0e2a800 x3 : 0000000000000000
[ 117.280661] x2 : 0000000000000000 x1 : 0000000000000001 x0 : ffffff80c0e2ad40
[ 117.280667] Kernel panic - not syncing: Asynchronous SError Interrupt
[ 117.280669] SMP: stopping secondary CPUs
[ 117.280677] Kernel Offset: disabled
[ 117.280678] CPU features: 0x0,00000000,20000000,1000400b
[ 117.280681] Memory Limit: none
[ 117.2885p2] pstore: backend (ramoops) writing error (-28)
PANIC at PC : 0x00000000430048a8


root@BPI-R4:~# spi-config -d /dev/spidev1.0 --speed=1000000
[  409.674045] SError Interrupt on CPU0, code 0x00000000bf000002 -- SError
[  409.674059] CPU: 0 PID: 5583 Comm: spi-config Tainted: G           O       6.6.23 #0
[  409.674066] Hardware name: Bananapi BPI-R4 (DT)
[  409.674068] pstate: 40400005 (nZcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[  409.674072] pc : mtk_spi_set_cs+0x54/0x80
[  409.674082] lr : spi_set_cs+0x88/0x1dc
[  409.674088] sp : ffffffc08738bc00
[  409.674089] x29: ffffffc08738bc00 x28: ffffff80ce051700 x27: 0000000000000000
[  409.674097] x26: 0000000000000000 x25: ffffff80c1679040 x24: ffffff80c1679008
[  409.674102] x23: ffffff80c0be9800 x22: 0000000000000000 x21: 0000000000000000
[  409.674106] x20: 0000000000000000 x19: ffffff80c0be9800 x18: 0000000000000000
[  409.674111] x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000000
[  409.674115] x14: 02d06a0f57810356 x13: 01683736ecc24756 x12: 0000000001683736
[  409.674120] x11: 00000000fa83b2da x10: 000000000000b67e x9 : 0000000000000009
[  409.674124] x8 : ffffff80ff76f400 x7 : ffffff80c0d66850 x6 : 0000000000000002
[  409.674128] x5 : 0000000620ecf26e x4 : ffffff80c0d7c000 x3 : 0000000000000000
[  409.674133] x2 : 0000000000000000 x1 : 0000000000000001 x0 : ffffff80c0d7c540
[  409.674139] Kernel panic - not syncing: Asynchronous SError Interrupt
[  409.674142] SMP: stopping secondary CPUs
[  409.674147] Kernel Offset: disabled
[  409.674148] CPU features: 0x0,00000000,20000000,1000400b
[  409.674152] Memory Limit: none
[  409.682019] pstore: backend (ramoops) writing error (-28)
PANIC at PC : 0x00000000430048a8


Regards
Robert

