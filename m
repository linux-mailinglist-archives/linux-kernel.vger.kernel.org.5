Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEEC0807434
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 16:58:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379445AbjLFP6n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 10:58:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379459AbjLFP6m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 10:58:42 -0500
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52C5D112
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 07:58:48 -0800 (PST)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3B6FweJT006911;
        Wed, 6 Dec 2023 09:58:40 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1701878320;
        bh=H/XPoJK46VKvEZPO7w09G67Hz1ujtLsZEgmehZzXbG8=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=Xl7v4SrtaPvgArNjfYEfCVu51ELKDB3joy3VWjkFfsUJ/rY+uDoWoeNuIFXWBgmNp
         /2HF0wPBZ0ozsFKmabOT4TbKFJP+h2qMVfk0AZpfkqWvyQHrkeHr7N3rkkblvieRmb
         LeLujccXrTqCCPeGP5YwbaQ5xI7HOI2ulPECuGWY=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3B6Fwea1072174
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 6 Dec 2023 09:58:40 -0600
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 6
 Dec 2023 09:58:39 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 6 Dec 2023 09:58:39 -0600
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3B6FwdE7002908;
        Wed, 6 Dec 2023 09:58:39 -0600
From:   Nishanth Menon <nm@ti.com>
To:     <ssantosh@kernel.org>, <t-konduru@ti.com>,
        Neha Malcom Francis <n-francis@ti.com>
CC:     Nishanth Menon <nm@ti.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <u-kumar1@ti.com>
Subject: Re: (subset) [PATCH v3 0/3] Revamp k3-socinfo driver
Date:   Wed, 6 Dec 2023 09:58:37 -0600
Message-ID: <170187817080.1997.17836327731857780198.b4-ty@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231016101608.993921-1-n-francis@ti.com>
References: <20231016101608.993921-1-n-francis@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Neha Malcom Francis,

On Mon, 16 Oct 2023 15:46:05 +0530, Neha Malcom Francis wrote:
> k3-socinfo driver doesn't account for difference series of silicon
> revisions instead of the typical 1.0, 2.0 etc case. This exception is
> currently already seen in J721E. This series aims to modify the driver
> to account for those exceptions as well as clean things up a bit.
> 
> Changes since v2:
> 	- Nishanth:
> 		- update commit message
> 		- move from double Signed-off-by to Co-developed-by
> 		- make j721e_rev_string_map[] a const char
> 		- drop k3_rev_string_map[] and continue using old
> 		  "variant++" logic for the typical cases
> 		- appropriate error handling with no overrides
> 		  distinguishing between ENODEV and ENOMEM
> 		- add patch for error handling initial cleanup
> 		- reorder patches
> 
> [...]

I have applied the following to branch ti-drivers-soc-next on [1].
Thank you!

[3/3] soc: ti: k3-socinfo: Revamp driver to accommodate different rev structs
      commit: 3ba080bf46e4a9039d0d41356f4a2515e00bf747

The networking dependency previously identified has been sorted out
and available in linux-next[2] since next-20231206. So, this is a good
time for us to merge the patch that I have been keeping held up. At least
on my local scan, I don't see any other in-tree driver impacted by this.

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
[2] https://lore.kernel.org/all/20231201132033.29576-1-r-gunasekaran@ti.com/
-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D

