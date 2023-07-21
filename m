Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6707C75D176
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 20:38:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230331AbjGUSiw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 14:38:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjGUSiu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 14:38:50 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A32FF30CA;
        Fri, 21 Jul 2023 11:38:48 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A7C5D150C;
        Fri, 21 Jul 2023 11:39:31 -0700 (PDT)
Received: from bogus (unknown [10.57.96.100])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C458D3F738;
        Fri, 21 Jul 2023 11:38:44 -0700 (PDT)
Date:   Fri, 21 Jul 2023 19:38:17 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Rob Herring <robh@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Cristian Marussi <cristian.marussi@arm.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Nikunj Kela <nkela@quicinc.com>,
        Prasad Sodagudi <psodagud@quicinc.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 08/11] dt-bindings: firmware: arm,scmi: Extend
 bindings for protocol@13
Message-ID: <20230721183817.34lgb42nlnsvqx4s@bogus>
References: <20230713141738.23970-1-ulf.hansson@linaro.org>
 <20230713141738.23970-9-ulf.hansson@linaro.org>
 <20230719151716.qhobfnclrjf4yqkg@bogus>
 <CAPDyKFpjMWOAbV+b2DcxDWqvRDQCbSC6Ti+KGGPWJoC4Ghp7=w@mail.gmail.com>
 <20230721115535.mx46dg56pxjnzbuv@bogus>
 <20230721143304.GA1092306-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230721143304.GA1092306-robh@kernel.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 21, 2023 at 08:33:04AM -0600, Rob Herring wrote:
> On Fri, Jul 21, 2023 at 12:55:35PM +0100, Sudeep Holla wrote:
> > On Fri, Jul 21, 2023 at 01:42:43PM +0200, Ulf Hansson wrote:
> > > On Wed, 19 Jul 2023 at 17:17, Sudeep Holla <sudeep.holla@arm.com> wrote:
> > > >
> > > > On Thu, Jul 13, 2023 at 04:17:35PM +0200, Ulf Hansson wrote:
> > > > > The protocol@13 node is describing the performance scaling option for the
> > > > > ARM SCMI interface, as a clock provider. This is unnecessary limiting, as
> > > > > performance scaling is in many cases not limited to switching a clock's
> > > > > frequency.
> > > > >
> > > > > Therefore, let's extend the binding so the interface can be modelled as a
> > > > > generic performance domaintoo. The common way to describe this, is to use
> > > > > the "power-domain" DT bindings, so let's use that.
> > > > >
> > > >
> > > > One thing I forgot to ask earlier is how we can manage different domain IDs
> > > > for perf and power domains which is the case with current SCMI platforms as
> > > > the spec never mandated or can ever mandate the perf and power domains IDs
> > > > to match. They need not be same anyways.
> > > 
> > > Based upon what you describe above, I have modelled the perf-domain
> > > and the power-domain as two separate power-domain providers.
> > > 
> > > A consumer device being hooked up to both domains, would specify the
> > > domain IDs in the second power-domain-cell, along the lines of the
> > > below. Then we would use power-domain-names to specify what each
> > > power-domain represents.
> > > 
> > > power-domains = <&scmi_pd 2>, <&scmi_dvfs 4>;
> > > power-domain-names = "power", "perf";
> > >
> > > I hope this makes it clearer!?
> > 
> > Yes it make is clear definitely, but it does change the definition of the
> > generic binding of the "power-domains" property now. I am interesting in
> > the feedback from the binding maintainers with respect to that. Or is it
> > already present ? IIUC, the ones supported already are generally both
> > power and performance providers. May be it doesn't matter much, just
> > wanted to explicit ask and confirm those details.
> 
> I commented on v1.
> 
> Looks like abuse of "power-domains" to me, but nothing new really. 
> Please define when to use a power domain vs. a perf domain and don't 
> leave it up to the whims of the platform. Maybe perf domains was a 
> mistake and they should be deprecated?
> 

Just a thought here, instead of deprecating it I was thinking if possible
to keep the power-domains and performance-domains separate and just extend
the genpd to handle the latter. There by we are not mixing up and creating
confusions that need more specific definitions in the binding(which is not
a big deal) but platforms getting it wrong inspite of that is a big problem.
Keep it separate makes it more aligned to the hardware and doesn't dilute
the definitions and probably avoids any possible mistakes due to that.

Sorry Ulf I am just not yet convinced to mix them up yet 😉 and wish you
don't convince me to. Let me know why the above suggestion won't work.

-- 
Regards,
Sudeep
