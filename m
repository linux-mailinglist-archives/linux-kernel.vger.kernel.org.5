Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8127375C640
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 13:59:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230421AbjGUL7u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 07:59:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjGUL7s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 07:59:48 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5DAB3171B;
        Fri, 21 Jul 2023 04:59:47 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7FB2C2F4;
        Fri, 21 Jul 2023 05:00:30 -0700 (PDT)
Received: from bogus (unknown [10.57.96.100])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BD21C3F6C4;
        Fri, 21 Jul 2023 04:59:44 -0700 (PDT)
Date:   Fri, 21 Jul 2023 12:59:17 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Cristian Marussi <cristian.marussi@arm.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Nikunj Kela <nkela@quicinc.com>,
        Prasad Sodagudi <psodagud@quicinc.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 09/11] cpufreq: scmi: Add support to parse domain-id
 using #power-domain-cells
Message-ID: <20230721115917.lescikl75kmeqkw4@bogus>
References: <20230713141738.23970-1-ulf.hansson@linaro.org>
 <20230713141738.23970-10-ulf.hansson@linaro.org>
 <20230719152426.qwc5qqewrfjsarlz@bogus>
 <CAPDyKFogrwFnz2ZuKE-mLrCQmTCQcrtjhhyzB4CnoVnxAXqKEg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFogrwFnz2ZuKE-mLrCQmTCQcrtjhhyzB4CnoVnxAXqKEg@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 21, 2023 at 01:52:17PM +0200, Ulf Hansson wrote:
> On Wed, 19 Jul 2023 at 17:24, Sudeep Holla <sudeep.holla@arm.com> wrote:
> >
> > On Thu, Jul 13, 2023 at 04:17:36PM +0200, Ulf Hansson wrote:
> > > The performance domain-id can be described in DT using the power-domains
> > > property or the clock property. The latter is already supported, so let's
> > > add support for the power-domains too.
> > >
> >
> > How is this supposed to work for the CPUs ? The CPU power domains are
> > generally PSCI on most of the platforms and the one using OSI explicitly
> > need to specify the details while ones using PC will not need to. Also they
> > can never be performance domains too. So I am not sure if I am following this
> > correctly.
> 
> Your concerns are certainly correct, I completely forgot about this.
> We need to specify what power-domain index belongs to what, by using
> power-domain-names in DT. So a CPU node, that has both psci for power
> and scmi for performance would then typically look like this:
> 
> power-domains = <&CPU_PD0>, <&scmi_dvfs 4>;
> power-domain-names = "psci", "scmi";
> 
> I will take care of this in the next version - and thanks a lot for
> pointing this out!


Yes something like this will work. Just curious will this impact the idle
paths ? By that I mean will the presence of additional domains add more
work or will they be skipped as early as possible with just one additional
check ?

-- 
Regards,
Sudeep
