Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B67877A46E9
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 12:27:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241068AbjIRK1A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 06:27:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241199AbjIRK0y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 06:26:54 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 280B1AD;
        Mon, 18 Sep 2023 03:26:47 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3339D1FB;
        Mon, 18 Sep 2023 03:27:24 -0700 (PDT)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2CEED3F67D;
        Mon, 18 Sep 2023 03:26:45 -0700 (PDT)
Date:   Mon, 18 Sep 2023 11:26:42 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Cristian Marussi <cristian.marussi@arm.com>,
        Nikunj Kela <nkela@quicinc.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Prasad Sodagudi <psodagud@quicinc.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Viresh Kumar <vireshk@kernel.org>,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH v3 00/13] arm_scmi/cpufreq: Add generic performance
 scaling support
Message-ID: <20230918102642.icz7gywqmakaatgc@bogus>
References: <20230825112633.236607-1-ulf.hansson@linaro.org>
 <CAPDyKFpn93YU78fRg02Avb3g=W2=+Cn=HD4tUbzTYq9WKGVOKw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFpn93YU78fRg02Avb3g=W2=+Cn=HD4tUbzTYq9WKGVOKw@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 15, 2023 at 12:45:02AM +0200, Ulf Hansson wrote:
> Sudeep, Christian,
> 
> On Fri, 25 Aug 2023 at 13:26, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> >
> > Changes in v3:
> >         - Re-based upon the for-next/scmi/updates branch.
> >         - Re-ordered some of the patches in the series, to eas review.
> >         - Added some new DT doc patches in the series, according to comments.
> >         - Fixed other comments, see version history for each patch.
> >
> > Changes in v2:
> >         - Split up the series, to get the basic support in place as the first
> >         step. The part that remains is the integration with the OPP library, to
> >         allow consumer drivers to change performance level using the OPP lib.
> >         - Re-based on top v6.5-rc1.
> >         - Other changes will be described for each patch.
> >
> > The current SCMI performance scaling support is limited to cpufreq. This series
> > extends the support, so it can be used for all kind of devices and not only for
> > CPUs.
> >
> > The changes are spread over a couple of different subsystems, although the
> > changes that affects the other subsystems than the arm_scmi directory are
> > mostly smaller, except for last patch which is in the new genpd directory.
> >
> > The series is based upon the for-next/scmi/updates branch, but to enable the
> > genpd provider in patch 13 (the actual scmi performance domain driver) to be
> > placed in the new genpd directory, I have also merged an immutable branch [1],
> > which is queued for v6.6.
> >
> > Note that, I am runing this on the Qemu virt platform with Optee running an SCMI
> > server. If you want some more details about my test setup, I can share this with
> > you, just let me know.
> >
> > Looking forward to your feedback!
> >
> > Kind regards
> > Ulf Hansson
> >
> > [1]
> > git.kernel.org/pub/scm/linux/kernel/git/people/ulf.hansson/linux-pm.git genpd_create_dir
> >
> >
> > Ulf Hansson (13):
> >   firmware: arm_scmi: Extend perf protocol ops to get number of domains
> >   firmware: arm_scmi: Extend perf protocol ops to get information of a
> >     domain
> >   cpufreq: scmi: Prepare to move OF parsing of domain-id to cpufreq
> >   firmware: arm_scmi: Align perf ops to use domain-id as in-parameter
> >   firmware: arm_scmi: Drop redundant ->device_domain_id() from perf ops
> >   cpufreq: scmi: Avoid one OF parsing in scmi_get_sharing_cpus()
> >   cpufreq: scmi: Drop redundant ifdef in scmi_cpufreq_probe()
> >   dt-bindings: arm: cpus: Add a power-domain-name for a
> >     performance-domain
> >   dt-bindings: firmware: arm,scmi: Extend bindings for protocol@13
> >   dt-bindings: power: Clarify performance capabilities of power-domains
> >   cpufreq: scmi: Add support to parse domain-id using
> >     #power-domain-cells
> >   PM: domains: Allow genpd providers to manage OPP tables directly by
> >     its FW
> >   genpd: arm: Add the SCMI performance domain
> >
> >  .../devicetree/bindings/arm/cpus.yaml         |   4 +-
> >  .../bindings/firmware/arm,scmi.yaml           |  11 +-
> >  .../bindings/power/power-domain.yaml          |  17 +-
> >  MAINTAINERS                                   |   1 +
> >  drivers/base/power/domain.c                   |  11 +-
> >  drivers/cpufreq/scmi-cpufreq.c                |  55 +++++--
> >  drivers/firmware/arm_scmi/Kconfig             |  12 ++
> >  drivers/firmware/arm_scmi/perf.c              |  90 +++++------
> >  drivers/genpd/Makefile                        |   1 +
> >  drivers/genpd/arm/Makefile                    |   3 +
> >  drivers/genpd/arm/scmi_perf_domain.c          | 150 ++++++++++++++++++
> >  include/linux/pm_domain.h                     |   5 +
> >  include/linux/scmi_protocol.h                 |  18 ++-
> >  13 files changed, 293 insertions(+), 85 deletions(-)
> >  create mode 100644 drivers/genpd/arm/Makefile
> >  create mode 100644 drivers/genpd/arm/scmi_perf_domain.c
> >
> 
> Unless you have some additional comments, I think patch 1 -> 12 should
> be ready to be applied to your scmi tree, as is. I tried to apply it
> today and did not encounter any problem.
>

Sorry for the delay, was off few days last week. I will take a look at
the series later this week

> Patch 13 needs a rebase so I will submit a new version of it. For you
> to apply it to your tree, you need to move your scmi branch to
> v6.6-rc2 (on Monday), would that be okay for you to manage?
>

Sure I can rebase on -rc2. I assume Arnd is aware of the dependency and
must be OK with that. The general preference/expectation is -rc1 but I
understand the exception this time.

-- 
Regards,
Sudeep
