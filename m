Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7C4F784C35
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 23:45:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231407AbjHVVpr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 17:45:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230444AbjHVVpq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 17:45:46 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00A93F3;
        Tue, 22 Aug 2023 14:45:44 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 37MLjWxj104189;
        Tue, 22 Aug 2023 16:45:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1692740732;
        bh=WgxMkMmw9MOrsFk9lD2LlijbIfUF6n4I27Lk5tuXGOc=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=mIhnykcRhaZ+VOvhAeJpUOYjM4cerp3jvB9/BNDDCvJQxwZrVwWdl0uurlQo7CH49
         7xMCJ1AJzm6JcVpbkfOejVHpLk0cpaTPNRVGSFabJSCVWxjIIGHBgLyiuMDCkTCV/s
         9SSp00gRgvIZ6q0tZXu4CePui1nRdrXEObNLjeUc=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 37MLjWDp024739
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 22 Aug 2023 16:45:32 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 22
 Aug 2023 16:45:31 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 22 Aug 2023 16:45:31 -0500
Received: from [10.250.38.120] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 37MLjVri024318;
        Tue, 22 Aug 2023 16:45:31 -0500
Message-ID: <949a8814-2084-2636-7a1b-a9d1188a16f8@ti.com>
Date:   Tue, 22 Aug 2023 16:45:31 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] remoteproc: core: Honor device tree /alias entries when
 assigning IDs
To:     Nishanth Menon <nm@ti.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
CC:     Bjorn Andersson <andersson@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-remoteproc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Robert Nelson <robertcnelson@gmail.com>,
        Kevin Cahalan <kevinacahalan@gmail.com>
References: <20230807140247.956255-1-nm@ti.com> <ZOULmFR51C+9kEhZ@p14s>
 <20230822201205.4csoj4kym2yhuyrf@decrease>
Content-Language: en-US
From:   Andrew Davis <afd@ti.com>
In-Reply-To: <20230822201205.4csoj4kym2yhuyrf@decrease>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/22/23 3:12 PM, Nishanth Menon wrote:
> On 13:25-20230822, Mathieu Poirier wrote:
>> Hi Nishanth,
>>
>> On Mon, Aug 07, 2023 at 09:02:47AM -0500, Nishanth Menon wrote:
>>> On many platforms, such as Beaglebone-AI64 with many remote
>>> processors, firmware configurations provided by the distributions can
>>> vary substantially depending on the distribution build's functionality
>>> and the specific remote cores enabled in that variant. Ensuring
>>> consistent udev rules mapping remoteproc nodes to constant remote
>>> proc device indices across distributions (yocto, ubuntu, debian and
>>> it's variants, ...) on a board basis can be challenging due to the
>>> various functions of these distributions. Varied device node paths
>>> create challenges for applications that operate on remote processors,
>>> especially in minimal embedded systems(initrd like) that may not
>>> have udev-like capabilities and rely on a more straightforward bare
>>> filesystem. This challenge is similar to that faced by I2C, RTC or the
>>> GPIO subsystems.
>>>
>>
>> I'm puzzled by this patch.  I can see how using an alias can help in boards with
>> various HW configuration.  That said, and as written above, FW files for remote
>> processors can vary based on the build's functionality.  As such "remoteproc3"
>> will reference the same HW device on all distributions but the functionality
>> enacted by the FW may be different.  As such I don't see how an alias can help
>> here.  Can you provide a concrete example that highlights the benefits?
> 
> Correct - *if* remoteproc3 is the constant node reference.
> 
> To take a trivial example: We ran into this issue with:
> https://github.com/kaofishy/bbai64_cortex-r5_example/blob/main/Makefile#L28
> 
> remoteproc18 apparently changed numbering in a different build.
> 
> If remoteproc18 remained the same between different distro builds that
> would have probably kept the userspace constant. but it does'nt. it
> dependent purely on probe order, which does'nt let userspace remain
> consistent.
> 
> Same reason and motivation to do the following:
> https://git.beagleboard.org/beagleboard/repos-arm64/-/blob/main/bb-customizations/suite/bookworm/debian/86-remoteproc-noroot.rules
> in one technique to do it - but that only works if all the distros
> follow the same udev rules - and there is no reasonable way to enforce
> that across distributions.
> 

Enforcing distros to behave the same isn't the job of Device Tree, udev
rules seems like a reasonable place. Anyone dealing with Linux should know
they should not rely on kernel provided device names/numbers
(like with disks, network interfaces, etc.).

If you want to have a path that will always work you could use:

/sys/devices/platform/bus@f4000/bus@f4000\:r5fss@78400000/78400000.r5f/remoteproc/

for the same. I don't like that it makes an ABI out of node names,
but better than putting any more Linux configuration in DT IMHO.

Andrew
