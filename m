Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 699C076A3E0
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 00:03:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231765AbjGaWDN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 18:03:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231822AbjGaWDA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 18:03:00 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E0E7139;
        Mon, 31 Jul 2023 15:02:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=gHoaM7eGFNI0KBp/0qw5JaxvSgb4EPXM7prcdF6Gpvo=; b=YOow06njeJ2olbzkCBKb8IZ9Nj
        jVqID3WRMSIwJ/moJkKieCB6dlOM6c18c0/E525uSPWKhKvDBfNhl9+sz1rfHT7CU0mSzimPsTbJD
        SK2jmsLU3kM/+Y+W+yFl5k69zuubZRgknxIPJtf1rGYYqD6UM5g0DcZNixGYffLkNEyZaZHbpNAYz
        mnxoMRdRuuxhHWWwK+QcuIELp00rYFGkNBppcswr9d0vcIkKFOXZRwth+afyxMBZQ4ZhStUOUIrfh
        vJLv4jqUMgfChpAkgO1/UwuuaC8r5L/k4nORLEkD6rVlDJTDwp5/6ZNJg5U2A4yRLuJa/HKlsXMhI
        3TkWjTVw==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qQayW-00HSp6-1h;
        Mon, 31 Jul 2023 22:02:48 +0000
Message-ID: <afac2810-f93e-eda5-975e-041ac4b908b5@infradead.org>
Date:   Mon, 31 Jul 2023 15:02:47 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 2/2] cpufreq: add virtual-cpufreq driver
Content-Language: en-US
To:     David Dai <davidai@google.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Saravana Kannan <saravanak@google.com>
Cc:     Quentin Perret <qperret@google.com>,
        Masami Hiramatsu <mhiramat@google.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Pavan Kondeti <quic_pkondeti@quicinc.com>,
        Gupta Pankaj <pankaj.gupta@amd.com>,
        Mel Gorman <mgorman@suse.de>, kernel-team@android.com,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230731174613.4133167-1-davidai@google.com>
 <20230731174613.4133167-3-davidai@google.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230731174613.4133167-3-davidai@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/31/23 10:46, David Dai wrote:
> diff --git a/drivers/cpufreq/Kconfig b/drivers/cpufreq/Kconfig
> index f429b9b37b76..3977ca796747 100644
> --- a/drivers/cpufreq/Kconfig
> +++ b/drivers/cpufreq/Kconfig
> @@ -217,6 +217,21 @@ config CPUFREQ_DT
>  
>  	  If in doubt, say N.
>  
> +config CPUFREQ_VIRT
> +        tristate "Virtual cpufreq driver"
> +	depends on OF
> +	select PM_OPP
> +        help

The 4 lines above should be indented with one tab (not 8 spaces).

> +	  This adds a virtualized cpufreq driver for guest kernels that
> +	  read/writes to a MMIO region for a virtualized cpufreq device to

	  reads/writes to an MMIO region

> +	  communicate with the host. It sends frequency updates to the host
> +	  which gets used as a hint to schedule vCPU threads and select CPU
> +	  frequency. If a VM does not support a virtualized FIE such as AMUs,
> +	  it updates the frequency scaling factor by polling host CPU frequency
> +	  to enable accurate Per-Entity Load Tracking for tasks running in the guest.
> +
> +	  If in doubt, say N.

-- 
~Randy
