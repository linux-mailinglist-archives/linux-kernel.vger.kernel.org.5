Return-Path: <linux-kernel+bounces-159054-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD9438B28B4
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 21:04:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F14151C21D9E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 19:04:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84AF81514DD;
	Thu, 25 Apr 2024 19:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ufgi97AB"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8EED2D627;
	Thu, 25 Apr 2024 19:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714071840; cv=none; b=YQ+UsTVw12IjAWAzuHC1TBBznoFdnWu7sUwVUkWAdi8U2dP2fsLNy424mAOG+kmEMbiSrCx6uCMJ55AH/Dk4EVzau6W+RUW1IC7ydIAAO1zIBLfP/Afc00lb+WEAmL/38QaCdZF8EU2zy5z5jrFWPvzG8kcmUHycXdNaoUqp61g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714071840; c=relaxed/simple;
	bh=l4wqcIAPZf476EKFqK75oCbeHyiGBYCR7vbC5Cof4UY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=tT1Ldjq8SwT5eKDYmsO7bHw2pmK+4WvhaeTfc5zFbyfN7yk9U0iaG3gOmOKDUR9Go6xYf2TyQoDP2P4o8yczLl6dTwZ0HuhhU5PitAy12mDnyWLIzz9+mCxkuo2NpHEY1rO/wvpRYLKVVPL/F1cRVZWKdCoiaAEYHIrz+nWYesw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=ufgi97AB; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 43PJ3aH2009932;
	Thu, 25 Apr 2024 14:03:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1714071816;
	bh=f/j51iHm9g/xIoVM7pqMu6jNQnAkUZLA+0hNmM4kd8w=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=ufgi97ABTPRoFQWqSbgl/ZZltiQO6o7Qz7UVcJs9tS4YR2rkIijYrE3B3m4F37sPP
	 WrkeVBek2v78cri71IDahZQE9VoKMvH4Q6Zrr6KQ/IFyHWxDGKk0igy4A0qg2ekPCl
	 5jQGafl98XcGxWPBhK6EzM5fEq6rq6D72M0BrH2k=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 43PJ3as2017054
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 25 Apr 2024 14:03:36 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 25
 Apr 2024 14:03:36 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 25 Apr 2024 14:03:36 -0500
Received: from [128.247.81.8] (ula0226330.dhcp.ti.com [128.247.81.8])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 43PJ3aml053300;
	Thu, 25 Apr 2024 14:03:36 -0500
Message-ID: <35e37395-c6d9-42ef-839c-bac47b50f3bf@ti.com>
Date: Thu, 25 Apr 2024 14:03:36 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 1/4] dt-bindings: remoteproc: k3-m4f: Add K3 AM64x SoCs
To: Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>
CC: Nishanth Menon <nm@ti.com>, Bjorn Andersson <andersson@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>, <devicetree@vger.kernel.org>,
        Conor
 Dooley <conor+dt@kernel.org>, Hari Nagalla <hnagalla@ti.com>,
        <linux-kernel@vger.kernel.org>, Tero Kristo <kristo@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        <linux-remoteproc@vger.kernel.org>,
        Vignesh
 Raghavendra <vigneshr@ti.com>,
        <linux-arm-kernel@lists.infradead.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
References: <20240424190612.17349-1-afd@ti.com>
 <20240424190612.17349-2-afd@ti.com>
 <171399099843.670532.4326365049493230346.robh@kernel.org>
 <20240425-herself-brigade-5b6b53dc5133@spud>
Content-Language: en-US
From: Andrew Davis <afd@ti.com>
In-Reply-To: <20240425-herself-brigade-5b6b53dc5133@spud>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On 4/25/24 12:15 PM, Conor Dooley wrote:
> On Wed, Apr 24, 2024 at 03:36:39PM -0500, Rob Herring wrote:
>>
>> On Wed, 24 Apr 2024 14:06:09 -0500, Andrew Davis wrote:
>>> From: Hari Nagalla <hnagalla@ti.com>
>>>
>>> K3 AM64x SoC has a Cortex M4F subsystem in the MCU voltage domain.
>>> The remote processor's life cycle management and IPC mechanisms are
>>> similar across the R5F and M4F cores from remote processor driver
>>> point of view. However, there are subtle differences in image loading
>>> and starting the M4F subsystems.
>>>
>>> The YAML binding document provides the various node properties to be
>>> configured by the consumers of the M4F subsystem.
>>>
>>> Signed-off-by: Martyn Welch <martyn.welch@collabora.com>
>>> Signed-off-by: Hari Nagalla <hnagalla@ti.com>
>>> Signed-off-by: Andrew Davis <afd@ti.com>
>>> ---
>>>   .../bindings/remoteproc/ti,k3-m4f-rproc.yaml  | 126 ++++++++++++++++++
>>>   1 file changed, 126 insertions(+)
>>>   create mode 100644 Documentation/devicetree/bindings/remoteproc/ti,k3-m4f-rproc.yaml
>>>
>>
>> My bot found errors running 'make dt_binding_check' on your patch:
>>
>> yamllint warnings/errors:
>>
>> dtschema/dtc warnings/errors:
>>
>>
>> doc reference errors (make refcheckdocs):
>> Warning: Documentation/devicetree/bindings/remoteproc/ti,k3-m4f-rproc.yaml references a file that doesn't exist: Documentation/devicetree/bindings/reserved-memory/reserved-memory.yaml
>> Documentation/devicetree/bindings/remoteproc/ti,k3-m4f-rproc.yaml: Documentation/devicetree/bindings/reserved-memory/reserved-memory.yaml
> 
> The file is now in dt-schema:
> https://github.com/devicetree-org/dt-schema/blob/main/dtschema/schemas/reserved-memory/reserved-memory.yaml

So should I use "reserved-memory/reserved-memory.yaml" here, or just
drop this line completely?

Andrew

