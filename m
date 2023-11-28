Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2633D7FB7F7
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 11:35:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344160AbjK1Kez (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 05:34:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234887AbjK1Kei (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 05:34:38 -0500
Received: from mx.kernkonzept.com (serv1.kernkonzept.com [IPv6:2a01:4f8:1c1c:b490::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7920F5B8A;
        Tue, 28 Nov 2023 02:29:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kernkonzept.com; s=mx1; h=In-Reply-To:Content-Type:MIME-Version:References:
        Message-ID:Subject:Cc:To:From:Date:Content-Transfer-Encoding:Reply-To:
        Content-ID:Content-Description;
        bh=EpPTjdpeYg0w4loH5/do8EUAnKxDsHXE57/3N6Z68X8=; b=aLdRprn3bm9/VdAqUWI8sZMDGy
        4Ueng9SKAuU2e4Wskgkno4UbZJlnpP1eXl7/6jV83jVYOdflrys0QAs5XEyLEhJAVz+3zfCG1nQ/K
        UsECCbRLlUpCwUYGqIKNij7GFXm/zEzzUhop4GmiIe29IczYFLyBNWr6ND5nCi5U6/EY5SEBMYaVG
        Ts4FZFbJTzvcmHSneNFdPCkUT/xUVlPJDP46mN09+1yQnBgpvVdEKHDorkkVgSkg3hTloxLFZUcgX
        Ae1wbZ+mlHK2lNlDk6tFANDHpBn6pf2/rXnN5qDETiZmVfpSq4NOfeer3tEfxtBlRYoeTXdMjxUek
        /R1p8+7w==;
Received: from [10.22.3.24] (helo=kernkonzept.com)
        by mx.kernkonzept.com with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim 4.96)
        id 1r7vLD-008QQS-33;
        Tue, 28 Nov 2023 11:29:19 +0100
Date:   Tue, 28 Nov 2023 11:29:11 +0100
From:   Stephan Gerhold <stephan.gerhold@kernkonzept.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>, Nishanth Menon <nm@ti.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3 0/3]  OPP: Simplify required-opp handling
Message-ID: <ZWXA9_VDRKzMA9Nj@kernkonzept.com>
References: <cover.1700131353.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1700131353.git.viresh.kumar@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 16, 2023 at 04:13:04PM +0530, Viresh Kumar wrote:
> Configuring the required OPP was never properly implemented, we just
> took an exception for genpds and configured them directly, while leaving
> out all other required OPP types.
> 
> Now that a standard call to dev_pm_opp_set_opp() takes care of
> configuring the opp->level too, the special handling for genpds can be
> avoided by simply calling dev_pm_opp_set_opp() for the required OPPs,
> which shall eventually configure the corresponding level for genpds.
> 
> This also makes it possible for us to configure other type of required
> OPPs (no concrete users yet though), via the same path. This is how
> other frameworks take care of parent nodes, like clock, regulators, etc,
> where we recursively call the same helper.
> 
> Pushed here:
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git opp/required-opps
> 

Sorry for the delay. I tested the "opp/linux-next" branch (which seems
to contain the changes in this series already now) with the following
configurations:

 - Single genpd used for cpufreq (MSM8909): Works
 - Multiple genpd used for cpufreq (MSM8916): Works
 - Single genpd used for cpufreq + parent genpd (MSM8916): Works, warning gone

Thanks for fixing this! :-)

I guess I'm too late now but FWIW:

Tested-by: Stephan Gerhold <stephan.gerhold@kernkonzept.com>

> V2->V3:
> - Dropped patch 1/3, merged.
> - Added a new commit to avoid propagation and a WARN() for parent genpd case.
> 
> V1->V2:
> - Support opp-level 0, drop vote i.e..
> - Fix OPP pointer while calling dev_pm_opp_set_opp() recursively.
> - Minor checks and fixes.
> - Add Reviewed-by from Ulf.
> 
> --
> Viresh
> 
> Viresh Kumar (3):
>   OPP: Use _set_opp_level() for single genpd case
>   OPP: Call dev_pm_opp_set_opp() for required OPPs
>   OPP: Don't set OPP recursively for a parent genpd
> 
>  drivers/opp/core.c     | 180 ++++++++++++++++++++++-------------------
>  drivers/opp/of.c       |  49 ++++++++---
>  drivers/opp/opp.h      |   8 +-
>  include/linux/pm_opp.h |   7 +-
>  4 files changed, 144 insertions(+), 100 deletions(-)
> 
> -- 
> 2.31.1.272.g89b43f80a514
> 

-- 
Stephan Gerhold <stephan.gerhold@kernkonzept.com>
Kernkonzept GmbH at Dresden, Germany, HRB 31129, CEO Dr.-Ing. Michael Hohmuth
