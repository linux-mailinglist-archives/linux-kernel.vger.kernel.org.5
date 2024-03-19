Return-Path: <linux-kernel+bounces-107833-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D66C7880246
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 17:28:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDE491C23110
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 16:28:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AC5382D67;
	Tue, 19 Mar 2024 16:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EDacBSHb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2CD31E4A9;
	Tue, 19 Mar 2024 16:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710865560; cv=none; b=tQf3ySc8MKEErjj7sbTGZlsC3Lx5w3y/O1dv7jmea/c6FuKKQ2VIQc/sXJTQ2RX65a0NjkSba9/SlE8kteVtiYiSJYQbdBzWzOKqPag+YNk+Wdf0Nn8jTqXVsEoWq+tCQ277i3vs2Zjgx4ViaBPyuCtvh9TMM2+tzVL20/z6qhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710865560; c=relaxed/simple;
	bh=+wx6pm84h4SSZqN7LgwX7nuza5CpaVwm5ikzrYbkklk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=boV1zwR71BUH79giYDsA43+NRKuf4+xqoW2i7Hn4CZfmMMEa++SqqFP27GnimTharEHDITgHCZtAuxWIeZO7YgkBZgWmfGXtljxc/OQ0MKgu1vaMSI1VcGDbr5dMLEwc43rDq1z9u6EW9OjOaeT8DxyqhzRrmuw9pkDg3aKJv0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EDacBSHb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10679C433F1;
	Tue, 19 Mar 2024 16:26:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710865560;
	bh=+wx6pm84h4SSZqN7LgwX7nuza5CpaVwm5ikzrYbkklk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EDacBSHbddGGkBkjEvMDDec/065XpdXqytnKL4IiuFBQn6bJQqM2BM3iYDROEXxDp
	 Km/QA7SXjxgSKyx+h0CxnIqPzDye5DToSDv7SMX737+StXoMB0yOhcGJsEGmn4Hbv+
	 ykNJFOhDZ0No+Sph2HQYihKOx6y8+Sb2Euf/uoTPk/MI+aizrVKh1E/jgikx03NzFV
	 rvbnvQkWXKhSDGUXhpIMg2dwW2+Q/BvmM7J6RdzWdlK/3n54mwx1ibUKDl/u8uMbRf
	 QbpPpCww1mqacFKfGIfPnYKg2jI9yc98w9elBpUaOvH8Ar2ZSWczvTlp/qHfBak43C
	 ocspy0Tj07VzQ==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1rmcHu-000000000s5-45bY;
	Tue, 19 Mar 2024 17:26:07 +0100
Date: Tue, 19 Mar 2024 17:26:06 +0100
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
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v3 2/5] Bluetooth: add quirk for broken address properties
Message-ID: <Zfm8nifvqb3xO5HG@hovoldconsulting.com>
References: <20240319152926.1288-1-johan+linaro@kernel.org>
 <20240319152926.1288-3-johan+linaro@kernel.org>
 <CAD=FV=VUFodCAXEJgfpSqZZdtQaw5-8n_-sX_2p6LuQ2ixLRpQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAD=FV=VUFodCAXEJgfpSqZZdtQaw5-8n_-sX_2p6LuQ2ixLRpQ@mail.gmail.com>

On Tue, Mar 19, 2024 at 09:10:23AM -0700, Doug Anderson wrote:
> On Tue, Mar 19, 2024 at 8:29 AM Johan Hovold <johan+linaro@kernel.org> wrote:

> > +       /* When this quirk is set, the Bluetooth Device Address provided by
> > +        * the 'local-bd-address' fwnode property is incorrectly specified in
> > +        * big-endian order.
> > +        *
> > +        * This quirk can be set before hci_register_dev is called or
> > +        * during the hdev->setup vendor callback.
> > +        */
> > +       HCI_QUIRK_BDADDR_PROPERTY_BROKEN,
> 
> Like with the binding, I feel like
> "HCI_QUIRK_BDADDR_PROPERTY_BACKWARDS" or
> "HCI_QUIRK_BDADDR_PROPERTY_SWAPPED" would be more documenting but I
> don't feel strongly.

So, same reasoning here, this it not some quirk that people should go
around setting without first considering to fix their boot firmware.

Johan

