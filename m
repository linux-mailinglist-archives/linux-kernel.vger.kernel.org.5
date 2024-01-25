Return-Path: <linux-kernel+bounces-39027-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0230683C9D2
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 18:20:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33AC61C212F3
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 17:20:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A67E8134722;
	Thu, 25 Jan 2024 17:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="gZfblozP"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34FDB1339A7;
	Thu, 25 Jan 2024 17:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706203147; cv=none; b=YELtbdovwVAGvpZXkbnh6BN3i4WfD5xLDLIBEJ/CVFVkvMF4vxyIM6slpTumb3WD1B+vKmyEOijxKvl9zEOvsQDDlZM7Dyce3ioaXeJQ4guZ3IW73/YuAompAeUmwfMCmnjJqi4I/xwboB0+DHH8NrXBIIpCViVmIihCw2fmKNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706203147; c=relaxed/simple;
	bh=ZjQiJUD24nK5yX7jLn5kVfmejt7+puip5A0lhvRJGWI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mVHiVt+lxklw5dm4D96sG4iYy32vyeCraSBI0iGZ+tMJU3B6IdAxdMRdmEwSdJexG/qJOQ43VgPqLEzxxlokbVC/j9lER535an2iptOu6Qsm/aq7nC/3M8IG2fEaASJE4H0yaPJmMhZNi37KwTfqRbtlGDYYvDrGQkO++WRBZGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=gZfblozP; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=SobXRVHM72b9LQv0v2wnfJmsjZXWoOULHbE1NnVnurI=; b=gZfblozPLOIAX4kP5pJhuUXXNR
	oXH816gdCS+5KV3WLxQf4tMfJWiKyqRb9KTjxI7XM1QteKNiYWHKLIRHqUcXatVdNDvQq4R07JCiz
	3fKd5ptruoYBJ7mXYj6MDNdEnpS67SOLXQgvy38QI65JLlui09SiOtgU7uMoIECbkEZI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rT3NO-0066c3-S5; Thu, 25 Jan 2024 18:18:54 +0100
Date: Thu, 25 Jan 2024 18:18:54 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Jie Luo <quic_luoj@quicinc.com>
Cc: Christian Marangi <ansuelsmth@gmail.com>,
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
Message-ID: <f8a9e328-5284-4f24-be5d-7e9804869ecd@lunn.ch>
References: <20240124213640.7582-1-ansuelsmth@gmail.com>
 <53445feb-a02c-4859-a993-ccf957208115@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <53445feb-a02c-4859-a993-ccf957208115@quicinc.com>

> Hi Christian,
> Just a gentle reminder.
> 
> The MDIO frequency config is already added by the following patch series.
> https://lore.kernel.org/netdev/28c8b31c-8dcb-4a19-9084-22c77a74b9a1@linaro.org/T/#m840cb8d269dca133c3ad3da3d112c63382ec2058

I admit this version was posted first. However, its embedded in a
patch series which is not making much progress, and i doubt will make
progress any time soon.

If you really want your version to be used, please split it out into a
standalone patch series adding just MDIO clock-frequency support, with
its binding, and nothing else.

    Andrew

