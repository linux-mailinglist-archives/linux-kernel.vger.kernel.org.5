Return-Path: <linux-kernel+bounces-75938-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EC34B85F0F1
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 06:30:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29A1E1C21699
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 05:30:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E832F501;
	Thu, 22 Feb 2024 05:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="NyCCma0o"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17DC879CB;
	Thu, 22 Feb 2024 05:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708579793; cv=none; b=d4jCTp+XJRBlY+6GHVTE/IRlpSJ5gU4w1QZryXO7oyZVaS2nU+i/WXctdckg8W90Qk3PihxYnCN9jtVw83SBpRzMXhKaiOHlY1RpXhsaH7dCLozWsP9wGFEGgVfqDLbl+Tj1S47d+HhU66+9U0XQGN0HTXvIzKrCn2aGy5v2kl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708579793; c=relaxed/simple;
	bh=ofLyyiFf7xCRt/r9ZJI7o/EjhAqBQyKKz0lTvUjnpgU=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GSohMEAzi9ePwfZ7oizZBITfqeirR6QtYk3dUXoYGY7Wj/CvURhS7iylwxdv1Mx8Qs3NpoJna6ZIYK+2RvYfMjgUNMICpTYTTqGJssLpWF/cS1bJKu5Nua8SAtACtKdzy09QV09s0wo73T5GhxVkwom0DBJ2Q+hw3LT8j8siIH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=NyCCma0o; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41M5Tbxg005794;
	Wed, 21 Feb 2024 23:29:37 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1708579777;
	bh=KDg485EZWUcOWKS2M9SaXYKG2jmQ06agzR2T0TO5Fhw=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=NyCCma0oYp04XBec/Zz7kXqniIrF5LsPbVMoua0gclBfayzGjCGkxC6GLXggffuUy
	 UolfLbk3upVCXmEJtSxiAg1BHWATCY5PtXrde4n2XgPwguNdQDa40tHYJzLT2dTUof
	 OXMgfGd+S1Dp0nSzYJOjVP5yDOAo/uGPMVnD3Bcw=
Received: from DLEE110.ent.ti.com (dlee110.ent.ti.com [157.170.170.21])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41M5Tbs1010202
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 21 Feb 2024 23:29:37 -0600
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 21
 Feb 2024 23:29:38 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 21 Feb 2024 23:29:37 -0600
Received: from localhost (uda0492258.dhcp.ti.com [172.24.227.9])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41M5TaS6113449;
	Wed, 21 Feb 2024 23:29:37 -0600
Date: Thu, 22 Feb 2024 10:59:36 +0530
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: Andrew Davis <afd@ti.com>
CC: Siddharth Vadapalli <s-vadapalli@ti.com>, <nm@ti.com>, <vigneshr@ti.com>,
        <kristo@kernel.org>, <robh@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>
Subject: Re: [PATCH] arm64: dts: ti: k3-j721e-evm-pcie0-ep: Extend overlay
 for PCIE1 in EP Mode
Message-ID: <7709aff8-869e-4496-a734-702bcefb0993@ti.com>
References: <20240220105006.1056824-1-s-vadapalli@ti.com>
 <415ee6d4-fe26-4582-80f3-9b503d308fdf@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <415ee6d4-fe26-4582-80f3-9b503d308fdf@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On Wed, Feb 21, 2024 at 10:53:14AM -0600, Andrew Davis wrote:
> On 2/20/24 4:50 AM, Siddharth Vadapalli wrote:
> > Update the existing overlay which configures PCIE0 instance of PCIe on
> > J721E-EVM in Endpoint mode of operation, in order to configure PCIE1
> > instance of PCIe as well in Endpoint mode of operation. Hence, change the
> > name of the overlay to reflect its updated functionality.
> > 
> 
> What if I only want PCIe0 to be in EP mode? Why not make a separate
> DTBO for PCIe1, that way I can have one in EP and the other in RC,
> and mix and match as needed.

Thank you for reviewing the patch. I had planned to create a different
overlay initially but felt that I would be asked to combine it with the
existing PCIe0 overlay.. I will create a separate overlay since that
seems to be acceptable and post the v2 patch.

Regards,
Siddharth.

