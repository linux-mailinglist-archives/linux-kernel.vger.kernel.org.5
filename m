Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01ED27CB05B
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 18:53:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234386AbjJPQxk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 12:53:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233675AbjJPQx1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 12:53:27 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4773C2EC18
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 09:46:30 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 39GGkL4r083055;
        Mon, 16 Oct 2023 11:46:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1697474781;
        bh=B3wlowVtxoF1zEa5N7rd+sGrJjrJCxVTGqYzXJ9gvVo=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=u86VsHjCG1BT5Cwe/6n+RJJv+RY6cRJNPiuegPmHGC21MsdazXLrayqA+nLrLdcPa
         blI0YnkmOpZt+UUCjLEOBy3tKzI/Cg6d1hwiYC4gJdxS0l3SVSmjLEhBwyP/F65qHV
         NO6mkwGfvx3ECHvCaSWzUAVb1CJNg5urn++Jlgx8=
Received: from DFLE110.ent.ti.com (dfle110.ent.ti.com [10.64.6.31])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 39GGkL4H103096
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 16 Oct 2023 11:46:21 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 16
 Oct 2023 11:46:21 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 16 Oct 2023 11:46:21 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 39GGkLnW007211;
        Mon, 16 Oct 2023 11:46:21 -0500
From:   Nishanth Menon <nm@ti.com>
To:     <ssantosh@kernel.org>, <t-konduru@ti.com>,
        Neha Malcom Francis <n-francis@ti.com>
CC:     Nishanth Menon <nm@ti.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <u-kumar1@ti.com>
Subject: Re: [PATCH v3 0/3] Revamp k3-socinfo driver
Date:   Mon, 16 Oct 2023 11:46:20 -0500
Message-ID: <169747471946.3009008.7592328657238269342.b4-ty@ti.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20231016101608.993921-1-n-francis@ti.com>
References: <20231016101608.993921-1-n-francis@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
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

I have applied the following to branch ti-drivers-soc-next on [1] with minor
fixups.

Thank you!

[1/3] soc: ti k3-socinfo: Fix typo
      commit: 8dec342ead710dace27dc82096144bf7a1011827
[2/3] soc: ti: k3-socinfo: Avoid overriding ret
      commit: 3aeb0d3694e16b5066db82aa1152884f2e6aace0
[3/3] soc: ti: k3-socinfo: Revamp driver to accommodate different rev structs
      commit: 07e651db2d78eac4c41d7144eb5ea734af2328fc

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

