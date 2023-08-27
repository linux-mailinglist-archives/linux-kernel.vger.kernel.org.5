Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C125978A00D
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Aug 2023 17:44:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230499AbjH0Pnu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Aug 2023 11:43:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230202AbjH0Pnb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Aug 2023 11:43:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F36F4ED;
        Sun, 27 Aug 2023 08:43:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 88BFE61122;
        Sun, 27 Aug 2023 15:43:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CD65C433C8;
        Sun, 27 Aug 2023 15:43:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693151007;
        bh=bPb4p4j0igZCsViibtVoyOO+JM0u5QNB2s0HIgV+F8I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lC44SRzrz4+W1/99hfg3uctoMoGo8F8b9BvJLyDlihyuz3NJ3XpESzTeDCSAw5uBR
         p0dwoGWIBkEt5/2tCuIHNUtllS+hiJjoQ1zpyofy47tXbEMI2VPMhm1q4R1kSluSNx
         2MxxGeDs6JiyybQdvmUEp7BpegjQ2oXA2oKROvhDj/3y7ZGUTqO8kB5vLUEVGJrUls
         J7omuqoSq0psI8MzX+L6V8SzHkTb0dXSWNnYafi+TeW/pW8Ig8R1WhPWgiZNTKsIIn
         iTowfQ5UTG1oH/WXP9oeYXumpG6f2BFAbv50c4NxjItLE5vPDNNiFYdCdZe6XwZ9lr
         LFWxOpV/Fz3Yw==
Date:   Sun, 27 Aug 2023 17:43:12 +0200
From:   Simon Horman <horms@kernel.org>
To:     Evan Quan <evan.quan@amd.com>
Cc:     lenb@kernel.org, johannes@sipsolutions.net, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        alexander.deucher@amd.com, rafael@kernel.org, Lijo.Lazar@amd.com,
        mario.limonciello@amd.com, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org
Subject: Re: [V10 1/8] ACPI: Add support for AMD ACPI based Wifi band RFI
 mitigation feature
Message-ID: <20230827154312.GT3523530@kernel.org>
References: <20230825083846.4001973-1-evan.quan@amd.com>
 <20230825083846.4001973-2-evan.quan@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230825083846.4001973-2-evan.quan@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 25, 2023 at 04:38:39PM +0800, Evan Quan wrote:
> Due to electrical and mechanical constraints in certain platform designs
> there may be likely interference of relatively high-powered harmonics of
> the (G-)DDR memory clocks with local radio module frequency bands used
> by Wifi 6/6e/7.
> 
> To mitigate this, AMD has introduced a mechanism that devices can use to
> notify active use of particular frequencies so that other devices can make
> relative internal adjustments as necessary to avoid this resonance.
> 
> Signed-off-by: Evan Quan <evan.quan@amd.com>

...

> diff --git a/drivers/acpi/amd_wbrf.c b/drivers/acpi/amd_wbrf.c

...

> +/**
> + * acpi_amd_wbrf_add_exclusion - broadcast the frequency band the device
> + *                               is using
> + *
> + * @dev: device pointer
> + * @in: input structure containing the frequency band the device is using
> + *
> + * Broadcast to other consumers the frequency band the device starts
> + * to use. Underneath the surface the information is cached into an
> + * internal buffer first. Then a notification is sent to all those
> + * registered consumers. So then they can retrieve that buffer to
> + * know the latest active frequency bands. The benifit with such design

nit: ./checkpatch.pl --codespell suggests benifit -> benefit.

> + * is for those consumers which have not been registered yet, they can
> + * still have a chance to retrieve such information later.
> + */
> +int acpi_amd_wbrf_add_exclusion(struct device *dev,
> +				struct wbrf_ranges_in_out *in)
> +{
> +	struct acpi_device *adev = ACPI_COMPANION(dev);
> +	int ret;
> +
> +	if (!adev)
> +		return -ENODEV;
> +
> +	ret = wbrf_record(adev, WBRF_RECORD_ADD, in);
> +	if (ret)
> +		return ret;
> +
> +	blocking_notifier_call_chain(&wbrf_chain_head,
> +				     WBRF_CHANGED,
> +				     NULL);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(acpi_amd_wbrf_add_exclusion);

...
