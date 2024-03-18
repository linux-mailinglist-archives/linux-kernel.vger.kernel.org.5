Return-Path: <linux-kernel+bounces-106154-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D34C887E9F3
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 14:17:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D9622817B5
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 13:17:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C36B23A1B5;
	Mon, 18 Mar 2024 13:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jfn6yFY5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F174D383B0;
	Mon, 18 Mar 2024 13:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710767863; cv=none; b=XA3q2EpYx9oPr0tl/EbGJ06pywOjyh8MJ4ouFFGNcl9PEfmq60SwCeg6pF+8sIpcma2L4PVJOySigIctoNhL5aoKuOQXP6LVkZ5U9DMw2NPSCx13RrR/NzqjaQH7ylZx/UMblLovwLl7XC2W69mE3SsTm4DXPbCZborhf8JMcWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710767863; c=relaxed/simple;
	bh=TBxlNbJ1kz+1mgc5LCV7B1yVqyid6pknsBQioHE+wvk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TCYke6JmP4QUlVkMsyJ9r4S0CTsDxryJJ0kP1u8xf6hau/7lBm4AyBHhi6/mQTJN750RnxCqu9EYec5EJjyfE+9yFz4BovuYla+LLBlAHaUaAXReTBajKX3p1qtZB9RiA3rgRstm5X6GSI4jbUv6yKjVd2cQPDFphM4sGRS9bSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jfn6yFY5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65B23C433C7;
	Mon, 18 Mar 2024 13:17:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710767862;
	bh=TBxlNbJ1kz+1mgc5LCV7B1yVqyid6pknsBQioHE+wvk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Jfn6yFY5x4ioM/28bhoexwqqED+kx78C7906yUeW8Z/8QSUgq6RolopQ5eyEINwNM
	 xzj5LQtBaqipMQ59yVEF6WL6G3XDksaViLZglkF4ECw2itY4cy0T6MRo+1sK4in3ON
	 d2ucQ4ZTUuSaZgx67vgbUhTVE0nnKtqGDPPhzZsFCXFFZ1dO3AK/e/vcpHia0wMHJo
	 RmzPD/XdSIDdvNQ8ra7bF3Wo03gdf+YltOu840+d3/180ohoqCDb6hDEKgDH8BELTv
	 7tvOEnAsZ36LpQVzqhCLUiFIsC8gGyJnvpnKi0iLica0joad0fiwH76tgOYGpz+4h+
	 hCP/rvpR1PB/w==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1rmCs7-000000000L7-46cK;
	Mon, 18 Mar 2024 14:17:48 +0100
Date: Mon, 18 Mar 2024 14:17:47 +0100
From: Johan Hovold <johan@kernel.org>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Johan Hovold <johan+linaro@kernel.org>,
	Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Matthias Kaehlcke <mka@chromium.org>,
	Doug Anderson <dianders@google.com>,
	Bjorn Andersson <quic_bjorande@quicinc.com>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	linux-bluetooth@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/4] dt-bindings: bluetooth: add new wcn3991
 compatible to fix bd_addr
Message-ID: <Zfg--2_NMPSPTxK-@hovoldconsulting.com>
References: <20240318110855.31954-1-johan+linaro@kernel.org>
 <20240318110855.31954-2-johan+linaro@kernel.org>
 <CAA8EJprywWbdoyfAbys=0WzEdAkp0UK1fzzCPzxKRjyk9DrC6Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA8EJprywWbdoyfAbys=0WzEdAkp0UK1fzzCPzxKRjyk9DrC6Q@mail.gmail.com>

On Mon, Mar 18, 2024 at 03:00:40PM +0200, Dmitry Baryshkov wrote:
> On Mon, 18 Mar 2024 at 13:09, Johan Hovold <johan+linaro@kernel.org> wrote:
> >
> > Several Qualcomm Bluetooth controllers lack persistent storage for the
> > device address and instead one can be provided by the boot firmware
> > using the 'local-bd-address' devicetree property.
> >
> > The Bluetooth bindings clearly says that the address should be specified
> > in little-endian order, but due to a long-standing bug in the Qualcomm
> > driver which reversed the address some bootloaders have been providing
> > the address in big-endian order instead.
> >
> > The only device out there that should be affected by this is the WCN3991
> > used in some Chromebooks. To maintain backwards compatibility, mark the
> > current compatible string as deprecated and add a new
> > 'qcom,wcn3991-bt-bdaddr-le' for firmware which conforms with the
> > binding.

> This compatible doesn't describe new hardware kind. As such, I think,
> the better way would be to continue using qcom,wcn3991-bt compatible
> string + add some kind of qcom,bt-addr-le property.

No, you can't handle backwards compatibility by *adding* a property.

I wanted to avoid doing this, but if we have to support Google's broken
boot firmware for these devices, then this is how it needs to be done.

Johan

