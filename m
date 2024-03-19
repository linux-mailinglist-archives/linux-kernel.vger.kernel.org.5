Return-Path: <linux-kernel+bounces-107923-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C091188039C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 18:38:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77173282ED9
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 17:38:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E56424B34;
	Tue, 19 Mar 2024 17:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FhpGq69C"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73BFD19BDC;
	Tue, 19 Mar 2024 17:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710869916; cv=none; b=e7yO4h/L8fmWDxroIUM0qmid17v+XCPqlo1PQZvEAxCIg1+i2VTClznjEs7xFkY4XLICDkqYSmjW6szf6igixwLTJORGep/LecaOTWvzT6KqzjYtzB+h78yF+T8POcpp5ygOrblAsJ7kmW0TEXYCWKtFtABVU0rMDXiAM1OZbW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710869916; c=relaxed/simple;
	bh=4vuAWBj1evs6v+OZMqxOpqf/OaE6RssOo2tlPJIKe2o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FBbHb3nfeM5Y/ZwZNvNJO52MK5dNvVsdAY6wmuHFZLsFg7Ua36MpynaYReQNJTxu6/85yVS07Ifwxh4IvH+MK5mQzUbSWyiF5CUkFl7DAEnN1EBJaBMLg8EqXJ+bI3KmJyFIfb5fLbLD5TMlLn95UnSjEaukTu0MgHKwBeKpv6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FhpGq69C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00477C433F1;
	Tue, 19 Mar 2024 17:38:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710869916;
	bh=4vuAWBj1evs6v+OZMqxOpqf/OaE6RssOo2tlPJIKe2o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FhpGq69CjbpLw7gdlpfimviyUI9rG1eiCMCeg4oRTfRHYiaEvNeWnvg8fB629aLZW
	 AZ81lwqhxnWfbJDM9iuNZ5Kl5VgSgWoIfbkIO/0TdZPrxNElSmJNv1D4NHBr1x3QQd
	 d98gs93XJgtAocflD6uznvPw2sPCqqyu19aSUi6BLS8vDa9pSw7V22D7C0mag/CeXa
	 J+Bwkwx3Dn4Rg02ptndnzDRowRBiznOdoFMON7/tYTQ3gGghhJIQFnLmaFVdaWM7K0
	 tRNrfqA5FYAFZjs861/KJiC57kUwu+d4A5Q5wuYc3cLP7a6wjL6pOW4W69YHBVCwGG
	 HvG5QSe0kw+nQ==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1rmdQA-0000000016b-11LA;
	Tue, 19 Mar 2024 18:38:42 +0100
Date: Tue, 19 Mar 2024 18:38:42 +0100
From: Johan Hovold <johan@kernel.org>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Doug Anderson <dianders@chromium.org>,
	Johan Hovold <johan+linaro@kernel.org>,
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
	linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v3 2/5] Bluetooth: add quirk for broken address properties
Message-ID: <ZfnNoi4ahVlzHvvo@hovoldconsulting.com>
References: <20240319152926.1288-1-johan+linaro@kernel.org>
 <20240319152926.1288-3-johan+linaro@kernel.org>
 <CAD=FV=VUFodCAXEJgfpSqZZdtQaw5-8n_-sX_2p6LuQ2ixLRpQ@mail.gmail.com>
 <Zfm8nifvqb3xO5HG@hovoldconsulting.com>
 <CAA8EJprp89VgFMjHv=EynROUs632CfQPbEka0GAcEAy743EMaA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAA8EJprp89VgFMjHv=EynROUs632CfQPbEka0GAcEAy743EMaA@mail.gmail.com>

On Tue, Mar 19, 2024 at 07:01:57PM +0200, Dmitry Baryshkov wrote:
> On Tue, 19 Mar 2024 at 18:26, Johan Hovold <johan@kernel.org> wrote:
> >
> > On Tue, Mar 19, 2024 at 09:10:23AM -0700, Doug Anderson wrote:
> > > On Tue, Mar 19, 2024 at 8:29 AM Johan Hovold <johan+linaro@kernel.org> wrote:
> >
> > > > +       /* When this quirk is set, the Bluetooth Device Address provided by
> > > > +        * the 'local-bd-address' fwnode property is incorrectly specified in
> > > > +        * big-endian order.
> > > > +        *
> > > > +        * This quirk can be set before hci_register_dev is called or
> > > > +        * during the hdev->setup vendor callback.
> > > > +        */
> > > > +       HCI_QUIRK_BDADDR_PROPERTY_BROKEN,
> > >
> > > Like with the binding, I feel like
> > > "HCI_QUIRK_BDADDR_PROPERTY_BACKWARDS" or
> > > "HCI_QUIRK_BDADDR_PROPERTY_SWAPPED" would be more documenting but I
> > > don't feel strongly.
> >
> > So, same reasoning here, this it not some quirk that people should go
> > around setting without first considering to fix their boot firmware.
> 
> The address can be considered broken in many different ways. The name
> should still be descriptive enough. If you want to specify that it is
> a broken behaviour, please consider something like BROKEN_BE.

I doubt that Qualcomm will be able come up with another way to break the
address property. They'd have to try real hard.

And this is an internal define which can be changed at any time. There's
also some worth in keeping it aligned with the DT property, which I'm
more open to renaming (e.g. if the DT maintainers thinks dropping the
vendor prefix makes sense).

The alternative I considered but rejected was something like
"local-bd-address-be" as that would be too neutral.

Perhaps "local-bd-address-reversed" would at least signal that something
is backwards, but I still fear that that may be too subtle.

Johan

