Return-Path: <linux-kernel+bounces-145210-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBBBD8A50D8
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 15:18:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFBBB1C21466
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 13:18:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA0688594D;
	Mon, 15 Apr 2024 12:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="U3DZfTt2"
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57D3084E1A
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 12:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713185932; cv=none; b=dBbnGg7ukTB1TF5IgN/G1B4vDFIsmfC1BnpUZFbSYgvS8TCSopxplvbKx1uRf5OzHjSdYLffvnnIkoEvd1tOvBEEtK4qgH2a+ZxoTrk9KDJWHcwOkSvFCTJDmgpdgnXwTWtdfG2CqvS1QZ8T0QfIWV+/moQNCAmunFsPXyTXBmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713185932; c=relaxed/simple;
	bh=iziCxtBeQUgWvhE++plh/rlR2F6qXEUcQ5jrLIOpDfU=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:In-Reply-To:
	 Content-Type:References; b=Nrnr7TstDWMvIr/VzmSvcn1dJ0FyC4XrBtvhl9Nr3Y7zYQJBk9kYMDA1NdKqX4NcvZ9yy8Ff5BmvCqAG6rxXkFNJltmyy8iKijt7MLebAMh/kbCbXv7zQJatqnrLZecyIACbo8sr4bh+TfL2S6iztt1jRKw/VYgC74tdjJ5ZgVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=U3DZfTt2; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20240415125848euoutp02406710cf51cf4a85ea3be87bd67c4f92~GdYZxAVra1053010530euoutp02a
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 12:58:48 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20240415125848euoutp02406710cf51cf4a85ea3be87bd67c4f92~GdYZxAVra1053010530euoutp02a
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1713185928;
	bh=K7kgIzAF8cwrWU7cZnQZrJq9/UxYfRIxipy6YJIOOnc=;
	h=Date:From:Subject:To:Cc:In-Reply-To:References:From;
	b=U3DZfTt2tz636C6PK/TOxc5kdPqHBA+WgNL+c9f7jbLpkfE7TazfaTNa1XDFdbp4K
	 OoNcBD9ppaVqFVCdTDnNa+PocIQQNt/VohmdBru9TOuKws3EYQ6SPCtNybhXcx7/Ii
	 uvixRC/CXtAC7SbwwI43vAloRWJGzUYSBTHr2z0Y=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20240415125848eucas1p2693e3902c12ef8668751a407d9d9f211~GdYZi7waQ1350713507eucas1p20;
	Mon, 15 Apr 2024 12:58:48 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges2new.samsung.com (EUCPMTA) with SMTP id 83.07.09875.8842D166; Mon, 15
	Apr 2024 13:58:48 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20240415125847eucas1p2bc180c35f40f9c490c713679871af9ae~GdYZAlLpo1350813508eucas1p25;
	Mon, 15 Apr 2024 12:58:47 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240415125847eusmtrp2b598b357b551f9ce09ab776ff9f34d8a~GdYY-6IPH2471724717eusmtrp2U;
	Mon, 15 Apr 2024 12:58:47 +0000 (GMT)
X-AuditID: cbfec7f4-11bff70000002693-32-661d2488da1c
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id 89.6F.08810.7842D166; Mon, 15
	Apr 2024 13:58:47 +0100 (BST)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240415125846eusmtip1044831a80b43d035463a2940376d5e6d~GdYYUHAow1109911099eusmtip1Q;
	Mon, 15 Apr 2024 12:58:46 +0000 (GMT)
Message-ID: <91ac609b-0fae-4856-a2a6-636908d7ad3c@samsung.com>
Date: Mon, 15 Apr 2024 14:58:46 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [PATCH 12/15] tty: serial: switch from circ_buf to kfifo
To: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>, gregkh@linuxfoundation.org,
	linux-amlogic@lists.infradead.org, "linux-arm-msm@vger.kernel.org"
	<linux-arm-msm@vger.kernel.org>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Bjorn
	Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>,
	Neil Armstrong <neil.armstrong@linaro.org>, Kevin Hilman
	<khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, Martin
	Blumenstingl <martin.blumenstingl@googlemail.com>
