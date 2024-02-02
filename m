Return-Path: <linux-kernel+bounces-49825-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DAF69847012
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 13:19:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9538628BF2E
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 12:19:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DDFF14078A;
	Fri,  2 Feb 2024 12:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Qp0qpyyA"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7CCF1420D0;
	Fri,  2 Feb 2024 12:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706876320; cv=none; b=R+J2tJ8KTAGi/zBlmFWAjWvsnPY6CcD77K/8e4j+Nc/1vE2GiTN3g0MDE5iAXALr86Q+CdWGFRjNfkf43MV9LZyr4jV6rJ3EMhc+i0B9xXi3Mwh8e5r8enESt81NaHzKdsnNaQIYp22KhZJfRoUjQTTKgbvqfUcTvi/bJCO98BA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706876320; c=relaxed/simple;
	bh=5J3N9yFdt0qyR+hC/ck9sRlxmz3Jz+XJfdzivrX1h6Q=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IZQbIsjA2Unjyt9bdi7O3qJW39d/Kvl4aXoix/a+S/0CjmQEKb68rr4T37W9ssbmVtkUi0NqyhIH0L7u4RQl2rXzimuJB0dzJVp9pWLF+Mk5a11Avdbonq1OZLPZUTC6M2EqnK3//rqaOR0kCnFN9VYIaeR8bJCPkkVDs1DmuxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Qp0qpyyA; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 412CITUO075863;
	Fri, 2 Feb 2024 06:18:29 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1706876309;
	bh=2A3mvVnp1lDZyNg+9zBZp184JjKbFNbozap0vLCz1Zg=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=Qp0qpyyAQiJQ+bEbdd3G1z6IqHg0gabUCxCZI0IS5Bu9GXT2hPliYQCNVUAiXNssR
	 1Eh3IYNilUAdlSNeEEkBIfUCkGqRqH89b0dwZx7UjUhdjY4ai1zALeQexyz6AGKy8Z
	 /jRWO0H3jTnAXjHzczgnP0ZAJmTA41nQvKLM+Yxw=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 412CITHH026341
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 2 Feb 2024 06:18:29 -0600
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 2
 Feb 2024 06:18:29 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 2 Feb 2024 06:18:28 -0600
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 412CISK7096797;
	Fri, 2 Feb 2024 06:18:28 -0600
Date: Fri, 2 Feb 2024 06:18:28 -0600
From: Nishanth Menon <nm@ti.com>
To: Roger Quadros <rogerq@kernel.org>
CC: Conor Dooley <conor.dooley@microchip.com>,
        Conor Dooley
	<conor@kernel.org>, Bin Liu <b-liu@ti.com>,
        <vigneshr@ti.com>, <afd@ti.com>, <kristo@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <srk@ti.com>, <r-gunasekaran@ti.com>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 4/5] dt-bindings: usb/ti,am62-usb.yaml: Add PHY2
 register space
Message-ID: <20240202121828.oo7grngyh2heqdxn@disposal>
References: <20240201120332.4811-1-rogerq@kernel.org>
 <20240201120332.4811-5-rogerq@kernel.org>
 <20240201-viewpoint-upload-fb714f650ff5@spud>
 <20240201-violet-chalice-51a73f113e7b@spud>
 <20240201183522.ssj553rwefr2wuqi@iaqt7>
 <20240201-clad-unopposed-ccfdfe53b770@spud>
 <bc3ab60f-539b-41d0-8595-6e0b55f2763d@kernel.org>
 <20240202-unzip-whacky-bb2f151c618b@wendy>
 <dc3c93dc-74d9-4b1c-a771-3ee6f67b5dcc@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <dc3c93dc-74d9-4b1c-a771-3ee6f67b5dcc@kernel.org>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On 12:13-20240202, Roger Quadros wrote:
[..]
> >>
> >> As DTS and driver will be merged by separate maintainers I thought it
> >> would be easier for maintainers this way.
> > 
> > dts and driver might be merged by different people, but dt-bindings and
> > drivers are merged by the same people. This is a bindings patch, not a
> 
> If we do that then I get a bunch of dtbs_check warnings
> 
> dwc3-usb@f900000: reg: [[0, 261095424, 0, 2048], [0, 261128192, 0, 1024]] is too long

Just my 2 cents: If the binding (and driver) change was truly backward
compatible (which it should be - for example: errata can only be
applied if the second property is described), then you want to control
that reg property to add minItems? - thatm I think will allow the dts
change to come in at the next cycle once the binding has been merged.

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D

