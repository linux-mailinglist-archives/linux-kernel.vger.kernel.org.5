Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 417AA76B807
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 16:53:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232087AbjHAOxE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 10:53:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233467AbjHAOw6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 10:52:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 266D9120
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 07:52:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AE301615D8
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 14:52:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D196CC433C8;
        Tue,  1 Aug 2023 14:52:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690901576;
        bh=k+zUUbInWgAaGFlhY5b3G3Dz/8tZF2FuJ6EEu0+1bB4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rwbA/Cn3f2qq4GX+8rl8pY/k/Z0al6XHkWCgB1fT30hoL9V2zqvrxdwLIm+JUf/Oe
         3loHcMsOTRbu01yWY0W+C+vLIpqmpLEAqpYdvpz9vorm1lFuHe1xGIB+lfZqtpwRev
         pHjqqeZ0iujs9neWkhJfIc1OJ5+B8lV3ku/31CK/oISOvSy5lPs1e2Ti3LJRlKQIan
         zFcMPMxc2juY2qHP8jm2qTzhTqHqG1dAFC339/jZ3orz1PuvCmncQtYB0SsLD0hT8W
         0laoATDVaUJJoWIncMyMO7ViPU3W7iFqZsoqFLDufznd4zOjbhT90bZMLttgREtPMu
         Tdsb54ltZoEDA==
Date:   Tue, 1 Aug 2023 15:52:50 +0100
From:   Will Deacon <will@kernel.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, suzuki.poulose@arm.com,
        Sami Mujawar <sami.mujawar@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        James Clark <james.clark@arm.com>, coresight@lists.linaro.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 0/4] coresight: trbe: Enable ACPI based devices
Message-ID: <20230801145249.GG26253@willie-the-truck>
References: <20230801094052.750416-1-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230801094052.750416-1-anshuman.khandual@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 01, 2023 at 03:10:48PM +0530, Anshuman Khandual wrote:
> This series enables detection of ACPI based TRBE devices via a stand alone
> purpose built representative platform device. But as a pre-requisite this
> changes coresight_platform_data structure assignment for the TRBE device.
> 
> This series is based on v6.5-rc4 kernel, is also dependent on the following
> EDK2 changes posted earlier by Sami.
> 
> https://edk2.groups.io/g/devel/message/107239
> https://edk2.groups.io/g/devel/message/107241
> 
> Changes in V2:
> 
> - Refactored arm_spe_acpi_register_device() in a separate patch
> - Renamed trbe_acpi_resources as trbe_resources
> - Renamed trbe_acpi_dev as trbe_dev
> 
> Changes in V1:
> 
> https://lore.kernel.org/all/20230728112733.359620-1-anshuman.khandual@arm.com/
> 
> Cc: Sami Mujawar <sami.mujawar@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
> Cc: Mike Leach <mike.leach@linaro.org>
> Cc: Leo Yan <leo.yan@linaro.org>
> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Cc: James Clark <james.clark@arm.com>
> Cc: coresight@lists.linaro.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org

FYI: if you pass '--cc-cover' to git send-email, it will CC all these
folks on the series, which I think is better when you're reviewing stuff
(I didn't receive patches 3 and 4).

Will
