Return-Path: <linux-kernel+bounces-43001-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 025C58409EB
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 16:29:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 994EFB22A02
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 15:29:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 451BA153BDB;
	Mon, 29 Jan 2024 15:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="n/FsBQcO"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 894EC153502;
	Mon, 29 Jan 2024 15:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706542167; cv=none; b=hCl8aoGKykAnc8wIFsGxWDNhCWUzBOBYUguasIxqXrzhwT/e+kTZ/Kmp09jocavdP23wUy+37qvRkvj/aHK7hZxnSzC06ZJvW1SQl71ug1RLK5FFKFRyNiAdUoG/3I4EVkfDQ3++Cd/DztVfVnKzuxEDm/bDO8311cc0Ij7fNh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706542167; c=relaxed/simple;
	bh=temvw+fKuDYFx07W/PqfCRAulSyTIn2NnJqhzpa3B60=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GDtdKdVkDDYZXyf4QehpGk2zwB91dpWMiqDwMZsc47tCCVB/U4xjAhmMrqZ7X9Auw6pulyeK5nb+O3PwbyhVjRPBy3grQ7PzNUjk57jfkBjfOEjosMFIOI14Vy8goUAkmJ/nwXR9qHZtfMXNwmjCG3twps8MjAN/S3OIphfqCtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=n/FsBQcO; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=byNfiL/pkoggyG/+oatuw7eueKrFjxfS3K9FZq27IAg=; b=n/FsBQcOafh31HIhCxKunlMYhY
	BINs0xUg+zirDh74DZomBMBrgPTUg6s+YKFk/eyPkCDp/foDwi2JN6quuX1kkblEZiSbOzXZpnlhP
	4ghCJVX3y19TyJLpl+W3QY5JDnD9jcKr+o01DYgJzsz6Qek3YsJcsL41l1McDcFMbpBY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rUTZP-006OKZ-UE; Mon, 29 Jan 2024 16:29:11 +0100
Date: Mon, 29 Jan 2024 16:29:11 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Jie Luo <quic_luoj@quicinc.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Andy Gross <agross@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
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
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Sergey Ryazanov <ryazanov.s.a@gmail.com>
Subject: Re: [net-next PATCH 0/3] net: mdio-ipq4019: fix wrong default MDC
 rate
Message-ID: <df0e0ddc-4134-41d0-94f4-aba1186f0ede@lunn.ch>
References: <20240124213640.7582-1-ansuelsmth@gmail.com>
 <53445feb-a02c-4859-a993-ccf957208115@quicinc.com>
 <f8a9e328-5284-4f24-be5d-7e9804869ecd@lunn.ch>
 <5d778fc0-864c-4e91-9722-1e39551ffc45@quicinc.com>
 <CAA8EJppUGH1pMg579nJmG2iTHGsOJdgDL93kfOvKofANTGGdHw@mail.gmail.com>
 <65b3ecd7.050a0220.9e26c.0d9e@mx.google.com>
 <cdd0e481-2738-465b-9ef8-b7ab79981fbe@quicinc.com>
 <65b7b565.170a0220.2666a.0d2b@mx.google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <65b7b565.170a0220.2666a.0d2b@mx.google.com>

On Mon, Jan 29, 2024 at 03:25:09PM +0100, Christian Marangi wrote:
> On Mon, Jan 29, 2024 at 09:59:03PM +0800, Jie Luo wrote:
> > 
> > 
> > On 1/27/2024 1:33 AM, Christian Marangi wrote:
> > > On Fri, Jan 26, 2024 at 07:20:03PM +0200, Dmitry Baryshkov wrote:
> > > > On Fri, 26 Jan 2024 at 18:03, Jie Luo <quic_luoj@quicinc.com> wrote:
> > > > > 
> > > > > 
> > > > > 
> > > > > On 1/26/2024 1:18 AM, Andrew Lunn wrote:
> > > > > > > Hi Christian,
> > > > > > > Just a gentle reminder.
> > > > > > > 
> > > > > > > The MDIO frequency config is already added by the following patch series.
> > > > > > > https://lore.kernel.org/netdev/28c8b31c-8dcb-4a19-9084-22c77a74b9a1@linaro.org/T/#m840cb8d269dca133c3ad3da3d112c63382ec2058
> > > > > > 
> > > > > > I admit this version was posted first. However, its embedded in a
> > > > > > patch series which is not making much progress, and i doubt will make
> > > > > > progress any time soon.
> > > > > > 
> > > > > > If you really want your version to be used, please split it out into a
> > > > > > standalone patch series adding just MDIO clock-frequency support, with
> > > > > > its binding, and nothing else.
> > > > > > 
> > > > > >       Andrew
> > > > > 
> > > > > Hi Andrew,
> > > > > We will rework the patch series to include only MDIO frequency related
> > > > > function and frequency dt binding, and post the updated patch series
> > > > > on th/Tuesdae Mondayy of next week. We will work with Christian to
> > > > > ensure he can re-use this patch as well.
> > > > 
> > > > Can you do the other way around: rebase your patches on top of Chritian's work?
> > 
> > Hi Dmitry,
> > Sure, we can take this approach if fine by Andrew as well.
> > 
> > > > 
> > > 
> > > Would be ideal, also I have to send v2 that handle the 802.3 suggested
> > > MDC rate (ready I just need to send after this has been handled).
> > > 
> > > Also I can see some problem with Lui patch where thse divior
> > > value is not reapplied after MDIO reset effectively reverting to the
> > > default value.
> > 
> > Hi Christian,
> > In my version, the divisor is programmed in every MDIO operation and hence I
> > did not add the code to revert to configured value in reset function. But
> > sure. we can program it once during the probe/reset and avoid doing it
> > during read/write ops.
> > 
> > In addition, the MDIO divisor 1, 2 and 4 are not supported by the MDIO
> > hardware block, maybe we can remove these macros to avoid confusion, or add
> > a comment mentioning that these are not supported.
> >
> 
> Hi, thanks for confirming it! In v2 I already changed the logic to start
> looping from divisor 8 and added comments in DT and driver about not
> assuring correct funcionality with those divisor.

Hi Christian

Lets go with your version. Please post V2 whenever you are ready.

Jie, please spend some time reviewing to patches, make any comments
you have, and if everything is O.K, you can add a Reviewed-by:

    Andrew

