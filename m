Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5AFF79BB0B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:12:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348516AbjIKV1I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 17:27:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235524AbjIKIvT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 04:51:19 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1B4291A2;
        Mon, 11 Sep 2023 01:51:14 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AE163D75;
        Mon, 11 Sep 2023 01:51:50 -0700 (PDT)
Received: from [192.168.1.3] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 936563F5A1;
        Mon, 11 Sep 2023 01:51:12 -0700 (PDT)
Message-ID: <446ec4c1-e97f-a5a1-9830-693dd7eec52d@arm.com>
Date:   Mon, 11 Sep 2023 09:51:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] perf test: Update cs_etm testcase for Arm ETE
To:     Ruidong Tian <tianruidong@linux.alibaba.com>
Cc:     coresight@lists.linaro.org, mike.leach@linaro.org,
        alexander.shishkin@linux.intel.com,
        linux-arm-kernel@lists.infradead.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        "acme@kernel.org" <acme@kernel.org>
References: <20230911065541.91293-1-tianruidong@linux.alibaba.com>
Content-Language: en-US
From:   James Clark <james.clark@arm.com>
In-Reply-To: <20230911065541.91293-1-tianruidong@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/09/2023 07:55, Ruidong Tian wrote:
> Add ETE as one of the supported device types in perf cs_etm testcase.
> 
> Signed-off-by: Ruidong Tian <tianruidong@linux.alibaba.com>
> ---
>  tools/perf/tests/shell/test_arm_coresight.sh | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/tests/shell/test_arm_coresight.sh b/tools/perf/tests/shell/test_arm_coresight.sh
> index f1bf5621160f..fe78c4626e45 100755
> --- a/tools/perf/tests/shell/test_arm_coresight.sh
> +++ b/tools/perf/tests/shell/test_arm_coresight.sh
> @@ -11,6 +11,19 @@
>  
>  glb_err=0
>  
> +cs_etm_dev_name() {
> +	cs_etm_path=$(find  /sys/bus/event_source/devices/cs_etm/ -name cpu* -print -quit)
> +	trcdevarch=$(cat ${cs_etm_path}/mgmt/trcdevarch)
> +	archhver=$((($trcdevarch >> 12) & 0xf))
> +	archpart=$(($trcdevarch & 0xfff))
> +
> +	if [ $archhver -eq 5 -a "$(printf "0x%X\n" $archpart)" = "0xA13" ] ; then
> +		echo "ete"
> +	else
> +		echo "etm"
> +	fi
> +}
> +
>  skip_if_no_cs_etm_event() {
>  	perf list | grep -q 'cs_etm//' && return 0
>  
> @@ -136,7 +149,7 @@ arm_cs_iterate_devices() {
>  
>  arm_cs_etm_traverse_path_test() {
>  	# Iterate for every ETM device
> -	for dev in /sys/bus/coresight/devices/etm*; do
> +	for dev in /sys/bus/coresight/devices/$(cs_etm_dev_name)*; do
>  
>  		# Find the ETM device belonging to which CPU
>  		cpu=`cat $dev/cpu`

Reviewed-by: James Clark <james.clark@arm.com>
