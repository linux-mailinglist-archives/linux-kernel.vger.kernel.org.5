Return-Path: <linux-kernel+bounces-107487-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CF64A87FD37
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 12:57:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 881E7283EA3
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 11:57:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6E417F488;
	Tue, 19 Mar 2024 11:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="kyytB6fI"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60D867F478;
	Tue, 19 Mar 2024 11:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710849462; cv=none; b=C/rIzsGu7ujBsqlibZnBvv5rylv4WYV92+8kKcFxwrueHKyUUBSbyS2PTzceLII8B/BDyGE7BgbHzA5yCNS6VwF+yCR1M4dVaq4r3rcOnLi9TlztHZRVO8UgkEL7al3T0uW94BN62/WMRPJAld8sBa6Fy/O5QSqCXipc3bvi9iY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710849462; c=relaxed/simple;
	bh=28mo+Pumh+euM0mDfTjHNX4tVJ9906A8vXXWwcWIJ7c=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gTGjJbBuZFkACBU4mQLVqFVKlVLr3mxqHurhv1HDy2F1kVrjnqFa5AQZ/3hh3m2QCP6VMBnOoOq3cBZms/n8Zb7sR0KMbyXH3pWMFZa4jIwl6MaOst57Yrxe4sMXOckqneParl9FriPgXUyVbtwMUEsWgWAYWH9UAn1FvGrJUeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=kyytB6fI; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 42JBvTTR098599;
	Tue, 19 Mar 2024 06:57:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1710849449;
	bh=46qHcvzcpxC2ekbJbhwahWjNl/P5cf9ZH6FyroqvWhY=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=kyytB6fID6hpYvU5J2FU1nyCxAu7MMRWjRjc18ZDOZlJU5CmlYziy6FBGOGmN//nJ
	 qLN+2dsz7XDIZkDf9XZLly6H556NXu2iw10MfUO5q6XsfyTkIi8T7wy1mFHQ+zgusR
	 A10uTXZ59HddQM9CgCIDLIx/mAL4Iy1OKqH1Sa6o=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 42JBvT4L122579
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 19 Mar 2024 06:57:29 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 19
 Mar 2024 06:57:28 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 19 Mar 2024 06:57:28 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 42JBvS0K062503;
	Tue, 19 Mar 2024 06:57:28 -0500
Date: Tue, 19 Mar 2024 06:57:28 -0500
From: Nishanth Menon <nm@ti.com>
To: Beleswar Padhi <b-padhi@ti.com>
CC: <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <u-kumar1@ti.com>, <b-kapoor@ti.com>
Subject: Re: [PATCH] arm64: dts: ti: k3-j721e-sk: Add support for multiple
 CAN instances
Message-ID: <20240319115728.sbruyk2l6yvuaqjx@contently>
References: <20240315124728.490331-1-b-padhi@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240315124728.490331-1-b-padhi@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On 18:17-20240315, Beleswar Padhi wrote:
> CAN instance 0 in the mcu domain is brought on the j721e-sk board
> through header J1. Thus, add its respective transceiver 1 dt node to add
> support for this CAN instance.
> 
> CAN instances 0, 5 and 9 in the main domain are brought on the j721e-sk
> board through headers J5, J6 and J2 respectively. Thus, add their
> respective transceivers 2, 3 and 4 dt nodes to add support for these CAN
> instances.
> 
> Signed-off-by: Beleswar Padhi <b-padhi@ti.com>
[..]
>  
> +&mcu_mcan0 {
> +	status = "okay";
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&mcu_mcan0_pins_default>;
> +	phys = <&transceiver1>;

Follow
https://docs.kernel.org/devicetree/bindings/dts-coding-style.html#order-of-properties-in-device-node

> +};
> +
> +&main_mcan0 {
> +	status = "okay";
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&main_mcan0_pins_default>;
> +	phys = <&transceiver2>;
> +};
> +
> +&main_mcan5 {
> +	status = "okay";
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&main_mcan5_pins_default>;
> +	phys = <&transceiver3>;
> +};
> +
> +&main_mcan9 {
> +	status = "okay";
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&main_mcan9_pins_default>;
> +	phys = <&transceiver4>;
> +};
> +
>  &ufs_wrapper {
>  	status = "disabled";
>  };
> -- 
> 2.34.1
> 

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D

