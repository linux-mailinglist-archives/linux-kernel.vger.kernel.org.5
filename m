Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADA067E70D8
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 18:52:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344890AbjKIRwM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 12:52:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344884AbjKIRwH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 12:52:07 -0500
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94ABA3A86;
        Thu,  9 Nov 2023 09:52:05 -0800 (PST)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3A9Hq0hv024616;
        Thu, 9 Nov 2023 11:52:00 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1699552320;
        bh=5uOTxlYJS8MKhrUcUPhByjmbsu/a445xJkB8+qsp8GI=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=JVusmdSdav3/3Cik+gbFqmx+AEt5MrDoSqk+c+fvN/WVXubztZVToukz0LmyTBqNv
         WGE3XIc8eNvbb2xa3h0xnMUtQhaZco24f4AhPc6uxSZ8CK5JCAGOskweOgfrtzc9/m
         /99YufiVrkWKs/+CifH+P/UtqBpeFNWDd5YzX8iI=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3A9Hq0Yi038288
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 9 Nov 2023 11:52:00 -0600
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 9
 Nov 2023 11:51:59 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 9 Nov 2023 11:52:00 -0600
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3A9Hpx4u031373;
        Thu, 9 Nov 2023 11:51:59 -0600
Date:   Thu, 9 Nov 2023 11:51:59 -0600
From:   Nishanth Menon <nm@ti.com>
To:     =?utf-8?Q?Jo=C3=A3o_Paulo_Silva_Gon=C3=A7alves?= 
        <joao.goncalves@toradex.com>
CC:     "faiz_abbas@ti.com" <faiz_abbas@ti.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: Re: SDHCI AM654 driver delaying boot time
Message-ID: <20231109175159.wylup6z45h7mgxji@clump>
References: <0e81af80de3d55e72f79af83fa5db87f5c9938f8.camel@toradex.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0e81af80de3d55e72f79af83fa5db87f5c9938f8.camel@toradex.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18:56-20231108, João Paulo Silva Gonçalves wrote:
> Hello all, 
> 
> We are trying to minimize boot time for our AM62 devices. Unfortunately, we have identified a delay of approximately 1.5 seconds caused by the
> sdhci_am654 driver. This delay is a result of a timeout within the driver (MAX_POWER_ON_TIMEOUT) and was introduced in commit 7ca0f16 ("mmc:
> sdhci_am654: Add workaround for card detect debounce timer"). This issue arises only when there is no SD card present in the MMC slot.  We tested the
> driver with a lower timeout value and everything worked. However, as indicated in the commit message, this timeout may be related to the way the sdhci
> controller hardware IP works. Currently, the driver employs a sort of a "busy loop" to wait for this timeout to pass delaying the boot. Why is
> need to busy loop for this timeout? Is it possible to wait for it in the backgroud? Am I am missing something here? 

I am not an mmc expert, but, Isn't this sequence part of the programmer
manual in the TRM[1]? Either way, one additional issue I did end up with
when I was doing beagleplay[2] was when i booted off emmc and runtime PM
disabled SD/MMC interface, the MMC IP's CD mode would'nt work since the
IP isn't clocked. So I switched the mux mode to GPIO to use mmc CD
there. I haven't timed that approach where
SDHCI_AM654_QUIRK_FORCE_CDTEST would get set.

[1] https://www.ti.com/lit/pdf/spruiv7
[2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts#n835
-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
