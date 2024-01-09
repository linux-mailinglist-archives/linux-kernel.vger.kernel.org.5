Return-Path: <linux-kernel+bounces-21150-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97D55828ACB
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 18:13:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3A2F6B2331F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 17:13:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C91193B2A4;
	Tue,  9 Jan 2024 17:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nMjAqNkO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19E9D3A8DC;
	Tue,  9 Jan 2024 17:12:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82155C433C7;
	Tue,  9 Jan 2024 17:12:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704820347;
	bh=R68MSDBYhZXBw3JD8klsX3dJnjsUWkASMAeLu74RGAM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nMjAqNkOT8bGrVlAgY2467bcJ4tXSA624As8/+CoYze0gJLu1e1yk+CJ6waXbTOoh
	 YXP8M+3w8gr6cKZKA9FDWXBn/XxD4IxvhW8E7OALTRrF3ik99qPfFGg9r2925ww9c1
	 ttssWGQ3Oqsr+ctV2+0izp2L9rpiDx3ls/Y64uE9oU7mxRxUpdhDtJzT4crTnpBRx4
	 KUTEZkcvZzMkki1TjdoAty9aGYAzL4XAm4h1aEX31KjLdXUlCQzMLGqdoxsk7jgffn
	 JOd+4I+pbwD1ftitAA1FM+cSdmF/6egwP8c9NiQg7ONTkgwEufeTOV1nMT7kQOXTwI
	 Pdpa+N1HPFKDA==
Received: from johan by xi.lan with local (Exim 4.96.2)
	(envelope-from <johan@kernel.org>)
	id 1rNFeM-0005Ty-0f;
	Tue, 09 Jan 2024 18:12:26 +0100
Date: Tue, 9 Jan 2024 18:12:26 +0100
From: Johan Hovold <johan@kernel.org>
To: Matthias Kaehlcke <mka@chromium.org>
Cc: Johan Hovold <johan+linaro@kernel.org>,
	Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Bjorn Andersson <quic_bjorande@quicinc.com>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	linux-bluetooth@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
	Doug Anderson <dianders@google.com>,
	Stephen Boyd <swboyd@google.com>
Subject: Re: [PATCH] Bluetooth: qca: fix device-address endianness
Message-ID: <ZZ1-ehpU-g6i9Qem@hovoldconsulting.com>
References: <20231227180306.6319-1-johan+linaro@kernel.org>
 <ZZ15c1HUQIH2cY5o@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZZ15c1HUQIH2cY5o@google.com>

On Tue, Jan 09, 2024 at 04:50:59PM +0000, Matthias Kaehlcke wrote:

> On Wed, Dec 27, 2023 at 07:03:06PM +0100, Johan Hovold wrote:
> > The WCN6855 firmware on the Lenovo ThinkPad X13s expects the Bluetooth
> > device address in MSB order when setting it using the
> > EDL_WRITE_BD_ADDR_OPCODE command.
> > 
> > Presumably, this is the case for all non-ROME devices which all use the
> > EDL_WRITE_BD_ADDR_OPCODE command for this (unlike the ROME devices which
> > use a different command and expect the address in LSB order).
> > 
> > Reverse the little-endian address before setting it to make sure that
> > the address can be configured using tools like btmgmt or using the
> > 'local-bd-address' devicetree property.
> > 
> > Note that this can potentially break systems with boot firmware which
> > has started relying on the broken behaviour and is incorrectly passing
> > the address via devicetree in MSB order.
> 
> We should not break existing devices. Their byte order for
> 'local-bd-address' may not adhere to the 'spec', however in practice
> it is the correct format for existing kernels.

That depends on in what way the current devices are broken.

Any machines that correctly specify their address in little-endian order
in the devicetree would no longer be configured using the wrong address.
So no problem there (except requiring users to re-pair their gadgets).

And tools like btgmt is broken on all of these Qualcomm machine in any
case and would now start working as expected. So no problem there either
(unless user space had adapted an inverted the addresses to btmgmt).

So the first question is whether there actually is any boot firmware out
there which passes the BD_ADDR in reverse order?

> I suggest adding a quirk like 'local-bd-address-msb-quirk' or
> 'qcom,local-bd-address-msb-quirk' to make sure existing devices keep
> working properly.

I don't think that would work. If this is something that we really need
to handle, then there's probably no way around introducing new
compatible strings for boot firmware that isn't broken while maintaining
the current broken behaviour with respect to 'local-bd-address' for some
of the current ones.

Johan

