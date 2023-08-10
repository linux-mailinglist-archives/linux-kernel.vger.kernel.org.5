Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 130C2776F75
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 07:18:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232907AbjHJFSn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 01:18:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjHJFSl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 01:18:41 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAD4BE69;
        Wed,  9 Aug 2023 22:18:40 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 37A5IYxE068659;
        Thu, 10 Aug 2023 00:18:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1691644714;
        bh=SPGNxxKPROiLK6upAQsm6TAldhEOEXZ4RF9QOJOvy28=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=a/880agXNfbSjjJA9Cws7p4n10lM6dngwHqtMrLyl2W7MYmhms7ET3T9MAsjLyhXs
         Yi6ZOFSdDM8dfPu39ToFjHTavpvHPti7io6fpTfaBocMLSmPIiX+ssX4GhHfquvdMx
         hvMSI20glKkTyhr2H8do5jMzqpUZ9Gyk/9rjzfiA=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 37A5IYRs119789
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 10 Aug 2023 00:18:34 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 10
 Aug 2023 00:18:33 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 10 Aug 2023 00:18:33 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 37A5IXcJ025712;
        Thu, 10 Aug 2023 00:18:33 -0500
From:   Nishanth Menon <nm@ti.com>
To:     <conor+dt@kernel.org>, <vigneshr@ti.com>,
        <krzysztof.kozlowski+dt@linaro.org>, <robh+dt@kernel.org>,
        <kristo@kernel.org>
CC:     Nishanth Menon <nm@ti.com>, <devicetree@vger.kernel.org>,
        <peter.ujfalusi@gmail.com>, <linux-arm-kernel@lists.infradead.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/2] soc: ti: k3-ringacc: Add additional register regions
Date:   Thu, 10 Aug 2023 00:18:31 -0500
Message-ID: <169164460968.19255.4934036570168892480.b4-ty@ti.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230809175932.2553156-1-vigneshr@ti.com>
References: <20230809175932.2553156-1-vigneshr@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vignesh Raghavendra,

On Wed, 9 Aug 2023 23:29:30 +0530, Vignesh Raghavendra wrote:
> Ringacc on TI K3 SoCs have configuration registers region which is
> usually hidden from Linux and configured via Device Manager Firmware
> APIs. But certain early SWs like bootloader which run before Device
> Manager is fully up would need to directly configure these registers and
> thus require to be in DT description.
> 
> This add bindings for the cfg region and also adds them to DT files.
> Backward compatibility is maintained to existing DT by only mandating
> existing regions to be present and this new region as optional.
> 
> [...]

I have assumed here with Conor's ack that this will flow through TI SoC tree.
Do let me know if that is not the case.

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/2] dt-bindings: soc: ti: k3-ringacc: Describe cfg reg region
      commit: 4f1e869915b7a8c48a0501ad0b102002013a7b7a
[2/2] arm64: dts: ti: k3: Add cfg reg region to ringacc node
      commit: 702110c2be999c1ad354ca6e14e8583ebcea2462

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent up the chain during
the next merge window (or sooner if it is a relevant bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/ti/linux.git
-- 

Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D

