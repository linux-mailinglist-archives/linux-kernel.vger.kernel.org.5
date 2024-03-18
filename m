Return-Path: <linux-kernel+bounces-106246-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9383787EB5A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 15:46:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E2755B22A36
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 14:46:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5F634F1E1;
	Mon, 18 Mar 2024 14:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kqwSd1uF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5A184E1C5;
	Mon, 18 Mar 2024 14:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710773140; cv=none; b=pHkQs+xKCOdEFJW/t55lKwJQXnHN39D/IdylIfwP5HGxsvunJJ0r9T8XoXehMggrObip3WoBcb4KKXZX5T1tGQ6x4KYdj+fZt2CDARi1l2jl6fON8+E1jzh1NmRJiJvtbzIp66G9uoJI7aOFok+P1zawdc0aJmluxHvjGP6pA/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710773140; c=relaxed/simple;
	bh=mNFwIbUpYbC6mIe+Ons8M/fmdCsJd0AHKosKXozTHfs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uKyLW1z1NmEK52DwAiloLSV8e0IwvDXEv6nFzKjMe5mpxtNY14MY0F658jNCU20TblMCpy2GUzu9gjD/cR+O9qomP8LD4JX2/VZYFz0e3h7b/G6xMjSrM5gQKTPoK+Vv5PmTdfx0mI75aMGyzFLcyVcZaoELWffS8yw3Wvvwkho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kqwSd1uF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EBC3C433F1;
	Mon, 18 Mar 2024 14:45:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710773139;
	bh=mNFwIbUpYbC6mIe+Ons8M/fmdCsJd0AHKosKXozTHfs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kqwSd1uFjWxPfNUE0/idanxGBUrdyMwC9MFJVRWvUhOVxbEuBrHkpxTBXNRmucbIu
	 drSTjRLLKhPKf9SVWv9E+6//cUMjLhj3ixKZNa9kwq7Sg9J6HwjpnNCXOJRGqVlVvY
	 WaE/9HaIvEnL2lNf5PtSKn8lAgqT2do3hOuJftC+fjuKUBNgw9k1Lt585dSw8zKB0G
	 QwH08EjqmxoUE1iHv7degGtOJ31pY+vyQ/H9ic+QHHYu+xWvGSAGvyF4cNXbnxs6gw
	 uoORzwsDvWQLi38VzylOrPel1jI0dYMYupn/imr0gT1NJzPD1PfU5Vofc0tusOr9Fr
	 itZfsI5QGKC/w==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1rmEFF-00000000310-1VgJ;
	Mon, 18 Mar 2024 15:45:45 +0100
Date: Mon, 18 Mar 2024 15:45:45 +0100
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
Message-ID: <ZfhTmQ6mOLR8eXA5@hovoldconsulting.com>
References: <20240318110855.31954-1-johan+linaro@kernel.org>
 <20240318110855.31954-2-johan+linaro@kernel.org>
 <CAA8EJprywWbdoyfAbys=0WzEdAkp0UK1fzzCPzxKRjyk9DrC6Q@mail.gmail.com>
 <Zfg--2_NMPSPTxK-@hovoldconsulting.com>
 <CAA8EJpoxq6__DMcsuAEsnxBfPrrQBuu4ZgfULkok4KWSYVxuHQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA8EJpoxq6__DMcsuAEsnxBfPrrQBuu4ZgfULkok4KWSYVxuHQ@mail.gmail.com>

On Mon, Mar 18, 2024 at 04:17:24PM +0200, Dmitry Baryshkov wrote:
> On Mon, 18 Mar 2024 at 15:17, Johan Hovold <johan@kernel.org> wrote:
> > On Mon, Mar 18, 2024 at 03:00:40PM +0200, Dmitry Baryshkov wrote:
> > > On Mon, 18 Mar 2024 at 13:09, Johan Hovold <johan+linaro@kernel.org> wrote:
> > > > The only device out there that should be affected by this is the WCN3991
> > > > used in some Chromebooks. To maintain backwards compatibility, mark the
> > > > current compatible string as deprecated and add a new
> > > > 'qcom,wcn3991-bt-bdaddr-le' for firmware which conforms with the
> > > > binding.
> >
> > > This compatible doesn't describe new hardware kind. As such, I think,
> > > the better way would be to continue using qcom,wcn3991-bt compatible
> > > string + add some kind of qcom,bt-addr-le property.
> >
> > No, you can't handle backwards compatibility by *adding* a property.
> >
> > I wanted to avoid doing this, but if we have to support Google's broken
> > boot firmware for these devices, then this is how it needs to be done.
> 
> One hardware compat string per hardware type.

Again, no. Not when there is an incompatible change in the binding. Then
we add a new compatible string and deprecate the old binding.

Johan

