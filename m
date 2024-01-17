Return-Path: <linux-kernel+bounces-29119-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E60A83090E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 16:03:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 035CF1F264FF
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 15:03:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AECC21356;
	Wed, 17 Jan 2024 15:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="n1mG+MAt"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5B1420DC9;
	Wed, 17 Jan 2024 15:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705503781; cv=none; b=ShvCXpZcLtuxPV/qPVAu27yNFfvcEoLW/Ss4idR4NUDHajb358FUpjFl5epMmz/9nGYjfLB9dNMejVwE9tKhxHyw84ao5oVo6jDaZB0Y/Al3zyy9sGFY9lVin19ccn0NBA+rpGC4p9KierEzbb5h9O6p+NoPRzO/en8gCV5QHdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705503781; c=relaxed/simple;
	bh=U30tMly9NPtZKE/JLAer7cPf9aPNHRLrxBNVnRZE3JQ=;
	h=Received:DKIM-Signature:Received:Received:Received:Received:Date:
	 From:To:CC:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-EXCLAIMER-MD-CONFIG; b=KIc278C4vxcYdceNYCUMct+pbWSNmtHwrqCLbosKlhDr4Td2A8doRAdiPzAUzovB2RCH5QjhVaTELBizJBaZ/k2IisRF9c7ydH95tIhX8Pw+Ro3oRVpcrrvCEIfO163hirzFLAtRlrKT7usiMltJg0DEnAWump7ERQtWo418kJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=n1mG+MAt; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40HF2ahI038819;
	Wed, 17 Jan 2024 09:02:36 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1705503756;
	bh=4DKlR/XOa60vrF3LRv1+V3xGI1FNo5diw36Qw9hUvYk=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=n1mG+MAtJict0pt9BdpTauvbJuIkiaD9OHne+EyNTqVoouMvoP4mdHBu2qLYyg3yl
	 Dk8xmHYMPK80Aa6uqzrOwCT8uLFaGJN5akUIR0sYYSDtjkhgsjSTmAv1n4iWyCjJaG
	 k1kYvWk59o01beoGg/bGgM/YWkC9YhJbDinXbe2g=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40HF2axQ017179
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 17 Jan 2024 09:02:36 -0600
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 17
 Jan 2024 09:02:35 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 17 Jan 2024 09:02:35 -0600
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40HF2ZrE008378;
	Wed, 17 Jan 2024 09:02:35 -0600
Date: Wed, 17 Jan 2024 09:02:35 -0600
From: Nishanth Menon <nm@ti.com>
To: Wadim Egorov <w.egorov@phytec.de>
CC: Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        Garrett Giordano
	<ggiordano@phytec.com>
Subject: Re: [PATCH 15/16] arm64: dts: ti: phycore*: Clarify GPL-2.0 as
 GPL-2.0-only
Message-ID: <20240117150235.37sw7ec3hegelno3@maturely>
References: <20240110140903.4090946-1-nm@ti.com>
 <20240110140903.4090946-16-nm@ti.com>
 <fb8232b1-9708-4b57-b67c-92ec6ccf9fd0@phytec.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <fb8232b1-9708-4b57-b67c-92ec6ccf9fd0@phytec.de>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On 03:29-20240117, Wadim Egorov wrote:
> Hey Nishanth,
> 
> I am also okay to have our device trees using the additional MIT license.
> 

OK - I can respin the series. I take it that I can retain your Acks.

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D

