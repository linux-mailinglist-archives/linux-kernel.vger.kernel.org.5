Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2F847B8CB8
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 21:20:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245206AbjJDTPY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 15:15:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245327AbjJDTPF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 15:15:05 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AF0911B;
        Wed,  4 Oct 2023 12:14:54 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD8A5C433C7;
        Wed,  4 Oct 2023 19:14:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696446894;
        bh=ApDtmv1qaYUzh+pCuxsBvwGBh8O049GYBAMvDvx1obk=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=TMYJ03zG548A10EOdx0m9PqE48jMm461T/Vv7Y0d6un4xq17JNktqH5MSHtkkXXEr
         NG9rwPnK/PGy8hojDP1JTJqjHV9/yq+Re46N6OfV48b8/aVaWQcabd9Z/Rs33wDYbQ
         FUirFo19d3/UKpljDIECkCOOy7Yhg63BlhMBCYJ9qiaxPUiXzsVtPva7FnJb4eYum5
         2vS5u0tQ1D0tm916wP5D0eN0xWM+aEoYD45kQJ+UIE2FI2aNT8A4ihfgrh01zC2Vbs
         eTa+Ho2Heun97pSJmixDTbUrl5GQy9Z4i4Z1j0WEsmlEkp0kXbp83IdJDwYnA+w5a7
         wsftpvSXDPrIA==
Date:   Wed, 4 Oct 2023 21:14:50 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
cc:     benjamin.tissoires@redhat.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: Re: [PATCH] HID: intel-ish-hid: ipc: Disable and reenable ACPI GPE
 bit
In-Reply-To: <20231003155332.1855569-1-srinivas.pandruvada@linux.intel.com>
Message-ID: <nycvar.YFH.7.76.2310042114420.3534@cbobk.fhfr.pm>
References: <20231003155332.1855569-1-srinivas.pandruvada@linux.intel.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 Oct 2023, Srinivas Pandruvada wrote:

> The EHL (Elkhart Lake) based platforms provide a OOB (Out of band)
> service, which allows to wakup device when the system is in S5 (Soft-Off
> state). This OOB service can be enabled/disabled from BIOS settings. When
> enabled, the ISH device gets PME wake capability. To enable PME wakeup,
> driver also needs to enable ACPI GPE bit.
> 
> On resume, BIOS will clear the wakeup bit. So driver need to re-enable it
> in resume function to keep the next wakeup capability. But this BIOS
> clearing of wakeup bit doesn't decrement internal OS GPE reference count,
> so this reenabling on every resume will cause reference count to overflow.
> 
> So first disable and reenable ACPI GPE bit using acpi_disable_gpe().
> 
> Fixes: 2e23a70edabe ("HID: intel-ish-hid: ipc: finish power flow for EHL OOB")
> Reported-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> Closes: https://lore.kernel.org/lkml/CAAd53p4=oLYiH2YbVSmrPNj1zpMcfp=Wxbasb5vhMXOWCArLCg@mail.gmail.com/T/
> Tested-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> ---
>  drivers/hid/intel-ish-hid/ipc/pci-ish.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/hid/intel-ish-hid/ipc/pci-ish.c b/drivers/hid/intel-ish-hid/ipc/pci-ish.c
> index 55cb25038e63..710fda5f19e1 100644
> --- a/drivers/hid/intel-ish-hid/ipc/pci-ish.c
> +++ b/drivers/hid/intel-ish-hid/ipc/pci-ish.c
> @@ -133,6 +133,14 @@ static int enable_gpe(struct device *dev)
>  	}
>  	wakeup = &adev->wakeup;
>  
> +	/*
> +	 * Call acpi_disable_gpe(), so that reference count
> +	 * gpe_event_info->runtime_count doesn't overflow.
> +	 * When gpe_event_info->runtime_count = 0, the call
> +	 * to acpi_disable_gpe() simply return.
> +	 */
> +	acpi_disable_gpe(wakeup->gpe_device, wakeup->gpe_number);
> +
>  	acpi_sts = acpi_enable_gpe(wakeup->gpe_device, wakeup->gpe_number);
>  	if (ACPI_FAILURE(acpi_sts)) {
>  		dev_err(dev, "enable ose_gpe failed\n");

Applied, thanks Srinivas.

-- 
Jiri Kosina
SUSE Labs

