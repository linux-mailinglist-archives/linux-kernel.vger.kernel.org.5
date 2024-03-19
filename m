Return-Path: <linux-kernel+bounces-107830-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33021880235
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 17:27:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C7653B255CF
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 16:27:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C69898593A;
	Tue, 19 Mar 2024 16:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MYx6JdOS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2B0E82864;
	Tue, 19 Mar 2024 16:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710865353; cv=none; b=UwBjKh+hSXNQX4Wsyaj1OaOQmyyguMj4tN5MOw/u2Kn9lF14ECF52d+D5KH2RdXic/7hmuGQgQN3Y3hABEHkVKYSiNiM/CbA4Z0cnA6yN7zt69FcZhj4/HwNExV/Kd74qg0YvODHisRbSH6Y9aMmbc88b1BeQcs84niy4C0is8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710865353; c=relaxed/simple;
	bh=acH73uxgSHv/9BCCRDyYgpImYhoviLo4KGKdazenxjg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L2BxXohy9GHKnlGNZl1UQOPNRBvJCeWS1GYR9kmkgafOzwZZFZlTlw/v8XIEdGluZalGucLH2RGPv8dXFsKQqb9bJq+yOcqBedCrE4MYvUU8KEHO+qg5v5AQ0TEKmg89CtGHeebO84P4BMtQr+RlSuxKbeQZe+oxSpMjcAfLHeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MYx6JdOS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66617C433F1;
	Tue, 19 Mar 2024 16:22:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710865352;
	bh=acH73uxgSHv/9BCCRDyYgpImYhoviLo4KGKdazenxjg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MYx6JdOS12ng1Hk7K5AcUmYuLhE4Q9WdE75c85+hNVQvIIPHwNf268g6VyXMp7EFe
	 gmcTs/Xv9e41VpLXQaEkkDrbr7OhdCnrib7jyGw+Eh9C11F1M9BliuVjPOdCXYXxUl
	 y5IFpsnROz0UEpTCbmrxWxsO/CVNyKRlOf0x152+5aFcAx5YUbM2jrkeyM09G9grOM
	 W0L9zk+jVK3trLI2EFEoN/NkHVN0kOeeaFqJZqHnO6hCPbEqz2diK8dOVkcKj7I8PS
	 9b4XwhUfADfYGyYGWVb2PlsmuXOVnnHIwic830u/Zq8XxZAXDIHvaRODtxTSwDJdvB
	 bFx4ftos+fZzQ==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1rmcEY-000000000rS-2PTg;
	Tue, 19 Mar 2024 17:22:39 +0100
Date: Tue, 19 Mar 2024 17:22:38 +0100
From: Johan Hovold <johan@kernel.org>
To: Doug Anderson <dianders@chromium.org>
Cc: Johan Hovold <johan+linaro@kernel.org>,
	Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	cros-qcom-dts-watchers@chromium.org,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
	Matthias Kaehlcke <mka@chromium.org>,
	Rocky Liao <quic_rjliao@quicinc.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/5] dt-bindings: bluetooth: add
 'qcom,local-bd-address-broken'
Message-ID: <Zfm7zjD-aicgvr-t@hovoldconsulting.com>
References: <20240319152926.1288-1-johan+linaro@kernel.org>
 <20240319152926.1288-2-johan+linaro@kernel.org>
 <CAD=FV=XJ+yAvDn5NyfCSJdg+DujPrWO+DZu=BmcqbJS-ugEGMg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAD=FV=XJ+yAvDn5NyfCSJdg+DujPrWO+DZu=BmcqbJS-ugEGMg@mail.gmail.com>

On Tue, Mar 19, 2024 at 09:10:08AM -0700, Doug Anderson wrote:
> On Tue, Mar 19, 2024 at 8:29 AM Johan Hovold <johan+linaro@kernel.org> wrote:

> > +  qcom,local-bd-address-broken: true
> > +    description: >
> > +      boot firmware is incorrectly passing the address in big-endian order
> 
> Personally, I feel like "qcom,local-bd-address-backwards" or
> "qcom,local-bd-address-swapped" would be more documenting but I don't
> feel super strongly about it. I guess "broken" makes it more obvious
> that this is not just a normal variant that someone should use.

Yeah, that is precisely why I chose that name, to avoid having people
think this is something they can just pick and choose for their driver.

As is repeatedly made clear, this needs to be obvious from the name, as
apparently not many people bother to look up the documentation.

> If DT binding folks are happy, I'm happy enough with this solution.

> Reviewed-by: Douglas Anderson <dianders@chromium.org>

Thanks for reviewing.

Johan