Content-Language: en-US
In-Reply-To: <20240405060826.2521-13-jirislaby@kernel.org>
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrHKsWRmVeSWpSXmKPExsWy7djP87odKrJpBtu2clls67CxaF68ns3i
	zaMjzBbv5spY/GzfwmTRMXk7i8WC2dwWE/efZbe4vGsOm8WZxb3sFscWnWSxeL/zFqMDj8f7
	G63sHk8nTGb32LSqk83jzrU9bB77565h99i8pN7j8ya5APYoLpuU1JzMstQifbsErozl3xYz
	FhxQqtiw6iNrA2OLbBcjB4eEgInEvgmSXYxcHEICKxglXm+9zAjhfGGU6Dv3Csr5zCjR3TGX
	uYuRE6zjaMNfZojEckaJD8svsEM4Hxklll1tAKviFbCT2P/zGxOIzSKgKvFg8go2iLigxMmZ
	T1hAbFEBeYn7t2awg9hsAoYSXW+7wGqEBVwlLr15ywYyVERgE6PEzYcvwDYwC5xkkrj7vBGs
	g1lAXOLWk/lgGzgFrCS+t35jhYjLSzRvnQ11azunxMMeawjbReLm7SNsELawxKvjW9ghbBmJ
	/ztB5nCB1DNKLPh9H8qZwCjR8PwWI0SVtcSdc7/YQGHGLKApsX6XPkTYUeLmz35WSFDySdx4
	KwhxA5/EpG3TmSHCvBIdbUIQ1WoSs46vg1t78MIl5gmMSrOQwmUWks9mIflmFsLeBYwsqxjF
	U0uLc9NTi43yUsv1ihNzi0vz0vWS83M3MQKT2Ol/x7/sYFz+6qPeIUYmDsZDjBIczEoivC3C
	smlCvCmJlVWpRfnxRaU5qcWHGKU5WJTEeVVT5FOFBNITS1KzU1MLUotgskwcnFINTIn/TW/5
	/DDaavv4asTFHU1BRxweWISkse3w6PTanv4ztNg7duZy1ntlUg9khJIzzj3+Um+Yk5ld0Ci3
	9whT8fWV3ou4j2jv+ijQrKWRq/ROmfHHj8f3XytIbZ/xuFftru7bXK3p71bxNnz0OpD6Yx3r
	9NPepTO31f6J6VM/MXWWua3dqf7Jh+/aKisrHOzI/iX47Z2+pXqthkCSv9zKehPjFbVfXaOE
	fbQcly642sK5WSg4IVEhzqRU/schx4Ifc5O0uROSV7z5ZhWw+mudaATvur/XSh5fM0p/vPvC
	k+uKceIvlGafa1+kfHvbrnLVCL5/zDv35Jz++jHqzW6uTa5L2sq/ON09fnXXWmOGP0osxRmJ
	hlrMRcWJADgPeZLRAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrAIsWRmVeSWpSXmKPExsVy+t/xu7rtKrJpBheWK1ts67CxaF68ns3i
	zaMjzBbv5spY/GzfwmTRMXk7i8WC2dwWE/efZbe4vGsOm8WZxb3sFscWnWSxeL/zFqMDj8f7
	G63sHk8nTGb32LSqk83jzrU9bB77565h99i8pN7j8ya5APYoPZui/NKSVIWM/OISW6VoQwsj
	PUNLCz0jE0s9Q2PzWCsjUyV9O5uU1JzMstQifbsEvYzl3xYzFhxQqtiw6iNrA2OLbBcjJ4eE
	gInE0Ya/zF2MXBxCAksZJbZ9m8oMkZCRODmtgRXCFpb4c62LDaLoPaPE0pfbwIp4Bewk9v/8
	xgRiswioSjyYvIINIi4ocXLmExYQW1RAXuL+rRnsIDabgKFE19susBphAVeJS2/egtkiApuA
	Nn+JAFnALHCaSWL1xYdgm4UEMiQ2rH0CtoBZQFzi1pP5YDangJXE99ZvrBBxM4murV2MELa8
	RPPW2cwTGIVmIbljFpL2WUhaZiFpWcDIsopRJLW0ODc9t9hQrzgxt7g0L10vOT93EyMwarcd
	+7l5B+O8Vx/1DjEycTAeYpTgYFYS4W0Rlk0T4k1JrKxKLcqPLyrNSS0+xGgKDIyJzFKiyfnA
	tJFXEm9oZmBqaGJmaWBqaWasJM7rWdCRKCSQnliSmp2aWpBaBNPHxMEp1cB0hMGP+ZL/w18K
	+zrbqtRvJdlZC3688KT3cF6w8nzJJjWBrGXretofr7quLegUNmMeU7fM7TvaZw1rd67i0O70
	e8Uw+Y9l9QSP9+zPzfWNJ6+RYog8EcwhcMFblMeh2n21hpjpjDli4Ut15KpPnb//c64Ok17W
	PvsXNY2Bu5SKbiqapHSvyJX3/5Uad0rrCntR9udk4f7pjH+j8jM2JuRdZ2x7xlcv5+C9dfak
	KwJv2eykvji8VfPb5qY042mSatjmGu5bxceePpUWdphxylz6juqS03rz0necFf7s1X5/2tNc
	S/1j2VLGSscY/jKUTUx3X3UuVb387Ju/HD63T+hsi1ylI6XG67D5robxCiWW4oxEQy3mouJE
	AEHZq4VjAwAA
