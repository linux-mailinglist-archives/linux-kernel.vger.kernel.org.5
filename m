Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0075676EDE5
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 17:18:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237033AbjHCPSr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 11:18:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237028AbjHCPSo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 11:18:44 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD13930E4;
        Thu,  3 Aug 2023 08:18:38 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 373FIQ7S017819;
        Thu, 3 Aug 2023 10:18:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1691075906;
        bh=oiVeJUXfShI5E8Dwfo1j4zrghe37ahZEJLbuO8Pl8b4=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=Ddtng5itZ8tV6fOnbNiAdym/gwpg3eBN9Bxsd3DWwhu2qy4noj1B3SP+xlEFXMQbm
         KeTJezkWoQCXEQSe/riEGgy44SQJdURRcIX9FK9CJim5MpPhY9vvcVWDyH1+CU+81m
         S33xpbj9qC66U74mSf9u6S9MEVPILsXK1fYBso14=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 373FIQT5090205
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 3 Aug 2023 10:18:26 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 3
 Aug 2023 10:18:24 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 3 Aug 2023 10:18:24 -0500
Received: from [10.250.36.243] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 373FIOUV121536;
        Thu, 3 Aug 2023 10:18:24 -0500
Message-ID: <d90be478-0956-de6a-aeb4-c2038167de39@ti.com>
Date:   Thu, 3 Aug 2023 10:18:23 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH V6 0/4] firmware: ti_sci: Introduce system suspend support
Content-Language: en-US
To:     Dhruva Gole <d-gole@ti.com>, Nishanth Menon <nm@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Praneeth Bajjuri <praneeth@ti.com>,
        Tony Lindgren <tony@atomide.com>, Vibhore <vibhore@ti.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Vignesh R <vigneshr@ti.com>
References: <20230803064247.503036-1-d-gole@ti.com>
From:   Andrew Davis <afd@ti.com>
In-Reply-To: <20230803064247.503036-1-d-gole@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/3/23 1:42 AM, Dhruva Gole wrote:
> Abstract
> ********
> 
> This series introduces necessary ti_sci driver functionality to support
> DeepSleep mode (suspend to mem) on TI K3 AM62x. DeepSleep mode is
> described in section "6.2.4.4 DeepSleep" of the AM62x Technical Reference
> Manual [0].
> 
> Summary
> *******
> 
> This V6 series is a fixup and rebase of the patch series by
> Dave Gerlach [1]. It applies on top of next-20230731.
> 
> The kernel triggers entry to DeepSleep mode through the mem suspend
> transition with the following:
> 
> * At the bootloader stage, one is expected to package the TIFS stub
>    which then gets pulled into the Tightly coupled memory of the Device Mgr
>    R5 when it starts up. If using U-Boot, then it requires tispl.bin to
>    contain the TIFS stub. Refer to ti-u-boot patch [3] for further
>    details. The supported firmware version is from TI Processor SDK
>    >= 09.00 ie. tag 09.00.00.006 from ti-linux-firmware [4].
> 
> * Use a TF-A binary that supports PSCI_SYSTEM_SUSPEND call. This causes
>    system to use PSCI system suspend as last step of mem sleep.

What happens if we do not have this TIFS stub or not using a TF-A that
supports PSCI_SYSTEM_SUSPEND (or mistakenly thinks it does due to firmware
bugs (this is a known issue for AM64, I'm only phrasing it like a hypothetical :)
)), can we safely return if suspend fails here?

Andrew

