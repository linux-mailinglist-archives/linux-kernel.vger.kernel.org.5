Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC9A7773DC4
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 18:23:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229638AbjHHQWi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 12:22:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232507AbjHHQUb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 12:20:31 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 557BB93D7;
        Tue,  8 Aug 2023 08:49:05 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 378Dn4Sc092506;
        Tue, 8 Aug 2023 08:49:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1691502544;
        bh=/diXiEy5Rar3GP8DL1v0Kz97W27qEYMY8d8jEN9wuNI=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=xQc13KDzs4rY/5Yh0KhwxXxbTGu21K+p5MPQfIpXeULdCoaHjZ3C7H+tWKqs+R0a/
         mPYU2n776xTrRr9yuKjigGyTYSX2EeQK6t5eKP/GEMnTRBnX7fDvB3OHKaI15O1I7h
         kAGsMc6e+6/GT6gmAtQpO08ULv0a/IqbxsVx8T3Y=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 378Dn4Jp003971
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 8 Aug 2023 08:49:04 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 8
 Aug 2023 08:49:04 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 8 Aug 2023 08:49:03 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 378Dn31e046024;
        Tue, 8 Aug 2023 08:49:03 -0500
Date:   Tue, 8 Aug 2023 08:49:03 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Dhruva Gole <d-gole@ti.com>
CC:     Tero Kristo <kristo@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-omap@vger.kernel.org>,
        "Kevin Hilman" <khilman@baylibre.com>, Vignesh R <vigneshr@ti.com>,
        Georgi Vlaev <g-vlaev@ti.com>
Subject: Re: [PATCH V7 2/4] firmware: ti_sci: Add support for querying the
 firmware caps
Message-ID: <20230808134903.vqrq7wxsgg5id4dj@crewmate>
References: <20230804115037.754994-1-d-gole@ti.com>
 <20230804115037.754994-3-d-gole@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230804115037.754994-3-d-gole@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17:20-20230804, Dhruva Gole wrote:
> From: Georgi Vlaev <g-vlaev@ti.com>
> 
[...]

> +	/*
> +	 * fw_caps 1st bit is used to check Generic capability. Other than
> +	 * that the 1:4 bits are used for various LPM capabilities.
> +	 * The API is buggy on SYSFW 9.00 and below, on some devices.
> +	 * Hence, to avoid any sort of bugs arising due to garbage values
> +	 * Let's allow the fw_caps to be set to whatever the firmware
> +	 * says only on devices listed under has_lpm. These devices should
> +	 * have lpm features tested and implemented in the firmware
> +	 * and only then should they be added to has_lpm struct.
> +	 * Otherwise, set the value to 1 that is the default.
> +	 */
> +	if (fw_caps && soc_device_match(has_lpm))
> +		*fw_caps = resp->fw_caps;
> +	else
> +		*fw_caps = resp->fw_caps & MSG_FLAG_CAPS_GENERIC;

Fix your firmware please. drop the has_lpm stuff.. that is what caps is
for.

As part of ti_sci_setup_ops you get info where you can check ABI version
where this is valid and which is not, ti_sci_msg_cmd_query_fw_caps can
be populated based on that check. That is the reason info is passed to
setup_ops and why we have ABI IDs in the first place.

[...]

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
