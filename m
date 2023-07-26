Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 229AF763A9E
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 17:15:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234932AbjGZPP1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 11:15:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234892AbjGZPPK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 11:15:10 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C179B26A1;
        Wed, 26 Jul 2023 08:14:40 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1C493168F;
        Wed, 26 Jul 2023 08:14:48 -0700 (PDT)
Received: from e120937-lin (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 98DD53F67D;
        Wed, 26 Jul 2023 08:14:03 -0700 (PDT)
Date:   Wed, 26 Jul 2023 16:13:53 +0100
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Nikunj Kela <nkela@quicinc.com>,
        Prasad Sodagudi <psodagud@quicinc.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 10/11] firmware: arm_scmi: Add the SCMI performance
 domain
Message-ID: <ZME4MQpYd7kJmFzF@e120937-lin>
References: <20230713141738.23970-1-ulf.hansson@linaro.org>
 <20230713141738.23970-11-ulf.hansson@linaro.org>
 <ZLf4c7ejFBJLH7iN@e120937-lin>
 <CAPDyKFr3ann52GAtOLfnLSGgsdF+EZBNz_apNo_OHzrQ-Hg55Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFr3ann52GAtOLfnLSGgsdF+EZBNz_apNo_OHzrQ-Hg55Q@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 21, 2023 at 05:19:51PM +0200, Ulf Hansson wrote:
> Hi Cristian,
> 

Hi,