> 
> * The firmware requires that the OS sends a TISCI_MSG_PREPARE_SLEEP
>    message in order to provide details about suspend, so we must add the
>    ability to send this message. We also add TISCI_MSG_LPM_WAKE_REASON
>    and TISCI_MSG_SET_IO_ISOLATION messages as part of a new PM ops. These
>    messages are part of the TISCI PM Low Power Mode API [2]. (Patch 2)
> 
> * A memory address must be provided to the firmware using the above
>    message, which is allocated and managed by dma_alloc_attrs()
>    and friends. This memory address can be used by the firmware to
>    save necessary context at that physical location in the DDR RAM. (Patch 3)
> 
> * While entering DeepSleep, it's also good to take precautions inorder to
>    prevent any external current from directly entering the internal IPs and
>    potentially damaging them. Hence, we send a ti_sci_cmd_set_io_isolation
>    which essentially tells the DM R5 Firmware to isolate all the I/O's or pads
>    from the IPs that they were connected to in active state. This is also
>    something that is required when for example we want an I/O daisychain wakeup
>    to wake the system from DeepSleep. More on this in the AM62x Processors TRM [0]
>    under section "6.2.4.11 I/O Power Management and Daisy Chaining" (Patch 1)
> 
> * Finally, the ti_sci driver must actually send TISCI_MSG_PREPARE_SLEEP
>    message to firmware with the above information included, which it
>    does during the driver suspend handler when PM_MEM_SUSPEND is the
>    determined state being entered. (Patch 4)
> 
> It currently enables only DeepSleep mode, but even if any additional
> modes are needed to be supported in future, they would not require any
> changes to the TISCI LPM APIs [2]. The enabling of additional modes
> would be done via GenPD changes that is currently in the works.
> 
> Testing:
> *******
> 
> In can be tested with the following branch:
> https://github.com/DhruvaG2000/v-linux/commits/lpm-upstream-6.5
> 
> Tested on SK-AM62B [6] here:
> https://gist.github.com/DhruvaG2000/8410fac048c677c40cd94f5169b5b0b4
> 
> Limitations:
> ************
> 
> Currently, DeepSleep is only supported on SK-AM62B with DDR4.
> Boards with LPDDR part like Beagle Play and AM62x LP have a known FW issue.
> 
> Base commit:
> ************
> 
> commit ec8939156379 (tag: next-20230731) ("Add linux-next specific files for 20230731")
> 
> origin:
> linux-next      https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
> 
> Changelog:
> **********
> 
> v6:
> - Loading of FS Stub from linux no longer needed, hence drop that patch,
> - Drop 1/6 and 5/6 from the previous series [4].
> - Add system suspend resume callbacks which were removed in
> commit 9225bcdedf16297a346082e7d23b0e8434aa98ed ("firmware: ti_sci: Use
> system_state to determine polling")
> - Use IO isolation while putting the system in suspend to RAM
> 
> v5:
> - link [5]
> - Add support (patch 3) for detecting the low power modes (LPM) of the
>    FW/SoC with a recently introduced core TISCI_MSG_QUERY_FW_CAPS message.
> - Use TISCI_MSG_QUERY_FW_CAPS instead of misusing the TISCI_MSG_PREPARE_SLEEP
>    to detect the FW/SoC low power caps (patch 4).
> - Take into account the supported LPMs in ti_sci_prepare_system_suspend()
>    and handle the case when CONFIG_SUSPEND is not enabled (patch 6) that
>    was reported by Roger Quadros and LKP.
> - Pick up Rob Herring's "Reviewed-by" tag for the binding patch.
> 
> v4:
> - Fix checkpacth warnings in patches 2 and 3.
> - Drop the links with anchors in patch 2.
> 
> v3:
> - Fix the compile warnings on 32-bit platforms reported by the kernel
>    test robot in patches (3,5).
> - Pick up Roger's "Tested-by" tags.
> 
> v2:
> - Addressed comments received for v1 series [1].
> - Updated v1 patch 5 to use pm notifier to avoid firmware loading
>    issues.
> - Dropped the reserved region requirement and allocate DMA memory
>    instead. The reserved region binding patch is also removed.
> - Introduce two more TISCI LPM messages that are supported in SysFW.
> - Fixes in error handling.
> 
> References:
> ***********
> 
> [0] https://www.ti.com/lit/pdf/spruiv7
> [1] https://lore.kernel.org/lkml/20220421203659.27853-1-d-gerlach@ti.com
> [2] https://software-dl.ti.com/tisci/esd/latest/2_tisci_msgs/pm/lpm.html
> [3] https://git.ti.com/cgit/ti-u-boot/ti-u-boot/commit/?h=ti-u-boot-2023.04&id=91886b68025c7ad121e62d1fc1fa4601eeb736cd
> [4] https://git.ti.com/cgit/processor-firmware/ti-linux-firmware/commit/?h=ti-linux-firmware-next&id=905eb58564581d951d148f45828e8c8a142a5938
> [5] https://lore.kernel.org/all/20221128140522.49474-1-g-vlaev@ti.com/
> [6] https://www.ti.com/tool/SK-AM62B
> 
> 
> Cc: Vibhore <vibhore@ti.com>
> Cc: Kevin Hilman <khilman@baylibre.com>
> Cc: Vignesh R <vigneshr@ti.com>
> Cc: Tony Lindgren <tony@atomide.com>
> 
> Dave Gerlach (2):
>    firmware: ti_sci: Introduce Power Management Ops
>    firmware: ti_sci: Allocate memory for Low Power Modes
> 
> Dhruva Gole (1):
>    firmware: ti_sci: Introduce system suspend resume support
> 
> Georgi Vlaev (1):
>    firmware: ti_sci: Add support for querying the firmware caps
> 
>   drivers/firmware/ti_sci.c              | 336 +++++++++++++++++++++++++
>   drivers/firmware/ti_sci.h              |  90 ++++++-
>   include/linux/soc/ti/ti_sci_protocol.h |  44 ++++
>   3 files changed, 469 insertions(+), 1 deletion(-)
> 
