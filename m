Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56EB875CA2F
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 16:38:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230346AbjGUOhn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 10:37:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229977AbjGUOhc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 10:37:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E50510C3;
        Fri, 21 Jul 2023 07:37:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3401E61CB7;
        Fri, 21 Jul 2023 14:37:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C8CFC433C8;
        Fri, 21 Jul 2023 14:37:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689950250;
        bh=xpqxjfNAq5qfvoIZPKgroAgkBwTKCqC8LQuUTeKH068=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Qz82IEOVGRejf21pj2fxcQ3819Lc2X2kORWsZeIH7MAYoBDthODOVTRQQGY/gqYU6
         gCC13j/7VQbLR/x9PmTnBmbGuhztJzZEvE/UL0lQ0jypssH0legAV0ikXYhQlVn6v0
         fVnQkCZ2VTPy7aOuSK6OxnlRCcIQyyecEyucGhKTbeYBE7BgdUkR0OZ8ibIug/it76
         dh+ighX2LLYodIUqqUuxwdewd1PEyrjBlSnYfDsnfaUVrdCxeEej+M9Lvp4Vne3Ti4
         XXeIAV5SgJRyP4gKCJqKFdFec1h0oYZsbI9WtNbfZv9uFb+LP0YxhaH5xOfcWO9omf
         2ymXAnyhOUnxQ==
Received: (nullmailer pid 1104459 invoked by uid 1000);
        Fri, 21 Jul 2023 14:37:28 -0000
Date:   Fri, 21 Jul 2023 08:37:28 -0600
From:   Rob Herring <robh@kernel.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Nikunj Kela <nkela@quicinc.com>,
        Prasad Sodagudi <psodagud@quicinc.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 09/11] cpufreq: scmi: Add support to parse domain-id
 using #power-domain-cells
Message-ID: <20230721143728.GB1092306-robh@kernel.org>
References: <20230713141738.23970-1-ulf.hansson@linaro.org>
 <20230713141738.23970-10-ulf.hansson@linaro.org>
 <20230719152426.qwc5qqewrfjsarlz@bogus>
 <CAPDyKFogrwFnz2ZuKE-mLrCQmTCQcrtjhhyzB4CnoVnxAXqKEg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFogrwFnz2ZuKE-mLrCQmTCQcrtjhhyzB4CnoVnxAXqKEg@mail.gmail.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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

That is completely backwards. Entries are named based on the consumer 
side. The function of each clock or interrupt for example. Here your 
entries are based on the provider which should be opaque to the 
consumer.

Rob
