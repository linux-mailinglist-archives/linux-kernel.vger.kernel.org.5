Return-Path: <linux-kernel+bounces-91696-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 96939871554
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 06:39:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0DD3FB20ACA
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 05:39:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB56C5D738;
	Tue,  5 Mar 2024 05:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="taBipomW"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7610CAD5E;
	Tue,  5 Mar 2024 05:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709617153; cv=none; b=i5/jy9fu2ErU6ntdM9c6qLOoDxl3pO8Xfo5Um+YIUk5kJf/Ak0a1IMAP8/eGFbaMBf4duX0OFyNVUMyKePBtyed8Zap/JHHrC9ALnB/bQYnjQud85FULctrPDAUFO5qraI0fnZCfCZh4t02s019XXaOYAU7gG17aihkv6v4DMsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709617153; c=relaxed/simple;
	bh=hUVkvGe/8tYwd184e2oQrO3kaT4UCfnUSnJaMICC4lo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=HfTp48+jWafqkLaDqW1wiVsPSSw2NHlTS3E0h52sXq2KzYkv+rg+kgQ6J9ufEGOzCvF8m+cRH+ZlDpP+tWllqo2RmZndQKttorNOBnuMn577S1naaqugnX8RHHh4zVsGeeReamsiTRurOI373CO8XEgJrL1T2e1MAyH+UqXU/gI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=taBipomW; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4255d1RF096702;
	Mon, 4 Mar 2024 23:39:01 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1709617141;
	bh=DwJ3/VlhfKTDqxCVbaSdIfpNgoltrF9Ybm/F45DIvA8=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=taBipomWQpH+mQL2Ill8HvrEMJZnSkqwjW4inwB9qpafQwIT5ixwxosgBq629fP5j
	 nFKf033DjgcpGoMapFtxUgOI8/SXuztUbmNS85uhINCjYsIadx5NIqJ7AGXgp8gXKZ
	 C/9luxvUnJJ07JMXoKwyoJ54EAKlrVYK7bX5RPms=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4255d1nX076610
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 4 Mar 2024 23:39:01 -0600
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 4
 Mar 2024 23:39:00 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 4 Mar 2024 23:39:00 -0600
Received: from [172.24.227.68] (dhruva.dhcp.ti.com [172.24.227.68])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4255cuZP048092;
	Mon, 4 Mar 2024 23:38:56 -0600
Message-ID: <df592e1c-30b5-4df5-a4cd-26d1ec266c06@ti.com>
Date: Tue, 5 Mar 2024 11:08:55 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: opp: drop maxItems from inner items
Content-Language: en-US
To: David Heidelberg <david@ixit.cz>, Viresh Kumar <vireshk@kernel.org>,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Manivannan Sadhasivam
	<manivannan.sadhasivam@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>
CC: Viresh Kumar <viresh.kumar@linaro.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski@linaro.org>,
        <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20240304234328.382467-1-david@ixit.cz>
From: Dhruva Gole <d-gole@ti.com>
In-Reply-To: <20240304234328.382467-1-david@ixit.cz>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi,

On 05/03/24 05:13, David Heidelberg wrote:
> With recent changes within matrix dimensions calculation,
> dropping maxItems: 1 provides a warning-free run.
> 
> Fixes warning such as:
> arch/arm64/boot/dts/qcom/sdm845-oneplus-enchilada.dtb: opp-table: opp-200000000:opp-hz:0: [200000000, 0, 0, 150000000, 0, 0, 0, 0, 300000000] is too long
> 
> Fixes: 3cb16ad69bef ("dt-bindings: opp: accept array of frequencies")
> Suggested-by: Rob Herring <robh@kernel.org>
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---
>   follow-up of https://lore.kernel.org/lkml/20231229191038.247258-1-david@ixit.cz/T/
> 
>   Documentation/devicetree/bindings/opp/opp-v2-base.yaml | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/opp/opp-v2-base.yaml b/Documentation/devicetree/bindings/opp/opp-v2-base.yaml
> index e2f8f7af3cf4..b1bb87c865ed 100644
> --- a/Documentation/devicetree/bindings/opp/opp-v2-base.yaml
> +++ b/Documentation/devicetree/bindings/opp/opp-v2-base.yaml
> @@ -57,8 +57,6 @@ patternProperties:
>             specific binding.
>           minItems: 1
>           maxItems: 32
> -        items:
> -          maxItems: 1

Thanks for the fix,

Reviewed-by: Dhruva Gole <d-gole@ti.com>

-- 
Thanks and Regards,
Dhruva Gole

