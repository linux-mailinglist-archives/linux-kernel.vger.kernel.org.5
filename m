Return-Path: <linux-kernel+bounces-54730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6778984B2FC
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 12:02:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 998641C23676
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 11:02:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1565212E1FC;
	Tue,  6 Feb 2024 11:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kWlnllwj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 473595F561;
	Tue,  6 Feb 2024 11:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707217334; cv=none; b=dJ/emA7RktIMX6F3HhWwCGaodiBHYkJy9jXRP9kzcJLY6bao35147+jAAnsH156O7mfZWTA4yOjyBWyxpVZ+pOteJUjjKdweQIo23ScujVUeGbKCV+2y+004FxWJ+Yp2c4HyF/828Sj7WqlDUla2Pi1fj4kzGuds0WYPbND/hfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707217334; c=relaxed/simple;
	bh=Pg7gzInhVbP+4MJrlr7AIQs7Dl6s73wN7MZFJhlFk0c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nJgyzxQJLK8ML977GrwqLLNPdqzMS4PQ1xXca3r/JcShzfi0enHosPvK35uXoP9ZGbsYzyyOaVhF6UMs5c1/eHROo0GpPIwwSRMyZrBmtpiPIMqeQOJ3biYaQHRwB/SiXMLENi9mgxb0E46Fvcnow/42WImbS2DD9/Rq4BMWYgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kWlnllwj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3105C433C7;
	Tue,  6 Feb 2024 11:02:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707217334;
	bh=Pg7gzInhVbP+4MJrlr7AIQs7Dl6s73wN7MZFJhlFk0c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kWlnllwj4HvBWKZMYXPvtg86jLxACkDEVS/oYnjtGosNHgCx5Z8sXCRYIANIHuZTw
	 RbnA1mWYhJD+if0Gr1/1Po62hwuZmq/DWiXf6odytpmDlOZmJxWJ10/SKZPLNcz9WT
	 uVnhtn/Ni4NaUVaNAfxhqoc+rFP3S92yKhRFMDiwVVzOWU0/IGwSadd6xT18YnWFDE
	 tpBDX5maMq6sFhZGQHaIWlys7EsBiSAlfxae1JRSLwTMRPQ7FOaE0/+vcGaqVY+IBE
	 A/3Md/NymEsRSngtf1ENiD6bwFD2F1eXEz7jGlMB1x/BJdPEg2zbHLicOxgS2HJich
	 UTtkFCDoRtXow==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1rXJDX-000000003MZ-1H39;
	Tue, 06 Feb 2024 12:02:19 +0100
Date: Tue, 6 Feb 2024 12:02:19 +0100
From: Johan Hovold <johan@kernel.org>
To: Bjorn Andersson <andersson@kernel.org>
Cc: Bjorn Andersson <quic_bjorande@quicinc.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Benjamin Tissoires <benjamin.tissoires@redhat.com>,
	Jiri Kosina <jikos@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Johan Hovold <johan+linaro@kernel.org>,
	linux-arm-msm@vger.kernel.org, linux-input@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Konrad Dybcio <konrad.dybcio@somainline.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Rob Herring <robh@kernel.org>
Subject: Re: Re: [PATCH v4 1/3] dt-bindings: HID: i2c-hid: Document
 reset-related properties
Message-ID: <ZcIRuz7ClkMQt8Mf@hovoldconsulting.com>
References: <20240131-x13s-touchscreen-v4-0-39c0f9925d3c@quicinc.com>
 <20240131-x13s-touchscreen-v4-1-39c0f9925d3c@quicinc.com>
 <Zbts-9tRDPcXbhYi@hovoldconsulting.com>
 <luzkdel2hshufku2gjgbsvfhxkmpg5eo6ekythuawaiz6kibvs@lsajkktmetkv>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <luzkdel2hshufku2gjgbsvfhxkmpg5eo6ekythuawaiz6kibvs@lsajkktmetkv>

On Thu, Feb 01, 2024 at 04:08:05PM -0600, Bjorn Andersson wrote:
> On Thu, Feb 01, 2024 at 11:05:47AM +0100, Johan Hovold wrote:
> > On Wed, Jan 31, 2024 at 07:07:26PM -0800, Bjorn Andersson wrote:
 
> > > +  post-reset-deassert-delay-ms:
> > > +    description: Time required by the device after reset has been deasserted,
> > > +      before it is ready for communication.
> > 
> > I know that Rob reluctantly acked this, but re-reading the commit
> > message for the commit that added support for the reset gpio to the
> > driver, and added a comment about this not having been added to the
> > devicetree binding, it becomes obvious that the latter was done on
> > purpose and that we probably should not be adding the
> > 'post-reset-deassert-delay-ms' property after all:
> > 
> > 	For now the new "post-reset-deassert-delay-ms" property is only
> > 	used on x86/ACPI (non devicetree) devs. IOW it is not used in
> > 	actual devicetree files and the same goes for the reset GPIO.
> > 	The devicetree-bindings maintainers have requested properties
> > 	like these to not be added to the devicetree-bindings, so the
> > 	new property + GPIO are deliberately not added to the existing
> > 	devicetree-bindings.
> > 
> > 	2be404486c05 ("HID: i2c-hid-of: Add reset GPIO support to i2c-hid-of")
> > 
> > So perhaps we should just do this properly and add a new compatible
> > property for X13s touchscreen which can be used to determine these
> > delays (e.g. for cases where some default values are insufficient).
> 
> So we should add a new binding, with a device-specific compatible and
> add a reset-gpios only for that (and not the generic hid-over-i2c
> binding), and then in the i2c-hid driver encode the two delays?

Right.

> I can try to rewrite these patches, if you can provide me with a
> compatible.

My X13s doesn't have a touchscreen, but the ACPI tables says "ELAN901C".

You can look at the current binding and work with the HID and DT
maintainers to come up with something appropriate. There is one
device-specific compatible in the DT schema currently:

	wacom,w9013

so something like

	elan,<product>

where <product> is a name for the device with product id 0x901c (or you
use the HID product id directly somehow).

Johan