X-CMS-MailID: 20240415125847eucas1p2bc180c35f40f9c490c713679871af9ae
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20240415125847eucas1p2bc180c35f40f9c490c713679871af9ae
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240415125847eucas1p2bc180c35f40f9c490c713679871af9ae
References: <20240405060826.2521-1-jirislaby@kernel.org>
	<20240405060826.2521-13-jirislaby@kernel.org>
	<CGME20240415125847eucas1p2bc180c35f40f9c490c713679871af9ae@eucas1p2.samsung.com>

Dear All,

On 05.04.2024 08:08, Jiri Slaby (SUSE) wrote:
> Switch from struct circ_buf to proper kfifo. kfifo provides much better
> API, esp. when wrap-around of the buffer needs to be taken into account.
> Look at pl011_dma_tx_refill() or cpm_uart_tx_pump() changes for example.
>
> Kfifo API can also fill in scatter-gather DMA structures, so it easier
> for that use case too. Look at lpuart_dma_tx() for example. Note that
> not all drivers can be converted to that (like atmel_serial), they
> handle DMA specially.
>
> Note that usb-serial uses kfifo for TX for ages.
>
> omap needed a bit more care as it needs to put a char into FIFO to start
> the DMA transfer when OMAP_DMA_TX_KICK is set. In that case, we have to
> do kfifo_dma_out_prepare twice: once to find out the tx_size (to find
> out if it is worths to do DMA at all -- size >= 4), the second time for
> the actual transfer.
>
> All traces of circ_buf are removed from serial_core.h (and its struct
> uart_state).
>
> Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
> ...

