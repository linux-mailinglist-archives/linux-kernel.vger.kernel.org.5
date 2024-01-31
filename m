Return-Path: <linux-kernel+bounces-47270-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64CCD844B2E
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 23:41:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C48B1C262B8
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 22:41:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F97F383A4;
	Wed, 31 Jan 2024 22:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="5OFYTm68"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E4C4364CA;
	Wed, 31 Jan 2024 22:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706740862; cv=none; b=QKFTz+Av7m3SOZj6uQ7hyRls0oGuTfV5PbgMV5fTN+shvn6/sOiEvVoiQ+FvbdnSznGNPe/vhtzHf4xiJ+2Ue83/kkY4qfyxs30uZ50lPfQXMvlnIrOhmTM8H8VQPXvAeA+SlZYIpRMaQUnPXY7zmS87y/pHH8gu9ec69jD4nu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706740862; c=relaxed/simple;
	bh=mTsfTmcgyNMXPcwEfj9zRffg8acVqn20k2Ate8tbaG8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s/k+XIDT5vmp20uHo4j6jJ4C7EKaetFkNQA+n1laUx1ALaW7WH1CyeUkVo6K11Zqhl7wZWjUdzu/adY1KkbS3aNA1bHJxFq2W8vHN6q9xmcpi3R5TqK0RWAHSmYNeJWT/N+qcuwYmVpB+Z9JKNAsSgukVC6INkZf7EMta/VItYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=5OFYTm68; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=1FCD7TewqQtQ/+NDwhbXiuyVwjThunikA4QhpumNVSU=; b=5OFYTm68G0r5vPSoHrEi0vd196
	qULK9+VCXwxp55c7CKayoDKirkf/RjynE6/yXifl8UlN1T4LwuKUxZiy+nI3tLiDk4SPRUIjf7vSn
	0mYoDqsjzdCImnuJGE0TynQCxs3XcQcig6iyjBh8fzaeDUXHBa6Tp9/fAP2ylvjmHOvE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rVJG9-006cek-Iq; Wed, 31 Jan 2024 23:40:45 +0100
Date: Wed, 31 Jan 2024 23:40:45 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Conor Dooley <conor@kernel.org>
Cc: Rob Herring <robh@kernel.org>,
	Bastien Curutchet <bastien.curutchet@bootlin.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Richard Cochran <richardcochran@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Herve Codina <herve.codina@bootlin.com>
Subject: Re: [PATCH 1/2] dt-bindings: net: Add TI DP83640
Message-ID: <a1e54836-51d2-4990-9444-56d9414eb28c@lunn.ch>
References: <20240130085935.33722-1-bastien.curutchet@bootlin.com>
 <20240130085935.33722-2-bastien.curutchet@bootlin.com>
 <20240130-impulsive-widow-9142a069b7fd@spud>
 <20240131210521.GA2289883-robh@kernel.org>
 <20240131-tummy-imperfect-e6d6f0e245e9@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240131-tummy-imperfect-e6d6f0e245e9@spud>

On Wed, Jan 31, 2024 at 09:18:39PM +0000, Conor Dooley wrote:
> On Wed, Jan 31, 2024 at 03:05:21PM -0600, Rob Herring wrote:
> > On Tue, Jan 30, 2024 at 05:56:37PM +0000, Conor Dooley wrote:
> > > On Tue, Jan 30, 2024 at 09:59:34AM +0100, Bastien Curutchet wrote:
> 
> > > > +  ti,fiber-mode:
> > > > +    $ref: /schemas/types.yaml#/definitions/uint32
> > > > +    enum: [0, 1]
> > > > +    description: |
> > > > +      If present, enables or disables the FX Fiber Mode.
> > > > +      Fiber mode support can also be strapped. If the strap pin is not set
> > > > +      correctly or not set at all then this can be used to configure it.
> > > > +       - 0     = FX Fiber Mode disabled
> > > > +       - 1     = FX Fiber Mode enabled
> > > > +       - unset = Configured by straps
> > > 
> > > I don't like these properties that map meanings onto numbers. We can
> > > have enums of strings in bindings that allow you to use something more
> > > meaningful than "0" or "1".
> > 
> > Tristate properties are fairly common pattern where we need 
> > on/off/default. I've thought about making it a type. I don't think we 
> > need defines for it.
> 
> I think a type would be a good idea. I am not at all a fan of any of the
> properties people introduce along these lines.

Before going too far with that, i'm not actually sure it is required
here. I've not looked at the PHY driver itself, but i expect there is
some indication somewhere that the network stack expects a fibre link
is to be used. We probably can determine at runtime if fibre should be
used.

	Andrew

