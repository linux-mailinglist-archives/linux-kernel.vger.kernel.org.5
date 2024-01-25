Return-Path: <linux-kernel+bounces-38404-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 150D783BF10
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 11:39:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C060A1F241C8
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 10:39:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF6D11CD1D;
	Thu, 25 Jan 2024 10:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="b3+gBlDX"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A348F1CAB8;
	Thu, 25 Jan 2024 10:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706179159; cv=none; b=RUvvQYOo2KgmhylRY7RXnVGHopFy/1d7KK+OSjrOBNc0TLemP/ipamn5AzLO382tVxAcJmAAn9zv+wuB8KKUNORjlKM9/e6Yzp/wClVuP3DS6krJvdjSo5n6H8NArCkEF7P+cMxdURsSlGg8bj4+zBX70PbPY/7mEVdt+6d/Tvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706179159; c=relaxed/simple;
	bh=1SIXC4wWYaFLAPwdkKFjp65vXY1gVmwuEvMvTcck4G0=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qpvytln082bMY8U5uzSQ8gB8in8GzHKnfbRRCsi0tYH7JY5c3faWp/G5fwHYNshaNodrXDYFuGfywSQPrAb9q+UVQkJuiyRx7lZYj6vWZReE8AzbS+X62KPpajgcc0HMlnbPlKR0ot6XfBS+G9pH19cRh8NdcR3PyWd4MjuHcT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=b3+gBlDX; arc=none smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40P5AAgS030847;
	Thu, 25 Jan 2024 04:38:57 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	date:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=PODMain02222019; bh=H+pywFxcGO3YzfU
	rAAIpNM2vOQO6zCM1bhi8m27y6OI=; b=b3+gBlDXeNI33HTb3T7utPWf75UcvTs
	ZcP/BhOpa3V4+/1KG2aJyhJmonJrkg58ulrc3GIVe4IVnfvBgY+Lox1KAI5JisQZ
	3b8JM2obfJM4NwlhRimVpm5BIoKJwxQ8WkYJbiWHrReD3jNTTwvK53q4/to2Qrsq
	ixXzNZmnJ0tBc4agwBubW1bNhaNmJACR47haBNshaI4PnGrKytTXJGGT7aHEnwcq
	y7UamTq69F0kQ+sPr/N7LOuKbnexmfPuOe9AwibpexoZATYkP67Q7C/b1PTV1G+k
	mm+nux6AVYhCUDatO6NJuqJP/k/tOfKBSSFfQEKidf2uiaZ2ktIvQ8g==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3vtmfhj3tc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Jan 2024 04:38:57 -0600 (CST)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 25 Jan
 2024 10:38:55 +0000
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 ediex01.ad.cirrus.com (198.61.84.80) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40 via Frontend Transport; Thu, 25 Jan 2024 10:38:55 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPS id 21112820246;
	Thu, 25 Jan 2024 10:38:55 +0000 (UTC)
Date: Thu, 25 Jan 2024 10:38:54 +0000
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: Rob Herring <robh@kernel.org>
CC: Richard Fitzgerald <rf@opensource.cirrus.com>,
        Linus Walleij
	<linus.walleij@linaro.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Avi
 Fishman" <avifishman70@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        "Tali
 Perry" <tali.perry1@gmail.com>,
        Patrick Venture <venture@google.com>, "Nancy
 Yuen" <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Jonathan
 =?iso-8859-1?Q?Neusch=E4fer?= <j.neuschaefer@gmx.net>,
        <patches@opensource.cirrus.com>, <alsa-devel@alsa-project.org>,
        <linux-gpio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <openbmc@lists.ozlabs.org>
Subject: Re: [PATCH 1/2] dt-bindings: pinctrl: Unify "input-debounce" schema
Message-ID: <ZbI6PrrQsVDIjt69@ediswmail9.ad.cirrus.com>
References: <20240124190106.1540585-1-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240124190106.1540585-1-robh@kernel.org>
X-Proofpoint-ORIG-GUID: 8iYiuE_6G63A78QKjJlEqxQHoZze71Jp
X-Proofpoint-GUID: 8iYiuE_6G63A78QKjJlEqxQHoZze71Jp
X-Proofpoint-Spam-Reason: safe

On Wed, Jan 24, 2024 at 01:01:04PM -0600, Rob Herring wrote:
> nuvoton,npcm845-pinctrl defines the common "input-debounce" property as
> an array rather than an scalar. Update the common definition to expand
> it to an uint32-array, and update all the users of the property with
> array constraints.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  Documentation/devicetree/bindings/pinctrl/cirrus,madera.yaml   | 3 ++-

Reviewed-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles

