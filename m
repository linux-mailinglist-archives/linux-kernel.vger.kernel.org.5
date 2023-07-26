Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8E51763D18
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 19:00:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230149AbjGZQ75 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 12:59:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229866AbjGZQ7z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 12:59:55 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9D40A188;
        Wed, 26 Jul 2023 09:59:54 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 52E172F4;
        Wed, 26 Jul 2023 10:00:37 -0700 (PDT)
Received: from [10.57.82.133] (unknown [10.57.82.133])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A95703F67D;
        Wed, 26 Jul 2023 09:59:51 -0700 (PDT)
Message-ID: <9c3b4a97-bbe2-a978-b000-9562123af523@arm.com>
Date:   Wed, 26 Jul 2023 17:59:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH V6 0/6] coresight: etm4x: Migrate ACPI AMBA devices to
 platform driver
To:     Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
        gregkh@linuxfoundation.org, rafael@kernel.org
Cc:     Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>,
        Steve Clevenger <scclevenger@os.amperecomputing.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Len Brown <lenb@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>, devicetree@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230710062500.45147-1-anshuman.khandual@arm.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <20230710062500.45147-1-anshuman.khandual@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/07/2023 07:24, Anshuman Khandual wrote:
> CoreSight ETM4x devices could be accessed either via MMIO (handled via
> amba_driver) or CPU system instructions (handled via platform driver). But
> this has the following issues :
> 
>    - Each new CPU comes up with its own PID and thus we need to keep on
>      adding the "known" PIDs to get it working with AMBA driver. While
>      the ETM4 architecture (and CoreSight architecture) defines way to
>      identify a device as ETM4. Thus older kernels  won't be able to
>      "discover" a newer CPU, unless we add the PIDs.
> 
>    - With ACPI, the ETM4x devices have the same HID to identify the device
>      irrespective of the mode of access. This creates a problem where two
>      different drivers (both AMBA based driver and platform driver) would
>      hook into the "HID" and could conflict. e.g., if AMBA driver gets
>      hold of a non-MMIO device, the probe fails. If we have single driver
>      hooked into the given "HID", we could handle them seamlessly,
>      irrespective of the mode of access.
> 
>    - CoreSight is heavily dependent on the runtime power management. With
>      ACPI, amba_driver doesn't get us anywhere with handling the power
>      and thus one need to always turn the power ON to use them. Moving to
>      platform driver gives us the power management for free.
> 
> Due to all of the above, we are moving ACPI MMIO based etm4x devices to be
> supported via tha platform driver. The series makes the existing platform
> driver generic to handle both type of the access modes. Although existing
> AMBA driver would still continue to support DT based etm4x MMIO devices.
> Although some problems still remain, such as manually adding PIDs for all
> new AMBA DT based devices.
> 
> The series applies on 6.5-rc1.
> 
> Changes in V6:
> 
> - Rebased on 6.5-rc1
> 

I have queued this version for v6.6, should appear on coresight/next soon.

Suzuki


