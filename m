Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DD0F7EBE48
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 08:55:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343494AbjKOHz6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 02:55:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234619AbjKOHz4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 02:55:56 -0500
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E30CD9
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 23:55:53 -0800 (PST)
Received: by mail-yb1-xb35.google.com with SMTP id 3f1490d57ef6-d9abc069c8bso6383559276.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 23:55:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700034952; x=1700639752; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1cL1YF7VYkHyUQDre6FeOXMq1Y6gs7hRDyZk7Lj8ek4=;
        b=mfNRmCiME5CwNOhpgcKo7gX9/jzjkkY+uHHKRUNKgkSi+CQj0MRz9lhLS7IX7icHCp
         PYeyAinmKzDpwDYI9HHSnm7GRr2q0xxyMV87m1UpbEzR/yZZQLXChrlRlnTURpMIljV7
         DBIunOXR21MsPu5jtzaEg5fgNO+L0D+OgAS6kmElsOR7gjgcjbRkkBvjuGxcGro6Ge3w
         3JMRzFredeoATbcG4nKhfQSSgIeey4fi5k51tabi41Z1DsU1S0zAwbn1sYTVfHUBofU6
         +ddpYkXtUBOs1lqDfQDbkmGAEsVCTeu5EsjYm9oZHr3PQqdZjNSGQ/Qq2pVT1xcncpiB
         h4pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700034952; x=1700639752;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1cL1YF7VYkHyUQDre6FeOXMq1Y6gs7hRDyZk7Lj8ek4=;
        b=wXGP2V5keO0vFL5o5OOcagj5735i/Z5LasZNuxxjIS+hAHJ6aiFQdmepyk5PjhH1hD
         MKzuvNij4cSN/GTwVU4I5UXT9l8gi4mWaLGgDgH3GA2OjK2MacN7ccpQKJFa4zh+3NrU
         oorpowkr+7D1h906Xjk+MW18TWv4f385hsUlfCVedVm1zRc15dbarba5QoqahOPeIQoV
         vAdi1oV3DglnnXhvU171f7LjkTT7P8LNfzylCuQahjYw3KKpMIgYkeEaBlkmGB3u7pM7
         w9SPSol89InRwW8JPA1wGXtVUMN2ade2lykQYUZ05tKq7ispMXvOlfjfekXbW7xiFgUe
         6POw==
X-Gm-Message-State: AOJu0YwECkos4VsPOjl/UYcO7U2hhklB/RegvgJqR7XJggrjUjo+HK0K
        Aq+xpfzsrzUK7euaFjDiMx9K
X-Google-Smtp-Source: AGHT+IH6yC5GdbaOIWZXJDVCumwRsf2gOHHZ7eQVvr7ft8F6sZFGm9FyqwuaVHz4x820Pelgc1BuYA==
X-Received: by 2002:a25:ce85:0:b0:d9a:5220:d6b3 with SMTP id x127-20020a25ce85000000b00d9a5220d6b3mr9275344ybe.56.1700034952390;
        Tue, 14 Nov 2023 23:55:52 -0800 (PST)
Received: from workstation ([117.217.189.60])
        by smtp.gmail.com with ESMTPSA id i6-20020ad44106000000b006731d3380f1sm350475qvp.15.2023.11.14.23.55.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 Nov 2023 23:55:51 -0800 (PST)
Date:   Wed, 15 Nov 2023 13:25:42 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Johan Hovold <johan@kernel.org>, Viresh Kumar <vireshk@kernel.org>,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>, andersson@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org,
        robdclark@gmail.com, dmitry.baryshkov@linaro.org
Subject: Re: [PATCH 2/2] OPP: Disallow "opp-hz" property without a
 corresponding clk
Message-ID: <20231115075542.GA20982@workstation>
References: <cover.1669012140.git.viresh.kumar@linaro.org>
 <c03c4f2b9d4dcc3264d1902606c6c5c464b4b043.1669012140.git.viresh.kumar@linaro.org>
 <Y3snGQet8yc7HnJK@hovoldconsulting.com>
 <20221121073946.GE11945@thinkpad>
 <20230125042145.hrjpnskywwqn7b6v@vireshk-i7>
 <20230216064727.GA2420@thinkpad>
 <20231011054858.3vvnr76u5enu5lf6@vireshk-i7>
 <20231115063201.rc3pf3pga6zhoqb5@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231115063201.rc3pf3pga6zhoqb5@vireshk-i7>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ Dmitry

On Wed, Nov 15, 2023 at 12:02:01PM +0530, Viresh Kumar wrote:
> On 11-10-23, 11:18, Viresh Kumar wrote:
> > On 16-02-23, 12:17, Manivannan Sadhasivam wrote:
> > > Sorry for the delay. I've submitted the dts changes [1] to handle the CPU clocks
> > > for the rest of the Qcom SoCs.
> > > 
> > > For the Qcom GPUs, I've CCed Rob Clark who is the maintainer.
> > > 
> > > Rob, here is the background on the issue that is being discussed in this
> > > thread:
> > > 
> > > Viresh submitted a series [2] back in July to improve the OPP framework, but
> > > that ended up breaking cpufreq on multiple Qcom SoCs. After investigation, it
> > > was found that the series was expecting the clocks supplied to the OPP end
> > > devices like CPUs/GPUs to be modeled in DT. But on Qcom platforms even though
> > > the clocks for these nodes are supplied by a separate entity, like CPUFreq
> > > (EPSS/OSM) for CPUs and GMU for GPUs, there was no clock property present in
> > > the respective nodes. And these nodes are using OPP table to switch frequencies
> > > dynamically.
> > > 
> > > While the series was merged with a hack that still allows the OPP nodes without
> > > clock property in DT, we came to an agreement that the clock hierarchy should
> > > be modeled properly.
> > > 
> > > So I submitted a series [3] that added clock provider support to cpufreq driver
> > > and sourced the clock from cpufreq node to CPU nodes in DT.
> > > 
> > > Likewise, it should be handled for the adreno GPUs whose clock is managed by
> > > GMU on newer SoCs. Can you take a look at this?
> > 
> > Any update on this ?
> 
> Mani,
> 
> Ping.
> 

Dmitry, can you please look into this? Please read my above reply to Rob
to get the background.

- Mani

> -- 
> viresh
