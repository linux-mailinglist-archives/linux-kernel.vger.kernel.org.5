Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5DA0778A09
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 11:35:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234509AbjHKJfD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 05:35:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230478AbjHKJfB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 05:35:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2D98FD;
        Fri, 11 Aug 2023 02:35:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 809E566D19;
        Fri, 11 Aug 2023 09:35:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D312C433C8;
        Fri, 11 Aug 2023 09:34:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691746499;
        bh=6nDL0utgw9wol8LbIsinlH77MMHM0gseUrwwE+1ZLyU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EeG1NLe583ovTo1ZKn2ViOlb2z0+MIv6z8INw8IouAdVmkw4jEAlxtWA55ZI/rENV
         2JS9IQHwBpdxSeezxRH21OyWoY/KJXJzAtUk71UgGeUvVJmNvJiUnbMra0c19t+tyy
         XFVZZFQkrjbB+G7hfjPPq1lwkJq/npA8LYbO3LXS7x5GJJSw8tWGDsOU1d/5QOZG9R
         7MLbnKt2uSes8rpWROYaRfjlziiS9cHmBz97Ys/d8kolTTgcs9NQO0Hi/7mZjE2xQH
         j2eWboyoeIujLA8u9+EMXQZvZS4hpGDbBOtDFLKIValNbUrgKMFqu+MLcm+CtFycfK
         z04vFqqVFQPsA==
Date:   Fri, 11 Aug 2023 11:34:51 +0200
From:   Simon Horman <horms@kernel.org>
To:     Evan Quan <evan.quan@amd.com>
Cc:     rafael@kernel.org, lenb@kernel.org, Alexander.Deucher@amd.com,
        Christian.Koenig@amd.com, Xinhui.Pan@amd.com, airlied@gmail.com,
        daniel@ffwll.ch, johannes@sipsolutions.net, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        Mario.Limonciello@amd.com, mdaenzer@redhat.com,
        maarten.lankhorst@linux.intel.com, tzimmermann@suse.de,
        hdegoede@redhat.com, jingyuwang_vip@163.com, Lijo.Lazar@amd.com,
        jim.cromie@gmail.com, bellosilicio@gmail.com,
        andrealmeid@igalia.com, trix@redhat.com, jsg@jsg.id.au,
        arnd@arndb.de, andrew@lunn.ch, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org
Subject: Re: [PATCH V8 6/9] drm/amd/pm: setup the framework to support Wifi
 RFI mitigation feature
Message-ID: <ZNYAuyrEWbRiHm55@vergenet.net>
References: <20230810073803.1643451-1-evan.quan@amd.com>
 <20230810073803.1643451-7-evan.quan@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230810073803.1643451-7-evan.quan@amd.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 10, 2023 at 03:38:00PM +0800, Evan Quan wrote:
> With WBRF feature supported, as a driver responding to the frequencies,
> amdgpu driver is able to do shadow pstate switching to mitigate possible
> interference(between its (G-)DDR memory clocks and local radio module
> frequency bands used by Wifi 6/6e/7).
> 
> Signed-off-by: Evan Quan <evan.quan@amd.com>
> Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>

...

> +/**
> + * smu_wbrf_event_handler - handle notify events
> + *
> + * @nb: notifier block
> + * @action: event type
> + * @data: event data

Hi Evan,

a minor nit from my side: although it is documented here,
smu_wbrf_event_handler has no @data parameter, while
it does have an undocumented _arg parameter.

> + *
> + * Calls relevant amdgpu function in response to wbrf event
> + * notification from kernel.
> + */
> +static int smu_wbrf_event_handler(struct notifier_block *nb,
> +				  unsigned long action, void *_arg)
> +{
> +	struct smu_context *smu = container_of(nb, struct smu_context,
> +					       wbrf_notifier);
> +
> +	switch (action) {
> +	case WBRF_CHANGED:
> +		smu_wbrf_handle_exclusion_ranges(smu);
> +		break;
> +	default:
> +		return NOTIFY_DONE;
> +	};
> +
> +	return NOTIFY_OK;
> +}

...
