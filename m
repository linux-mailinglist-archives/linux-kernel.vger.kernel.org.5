Return-Path: <linux-kernel+bounces-167323-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B3678BA7E2
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 09:36:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA66B2820C4
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 07:36:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D0051474BF;
	Fri,  3 May 2024 07:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=richtek.com header.i=@richtek.com header.b="zgH0Y8RL"
Received: from mg.richtek.com (mg.richtek.com [220.130.44.152])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5802B146D5B
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 07:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.130.44.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714721759; cv=none; b=XVprmk+5TWBRuoCp1cj44AjnHfCeL1jOBhSS+cJ2MCB9jZE29a9jT3oj1vXbYfH3um/z6gepEmRrSzzBSBe3Hm4tXHbxlxlQl1fpeCXGU0glc4b8Ym9wLs8CFFAZHZLcdegZJX16/3BVUT0oIptt6Q9KwzxFlTWknpvYSsIhy9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714721759; c=relaxed/simple;
	bh=5Rs3pBpzgm60FTVaM6YXseZbN560iglv7RG+Vh9AXrw=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qUEfEYFXYx859RTCdM3DITLM+klInqRw1aW0DaJiSFQGlR7sTidGcASsqgatqpR2K0BF3INC69jNklmr4aZ0jawldCXB2ZvqMG9fiSPL6C29ViyllLLEy+5pMgn9zmfZSQBoOTrteP9L254OLyOoR54vHMIkJfi0RX2fZAWlbgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=richtek.com; spf=pass smtp.mailfrom=richtek.com; dkim=pass (2048-bit key) header.d=richtek.com header.i=@richtek.com header.b=zgH0Y8RL; arc=none smtp.client-ip=220.130.44.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=richtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=richtek.com
X-MailGates: (SIP:2,PASS,NONE)(compute_score:DELIVER,40,3)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=richtek.com;
	s=richtek; t=1714721749;
	bh=10xZCuql4TPgrgP4qz5sC2A8B87AtLlLXWNSC/pTUbw=; l=1345;
	h=Date:From:To:Subject:Message-ID:MIME-Version;
	b=zgH0Y8RLTIq7autOsJqemXRl/P/UHs1PqkozOKhB8zn0AVXJrSYkwfHjMYJFnIxUL
	 OjT2WxncrGCxORsX+0fH7yJtbG5cj9ltwwyitFLd23/w+ie9Z41y/L/RsxSyYI4NNj
	 W5BwVTmHfNhmObONUoLdf9qETSe/KsBx+/PyXVj9i+UK0EYedZkbvzm59nHzzRO1f1
	 gmJtmPdARrX1NvDvI8WPimzRgwxlwc1k2NVec9aAncpvEYm+xjTVZxqPcR4jxIFCfw
	 2q3fEVJvK1r25JxShARwbcFsnHF22Oq19y8djxa2d+xEeMhUvk0S+rvLl8m+oDTkEM
	 zW23cy8Dm7mNw==
Received: from 192.168.10.47
	by mg.richtek.com with MailGates ESMTPS Server V6.0(398666:1:AUTH_RELAY)
	(envelope-from <alina_yu@richtek.com>)
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256/256); Fri, 03 May 2024 15:35:37 +0800 (CST)
Received: from ex4.rt.l (192.168.10.47) by ex4.rt.l (192.168.10.47) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 3 May 2024
 15:35:36 +0800
Received: from linuxcarl2.richtek.com (192.168.10.154) by ex4.rt.l
 (192.168.10.45) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 3 May 2024 15:35:36 +0800
Date: Fri, 3 May 2024 15:35:36 +0800
From: Alina Yu <alina_yu@richtek.com>
To: Mark Brown <broonie@kernel.org>
CC: <lgirdwood@gmail.com>, <linux-kernel@vger.kernel.org>,
	<johnny_lai@richtek.com>, <cy_huang@richtek.com>
Subject: Re: [PATCH v2 2/4] regulator: rtq2208: Fix LDO to be compatible with
 both fixed and adjustable vout
Message-ID: <20240503073536.GA12846@linuxcarl2.richtek.com>
References: <cover.1714467553.git.alina_yu@richtek.com>
 <ffeecd61c194df1f7f049bd50cb2bbbad3cf1025.1714467553.git.alina_yu@richtek.com>
 <ZjGmmYWHu-ZQQdIh@finisterre.sirena.org.uk>
 <20240502073029.GA4055@linuxcarl2.richtek.com>
 <20240502092614.GA31518@linuxcarl2.richtek.com>
 <ZjRAsJHn57pZy5UH@finisterre.sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZjRAsJHn57pZy5UH@finisterre.sirena.org.uk>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Fri, May 03, 2024 at 10:41:04AM +0900, Mark Brown wrote:
> On Thu, May 02, 2024 at 05:26:14PM +0800, Alina Yu wrote:
> 
> > For the fixed LDO Vout, it will be set to either 0.9V or 1.2V, which are outside the range of 1.8V to 3.3V.
> > The determination of whether it is fixed or adjustable lies solely with the user.
> > This modification aims to ensure compatibility with the user's application.
> 
> That's a substantail reconfiguration of the regulator, it would be
> better to have an explicit property for these non-standard fixed
> voltages rather than trying to do this using constraints, or at the very
> least have validation that the values being set are supported by the
> hardware.  The code should also be very clear about what is going on.

May I add the 'richtek,use-fix-dvs' property back ?
which is the proerty I add in v1 patch series to let the user determines whether the LDO Vout is fixed or not.

+		fixed_uV = of_property_read_bool(match->of_node, "richtek,use-fix-dvs");
+
+		if (fixed_uV) {
+			desc->n_voltages = 1;
+			desc->fixed_uV = init_data->constraints.min_uV;
+			desc->ops = &rtq2208_regulator_ldo_fix_ops;
+		} else {
+			desc->n_voltages = ARRAY_SIZE(rtq2208_ldo_volt_table);
+			desc->volt_table = rtq2208_ldo_volt_table;
+			desc->ops = &rtq2208_regulator_ldo_adj_ops;
+		}


Thanks,
Alina

