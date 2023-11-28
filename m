Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B70EF7FC133
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 19:15:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345838AbjK1Ox3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 09:53:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346428AbjK1OxO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 09:53:14 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C7E741BF5
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 06:53:05 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0AC18C15;
        Tue, 28 Nov 2023 06:53:53 -0800 (PST)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C596F3F6C4;
        Tue, 28 Nov 2023 06:53:04 -0800 (PST)
Message-ID: <3a8d7ea4-c5f9-421e-84fa-2e4934cd6c92@arm.com>
Date:   Tue, 28 Nov 2023 14:53:03 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] iommufd/selftest: Use normal IOMMU registration
Content-Language: en-GB
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     joro@8bytes.org, kevin.tian@intel.com, will@kernel.org,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org
References: <cover.1701165201.git.robin.murphy@arm.com>
 <44ee6854da69e86b208f49752f60a4c18205c32a.1701165201.git.robin.murphy@arm.com>
 <20231128143508.GG432016@ziepe.ca>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20231128143508.GG432016@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/11/2023 2:35 pm, Jason Gunthorpe wrote:
> On Tue, Nov 28, 2023 at 10:42:12AM +0000, Robin Murphy wrote:
>> The IOMMU core now supports coexistence of fwspec-based drivers, which
>> the mock driver now is, so let's bring the mock bus into iommu_buses,
>> drop the special interface, and use the normal registration flow. The
>> one concession we have to make is to ensure that the mock bus is
>> registered early enough so that bus_for_each_dev() doesn't error out
>> for other IOMMU drivers registering before iommufd_test_init() runs.
> 
> This makes iommufd non-modular which becomes a total PITA for development :(

Oh fiddle, I misread the makefile, and indeed this doesn't work at all, 
sorry (turns out it fails to even build for IOMMUFD=m...) Guess I should 
have been more wary of how suspiciously easy it seemed :(

Dynamic bus registration in general would be a neat thing to explore at 
some point, since the static iommu_buses array isn't my most favourite 
part of the whole business, but I guess we leave this as-is for now.

Robin.
