Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA5A279E4DF
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 12:27:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239671AbjIMK1d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 06:27:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235450AbjIMK1b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 06:27:31 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 979A11989;
        Wed, 13 Sep 2023 03:27:27 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84B55C433C8;
        Wed, 13 Sep 2023 10:27:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694600847;
        bh=V3lpNZExinvJ7sElkKRa9XZCuf6kPmAXcMMplgPNDl4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JZwOIE7VN94u2rpU7L20jZRmjtCK8CdeOqVWc8kTw9OveDj2Ni0wV0l2u1+Gi9B1v
         pkd0YNIQ56+eiw0NfY+/EWbBPVaUS/ltH+it5KYmv8eLEpQHY0Bxgp0m4gSndrPK6W
         MycPUViihGLMhB08gSDO6X0B02kbl9P8bfKqm/nnt57qkYxMT4C1nLrcHZDhURqLRy
         Pi4YhqvIFF4JwThNvXtw2dfk5W2euzxx06/4Z2GzjO2n/4ry67CIfscUeXP+2gH8Gw
         z/SA/EN03SJHjBLxFayozzs2kEdrvC3DtXQdxjU8NKUQ+5n7cQPGjQlmgL4/h8N2QW
         EnozEduJy+yxg==
Date:   Wed, 13 Sep 2023 11:27:21 +0100
From:   Will Deacon <will@kernel.org>
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Oza Pawandeep <quic_poza@quicinc.com>, catalin.marinas@arm.com,
        rafael@kernel.org, lenb@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org
Subject: Re: [PATCH v5] cpuidle, ACPI: Evaluate LPI arch_flags for broadcast
 timer
Message-ID: <20230913102721.GB12021@willie-the-truck>
References: <20230912172933.3561144-1-quic_poza@quicinc.com>
 <20230913083908.dfanwizomj5i536k@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230913083908.dfanwizomj5i536k@bogus>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 13, 2023 at 09:43:01AM +0100, Sudeep Holla wrote:
> On Tue, Sep 12, 2023 at 10:29:33AM -0700, Oza Pawandeep wrote:
> > Arm® Functional Fixed Hardware Specification defines LPI states,
> > which provide an architectural context loss flags field that can
> > be used to describe the context that might be lost when an LPI
> > state is entered.
> > 
> > - Core context Lost
> >         - General purpose registers.
> >         - Floating point and SIMD registers.
> >         - System registers, include the System register based
> >         - generic timer for the core.
> >         - Debug register in the core power domain.
> >         - PMU registers in the core power domain.
> >         - Trace register in the core power domain.
> > - Trace context loss
> > - GICR
> > - GICD
> > 
> > Qualcomm's custom CPUs preserves the architectural state,
> > including keeping the power domain for local timers active.
> > when core is power gated, the local timers are sufficient to
> > wake the core up without needing broadcast timer.
> > 
> > The patch fixes the evaluation of cpuidle arch_flags, and moves only to
> > broadcast timer if core context lost is defined in ACPI LPI.
> > 
> > Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
> 
> IIRC, Rafael had acked this, perhaps missing the tag ?
> Also just add a note to Will/Catalin that Rafael has acked and prefer to
> take it via arm64 tree.

Is this a fix? If so, please can I have a "Fixes:" tag (and does it need to
go into stable?)

Will
