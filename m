Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A11F67B7F17
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 14:27:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242370AbjJDM1p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 08:27:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242353AbjJDM1o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 08:27:44 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EC43E9
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 05:27:40 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 518ACC433C9;
        Wed,  4 Oct 2023 12:27:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696422460;
        bh=jLtpvUu3o2mCQfgfqelejQUPXc1SMpmQFBdmvnSadmQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kRDgIR6WXxZmRUOX9AEKsETpXqUxHBzUG3ZCxQNV3A7erIU9r4H3qNZEIpmsNZ6vd
         +YHymlJhFlVRq/pg0hiFAm2cc9E4cdWW3wZqZdKHxOAOZ1BlIYJiqkYttXL8/Kep6p
         MiReP0tpPrGNdcUMIoRYJZWGBtXFlMaTRItg1RyOX/sAVu/Lqvy9BKvV30ojNCVHgn
         aQcx+pXRM38ku9h0V2Acup8diwx67h2bgNr96QT+z0SUui2EcOK+dbzLcmsKo79S2E
         vH8GGZ7E49F7rpSxVAbzeKbw5xO07Ece7lYGYdFF1nL+T47G+Ux27S1d3AekE4fi6B
         I4VhYRuyZ9aXQ==
Date:   Wed, 4 Oct 2023 14:27:33 +0200
From:   Simon Horman <horms@kernel.org>
To:     Konstantin Aladyshev <aladyshev22@gmail.com>
Cc:     minyard@acm.org, joel@jms.id.au, andrew@aj.id.au,
        avifishman70@gmail.com, tmaimon77@gmail.com, tali.perry1@gmail.com,
        venture@google.com, yuenn@google.com, benjaminfair@google.com,
        jk@codeconstruct.com.au, matt@codeconstruct.com.au,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, openbmc@lists.ozlabs.org,
        netdev@vger.kernel.org
Subject: Re: [PATCH v3 3/3] mctp: Add MCTP-over-KCS transport binding
Message-ID: <ZR1aNb0+D+uO+Qm8@kernel.org>
References: <20231003131505.337-1-aladyshev22@gmail.com>
 <20231003131505.337-4-aladyshev22@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231003131505.337-4-aladyshev22@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 03, 2023 at 04:15:05PM +0300, Konstantin Aladyshev wrote:
> This change adds a MCTP KCS transport binding, as defined by the DMTF
> specificiation DSP0254 - "MCTP KCS Transport Binding".
> A MCTP protocol network device is created for each KCS channel found in
> the system.
> The interrupt code for the KCS state machine is based on the current
> IPMI KCS driver.
> 
> Signed-off-by: Konstantin Aladyshev <aladyshev22@gmail.com>

...

> diff --git a/drivers/net/mctp/mctp-kcs.c b/drivers/net/mctp/mctp-kcs.c

...

> +static inline void set_state(struct mctp_kcs *mkcs, u8 state)

Hi Konstantin,

Please avoid the inline keyword in C files unless there is a demonstrable
reason to use it. In general, the compiler should be left to decide.

> +{
> +	dev_dbg(mkcs->client.dev->dev, "%s: state=0x%02x", __func__, state);
> +	kcs_bmc_update_status(mkcs->client.dev, KCS_STATUS_STATE_MASK,
> +			      KCS_STATUS_STATE(state));
> +}

...

> +static inline struct mctp_kcs *client_to_mctp_kcs(struct kcs_bmc_client *client)

Ditto.

> +{
> +	return container_of(client, struct mctp_kcs, client);
> +}

...
