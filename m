Return-Path: <linux-kernel+bounces-27729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ED4E82F4EC
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 20:03:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3D421C239B5
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 19:03:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E8291D520;
	Tue, 16 Jan 2024 19:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VaDXIcsg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 455521D53E;
	Tue, 16 Jan 2024 19:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705431804; cv=none; b=CNA+gKAn1YjaoDTOSMY6fHCDOgj9sx3t6z7GJiO+Mz0FkSXbIeD58kmFfzucVDo2BbbqzxMQ4DEwHFTqMXm9WMwyuny2haAm3UCw6pVd1sYmfckel9l1knJqT/5hMnD35VCivs9ZCxzySJwVu3XQDW2ZjlnuG0DWoDJEbuwUK7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705431804; c=relaxed/simple;
	bh=O97xKl3K/JtNvHQ+44OKckuR3Pp75TXib8o3WdXgsus=;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To; b=NDzl2xxuJwolXUgtDUUKwSYvt/JOeOLVXyH8lkfAZxkcEFxDr9goRvWhQuJeA3V8zqGklY2SVCRVNiPr6JXv5jJA1eDsg4OETXvxu3JX+SZZTQUjDjj5UcCHA9jEGDJK1MUxXwhJPft6LMlPIGUKnzfgudD6zz8m1To6AwwYvXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VaDXIcsg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BE70C433B2;
	Tue, 16 Jan 2024 19:03:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705431802;
	bh=O97xKl3K/JtNvHQ+44OKckuR3Pp75TXib8o3WdXgsus=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=VaDXIcsgPU2HcWZ7gq00FVh03mn2KgTtLHehEQ4XaZuvq9AcUZKwE/E/YIKBPnAR+
	 8JQOKTCPO/ZCvOrmI/L8S3uhC0x9GOG/35KX6GFud+O6wk83cD+hgToCSIfIq3xXvV
	 YpsuQvUfyyG3W8y5zaBmmRdWMiq4oELhjY1wvWQPSNDZL4CtVwPdO8+HJIaNg77iV8
	 G3XEEbPw9YyTJbgVbiPBWWpfaPehq85FkAcEUIpHbuTcTp5lRLF5qSOBEjtl5p/vHb
	 4FI/dNyCUUJnNpnk7hvW86QD9TjUkgES9bCkParwNUcyGr1FJ/MYPIjiqhPOh6kksL
	 Kx/fMh+u9cLOA==
Date: Tue, 16 Jan 2024 13:03:21 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ninad Palsule <ninad@linux.ibm.com>
Cc: robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, joel@jms.id.au, andrew@codeconstruct.com.au,
	peterhuewe@gmx.de, jarkko@kernel.org, jgg@ziepe.ca,
	keescook@chromium.org, tony.luck@intel.com, gpiccoli@igalia.com,
	johannes.holland@infineon.com, linux@roeck-us.net,
	broonie@kernel.org, andre.werner@systec-electronic.com,
	Andrew Geissler <geissonator@yahoo.com>,
	patrick.rudolph@9elements.com, vincent@vtremblay.dev,
	peteryin.openbmc@gmail.com, lakshmiy@us.ibm.com,
	bhelgaas@google.com, naresh.solanki@9elements.com,
	alexander.stein@ew.tq-group.com, festevam@denx.de,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	linux-integrity@vger.kernel.org, linux-hardening@vger.kernel.org,
	geert+renesas@glider.be, luca.ceresoli@bootlin.com
Subject: Re: [PATCH v4 3/3] ARM: dts: aspeed: System1: IBM system1 BMC board
Message-ID: <20240116190321.GA102334@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240116183734.3944028-4-ninad@linux.ibm.com>

On Tue, Jan 16, 2024 at 12:37:34PM -0600, Ninad Palsule wrote:
> From: Andrew Geissler <geissonator@yahoo.com>
> 
> Add a device tree for IBM system1 BMC board. It uses AST2600 SOC.
> - Added base board

s/Added/Add/ to match first sentence.

> - Added i2c devices and muxes.
> - Added different voltage regulators.
> - Added GPIO pin assignements, GPIO expansion devices
> - Added LED brinker devices

"brinker"?  "blinker" maybe (no idea what it actually is).

> - Added Fan controllers

s/Fan/fan/

> - Added EEPROM/VPD
> - Added Power supplies

s/Power/power/

> - Added Humidity, pressure and temperature sensors.

s/Humidity/humidity/

> - Added Trusted platform module(TPM) chip.

s/Trusted platform module/Trusted Platform Module /

> Tested:
>     This board is tested using the simics simulator.
> 
> Signed-off-by: Ninad Palsule <ninad@linux.ibm.com>
> Signed-off-by: Andrew Geissler <geissonator@yahoo.com>

Your sign-off should be last since you are sending the series.

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?id=v6.6#n396