This patch landed in linux-next as commit 1788cf6a91d9 ("tty: serial: 
switch from circ_buf to kfifo"). Unfortunately it breaks UART operation 
on thr Amlogic Meson based boards (drivers/tty/serial/meson_uart.c 
driver) and Qualcomm RB5 board (drivers/tty/serial/qcom_geni_serial.c). 
Once the init process is started, a complete garbage is printed to the 
serial console. Here is an example how it looks:

[    8.763154] Run /sbin/init as init process
NT [   12.429776] platform cpufreq-dt: deferred probe pending: (reason 
unknown)
[   12.434259] platform regulator-vddcpu: deferred probe pending: 
pwm-regulator: Failed to get PWM
[[6if;9]Uigmkfl-tl ocretbo nrnee .[[6if;9]Uigmkfl-tl ocretbo nrnee .
[[6if;9]Uigmkfl-tl ocretbo nrnee .
[[6if;9]Uigmkfl-tl ocretbo nrnee .
[[6if;9]Uigmkfl-tl ocretbo nrnee .
[[6if;9]Uigmkfl-tl ocretbo nrnee .
[[6if;9]Uigmkfl-tl ocretbo nrnee .
[.. trightlgeet ipthr ytm-dv[[6if;9]Uigmkfl-tl ocretbo nrnee .
[.. trightlgeet ipthr ytm-dv5c[[6if;9]Uigmkfl-tl ocretbo nrnee .
[.. trightlgeet ipthr ytm-dv5c7[Gmo [94m8[2h[0.
.]Snhszn h nta opu vns(usses..[[6if;9]Uigmkfl-tl ocretbo nrnee .
[.. trightlgeet ipthr ytm-dv5c7[Gmo [94m8[2h[0.
.]Snhszn h nta opu vns(usses..[[6if;9]Uigmkfl-tl ocretbo nrnee .
[.. trightlgeet ipthr ytm-dv5c7[Gmo [94m8[2h[0.
.]Snhszn h nta opu vns(usses..[[6if;9]Uigmkfl-tl ocretbo nrnee .
[.. trightlgeet ipthr ytm-dv5c7[Gmo [94m8[2h[0.
.]Snhszn h nta opu vns(usses..[[6if;9]Uigmkfl-tl ocretbo nrnee .
[.. trightlgeet ipthr ytm-dv5c7[Gmo [94m8[2h[0.
.]Snhszn h nta opu vns(usses..[[6if;9]Uigmkfl-tl ocretbo nrnee .
[.. trightlgeet ipthr ytm-dv5c7[Gmo [94m8[2h[0.
.]Snhszn h nta opu vns(usses..[[6if;9]Uigmkfl-tl ocretbo nrnee .
[.. trightlgeet ipthr ytm-dv5c7[Gmo [94m8[2h[0.
.]Snhszn h nta opu vns(usses..[[6if;9]Uigmkfl-tl ocretbo nrnee .
[.. trightlgeet ipthr ytm-dv5c7[Gmo [94m8[2h[0.
.]Snhszn h nta opu vns(usses..[[6if;9]Uigmkfl-tl ocretbo nrnee .
[.. trightlgeet ipthr ytm-dv5c7[Gmo [94m8[2h[0.
.]Snhszn h nta opu vns(usses..[2l[1[[6if;9]Uigmkfl-tl ocretbo nrnee .
[.. trightlgeet ipthr ytm-dv5c7[Gmo [94m8[2h[0.
[.. yteiigteiiilhtlgeet dvcs..[[6if;9]Uigmkfl-tl ocretbo nrnee .
[.. trightlgeet ipthr ytm-dv5c7[Gmo [94m8[2h[0.
[.. yteiigteiiilhtlgeet dvcs..[[6if;9]Uigmkfl-tl ocretbo nrnee .
[.. trightlgeet ipthr ytm-dv5c7[Gmo [94m8[2h[0.
[.. yteiigteiiilhtlgeet dvcs..[[6if;9]Uigmkfl-tl ocretbo nrnee .
[.. trightlgeet ipthr ytm-dv5c7[Gmo [94m8[2h[0.
[.. yteiigteiiilhtlgeet dvcs..[[6if;9]Uigmkfl-tl ocretbo nrnee .
[.. trightlgeet ipthr ytm-dv5c7[Gmo [94m8[2h[0.
[.. yteiigteiiilhtlgeet dvcs..[  105.613420] debugfs: Directory 
'ff800280.cec' with parent 'regmap' already present!
[[6if;9]Uigmkfl-tl ocretbo nrnee .
[.. trightlgeet ipthr ytm-dv5c7[Gmo [94m8[2h[0.
.]Snhszn h nta opu vns(usses..[2l[11[[2 k;9?5[  105.638809] mc: Linux 
media interface: v0.10
[.. atn o dvt eflyppltd.[  105.707390] meson-vrtc ff8000a8.rtc: 
registered as rtc0


I found this patch by bisecting today's linux-next. I've checked the 
changes in the related UART drivers and I don't see any obvious issues 
though. Let me know if I can help debugging this issue somehow.

I've trimmed recipient list due to my smtp server limitation.


Best regards

-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland


