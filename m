Return-Path: <linux-kernel+bounces-106329-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B93F087EC79
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 16:47:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E46D91C20CAA
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 15:47:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89B125339A;
	Mon, 18 Mar 2024 15:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MV/uCDEP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA778524CA;
	Mon, 18 Mar 2024 15:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710776822; cv=none; b=cHayKSONJcWB1EfUWfQ/JOfQcN1j23/4t8RZJ2NBuNIeCRLVxwPheEmMjv4AwAe7h2MvFnBEU+inP6iSSWdHF3bnhO/8C18dYzpysMnsHV6C5uHoFqWiodjCKgbX+97IF2SPS5ndYoDWdC4pBjB8gQWB+i2MF9TFQnToGkRZWQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710776822; c=relaxed/simple;
	bh=REkax58sXTPomHSh67uxOzD64atEhWrNncC5hHCfKnM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X+hwHNYKM1TRnjHWKn3rcPrHkraRkgCaT9aCd1DAEd8lMo+Rq2A9r0ZcMjYSKZH3YZjkJOhZ9cB8iELIFXRQZ8kDFMsVpwqvdI+jyVt5URnooDs7DInY0ctwcK6yIhFCWxeDVEUb8tERV2k/3dYssZeFgtEW3Q1Q3FhbKMp44J0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MV/uCDEP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30171C433F1;
	Mon, 18 Mar 2024 15:47:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710776822;
	bh=REkax58sXTPomHSh67uxOzD64atEhWrNncC5hHCfKnM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MV/uCDEP+jETJPzX9aWGhs5GSFEaUIiwLg+aftvin+D/DwpaPiPTL6971ScZk2bOn
	 nIq2MlJbs0Wt1JrpSZDj+0stN/8CLJigWO4n9vSxQhMSy2bAL0Sky9KuAp1XcBvV8C
	 rCnx6phKWy0UQTLCVhL3KE3ncvMuGnANX22YSeijVk6mcBu79L9gzfWTENzjjgizOW
	 d27sTdgnC0uzPGlC4RlwM/OpiREWKt7WnLrA2hfGp5lEhrFPjr4lfEV5guiHkRJPSB
	 Lvh7Gow/9Qktjz+WVfDUZY5U4lV0ExHo9M6iI00rn0X34HxVv6p9uJWX1+teP4TRHC
	 505t+VjwdA+iA==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1rmFCd-000000003Bk-3Xhk;
	Mon, 18 Mar 2024 16:47:07 +0100
Date: Mon, 18 Mar 2024 16:47:07 +0100
From: Johan Hovold <johan@kernel.org>
To: Doug Anderson <dianders@google.com>
Cc: Rob Herring <robh@kernel.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Johan Hovold <johan+linaro@kernel.org>,
	Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Matthias Kaehlcke <mka@chromium.org>,
	Bjorn Andersson <quic_bjorande@quicinc.com>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	linux-bluetooth@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/4] dt-bindings: bluetooth: add new wcn3991
 compatible to fix bd_addr
Message-ID: <Zfhh-4wEg4O4Xqeu@hovoldconsulting.com>
References: <20240318110855.31954-1-johan+linaro@kernel.org>
 <20240318110855.31954-2-johan+linaro@kernel.org>
 <CAA8EJprywWbdoyfAbys=0WzEdAkp0UK1fzzCPzxKRjyk9DrC6Q@mail.gmail.com>
 <Zfg--2_NMPSPTxK-@hovoldconsulting.com>
 <20240318144806.GA3963554-robh@kernel.org>
 <ZfhZffrZXwtKgZ13@hovoldconsulting.com>
 <CAD=FV=UpuD7Lq0DxSZAGpL4Mi2uxy9HNt3V3FZq7Y3p--gbMrg@mail.gmail.com>
 <CAD=FV=WCzrh926mkiyBnKRG_+KGuOkGN6v0DgPiXhQCD3PSQ9w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAD=FV=WCzrh926mkiyBnKRG_+KGuOkGN6v0DgPiXhQCD3PSQ9w@mail.gmail.com>

On Mon, Mar 18, 2024 at 08:31:09AM -0700, Doug Anderson wrote:
> On Mon, Mar 18, 2024 at 8:26 AM Doug Anderson <dianders@google.com> wrote:

> > > A new compatible string (or one-off property) would allow them do make a
> > > change when they are ready (e.g. by only updating the devicetrees after
> > > all boot firmware has been patched and pushed out).
> >
> > I have no real opinion about the exact way this is solved so happy to
> > let DT folks decide on how they want this. I will note, however, that
> > device trees are never shipped separately and thus we have no
> > intrinsic need for DT backward compatbility here. It would be OK from
> > a ChromeOS perspective to add a property or compatible string for the
> > broken case.
> 
> Actually, I should probably say more about this to make it clear how it works.
> 
> Chromebooks ship the kernel as a FIT image which bundles the kernel
> and device trees together. The firmware looks at all the bundled
> device trees and picks the proper one based on the board name,
> revision, and SKU ID. The firmware then looks for the bluetooth node
> (I believe it finds it from the "aliases" section) and adds the MAC
> address there.
> 
> ...so we could update the DT to add a property (if that's desired)
> even if we don't update the firmware.

Thanks for the details. Sounds like we could get away with adding a new
property for the broken firmware in this case, which should resolve this
nicely without having to deprecate anything.

Could you carry such a devicetree patch out-of-tree until the firmware
has been fixed?

Johan

