Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDCE67DB8EF
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 12:29:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232997AbjJ3L3J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 07:29:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232958AbjJ3L3I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 07:29:08 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2E239B3;
        Mon, 30 Oct 2023 04:29:05 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 932DCFEC;
        Mon, 30 Oct 2023 04:29:46 -0700 (PDT)
Received: from [192.168.1.3] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6D8F83F67D;
        Mon, 30 Oct 2023 04:29:02 -0700 (PDT)
Message-ID: <288bcd70-ee12-e4f7-2381-8d18e6fc0c1b@arm.com>
Date:   Mon, 30 Oct 2023 11:29:03 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2 4/8] coresight-tpdm: Add support to configure CMB
Content-Language: en-US
To:     Tao Zhang <quic_taozha@quicinc.com>
Cc:     Jinlong Mao <quic_jinlmao@quicinc.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Song Chai <quic_songchai@quicinc.com>,
        linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Konrad Dybcio <konradybcio@gmail.com>,
        Mike Leach <mike.leach@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
References: <1698202408-14608-1-git-send-email-quic_taozha@quicinc.com>
 <1698202408-14608-5-git-send-email-quic_taozha@quicinc.com>
From:   James Clark <james.clark@arm.com>
In-Reply-To: <1698202408-14608-5-git-send-email-quic_taozha@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 25/10/2023 03:53, Tao Zhang wrote:
> TPDM CMB subunits support two forms of CMB data set element creation:
> continuous and trace-on-change collection mode. Continuous change
> creates CMB data set elements on every CMBCLK edge. Trace-on-change
> creates CMB data set elements only when a new data set element differs
> in value from the previous element in a CMB data set. Set CMB_CR.MODE
> to 0 for continuous CMB collection mode. Set CMB_CR.MODE to 1 for
> trace-on-change CMB collection mode
> 
> Signed-off-by: Tao Zhang <quic_taozha@quicinc.com>
> Signed-off-by: Jinlong Mao <quic_jinlmao@quicinc.com>
> ---
>  .../ABI/testing/sysfs-bus-coresight-devices-tpdm   | 10 +++
>  drivers/hwtracing/coresight/coresight-tpdm.c       | 71 ++++++++++++++++++++++
>  drivers/hwtracing/coresight/coresight-tpdm.h       | 12 ++++
>  3 files changed, 93 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm b/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm
> index f07218e..ace7231 100644
> --- a/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm
> +++ b/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm
> @@ -170,3 +170,13 @@ Contact:	Jinlong Mao (QUIC) <quic_jinlmao@quicinc.com>, Tao Zhang (QUIC) <quic_t
>  Description:
>  		(RW) Set/Get the MSR(mux select register) for the DSB subunit
>  		TPDM.
> +
> +What:		/sys/bus/coresight/devices/<tpdm-name>/cmb_mode
> +Date:		March 2023
> +KernelVersion	6.7
> +Contact:	Jinlong Mao (QUIC) <quic_jinlmao@quicinc.com>, Tao Zhang (QUIC) <quic_taozha@quicinc.com>
> +Description:	(Write) Set the data collection mode of CMB tpdm.

I know it's expanded elsewhere, but it's probably worth expanding the
CMB abbreviation here as well so people reading the docs don't have to
go into the code.

Otherwise:

Reviewed-by: James Clark <james.clark@arm.com>

> +
> +		Accepts only one of the 2 values -  0 or 1.
> +		0 : Continuous CMB collection mode.
> +		1 : Trace-on-change CMB collection mode.
> diff --git a/drivers/hwtracing/coresight/coresight-tpdm.c b/drivers/hwtracing/coresight/coresight-tpdm.c
> index c8bb388..efb376e 100644
> --- a/drivers/hwtracing/coresight/coresight-tpdm.c
> +++ b/drivers/hwtracing/coresight/coresight-tpdm.c
> @@ -148,6 +148,18 @@ static umode_t tpdm_dsb_is_visible(struct kobject *kobj,
>  	return 0;
>  }

[...]
