Return-Path: <linux-kernel+bounces-66813-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C44A88561C2
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 12:37:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FC39294CD4
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 11:37:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E246212AAE9;
	Thu, 15 Feb 2024 11:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="MX5vMfrw"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73FC312AACF;
	Thu, 15 Feb 2024 11:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707996819; cv=none; b=aSd/wEG89m2DZwxw0KMMkWljwZLr9lByXhAjwy0f1MyUq76kuvTAoNHjvDMSI67wrsHJIRx+DqSKurAbuTdVV8K+Vc87IzYlG6ANh4n12zLrDpaeIZ/1F9nAzEjQMlHbYowx+tADlXHRpgYh4y/ekWaEmRrNC/MtiO2xh594BdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707996819; c=relaxed/simple;
	bh=5Mxr7TMKSWsl11qn4WggocCDFkTw3msUvohOG+7eml4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=KFejLw/Rw06lWHNwpVfm1XCkcT9uotH7fBkl+H1AoLuBdOG/vCDS34z6WqOP9AvFvE6mNSAS6eShXTEAR3BCVlHFcT5SyPADZ84jPyhv8G+KqnuqNw8BziJV5eM54h0phBtM2l0RaYjkr0cbpYaKNHP6Whmu7ggGwOYM1aAC0xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=MX5vMfrw; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41FBX79G107037;
	Thu, 15 Feb 2024 05:33:07 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1707996787;
	bh=ABHkRW2SheIUF0P3f0D9642QH8CsZI9lD6RNSWt1xzU=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=MX5vMfrwGgdQUAUzso/q6iFDNfLD8Je8/6enYBBsOT4e7sYSr012n10tcYu5jGlSZ
	 Z3eERe0CILc0/zUYc/qD8mjQ/cWm2th5c6FnPdnialoX6VopbwEVyE62EJ3Kh7KUEb
	 0ImxEdDURUYM7jHkkuuWlQaExlZXXiVrLeaBOSFY=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41FBX6wS026115
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 15 Feb 2024 05:33:06 -0600
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 15
 Feb 2024 05:33:06 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 15 Feb 2024 05:33:06 -0600
Received: from [172.24.227.31] (uda0496377.dhcp.ti.com [172.24.227.31])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41FBX1NF008649;
	Thu, 15 Feb 2024 05:33:01 -0600
Message-ID: <5c73328c-5a83-4937-aafe-af55d14fcb89@ti.com>
Date: Thu, 15 Feb 2024 17:03:00 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] dt-bindings: display: ti,am65x-dss: Add support
 for common1 region
Content-Language: en-US
To: Devarsh Thakkar <devarsht@ti.com>, <jyri.sarha@iki.fi>,
        <tomi.valkeinen@ideasonboard.com>, <airlied@gmail.com>,
        <daniel@ffwll.ch>, <maarten.lankhorst@linux.intel.com>,
        <mripard@kernel.org>, <tzimmermann@suse.de>, <robh@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>
CC: <praneeth@ti.com>, <j-luthra@ti.com>
References: <20240215083205.2902634-1-devarsht@ti.com>
 <20240215083205.2902634-2-devarsht@ti.com>
From: Aradhya Bhatia <a-bhatia1@ti.com>
In-Reply-To: <20240215083205.2902634-2-devarsht@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180



On 15/02/24 14:02, Devarsh Thakkar wrote:
> TI keystone display subsystem present in AM65 and other SoCs such as AM62
> support two separate register spaces namely "common" and "common1" which
> can be used by two separate hosts to program the display controller as
> described in respective Technical Reference Manuals [1].
> 
> The common1 register space has similar set of configuration registers as
> supported in common register space except the global configuration
> registers which are exclusive to common region.
> 
> This adds binding for "common1" register region too as supported by the
> hardware.
> 
> [1]:
> AM62x TRM:
> https://www.ti.com/lit/pdf/spruiv7 (Section 14.8.9.1 DSS Registers)
> 
> AM65x TRM:
> https://www.ti.com/lit/pdf/spruid7 (Section 12.6.5 DSS Registers)

Can you add the TRM link for AM62A too?

With that sorted,

Reviewed-by: Aradhya Bhatia <a-bhatia1@ti.com>

> 
> Fixes: 2d8730f1021f ("dt-bindings: display: ti,am65x-dss: Add dt-schema yaml binding")
> Signed-off-by: Devarsh Thakkar <devarsht@ti.com>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>> ---
> V2: Add Acked-by tag
> V3: Add Fixes tag
> ---
>  .../devicetree/bindings/display/ti/ti,am65x-dss.yaml       | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/display/ti/ti,am65x-dss.yaml b/Documentation/devicetree/bindings/display/ti/ti,am65x-dss.yaml
> index b6767ef0d24d..55e3e490d0e6 100644
> --- a/Documentation/devicetree/bindings/display/ti/ti,am65x-dss.yaml
> +++ b/Documentation/devicetree/bindings/display/ti/ti,am65x-dss.yaml
> @@ -37,6 +37,7 @@ properties:
>        - description: OVR2 overlay manager for vp2
>        - description: VP1 video port 1
>        - description: VP2 video port 2
> +      - description: common1 DSS register area
>  
>    reg-names:
>      items:
> @@ -47,6 +48,7 @@ properties:
>        - const: ovr2
>        - const: vp1
>        - const: vp2
> +      - const: common1
>  
>    clocks:
>      items:
> @@ -147,9 +149,10 @@ examples:
>                      <0x04a07000 0x1000>, /* ovr1 */
>                      <0x04a08000 0x1000>, /* ovr2 */
>                      <0x04a0a000 0x1000>, /* vp1 */
> -                    <0x04a0b000 0x1000>; /* vp2 */
> +                    <0x04a0b000 0x1000>, /* vp2 */
> +                    <0x04a01000 0x1000>; /* common1 */
>              reg-names = "common", "vidl1", "vid",
> -                    "ovr1", "ovr2", "vp1", "vp2";
> +                    "ovr1", "ovr2", "vp1", "vp2", "common1";
>              ti,am65x-oldi-io-ctrl = <&dss_oldi_io_ctrl>;
>              power-domains = <&k3_pds 67 TI_SCI_PD_EXCLUSIVE>;
>              clocks =        <&k3_clks 67 1>,

