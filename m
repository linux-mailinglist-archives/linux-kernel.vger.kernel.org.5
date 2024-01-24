Return-Path: <linux-kernel+bounces-37760-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 324BC83B4DB
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 23:38:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6E347B26306
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 22:38:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEC3713664A;
	Wed, 24 Jan 2024 22:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="vpA42fg/"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 354B5134750;
	Wed, 24 Jan 2024 22:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706135906; cv=none; b=si2OdLl8cLX50Co3X+yeedHMniduhGQqdnGu8Lt/zK6LRh1zaW6/F86MKexRaZCvzpzZXso2yV60RDlyGHjw6ydbPQsHGuOuCa3x9HFHQ1uNwSzNxFKAjLgPD0UOuV4Kz8IPXzQdCA/OCrEcQYtfCH4kUks06nfVNOd0tD3SaWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706135906; c=relaxed/simple;
	bh=DTrll0FOkAbkEqdZ2vp/TWJw7W7v966osQ+uN/3YWkM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X4DCpu+VnnT/MX6mDCd5LKMYu+Oa+zoFrETcPmIjfb68dEp6Fy6kki1qwiMLrELBIYrprQR4/8jfXxYE6uSJLDGSLXu7/TCu6saMMmoBvsxXxpO2hPQdlw8ggahvKRkvD5IqOqWLjO5AXRR6aZ6LksXl+HiP6dqaWwiYk8h/7yU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=vpA42fg/; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=m89aTmxIORDpdqFWg3Gk7PEdhQXgqNhKa+YwoQCM5Dg=; b=vpA42fg/VmuC9/m9LxgKbDN78e
	XQR8plsmgZuKLvoZRHVRlwNXUEVu1QwxxRhXs/TOIJ6MbNDs2rjJjuFVr8u6MqiWJ0kcMtjq1aSSd
	4UxNRiNS30In28+LvoP6DhIo8NGhTZhSS9OPgIfHjMNCV5jub9mnS+bP/oFw3+eHpIJQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rSlss-0062N8-K5; Wed, 24 Jan 2024 23:38:14 +0100
Date: Wed, 24 Jan 2024 23:38:14 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Robert Marko <robert.marko@sartura.hr>,
	linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [net-next PATCH 1/3] dt-bindings: net: ipq4019-mdio: document
 now supported clock-frequency
Message-ID: <9a63b6b1-ecf9-4a9f-9b6a-283367b2a219@lunn.ch>
References: <20240124213640.7582-1-ansuelsmth@gmail.com>
 <20240124213640.7582-2-ansuelsmth@gmail.com>
 <010becc5-51f6-44c1-863e-f5092ca5018c@lunn.ch>
 <65b18ecb.5d0a0220.e8e31.c94c@mx.google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <65b18ecb.5d0a0220.e8e31.c94c@mx.google.com>

On Wed, Jan 24, 2024 at 11:27:20PM +0100, Christian Marangi wrote:
> On Wed, Jan 24, 2024 at 11:23:05PM +0100, Andrew Lunn wrote:
> > > +  clock-frequency:
> > > +    description:
> > > +      The MDIO bus clock that must be output by the MDIO bus hardware, if
> > > +      absent, the default hardware values are used.
> > > +
> > > +      MDC rate is feed by an external clock (fixed 100MHz) and is divider
> > > +      internally. The default divider is /256 resulting in the default rate
> > > +      applied of 390KHz.
> > > +    enum: [ 390625, 781250, 1562500, 3125000, 6250000, 12500000 ]
> > 
> > Hi Christian
> > 
> > 802.3 says the clock should be up to 2.5MHz by default. So the nearest
> > would be 1562500. Please document that if not set, it defaults to
> > this. And make the driver actually default to that.
> >
> 
> As I said, this is very fk up and default value is 390KHz unless anyone
> in the chain sets it (sometime uboot does it but it's not that common...
> default qsdk uboot doesn't do that for example)... Ok I have to change
> this to default to 1562500.

I doubt you will cause any regression by defaulting to 2.5HHz
instead. That is what the standard says it should be. All devices on
the bus should support that.

    Andrew

