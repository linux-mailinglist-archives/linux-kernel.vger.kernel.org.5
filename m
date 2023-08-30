Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E02778DFF2
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 22:16:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242932AbjH3TOu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 15:14:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243756AbjH3LmQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 07:42:16 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id ADC401B0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 04:42:13 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E26402F4;
        Wed, 30 Aug 2023 04:42:52 -0700 (PDT)
Received: from [10.163.57.203] (unknown [10.163.57.203])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4C3E33F64C;
        Wed, 30 Aug 2023 04:42:09 -0700 (PDT)
Message-ID: <e4b260cf-e0bd-d593-c630-e3b8e0d11253@arm.com>
Date:   Wed, 30 Aug 2023 17:12:07 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH V6 0/2] coresight: trbe: Enable ACPI based devices
Content-Language: en-US
To:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-arm-kernel@lists.infradead.org, Will Deacon <will@kernel.org>
Cc:     Sami Mujawar <sami.mujawar@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        coresight@lists.linaro.org, linux-kernel@vger.kernel.org
References: <20230829135405.1159449-1-anshuman.khandual@arm.com>
 <76135689-79c3-9845-15ad-847cdac8ac59@arm.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <76135689-79c3-9845-15ad-847cdac8ac59@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/30/23 14:32, Suzuki K Poulose wrote:
> Hi Will
> 
> On 29/08/2023 14:54, Anshuman Khandual wrote:
>> These are remaining coresight patches after fixing the merge conflict which
>> applies on coresight/next coresight-next-v6.6.
>>
>> Changes in V6:
>>
>> - Fixed te merge conflict
>>
> 
> 
> Please could you confirm if the commits [0] in your for-next/perf branch
> are stable ? Accordingly I could merge these patches on top of your
> commits and send them to Greg.
> 
> [0] https://git.kernel.org/will/c/1aa3d0274a4a

Both these patches are already in the mainline kernel.

commit 1aa3d0274a4aac338ee45a3dfc3b17c944bcc2bc
Author: Anshuman Khandual <anshuman.khandual@arm.com>
Date:   Thu Aug 17 11:24:03 2023 +0530

    arm_pmu: acpi: Add a representative platform device for TRBE
    
    ACPI TRBE does not have a HID for identification which could create and add
    a platform device into the platform bus. Also without a platform device, it
    cannot be probed and bound to a platform driver.
    
    This creates a dummy platform device for TRBE after ascertaining that ACPI
    provides required interrupts uniformly across all cpus on the system. This
    device gets created inside drivers/perf/arm_pmu_acpi.c to accommodate TRBE
    being built as a module.
    
    Cc: Catalin Marinas <catalin.marinas@arm.com>
    Cc: Will Deacon <will@kernel.org>
    Cc: Mark Rutland <mark.rutland@arm.com>
    Cc: linux-arm-kernel@lists.infradead.org
    Cc: linux-kernel@vger.kernel.org
    Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
    Link: https://lore.kernel.org/r/20230817055405.249630-3-anshuman.khandual@arm.com
    Signed-off-by: Will Deacon <will@kernel.org>

commit 81e5ee471609848ee1ebf3beb2a46788113fe0eb
Author: Anshuman Khandual <anshuman.khandual@arm.com>
Date:   Thu Aug 17 11:24:02 2023 +0530

    arm_pmu: acpi: Refactor arm_spe_acpi_register_device()
    
    Sanity checking all the GICC tables for same interrupt number, and ensuring
    a homogeneous ACPI based machine, could be used for other platform devices
    as well. Hence this refactors arm_spe_acpi_register_device() into a common
    helper arm_acpi_register_pmu_device().
    
    Cc: Catalin Marinas <catalin.marinas@arm.com>
    Cc: Will Deacon <will@kernel.org>
    Cc: Mark Rutland <mark.rutland@arm.com>
    Cc: linux-arm-kernel@lists.infradead.org
    Cc: linux-kernel@vger.kernel.org
    Co-developed-by: Will Deacon <will@kernel.org>
    Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
    Link: https://lore.kernel.org/r/20230817055405.249630-2-anshuman.khandual@arm.com
    Signed-off-by: Will Deacon <will@kernel.org>
