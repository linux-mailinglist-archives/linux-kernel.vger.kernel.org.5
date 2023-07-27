Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17428765070
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 11:56:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232941AbjG0J4g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 05:56:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232981AbjG0J4W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 05:56:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D4C9122;
        Thu, 27 Jul 2023 02:56:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EA3E161DE6;
        Thu, 27 Jul 2023 09:56:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D4A9C433C8;
        Thu, 27 Jul 2023 09:56:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690451771;
        bh=J7ZXQyJs9VwKG49702cEjp5BBaWLGJW95hpeDTHwnW0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ovuRrgBqVfaaWo+AAwh7i+/KJm/+GHfb6IJKGJChshbe239WjFuQlKZOOvI14PUa3
         FtWY5zy2T5NNpwmlMC0ILDQRtX8fa621Ei/QimyzHH8lkTRdZ0bI5ioEn/c0pvgVtL
         jui5siBD6Z2Sqj+wr+CqYSHbBLd23sRVyox9Yua11qZKdm8pXq7OVT+eDaes6rEEB5
         ihpjm9VfTdApcBvVtqqGZ1pWLf5QEBqBZYS5uM8pxB5NLvNfennidFGMoP2c4ELZn8
         +v4MHOfOH6XG49E9M6z+DqEbcP+Dq/ZFMP+wn+aTzrXXqXPGMLSMJQNENcntNfhjoj
         Xb9GoZpGa+EoA==
Date:   Thu, 27 Jul 2023 10:56:05 +0100
From:   Will Deacon <will@kernel.org>
To:     Beata Michalska <beata.michalska@arm.com>
Cc:     Sudeep Holla <sudeep.holla@arm.com>, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        catalin.marinas@arm.com, mark.rutland@arm.com, rafael@kernel.org,
        viresh.kumar@linaro.org, ionela.voinescu@arm.com,
        sumitg@nvidia.com, yang@os.amperecomputing.com
Subject: Re: [PATCH] arm64: Provide an AMU-based version of
 arch_freq_get_on_cpu
Message-ID: <20230727095604.GA18721@willie-the-truck>
References: <20230606155754.245998-1-beata.michalska@arm.com>
 <20230607095856.7nyv7vzuehceudnl@bogus>
 <ZICNkXfBQUiT/BvK@e120325.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZICNkXfBQUiT/BvK@e120325.cambridge.arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 07, 2023 at 03:00:49PM +0100, Beata Michalska wrote:
> On Wed, Jun 07, 2023 at 10:58:56AM +0100, Sudeep Holla wrote:
> > On Tue, Jun 06, 2023 at 04:57:54PM +0100, Beata Michalska wrote:
> > > With the Frequency Invariance Engine (FIE) being already wired up with
> > > sched tick and making use of relevant (core counter and constant
> > > counter) AMU counters, getting the current frequency for a given CPU
> > > on supported platforms, can be achieved by utilizing the frequency scale
> > > factor which reflects an average CPU frequency for the last tick period
> > > length.
> > > 
> > > With that at hand, arch_freq_get_on_cpu dedicated implementation
> > > gets enrolled into cpuinfo_cur_freq policy sysfs attribute handler,
> > > which is expected to represent the current frequency of a given CPU,
> > > as obtained by the hardware. This is exactly the type of feedback that
> > > cycle counters provide.
> > > 
> > > In order to avoid calling arch_freq_get_on_cpu from the scaling_cur_freq
> > > attribute handler for platforms that do provide cpuinfo_cur_freq, and
> > > yet keeping things intact for those platform that do not, its use gets
> > > conditioned on the presence of cpufreq_driver (*get) callback (which also
> > > seems to be the case for creating cpuinfo_cur_freq attribute).
> > >
> > 
> > LGTM,
> > 
> > Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
> > 
> Thanks for the review.
> > However I fail to understand if both the changes are dependent ?
> > Can this be split into 2 patches ? I fail to see the dependency, what
> > am I missing ? Even if there is some dependency to get arch value
> > (arch_freq_get_on_cpu() from show_cpuinfo_cur_freq()), you can push
> > that change first followed by the arm64 change as 2 different change.
> > 
> I guess I could split the patch into two parts:
> 1. adding implementation for the arch_freq_get_on_cpu
> 2. wiring it up with the cpufreq relevant attrib handlers
> 
> or the other way round (if that's what you have in mind).
> 
> Will wait a bit for any further comments before pushing new v.

Are you still planning on a v2?

Will
