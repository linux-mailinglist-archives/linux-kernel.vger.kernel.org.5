Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89F977AFF31
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 10:58:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230336AbjI0I6X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 04:58:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230232AbjI0I6R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 04:58:17 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CC8B2191;
        Wed, 27 Sep 2023 01:58:15 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B2B321FB;
        Wed, 27 Sep 2023 01:58:53 -0700 (PDT)
Received: from [10.57.1.56] (unknown [10.57.1.56])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E04A63F59C;
        Wed, 27 Sep 2023 01:58:12 -0700 (PDT)
Message-ID: <01a4ad7a-8031-558f-de87-a3ffc5d6c43c@arm.com>
Date:   Wed, 27 Sep 2023 09:58:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH v9 00/13] Add support to configure TPDM DSB subunit
To:     Tao Zhang <quic_taozha@quicinc.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Konrad Dybcio <konradybcio@gmail.com>,
        Mike Leach <mike.leach@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Jinlong Mao <quic_jinlmao@quicinc.com>,
        Leo Yan <leo.yan@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Hao Zhang <quic_hazha@quicinc.com>,
        linux-arm-msm@vger.kernel.org, andersson@kernel.org
References: <1694670204-11515-1-git-send-email-quic_taozha@quicinc.com>
 <2fe54425-70b5-95e8-1e9e-337424827adb@arm.com>
 <b31e427e-071f-1ded-eeb0-eb9a0f5dc075@quicinc.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <b31e427e-071f-1ded-eeb0-eb9a0f5dc075@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/09/2023 07:37, Tao Zhang wrote:
> 
> On 9/26/2023 9:12 PM, Suzuki K Poulose wrote:
>> On 14/09/2023 06:43, Tao Zhang wrote:
>>> Introduction of TPDM DSB subunit
>>> DSB subunit is responsible for creating a dataset element, and is also
>>> optionally responsible for packing it to fit multiple elements on a
>>> single ATB transfer if possible in the configuration. The TPDM Core
>>> Datapath requests timestamps be stored by the TPDA and then delivering
>>> ATB sized data (depending on ATB width and element size, this could
>>> be smaller or larger than a dataset element) to the ATB Mast FSM.
>>>
>>> The DSB subunit must be configured prior to enablement. This series
>>> adds support for TPDM to configure the configure DSB subunit.
>>>
>>> Once this series patches are applied properly, the new tpdm nodes for
>>> should be observed at the tpdm path /sys/bus/coresight/devices/tpdm*
>>> which supports DSB subunit.
>>> e.g.
>>> root@qemuarm64:/sys/devices/platform/soc@0/6c08000.tpdm/tpdm1# ls -l
>>> drwxr-xr-x    2 root     root             0 Jan  1 00:00 connections
>>> drwxr-xr-x    2 root     root             0 Jan  1 00:00 dsb_edge
>>> -rw-r--r--    1 root     root          4096 Jan  1 00:00 dsb_mode
>>> drwxr-xr-x    2 root     root             0 Jan  1 00:00 dsb_msr
>>> drwxr-xr-x    2 root     root             0 Jan  1 00:00 dsb_patt
>>> -rw-r--r--    1 root     root          4096 Jan  1 00:00 dsb_patt_ts
>>> -rw-r--r--    1 root     root          4096 Jan  1 00:00 dsb_patt_type
>>> drwxr-xr-x    2 root     root             0 Jan  1 00:00 dsb_trig_patt
>>> -rw-r--r--    1 root     root          4096 Jan  1 00:00 dsb_trig_ts
>>> -rw-r--r--    1 root     root          4096 Jan  1 00:00 dsb_trig_type
>>> -rw-r--r--    1 root     root          4096 Jan  1 00:02 enable_source
>>> --w-------    1 root     root          4096 Jan  1 00:00 
>>> integration_test
>>> drwxr-xr-x    2 root     root             0 Jan  1 00:00 power
>>> --w-------    1 root     root          4096 Jan  1 00:02 reset_dataset
>>> lrwxrwxrwx    1 root     root             0 Apr  5  2021 subsystem -> 
>>> ../../../../../bus/coresight
>>> -rw-r--r--    1 root     root          4096 Apr  5  2021 uevent
>>> -r--r--r--    1 root     root          4096 Jan  1 00:00 
>>> waiting_for_supplier
>>>
>>> We can use the commands are similar to the below to configure the
>>> TPDMs which support DSB subunit. Enable coresight sink first.
>>> echo 1 > /sys/bus/coresight/devices/tmc_etf0/enable_sink
>>> echo 1 > /sys/bus/coresight/devices/tpdm1/reset_dataset
>>> echo 0x3 > /sys/bus/coresight/devices/tpdm1/dsb_edge/ctrl_idx
>>> echo 0x1 > /sys/bus/coresight/devices/tpdm1/dsb_edge/ctrl_mask
>>> echo 0x0 > /sys/bus/coresight/devices/tpdm1/dsb_edge/ctrl_val
>>> echo 1 > /sys/bus/coresight/devices/tpdm1/dsb_patt/enable_ts
>>> echo 1 > /sys/bus/coresight/devices/tpdm1/dsb_patt/set_type
>>> echo 0 > /sys/bus/coresight/devices/tpdm1/dsb_trig_ts
>>> echo 0xFFFFFFFF > /sys/bus/coresight/devices/tpdm1/dsb_patt/tpmr5
>>> echo 0xFFFFFFFF > /sys/bus/coresight/devices/tpdm1/dsb_trig_patt/xpr2
>>> echo 1 > /sys/bus/coresight/devices/tpdm1/enable_source
>>>
>>
>> I have reviewed this set, except for the last patch, rest looks fine.
>> If you could resend the series with the comments addressed, we could
>> queue this.
> 
> That's great. Thanks for your review.
> 
> I also want to make a minor change.
> 
> Can I rename "tpdm_dsb_attrs_grp" to "tpdm_dsb_attr_grp" in the next 

Sure, that is fine. The proposed changes to the other patch look good
too.

Suzuki
