Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0CD7751441
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 01:14:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233168AbjGLXOB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 19:14:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231435AbjGLXNt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 19:13:49 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F14C5270B;
        Wed, 12 Jul 2023 16:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=Y5SzVlzKIJDGUT9EANNyQG9MJsCdwH/wBupzje6OdiM=; b=qhP8b1q/52VMiBvnIqhcAYbjNx
        zbmKTamtufBzg+FG6s1+PVEzoqOJ204eV2UElZ37KrbQLYVyDSiK3GxXP0qars3wTrekPxYD75yqo
        /kzmMYfzIweYsm5sAkfnZyOWVOglsadzHxqCcH5EKZlU5o7VwRpv0YvWNw5bim8GYR/E=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1qJj08-001BOI-Go; Thu, 13 Jul 2023 01:12:04 +0200
Date:   Thu, 13 Jul 2023 01:12:04 +0200
From:   Andrew Lunn <andrew@lunn.ch>
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
        arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org
Subject: Re: [PATCH V6 1/9] drivers core: Add support for Wifi band RF
 mitigations
Message-ID: <5439dd61-7b5f-4fc9-8ccd-f7df43a791dd@lunn.ch>
References: <20230710083641.2132264-1-evan.quan@amd.com>
 <20230710083641.2132264-2-evan.quan@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230710083641.2132264-2-evan.quan@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +/**
> + * wbrf_supported_producer - Determine if the device can report frequencies
> + *
> + * @dev: device pointer
> + *
> + * WBRF is used to mitigate devices that cause harmonic interference.
> + * This function will determine if this device needs to report such frequencies.

How is the WBRF core supposed to answer this question? That it knows
there is at least one device which has registered with WBRF saying it
can change its behaviour to avoid causing interference?

Rather than "Determine if the device can report frequencies" should it be
"Determine if the device should report frequencies"

A WiFi device can always report frequencies, since it knows what
frequency is it currently using. However, it is pointless making such
reports if there is no device which can actually make use of the
information. 

> +bool wbrf_supported_producer(struct device *dev)
> +{
> +	return true;
> +}

I found the default implementation of true being odd. It makes me
wounder, what is the point of this call. I would expect this to see if
a linked list is empty or not.

> +/**
> + * wbrf_supported_consumer - Determine if the device can react to frequencies

This again seems odd. A device should know if it can react to
frequencies or not. WBRF core should not need to tell it. What makes
more sense to me is that this call is about a device telling the WBRF
core it is able to react to frequencies. The WBRF core then can give a
good answer to wbrf_supported_producer(), yes, i know of some other
device who might be able to do something to avoid causing interference
to you, so please do tell me about frequencies you want to use.

What is missing here in this API is policy information. The WBRF core
knows it has zero or more devices which can report what frequencies
they are using, and it has zero or more devices which maybe can do
something. But then you need policy to say this particular board needs
any registered devices to actually do something because of poor
shielding. Should this policy be as simple as a bool, or should it
actually say the board has shielding issues for a list of frequencies?
I think the answer to what will depend on the cost of taking action
when no action is actually required.

> + * wbrf_register_notifier - Register for notifications of frequency changes
> + *
> + * @nb: driver notifier block
> + *
> + * WBRF is used to mitigate devices that cause harmonic interference.
> + * This function will allow consumers to register for frequency notifications.
> + */
> +int wbrf_register_notifier(struct notifier_block *nb)
> +{
> +	return blocking_notifier_chain_register(&wbrf_chain_head, nb);
> +}

What are the timing requirements for the handler? Should the handler
block until the device has finished doing what it needs to do and the
frequency response has settled? We don't want the WiFi device doing a
SNR measurement until we know local noise is at a minimum. I think it
would be good to document things like this here.

> +struct wbrf_ranges_out {
> +	u32			num_of_ranges;
> +	struct exclusion_range	band_list[MAX_NUM_OF_WBRF_RANGES];
> +} __packed;

Seems odd using packed here. It is the only structure which is
packed. I would also move the u32 after the struct so it is naturally
aligned on 64 bit systems.

	Andrew
