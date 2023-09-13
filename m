Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D330179E552
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 12:52:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239785AbjIMKwz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 06:52:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239771AbjIMKwy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 06:52:54 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D861F19AD;
        Wed, 13 Sep 2023 03:52:49 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D25C51FB;
        Wed, 13 Sep 2023 03:53:26 -0700 (PDT)
Received: from bogus (unknown [10.57.93.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A941C3F5A1;
        Wed, 13 Sep 2023 03:52:47 -0700 (PDT)
Date:   Wed, 13 Sep 2023 11:51:48 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Will Deacon <will@kernel.org>
Cc:     Oza Pawandeep <quic_poza@quicinc.com>, catalin.marinas@arm.com,
        Sudeep Holla <sudeep.holla@arm.com>, rafael@kernel.org,
        lenb@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH v5] cpuidle, ACPI: Evaluate LPI arch_flags for broadcast
 timer
Message-ID: <20230913105148.xntz3qeascibvuxx@bogus>
References: <20230912172933.3561144-1-quic_poza@quicinc.com>
 <20230913083908.dfanwizomj5i536k@bogus>
 <20230913102721.GB12021@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230913102721.GB12021@willie-the-truck>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 13, 2023 at 11:27:21AM +0100, Will Deacon wrote:
> On Wed, Sep 13, 2023 at 09:43:01AM +0100, Sudeep Holla wrote:
> > On Tue, Sep 12, 2023 at 10:29:33AM -0700, Oza Pawandeep wrote:
> > > Arm� Functional Fixed Hardware Specification defines LPI states,
> > > which provide an architectural context loss flags field that can
> > > be used to describe the context that might be lost when an LPI
> > > state is entered.
> > > 
> > > - Core context Lost
> > >         - General purpose registers.
> > >         - Floating point and SIMD registers.
> > >         - System registers, include the System register based
> > >         - generic timer for the core.
> > >         - Debug register in the core power domain.
> > >         - PMU registers in the core power domain.
> > >         - Trace register in the core power domain.
> > > - Trace context loss
> > > - GICR
> > > - GICD
> > > 
> > > Qualcomm's custom CPUs preserves the architectural state,
> > > including keeping the power domain for local timers active.
> > > when core is power gated, the local timers are sufficient to
> > > wake the core up without needing broadcast timer.
> > > 
> > > The patch fixes the evaluation of cpuidle arch_flags, and moves only to
> > > broadcast timer if core context lost is defined in ACPI LPI.
> > > 
> > > Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
> > 
> > IIRC, Rafael had acked this, perhaps missing the tag ?
> > Also just add a note to Will/Catalin that Rafael has acked and prefer to
> > take it via arm64 tree.
> 
> Is this a fix? If so, please can I have a "Fixes:" tag (and does it need to
> go into stable?)
>

Well, most platform today have CPUIDLE_CORE_CTXT set so the existing code
works as expected. It is this Qcom platform that doesn't set it and need
different behaviour. So based on their requirement for running stable
tree, the fixes tag can be added. In short yes it can be seen as a fix
if this new requirement is considered.

Sorry the main reason for trying to avoid is there are multiple patches
adding the initial support and there has been some code restructuring
around this. So it may need proper backporting based on the version.
I just want to avoid if there is no real requirement for that.

--
Regards,
Sudeep
