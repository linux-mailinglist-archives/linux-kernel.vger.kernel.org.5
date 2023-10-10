Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D1EB7BF5DC
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 10:29:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442852AbjJJI3v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 04:29:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442775AbjJJI3t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 04:29:49 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 62533A4;
        Tue, 10 Oct 2023 01:29:47 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9959F1FB;
        Tue, 10 Oct 2023 01:30:27 -0700 (PDT)
Received: from e120937-lin (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 744003F7A6;
        Tue, 10 Oct 2023 01:29:45 -0700 (PDT)
Date:   Tue, 10 Oct 2023 09:29:39 +0100
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     Peng Fan <peng.fan@nxp.com>
Cc:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
        "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ranjani Vaidyanathan <ranjani.vaidyanathan@nxp.com>,
        Glen G Wienecke <glen.wienecke@nxp.com>,
        "souvik.chakravarty@arm.com" <souvik.chakravarty@arm.com>,
        Chuck Cannon <chuck.cannon@nxp.com>
Subject: Re: [RFC] firmware: arm_scmi: clock: add fixed clock attribute
 support
Message-ID: <ZSULYoS4FUNQaVtd@e120937-lin>
References: <20231010022911.4106863-1-peng.fan@oss.nxp.com>
 <ZSUCDdfJjs1blK1T@e120937-lin>
 <DU0PR04MB9417DCEC4CA9DA488796194C88CDA@DU0PR04MB9417.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DU0PR04MB9417DCEC4CA9DA488796194C88CDA@DU0PR04MB9417.eurprd04.prod.outlook.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 10, 2023 at 08:08:01AM +0000, Peng Fan wrote:
> > Subject: Re: [RFC] firmware: arm_scmi: clock: add fixed clock attribute
> > support
> > 
> > On Tue, Oct 10, 2023 at 10:29:11AM +0800, Peng Fan (OSS) wrote:
> > > From: Peng Fan <peng.fan@nxp.com>
> > >
> > > There are clocks:
> > >  system critical, not allow linux to disable, change rate  allow linux
> > > to get rate, because some periphals will use the frequency  to
> > > configure periphals.
> > >
> > >  So introduce an attribute to indicated FIXED clock
> > >
> > 
> > Hi,
> > 
> > (CCed souvik.chakravarty@arm.com)
> > 
> > so AFAIU here you are describing a clock that really is NOT fixed in general, it
> > is just that the Linux SCMI Agent cannot touch it, but other SCMI agents on
> > the system CAN change it and so, on one side, you keep the ability for the
> > Linux agent to read back the current rate with
> > recalc_rate() and remove all the Clk frameworks callbacks needed to modify
> > its state, am I right ?
> 
> Right.
> 
> > 
> > In this scenario, it is really the SCMI platform fw (server) that has to
> > implement the checks and simply DENY the requests coming from an agent
> > that is not supposed to touch that clock, while allowing the current rate to be
> > retrieved.
> 
> Linux will try to enable, get rate, runtime disable the clock.
> But the server does not allow enable/disable the clock, so the driver probe
> will fail.
> 

Which driver probe ? I have just double checked and when clk-scmi driver
is loaded there are a bunch of SCMI queries to the server BUT no *_SET
command is issued during the clk-scmi probe; indeed JUNO had never had any
issue despite having access to a bunch of CLKs which are visibile BUT not
modifiable from Linux.

> The SCMI server could bypass enable/disable and only allow get rate,
> But this introduces heavy RPC, so just wanna whether it is ok to register
> fixed clock and avoid RPC.
> 
> > 
> > JUNO/SCP is an example of how the CPUs clocks are visible to Linux BUT
> > cannot be touched directly via Clock protocol by Linux since in the SCMI
> > world you are supposed to use the Perf protocol instead to change the OPPs
> > when you want to modify the performance level of the runnning CPU.
> > 
> > This kind of server-side permissions checks, meant to filter access to resources
> > based on the requesting agent, are part of the SCMI declared aim to push the
> > responsibility of such controls out of the kernel into the platform fw in order
> > to avoid attacks like CLOCK_SCREW by letting the SCMI firmware be the one
> > and only final arbiter on the requests coming from the agents; you can ask
> > teh server whatever you like as an agent but your request can be DENIED or
> > silently ignored (in case of shared resources) at the will of the platform which
> > has the final say and it is implemented in a physically distinct code-base.
> > 
> > It seems to me that this patch and the possible associated SCMI specification
> > change would give back the control to the Linux agent and could allow the
> > implementation of an SCMI Server that does NOT perform any of these
> > permission checks.
> > 
> > So, IMO, while this change, on one side, could be certainly useful by removing
> > a bunch of unused/uneeded callbacks from the CLK SCMI driver when a fixed
> > clock is identified, it could open the door to a bad implementation like the
> > one mentioned above which does NOT perform any agent-based permission
> > check.
> 
> Thanks for detailed information, let me check whether our SCMI firmware
> could do more on the permission side. But if RPC could be removed,
> it could save some time.
> 

Avoiding to issue SCMI requests destined to fail would be certainly good, even though
it could lead to just quietly implementing a server with no-checks at
all, but why these unneeded calls happen in first place ?

I have never observed anything like that in my setups.

Thanks,
Cristian
