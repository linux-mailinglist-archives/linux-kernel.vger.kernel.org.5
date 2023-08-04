Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3374D770556
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 17:55:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229528AbjHDPzg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 11:55:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232281AbjHDPz2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 11:55:28 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2A8F349D7
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 08:55:24 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4CE211007;
        Fri,  4 Aug 2023 08:56:06 -0700 (PDT)
Received: from [10.57.3.154] (unknown [10.57.3.154])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3D6BA3F6C4;
        Fri,  4 Aug 2023 08:55:21 -0700 (PDT)
Message-ID: <a8e15838-42e5-3f49-62e3-0a6646566b8e@arm.com>
Date:   Fri, 4 Aug 2023 16:55:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 1/2] arm64/sysreg: Move TRFCR definitions to sysreg
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>
Cc:     coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        James Morse <james.morse@arm.com>,
        Kristina Martsenko <kristina.martsenko@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Rob Herring <robh@kernel.org>,
        Jintack Lim <jintack.lim@linaro.org>,
        Joey Gouly <joey.gouly@arm.com>, linux-kernel@vger.kernel.org
References: <20230804085219.260790-1-james.clark@arm.com>
 <20230804085219.260790-2-james.clark@arm.com>
 <143152c8-61b8-4a71-9090-7203342b661c@sirena.org.uk>
From:   James Clark <james.clark@arm.com>
In-Reply-To: <143152c8-61b8-4a71-9090-7203342b661c@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 04/08/2023 13:10, Mark Brown wrote:
> On Fri, Aug 04, 2023 at 09:52:16AM +0100, James Clark wrote:
> 
>> TRFCR_EL2_CX needs to become TRFCR_ELx_CX to avoid unnecessary
>> duplication and make the SysregFields block re-usable.
> 
> That field is only present in the EL2 version.  I would tend to leave
> the registers split for that reason, there's some minor potential for
> confusion if people refer to the sysreg file rather than the docs, or
> potentially confuse some future automation.  However that's not a super
> strongly held opinion.
> 

True, the potential for confusion is a good reason to not try to avoid
duplication. Probably helps if it is ever auto generated or validated as
well.

I could update it on the next version. But do I leave all the existing
_ELx usages in the code, or change them all to _EL1 (Except CX_EL2)? To
leave them as _ELx sysreg would look like this, even though _EL1 would
probably be more accurate:

  SysregFields TRFCR_EL2
  Res0	63:7
  UnsignedEnum	6:5	TS
  	0b0001	VIRTUAL
  	0b0010	GUEST_PHYSICAL
  	0b0011	PHYSICAL
  EndEnum
  Res0	4
  Field	3	CX
  Res0	2
  Field	1	E2TRE
  Field	0	E0TRE
  EndSysregFields

  SysregFields TRFCR_ELx
  Res0	63:7
  UnsignedEnum	6:5	TS
  	0b0001	VIRTUAL
  	0b0010	GUEST_PHYSICAL
  	0b0011	PHYSICAL
  EndEnum
  Res0	4:2
  Field	1	ExTRE
  Field	0	E0TRE
  EndSysregFields

  Sysreg	TRFCR_EL1	3	0	1	2	1
  Fields	TRFCR_ELx
  EndSysreg

  Sysreg	TRFCR_EL2	3	4	1	2	1
  Fields	TRFCR_EL2
  EndSysreg

  Sysreg TRFCR_EL12	3	5	1	2	1
  Fields	TRFCR_ELx
  EndSysreg


> Otherwise this checks out against DDI0601 2023-06:
> 
> Reviewed-by: Mark Brown <broonie@kernel.org>

Thanks for the review
