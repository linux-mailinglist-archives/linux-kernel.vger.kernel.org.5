Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CA0E78BA61
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 23:36:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233745AbjH1Vf5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 17:35:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233840AbjH1Vfu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 17:35:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DD7311C
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 14:35:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0C221612CE
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 21:35:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF13FC433C7;
        Mon, 28 Aug 2023 21:35:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693258547;
        bh=NEgimGcrzmezQkF7I4C28Tb0IMasaq++3rxZDBFmRj8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mg/VCPJRGBhdqqnZShz3cA0SHojyR5lr3FtT4zfN9APlDFO5w3m0aiCGCqqmF8Urp
         /wq40aZGxXN/jrUk8HPqVvEB2jQj9rKvH/YO8qrZZroFecFrNYtZVoI7T4yXNHj4bs
         Cz+U4kaJqmTeWKef1EcjKkJsn0W7mcXqy9lKOclKGwKxUIwDb5X60SHFGMXRKGQ4rC
         Ve6RfCabaP6u0KkUcKFK141qgK8Q7EHs27J10xiW+uy+2h1BfZOlNsdKQQMAl5Xyei
         T4g+ZwUw372fsSC3AE9KTPbfIpmu4KX7xKKaYHHVoA4Wf1XWIv2xR6wkOfAqGr+xyB
         RJerCPZgNulAQ==
Date:   Mon, 28 Aug 2023 22:35:37 +0100
From:   Will Deacon <will@kernel.org>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com,
        kernel-team@android.com,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        coresight@lists.linaro.org, linux-kernel@vger.kernel.org,
        James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>, yangyicong@huawei.com,
        Mark Rutland <mark.rutland@arm.com>,
        Sami Mujawar <sami.mujawar@arm.com>,
        Leo Yan <leo.yan@linaro.org>
Subject: Re: [PATCH V5 0/4] coresight: trbe: Enable ACPI based devices
Message-ID: <20230828213537.GA27629@willie-the-truck>
References: <20230817055405.249630-1-anshuman.khandual@arm.com>
 <169237557557.1402587.14721093106016169238.b4-ty@kernel.org>
 <f8f13510-ec6a-b18b-d9ff-9247b250bc03@arm.com>
 <20230821112851.GC19469@willie-the-truck>
 <311d0ecf-dddf-dcf5-9545-3f8a51634a9a@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <311d0ecf-dddf-dcf5-9545-3f8a51634a9a@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 27, 2023 at 11:11:16PM +0100, Suzuki K Poulose wrote:
> On 21/08/2023 12:28, Will Deacon wrote:
> > Hmm, the rationale behind your change to make the pdata allocation
> > per-device in ("coresight: trbe: Allocate platform data per device")
> > confuses me: with Anshuman's change to allocate the pdata using
> > devm_kzalloc(), there shouldn't be any connections for the coresight
> > core to trip over, should there?
> 
> Anshuman's patch is working around the problem of "TRBE platform
> device with ACPI doesn't have a valid companion device" - this is a problem
> for the acpi_get_coresight_platform_data(). The work
> around is to move the "allocation" from coresight_get_platform_data()
> to the driver (given we don't need anything else from the ACPI except
> the IRQ). That doesn't change *how* it is allocated.
> Also please note that, the TRBE driver creates a TRBE coresight_device
> per-CPU and the platform data is shared by all of these devices, which
> the coresight core driver doesn't cope with. The other option is to
> move the releasing of these platform-data to the individual drivers,
> which is quite an invasive change. Or, make the core driver tolerate
> a NULL platform data, which is also again invasive. So the merged fix
> is correct and is still valid after this patch.

Ah, ok, so the problem with TRBE isn't anything to do with its connections,
but simply because the pdata is shared?

Will
