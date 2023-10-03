Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59AA57B6E3D
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 18:19:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232014AbjJCQTK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 12:19:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230486AbjJCQTI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 12:19:08 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 59824BF;
        Tue,  3 Oct 2023 09:19:05 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AE6C0C15;
        Tue,  3 Oct 2023 09:19:43 -0700 (PDT)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2A5393F762;
        Tue,  3 Oct 2023 09:19:04 -0700 (PDT)
Message-ID: <e0855325-37be-63ac-a0d5-9cd4cd4d375d@arm.com>
Date:   Tue, 3 Oct 2023 17:18:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 2/2] irqchip/gic-v3: Enable non-coherent
 redistributors/ITSes probing
Content-Language: en-GB
To:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Marc Zyngier <maz@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Fang Xiang <fangxiang3@xiaomi.com>
References: <20230905104721.52199-1-lpieralisi@kernel.org>
 <20230905104721.52199-3-lpieralisi@kernel.org> <86msy0etul.wl-maz@kernel.org>
 <ZRwonK+01HKJkKXa@lpieralisi>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <ZRwonK+01HKJkKXa@lpieralisi>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/10/2023 3:43 pm, Lorenzo Pieralisi wrote:
> On Tue, Sep 05, 2023 at 12:34:58PM +0100, Marc Zyngier wrote:
> 
> [...]
> 
>>>   	 * Make sure *all* the ITS are reset before we probe any, as
>>>   	 * they may be sharing memory. If any of the ITS fails to
>>> @@ -5396,7 +5405,8 @@ static int __init its_of_probe(struct device_node *node)
>>>   			continue;
>>>   		}
>>>   
>>> -		its_probe_one(&res, &np->fwnode, of_node_to_nid(np));
>>> +		its_probe_one(&res, &np->fwnode, of_node_to_nid(np),
>>> +			      of_property_read_bool(np, "dma-noncoherent"));
>>>   	}
>>>   	return 0;
>>>   }
>>> @@ -5533,7 +5543,8 @@ static int __init gic_acpi_parse_madt_its(union acpi_subtable_headers *header,
>>>   	}
>>>   
>>>   	err = its_probe_one(&res, dom_handle,
>>> -			acpi_get_its_numa_node(its_entry->translation_id));
>>> +			acpi_get_its_numa_node(its_entry->translation_id),
>>> +			false);
>>
>> I came up with the following alternative approach, which is as usual
>> completely untested. It is entirely based on the quirk infrastructure,
>> and doesn't touch the ACPI path at all.
> 
> Writing the ACPI bits. We can't use the quirks framework for ACPI (we
> don't have "properties" and I don't think we want to attach any to the
> fwnode_handle) that's why I generalized its_probe_one() above with an
> extra param, that would have simplified ACPI parsing:
> 
> - we alloc struct its_node in its_probe_one() but at that stage
>    ACPI parsing was already done. If we have to parse the MADT(ITS) again
>    just to scan for non-coherent we then have to match the MADT entries
>    to the *current* struct its_node* we are handling (MADT parsing
>    callbacks don't even take a param - we have to resort to global
>    variables - definitely doable but it is a bit ugly).

How about a compromise of passing a whole MADT flags field into 
its_probe_one() (where its_of_probe() can just pass 0), to pass through 
to its_enable_quirks() to then match against an madt_flags field in the 
gic_quirk? gic_acpi_init() could then do something similar for the 
redistributor quirk, although I guess it would then need to distinguish 
GICC and GICR-based quirks cases since the respective flags are in 
different formats.

Thanks,
Robin.
