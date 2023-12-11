Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8128E80CA9C
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 14:16:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343604AbjLKNQN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 08:16:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234350AbjLKNQM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 08:16:12 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA1A8C3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 05:16:18 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49330C433C7;
        Mon, 11 Dec 2023 13:16:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702300578;
        bh=jXM3Fw++iJ3xzfWAPq/6lRIv6SSxDgbBPkDt8nkAY7g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hwdvHRCCgKg8zqgQEhB3H8xTCChRrnHZiFQjqdN97d9dUgveWm7OPNz63BOCO5LKE
         9OvpGkHFRgqxFnuwT+ZwW690oWUR0KkhV+1xOjk/n+u9UXRMtRHExnTHZDu3MvoZhW
         RfkoDSbOmKt9qszpRcSmLIMWPM04FzQVn4JdS50Pbm2iACkVKR9x0jLQ4HZB6YD/Tr
         X78z+D2GpSqf9Cz1Qukwwn401JbRZ/DyrIlV2zJ71XmpVUhAGg0qUiQVdtKJhJruD9
         zCjjtAM5qW38Wy2eokHZXYOFftfa38q+j+kxGfdTxxzCtu9ETSjoX1r6KDQLMdGWGG
         E0VSqQAIm3tWg==
Date:   Mon, 11 Dec 2023 13:16:12 +0000
From:   Will Deacon <will@kernel.org>
To:     Yicong Yang <yangyicong@huawei.com>
Cc:     catalin.marinas@arm.com, sudeep.holla@arm.com,
        linux-arm-kernel@lists.infradead.org, dietmar.eggemann@arm.com,
        gregkh@linuxfoundation.org, rafael@kernel.org,
        jonathan.cameron@huawei.com, prime.zeng@hisilicon.com,
        linuxarm@huawei.com, yangyicong@hisilicon.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/4] Support SMT control on arm64
Message-ID: <20231211131612.GB25681@willie-the-truck>
References: <20231121092602.47792-1-yangyicong@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231121092602.47792-1-yangyicong@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 21, 2023 at 05:25:58PM +0800, Yicong Yang wrote:
> From: Yicong Yang <yangyicong@hisilicon.com>
> 
> The core CPU control framework supports runtime SMT control which
> is not yet supported on arm64. Besides the general vulnerabilities
> concerns we want this runtime control on our arm64 server for:
> 
> - better single CPU performance in some cases
> - saving overall power consumption
> 
> This patchset implements it in the following aspects:
> 
> - implements the basic support in arch_topology driver
> - support retrieve SMT thread number on OF based system
> - support retrieve SMT thread number on ACPI based system
> - select HOTPLUG_SMT for arm64
> 
> Tests has been done on our real ACPI based arm64 server and on
> ACPI/OF based QEMU VMs.
> 
> The patchset is based on v6.7-rc1.
> 
> Change since v3:
> - Fix some build and kconfig error reported by kernel test robot <lkp@intel.com>
> Link: https://lore.kernel.org/linux-arm-kernel/20231114040110.54590-1-yangyicong@huawei.com/
> 
> Change since v2:
> - Detect SMT thread number at topology build from ACPI/DT, avoid looping CPUs
> - Split patches into ACPI/OF/arch_topology path and enable the kconfig for arm64
> Link: https://lore.kernel.org/linux-arm-kernel/20231010115335.13862-1-yangyicong@huawei.com/
> 
> Yicong Yang (4):
>   arch_topology: Support basic SMT control for the driver
>   arch_topology: Support SMT control for OF based system

Looking at the first two patches you have here, they are incredibly trivial
and feel like they'd be better off implemented as the default behaviour in
the core code so that architectures with additional constraints (e.g. x86)
can override that.

Will
