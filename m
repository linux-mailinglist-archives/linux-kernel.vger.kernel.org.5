Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EC7F75CB30
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 17:14:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231853AbjGUPOU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 11:14:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231892AbjGUPOK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 11:14:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36D523A98;
        Fri, 21 Jul 2023 08:14:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 956F161CEC;
        Fri, 21 Jul 2023 15:13:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D02E1C433CB;
        Fri, 21 Jul 2023 15:13:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689952439;
        bh=YwIOYtjQQopxqVMGwCdqHddpY/KN/9YTvyayY+0BD+o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VQfnyRYr4kKWHYGElr6wSyLotg6sRZVYAkK0I0g0P2DMhZLfXuWgmSoPAyFcvoGTP
         GDnUx36TIC1Qk4W8U8EqE1wpbYlzi7sarJWz7X2A+kxTqIdXLyWSZypoW7syHyERN1
         4UaaGhrBAOq6mH6H92vZrEOscjX+ytF3wgYfDYphZ0jPryd6ZB1PElESLAmWlxyfNd
         hX2H+7u6iJ/GnptmNJ5pfOklROZeROVZ5X0EfbmtDCvHjnnWi9kTcMuXPf+Ey0YBDw
         29batj/P5YdkKkhZJeUqnt7s8cJnJf1VpOxpXbLDvY/e0AMTA8dWb19O/Zp2yUApI8
         XUZA7I+pCsSUw==
Date:   Fri, 21 Jul 2023 11:13:57 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Junhao He <hejunhao3@huawei.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Yicong Yang <yangyicong@hisilicon.com>,
        Will Deacon <will@kernel.org>, zhangshaokun@hisilicon.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH AUTOSEL 6.4 11/12] drivers/perf: hisi: Add support for
 HiSilicon H60PA and PAv3 PMU driver
Message-ID: <ZLqgtRcgGqmHUXFM@sashalap>
References: <20230702195057.1787686-1-sashal@kernel.org>
 <20230702195057.1787686-11-sashal@kernel.org>
 <ZKKfjW6Ix9dg11QZ@FVFF77S0Q05N>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <ZKKfjW6Ix9dg11QZ@FVFF77S0Q05N>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 03, 2023 at 11:14:37AM +0100, Mark Rutland wrote:
>On Sun, Jul 02, 2023 at 03:50:56PM -0400, Sasha Levin wrote:
>> From: Junhao He <hejunhao3@huawei.com>
>>
>> [ Upstream commit 1a51688474c0d395b864e98236335fba712e29bf ]
>>
>> Compared to the original PA device, H60PA offers higher bandwidth.
>> The H60PA is a new device and we use HID to differentiate them.
>>
>> The events supported by PAv3 and PAv2 are different. The PAv3 PMU
>> removed some events which are supported by PAv2 PMU. The older PA
>> PMU driver will probe v3 as v2. Therefore PA events displayed by
>> "perf list" cannot work properly. We add the HISI0275 HID for PAv3
>> PMU to distinguish different.
>>
>> For each H60PA PMU, except for the overflow interrupt register, other
>> functions of the H60PA PMU are the same as the original PA PMU module.
>> It has 8-programable counters and each counter is free-running.
>> Interrupt is supported to handle counter (64-bits) overflow.
>>
>> Signed-off-by: Junhao He <hejunhao3@huawei.com>
>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> Reviewed-by: Yicong Yang <yangyicong@hisilicon.com>
>> Acked-by: Mark Rutland <mark.rutland@arm.com>
>> Link: https://lore.kernel.org/r/20230615125926.29832-2-hejunhao3@huawei.com
>> Signed-off-by: Will Deacon <will@kernel.org>
>> Signed-off-by: Sasha Levin <sashal@kernel.org>
>> ---
>>  drivers/perf/hisilicon/hisi_uncore_pa_pmu.c | 127 +++++++++++++++++---
>>  drivers/perf/hisilicon/hisi_uncore_pmu.h    |   8 ++
>>  2 files changed, 120 insertions(+), 15 deletions(-)
>
>Why is this being backported to stable?
>
>This patch adds supoprt for new HW, and is clearly not a fix, so it's not clear
>to me why it has been selected.

I'll drop it, thanks.

-- 
Thanks,
Sasha