> On Wed, 19 Jul 2023 at 16:51, Cristian Marussi <cristian.marussi@arm.com> wrote:
> >
> > On Thu, Jul 13, 2023 at 04:17:37PM +0200, Ulf Hansson wrote:
> > > To enable support for performance scaling (DVFS) for generic devices with
> > > the SCMI performance protocol, let's add an SCMI performance domain. This
> > > is being modelled as a genpd provider, with support for performance scaling
> > > through genpd's ->set_performance_state() callback.
> > >
> > > Note that, this adds the initial support that allows consumer drivers for
> > > attached devices, to vote for a new performance state via calling the
> > > dev_pm_genpd_set_performance_state(). However, this should be avoided as
> > > it's in most cases preferred to use the OPP library to vote for a new OPP
> > > instead. The support using the OPP library isn't part of this change, but
> > > needs to be implemented from subsequent changes.
> > >
> >
> > Hi Ulf,
> >
> > a couple of remarks down below.
> >
> > > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > > ---
> > >
> > > Changes in v2:
> > >       - Converted to use the new ->domain_info_get() callback.
> > >
> > > ---
> > >  drivers/firmware/arm_scmi/Kconfig            |  12 ++
> > >  drivers/firmware/arm_scmi/Makefile           |   1 +
> > >  drivers/firmware/arm_scmi/scmi_perf_domain.c | 155 +++++++++++++++++++
> > >  3 files changed, 168 insertions(+)
> > >  create mode 100644 drivers/firmware/arm_scmi/scmi_perf_domain.c
> >
> > [snip]
> >
> > > +static int scmi_perf_domain_probe(struct scmi_device *sdev)
> > > +{
> > > +     struct device *dev = &sdev->dev;
> > > +     const struct scmi_handle *handle = sdev->handle;
> > > +     const struct scmi_perf_proto_ops *perf_ops;
> > > +     struct scmi_protocol_handle *ph;
> > > +     struct scmi_perf_domain *scmi_pd;
> > > +     struct genpd_onecell_data *scmi_pd_data;
> > > +     struct generic_pm_domain **domains;
> > > +     int num_domains, i, ret = 0;
> > > +     u32 perf_level;
> > > +
> > > +     if (!handle)
> > > +             return -ENODEV;
> > > +
> > > +     /* The OF node must specify us as a power-domain provider. */
> > > +     if (!of_find_property(dev->of_node, "#power-domain-cells", NULL))
> > > +             return 0;
> > > +
> > > +     perf_ops = handle->devm_protocol_get(sdev, SCMI_PROTOCOL_PERF, &ph);
> > > +     if (IS_ERR(perf_ops))
> > > +             return PTR_ERR(perf_ops);
> > > +
> > > +     num_domains = perf_ops->num_domains_get(ph);
> > > +     if (num_domains < 0) {
> > > +             dev_warn(dev, "Failed with %d when getting num perf domains\n",
> > > +                      num_domains);
> > > +             return num_domains;
> > > +     } else if (!num_domains) {
> > > +             return 0;
> > > +     }
> > > +
> > > +     scmi_pd = devm_kcalloc(dev, num_domains, sizeof(*scmi_pd), GFP_KERNEL);
> > > +     if (!scmi_pd)
> > > +             return -ENOMEM;
> > > +
> > > +     scmi_pd_data = devm_kzalloc(dev, sizeof(*scmi_pd_data), GFP_KERNEL);
> > > +     if (!scmi_pd_data)
> > > +             return -ENOMEM;
> > > +
> > > +     domains = devm_kcalloc(dev, num_domains, sizeof(*domains), GFP_KERNEL);
> > > +     if (!domains)
> > > +             return -ENOMEM;
> > > +
> > > +     for (i = 0; i < num_domains; i++, scmi_pd++) {
> > > +             scmi_pd->info = perf_ops->domain_info_get(ph, i);
> >
> > So here you are grabbing all the performance domains exposed by the
> > platform via PERF protocol and then a few lines down below you are
> > registering them with pm_genpd_init(), but the list of domains obtained
> > from the platform will contain NOT only devices but also CPUs possibly,
> > already managed by the SCMI CPUFreq driver.
> 
> Correct.
> 
> >
> > In fact the SCMI CPUFreq driver, on his side, takes care to pick only
> > domains that are bound in the DT to a CPU (via scmi_cpu_domain_id DT
> > parsing) but here you are registering all domains with GenPD upfront.
> 
> Right, genpds are acting as providers, which need to be registered
> upfront to allow consumer devices to be attached when they get probed.
> 
> This isn't specific to this case, but how the genpd infrastructure is
> working per design.
> 
> >
> > Is it not possible that, once registered, GenPD can decide, at some point
> > in the future, to try act on some of these domains associated with a CPU ?
> > (like Clock framework does at the end of boot trying to disable unused
> >  clocks...not familiar with internals of GenPD, though)
> 
> The "magic" that exists in genpd is to save/restore the performance
> state at genpd_runtime_suspend|resume().
> 
> That means the consumer device needs to be attached and runtime PM
> enabled, otherwise genpd will just leave the performance level
> unchanged. In other words, the control is entirely at the consumer
> driver (scmi cpufreq driver).
> 

Ok, so if the DT is well formed and a CPU-related perf domain is not
wrongly referred from a driver looking for a device perf-domain, the
genPD subsystem wont act on the CPUs domains.

> >
> > > +             scmi_pd->domain_id = i;
> > > +             scmi_pd->perf_ops = perf_ops;
> > > +             scmi_pd->ph = ph;
> > > +             scmi_pd->genpd.name = scmi_pd->info->name;
> > > +             scmi_pd->genpd.flags = GENPD_FLAG_OPP_TABLE_FW;
> > > +             scmi_pd->genpd.set_performance_state = scmi_pd_set_perf_state;
> > > +
> > > +             ret = perf_ops->level_get(ph, i, &perf_level, false);
> > > +             if (ret) {
> > > +                     dev_dbg(dev, "Failed to get perf level for %s",
> > > +                              scmi_pd->genpd.name);
> > > +                     perf_level = 0;
> > > +             }
> > > +
> > > +             /* Let the perf level indicate the power-state too. */
> > > +             ret = pm_genpd_init(&scmi_pd->genpd, NULL, perf_level == 0);
> >
> > In SCMI world PERF levels should have nothing to do with the Power
> > state of a domain: you have the POWER protocol for that, so you should
> > not assume that perf level 0 means OFF, but you can use the POWER protocol
> > operation .state_get() to lookup the power state. (and you can grab both
> > perf and power ops from the same driver)
> 
> Well, I think this may be SCMI FW implementation specific, but
> honestly I don't know exactly what the spec says about this. In any
> case, I don't think it's a good idea to mix this with the POWER
> domain, as that's something that is entirely different. We have no
> clue of those relationships (domain IDs).
> 
> My main idea behind this, is just to give the genpd internals a
> reasonably defined value for its power state.
> 

The thing is that in the SCMI world you cannot assume that perf_level 0
means powered off, the current SCP/SCMI platform fw, as an example, wont
advertise a 0-perf-level and wont act on such a request, because you are
supposed to use POWER protocol to get/set the power-state of a device.

So it could be fine, as long as genPD wont try to set the level to 0
expecting the domain to be as a consequence also powered off and as
long as it is fine for these genpd domains to be always initialized
as ON. (since perf_level could never be found as zero..)

Thanks,
Cristian
