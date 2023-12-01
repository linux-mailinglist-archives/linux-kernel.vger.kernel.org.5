Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD946801179
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 18:21:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229919AbjLAQ05 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 11:26:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229594AbjLAQ04 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 11:26:56 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0F56A83
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 08:27:02 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2FA451007;
        Fri,  1 Dec 2023 08:27:48 -0800 (PST)
Received: from pluto (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CD9503F6C4;
        Fri,  1 Dec 2023 08:27:00 -0800 (PST)
Date:   Fri, 1 Dec 2023 16:26:58 +0000
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        vincent.guittot@linaro.org, souvik.chakravarty@arm.com,
        nicola.mazzucato@arm.com
Subject: Re: [PATCH] firmware: arm_scmi: Add protocol versioning checks
Message-ID: <ZWoJUt8oAwyUHazv@pluto>
References: <20231201135858.2367651-1-cristian.marussi@arm.com>
 <20231201153145.emneavw53en4hsju@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231201153145.emneavw53en4hsju@bogus>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 01, 2023 at 03:31:45PM +0000, Sudeep Holla wrote:
> On Fri, Dec 01, 2023 at 01:58:58PM +0000, Cristian Marussi wrote:
> > Platform and agent supported protocols versions do not necessarily match.
> > 
> > When talking to an older platform SCMI server, supporting only older
> > protocol versions, the kernel SCMI agent will downgrade the version of
> > the used protocol to match the platform one and avoid compatibility issues.
> > 
> > In the case, instead, in which the agent happens to communicate with a
> > newer platform server which can support newer protocol versions unknown to
> > the agent, and potentially backward incompatible, the agent currently
> > carries on, silently, in a best-effort approach.
> > 
> > Note that the SCMI server, by the specification, has no means to explicitly
> > detect the protocol versions used by the agents, neither it is required to
> > support multiple, older, protocol versions.
> > 
> > Add an explicit protocol version check to let the agent detect when this
> > version mismatch happens and warn the user about this condition.
> > 
> > Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> > ---
> > Any suggestion for a more meaningful warn message is very much welcome.
> 
> Looks good to me. I will apply soon with couple of changes as mentioned
> below. Let me know if you agree/disagree.
> 
> > Based on sudeep/for-next/scmi/updates
> > ---
> >  drivers/firmware/arm_scmi/base.c      |  6 +++++-
> >  drivers/firmware/arm_scmi/clock.c     |  6 +++++-
> >  drivers/firmware/arm_scmi/driver.c    | 11 ++++++++++-
> >  drivers/firmware/arm_scmi/perf.c      |  6 +++++-
> >  drivers/firmware/arm_scmi/power.c     |  6 +++++-
> >  drivers/firmware/arm_scmi/powercap.c  |  6 +++++-
> >  drivers/firmware/arm_scmi/protocols.h |  8 +++++++-
> >  drivers/firmware/arm_scmi/reset.c     |  6 +++++-
> >  drivers/firmware/arm_scmi/sensors.c   |  6 +++++-
> >  drivers/firmware/arm_scmi/system.c    |  6 +++++-
> >  drivers/firmware/arm_scmi/voltage.c   |  6 +++++-
> >  11 files changed, 62 insertions(+), 11 deletions(-)
> > 
> > diff --git a/drivers/firmware/arm_scmi/base.c b/drivers/firmware/arm_scmi/base.c
> > index a52f084a6a87..3f5c89ae5af2 100644
> > --- a/drivers/firmware/arm_scmi/base.c
> > +++ b/drivers/firmware/arm_scmi/base.c
> > @@ -13,6 +13,9 @@
> >  #include "common.h"
> >  #include "notify.h"
> >  
> > +/* Must be updated only after ALL new features for that version are merged */
> 
> s/new/mandatory/
> 
> > +#define SCMI_PROTOCOL_SUPPORTED_VERSION		0x20000
> > +
> >  #define SCMI_BASE_NUM_SOURCES		1
> >  #define SCMI_BASE_MAX_CMD_ERR_COUNT	1024
> >  
> > index 3eb19ed6f148..46320f627066 100644
> > --- a/drivers/firmware/arm_scmi/driver.c
> > +++ b/drivers/firmware/arm_scmi/driver.c
> > @@ -1849,6 +1853,11 @@ scmi_alloc_init_protocol_instance(struct scmi_info *info,
> >  	devres_close_group(handle->dev, pi->gid);
> >  	dev_dbg(handle->dev, "Initialized protocol: 0x%X\n", pi->proto->id);
> >  
> > +	if (pi->version > proto->supported_version)
> > +		dev_warn(handle->dev,
> > +			 "Detected UNSUPPORTED version 0x%X for protocol 0x%X. Backward compatibility is NOT assured.\n",
> 
> s/UNSUPPORTED version/UNSUPPORTED newer version/ or higher instead of newer
> 

Much better ... I'm fine with these changes ... I was tempted to use
'higher' too, but not sure what was more effective at communicating
the issue...a panic usually does it better :P (joking ah,...)

Thanks,
Cristian
