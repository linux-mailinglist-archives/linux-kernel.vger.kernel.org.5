Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D9737C55AB
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 15:41:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234906AbjJKNln (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 09:41:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232091AbjJKNlj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 09:41:39 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4055090;
        Wed, 11 Oct 2023 06:41:38 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8121EC15;
        Wed, 11 Oct 2023 06:42:18 -0700 (PDT)
Received: from bogus (unknown [10.57.93.106])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C229D3F5A1;
        Wed, 11 Oct 2023 06:41:35 -0700 (PDT)
Date:   Wed, 11 Oct 2023 14:40:03 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Ranjani Vaidyanathan <ranjani.vaidyanathan@nxp.com>
Cc:     Cristian Marussi <cristian.marussi@arm.com>,
        "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "souvik.chakravarty@arm.com" <souvik.chakravarty@arm.com>,
        Glen G Wienecke <glen.wienecke@nxp.com>,
        Peng Fan <peng.fan@nxp.com>
Subject: Re: [EXT] Re: [RFC] firmware: arm_scmi: clock: add fixed clock
 attribute support
Message-ID: <20231011134003.lhb5yiicgr5cbzr2@bogus>
References: <20231010022911.4106863-1-peng.fan@oss.nxp.com>
 <20231010091223.rvcyrgbjcrmjzmvp@bogus>
 <ZSUXu65bOYVG689E@pluto>
 <20231010093509.ddy75og4jd72n6cq@bogus>
 <PA4PR04MB94859C7729B19C8B88541F8692CCA@PA4PR04MB9485.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PA4PR04MB94859C7729B19C8B88541F8692CCA@PA4PR04MB9485.eurprd04.prod.outlook.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 11, 2023 at 03:54:59AM +0000, Ranjani Vaidyanathan wrote:
> From what I see SCMI clock protocol could benefit from an attribute for the
> clock that describes what operations are possible on a clock. There are many
> bus clocks that only the SCMI server manages and the error code DENIED
> should be handled gracefully by the agent.
>

Agreed, but we need to understand if we need it per operation basis or
at the higher granularity such as any write or set operations not allowed.
Just my initial thoughts, we can discuss.

> In the case of Linux, perhaps this should be handled by the SCMI clock
> driver, instead of allowing the error to propagate up the Linux clock
> framework?

Yes but even for that we need information from the firmware.

> It seems strange that the SCMI server should swallow the error (silently
> fail) only for certain agents.

I am bit confused by this statement. The SCMI server/platform must not
ignore or fail silently. Since the agent is not allowed, if it attempts
it must return the apt error.

While Linux may choose to ignore the error but I think this is what
we are discussing to figure out what is the best way to avoid it or
worst case handle it gracefully. With any extra info from the firmware,
the former option must be possible and we need not think of the latter
option IMO.

> I would think this would make debug quite difficult and having a "DENIED"
> error code not very useful.
>

Agreed especially if it can and is expected to continue functioning as normal.

-- 
Regards,
Sudeep
