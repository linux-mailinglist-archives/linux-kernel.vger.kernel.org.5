Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3890578DE84
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 21:05:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239394AbjH3TEV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 15:04:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244809AbjH3OHl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 10:07:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC3BAB9;
        Wed, 30 Aug 2023 07:07:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7E7F46222B;
        Wed, 30 Aug 2023 14:07:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFD6DC433C8;
        Wed, 30 Aug 2023 14:07:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693404457;
        bh=gC7h2o8DgHf81V55Hr5r2OhHYYm/45JyKuio5PaFFPc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=aAwWrGyRb2jklRlBUfr4I5S4y6Ybzv+C+F+pnwukkztG6Y9Y0xJ4CFQnjWKUMs7DK
         drC3Ygd6i4NJsjcTuK/liuut36Yn/pJc5HwFZrRqhE4fziL4wQOy4RIO4Wp0PRFM0y
         eJqIW79j7QT22tDBFLOAv6Hh39HdjrfhFnhIRRKq/XjLOE4mi8f9RcrhhT5pgGO+Er
         Nuoo5aIHrOQma//4yf0jOCz3Q9mis/JTAvHyg9v5HEb5keDj2a+9Ovr00Vd4XH1oOK
         SzNub1P1ospLCF7azOdfgUXVLLaDHUrKrBHVe/m7acyyY5i2YTk7e5L34pCzcYueTh
         /LU670E69OxqQ==
Received: from disco-boy.misterjones.org ([217.182.43.188] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <maz@kernel.org>)
        id 1qbLr5-009KZQ-CL;
        Wed, 30 Aug 2023 15:07:35 +0100
MIME-Version: 1.0
Date:   Wed, 30 Aug 2023 15:07:35 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Oza Pawandeep <quic_poza@quicinc.com>
Cc:     sudeep.holla@arm.com, catalin.marinas@arm.com, will@kernel.org,
        rafael@kernel.org, lenb@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org
Subject: Re: [PATCH v3] cpuidle, ACPI: Evaluate LPI arch_flags for broadcast
 timer
In-Reply-To: <20230829201101.3330337-1-quic_poza@quicinc.com>
References: <20230829201101.3330337-1-quic_poza@quicinc.com>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <a4811a5e1df589573a27771749a68d34@kernel.org>
X-Sender: maz@kernel.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 217.182.43.188
X-SA-Exim-Rcpt-To: quic_poza@quicinc.com, sudeep.holla@arm.com, catalin.marinas@arm.com, will@kernel.org, rafael@kernel.org, lenb@kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-08-29 21:11, Oza Pawandeep wrote:
> Arm® Functional Fixed Hardware Specification defines LPI states,
> which provide an architectural context loss flags field that can
> be used to describe the context that might be lost when an LPI
> state is entered.
> 
> - Core context Lost
>         - General purpose registers.
>         - Floating point and SIMD registers.
>         - System registers, include the System register based
>         - generic timer for the core.
>         - Debug register in the core power domain.
>         - PMU registers in the core power domain.
>         - Trace register in the core power domain.
> - Trace context loss
> - GICR
> - GICD
> 
> Qualcomm's custom CPUs preserves the architectural state,
> including keeping the power domain for local timers active.
> when core is power gated, the local timers are sufficient to
> wake the core up without needing broadcast timer.

Isn't that what should be exposed by GTDT when ACPI_GTDT_ALWAYS_ON
is set on the relevant interrupt and EL? The arch timer already
deals with that.

Why do we need anything else?

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
