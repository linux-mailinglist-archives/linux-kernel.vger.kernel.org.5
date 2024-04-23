Return-Path: <linux-kernel+bounces-155987-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CB298AFC64
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 01:05:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0F421C22AEC
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 23:05:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F40B136139;
	Tue, 23 Apr 2024 23:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="iIWWrZ6T"
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EED9F1C6BE
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 23:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713913507; cv=none; b=e2DS0aevsoyeawLYQaMhBRFz46PpeM03K06nXI9HVqcz+qmrge+E6wBCAwFVlCjX+4wbqIFBTzEVkTlCCvX2Q84WtJYZSLkLpJ2hAbaf4clfitoHFVIVdYTW4T5GtrvetRQeyohQrTGggqEhPg78SJdHTnOK95gpEsbUL4JBljw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713913507; c=relaxed/simple;
	bh=W5rtmWZn+gzmSPYDajf5hzHjrrARRPwmvtUOsrkg4+4=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=GWR5KWEWjzS1nwVwm3cg8cel0IngG3vhKsAL2auK1DAjzt/VUhaR04Q1Ybziy+vW4N0sChtRBJhqMmT1dxVwGwn+SqojwNt9twXn3pcCy6zcnxE8c4A/gsbXvwt7KoOSEsUM633rH/6FbcIiDkKi5k4TE84ySe4R2X/HvxAsQls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=iIWWrZ6T; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <5bb0dc7e-4c89-4f3d-abc6-41ae9ded5ae9@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1713913503;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=MSoV0N+Bh0IcWueNazIcpLY5jxZX12Cx6M7J1n6K4tQ=;
	b=iIWWrZ6TYv1Vkk9lzS5cmCbBhaLuYOk6Y3nM7tg9EQHaECQ4PwjLBPtijt3JPsXmwxwUs8
	G0aNxaaEd1AFs9bPfZnlFuXSArh1+4m56fH2DQ1ULb8FjeIrWj53YB0naS/20bX503DvbS
	7YtZjJWLmJxpyDE2ScYFTkwSzguYsdQ=
Date: Tue, 23 Apr 2024 19:04:59 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Language: en-US
To: Michal Simek <michal.simek@amd.com>,
 "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>
Cc: Linus Walleij <linus.walleij@linaro.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
Subject: pinctrl: zynqmp: Valid pin muxings cannot be configured
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

Hi Michal,

I was looking to upstream one of our ZynqMP boards, and I ran into an
issue with the pinmuxing. We use almost all of the I/Os, so everything
is tightly packed into the MIO. For example, we have the QSPI on MIO0 to
MIO5, and MIO6 to MIO11 are used for SPI1. However, I cannot select this
configuration using the pinmux driver. I am using the following
configuration:

pinctrl_qspi_default: qspi-default {
	mux {
		groups = "qspi0_0_grp";
		function = "qspi0";
	};

	mux-cs {
		groups = "qspi_ss_0_grp";
		function = "qspi_ss";
	};
};

pinctrl_spi1_default: spi1-default {
	mux {
		groups = "spi1_0_grp";
		function = "spi1";
	};

	mux-cs {
		groups = "spi1_ss_0_grp", "spi1_ss_1_grp";
		function = "spi1_ss";
	};
};

But I get the following errors on boot:

[    4.261739] zynqmp-pinctrl firmware:zynqmp-firmware:pinctrl: pin MIO8 already requested by ff050000.spi; cannot claim for ff0f0000.spi
[    4.274506] zynqmp-pinctrl firmware:zynqmp-firmware:pinctrl: error -EINVAL: pin-8 (ff0f0000.spi)
[    4.283789] zynqmp-pinctrl firmware:zynqmp-firmware:pinctrl: error -EINVAL: could not request pin 8 (MIO8) from group qspi0_0_grp  on device zynqmp_pinctrl

This is because the qspi0_0_grp and spi1_0_grp groups overlap:

group: qspi0_0_grp
pin 0 (MIO0)
pin 1 (MIO1)
pin 2 (MIO2)
pin 3 (MIO3)
pin 4 (MIO4)
pin 8 (MIO8)
pin 9 (MIO9)
pin 10 (MIO10)
pin 11 (MIO11)
pin 12 (MIO12)

group: qspi_ss_0_grp
pin 5 (MIO5)
pin 7 (MIO7)

group: qspi_fbclk_0_grp
pin 6 (MIO6)

group: spi1_0_grp
pin 6 (MIO6)
pin 10 (MIO10)
pin 11 (MIO11)

group: spi1_ss_0_grp
pin 9 (MIO9)

group: spi1_ss_1_grp
pin 8 (MIO8)

group: spi1_ss_2_grp
pin 7 (MIO7)

However, we are not using the "upper" pins of the QSPI device.
Therefore, these pins should not be included in the qspi0_0_grp. This
stems from the driver placing all possible pins into a function's group,
even though each pin can be muxed individially and it is not necessary
to mux all pins for full functionality.

I think it would be better to have a single group for each pin:

pinctrl_qspi_default: qspi-default {
	mux {
		groups = "mio0", "mio1", "mio2", "mio3", "mio4";
		function = "qspi0";
	};

	mux-cs {
		groups = "mio5";
		function = "qspi_ss";
	};
};

pinctrl_spi1_default: spi1-default {
	mux {
		groups = "mio6", "mio10", "mio11";
		function = "spi1";
	};

	mux-cs {
		groups = "mio8", "mio9";
		function = "spi1_ss";
	};
};

This allows the full functionality of this chip to be configured. Does
that sound good? I can send a patch to this effect if you agree.

--Sean

