Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26C397D81B4
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 13:20:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231250AbjJZLT7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 07:19:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229980AbjJZLT6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 07:19:58 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 169591AE;
        Thu, 26 Oct 2023 04:19:56 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2B8D12F4;
        Thu, 26 Oct 2023 04:20:37 -0700 (PDT)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8CA653F738;
        Thu, 26 Oct 2023 04:19:50 -0700 (PDT)
Message-ID: <c000f7a3-caeb-4d75-8c88-40ed02950ec1@arm.com>
Date:   Thu, 26 Oct 2023 13:19:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v3 6/6] arm64/amu: use capacity_ref_freq to set AMU ratio
Content-Language: en-US
To:     Vincent Guittot <vincent.guittot@linaro.org>,
        Ionela Voinescu <ionela.voinescu@arm.com>
Cc:     linux@armlinux.org.uk, catalin.marinas@arm.com, will@kernel.org,
        paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, sudeep.holla@arm.com,
        gregkh@linuxfoundation.org, rafael@kernel.org, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com, rostedt@goodmis.org,
        bsegall@google.com, mgorman@suse.de, bristot@redhat.com,
        vschneid@redhat.com, viresh.kumar@linaro.org, lenb@kernel.org,
        robert.moore@intel.com, lukasz.luba@arm.com,
        pierre.gondois@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org,
        acpica-devel@lists.linuxfoundation.org, conor.dooley@microchip.com,
        suagrfillet@gmail.com, ajones@ventanamicro.com, lftan@kernel.org
References: <20231018162540.667646-1-vincent.guittot@linaro.org>
 <20231018162540.667646-7-vincent.guittot@linaro.org>
 <ZTbebQrK3K+JwWxR@arm.com>
 <CAKfTPtA0KBE8TFifOEXddF9d_wqDjb4QUvgK8c0DTtyLrX0atA@mail.gmail.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <CAKfTPtA0KBE8TFifOEXddF9d_wqDjb4QUvgK8c0DTtyLrX0atA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/10/2023 11:58, Vincent Guittot wrote:
> On Mon, 23 Oct 2023 at 22:58, Ionela Voinescu <ionela.voinescu@arm.com> wrote:
>>
>> Hi,
>>
>> On Wednesday 18 Oct 2023 at 18:25:40 (+0200), Vincent Guittot wrote:
>>> Use the new capacity_ref_freq to set the ratio that is used by AMU for
>>> computing the arch_scale_freq_capacity().
>>> This helps to keep everything aligned using the same reference for
>>> computing CPUs capacity.
>>>
>>> The default value of the ratio ensures that arch_scale_freq_capacity()
>>> returns max capacity until it is set to its correct value with the
>>> cpu capacity and capacity_ref_freq.

Nitpick: Could you mention that arch_max_freq_scale is the default value
for this ratio? Took me a while to recreate the (not so simple) story
for this change, i.e. make the connection between ratio and
arch_max_freq_scale.

init_cpu_capacity_callback()

  freq_inv_set_max_ratio()

    u64 ratio
    ...
    per_cpu(arch_max_freq_scale, cpu) = (unsigned long)ratio
            ^^^^^^^^^^^^^^^^^^^


static struct scale_freq_data amu_sfd = {
        .set_freq_scale = amu_scale_freq_tick,
}

#define arch_scale_freq_tick topology_scale_freq_tick

topology_scale_freq_tick()

  sfd->set_freq_scale()


amu_scale_freq_tick()

  ...
  scale *= this_cpu_read(arch_max_freq_scale)
                         ^^^^^^^^^^^^^^^^^^^
  ...
  this_cpu_write(arch_freq_scale, (unsigned long)scale);


#define arch_scale_freq_capacity topology_get_freq_scale

topology_get_freq_scale(cpu)

  return per_cpu(arch_freq_scale, cpu)

[...]

