Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25ADE773518
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 01:39:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229743AbjHGXjW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 19:39:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbjHGXjU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 19:39:20 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A908A1736;
        Mon,  7 Aug 2023 16:39:19 -0700 (PDT)
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
        by linux.microsoft.com (Postfix) with ESMTPSA id 08FFA20CD151;
        Mon,  7 Aug 2023 16:39:19 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 08FFA20CD151
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1691451559;
        bh=EQXcYPykQB/jwitR5EDr0ODUk0xBPqd7pP3EgOvFa54=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:In-Reply-To:References:From;
        b=LSvV2hMcg+xTJVokTQNM3JqeRryUGVgZLYEqvfX5LyrXpPKkZ1feqwv9GTcIpydra
         g9kaQRL/PJvypv9WLcTvbO+Nrmo/wAt+91/krWudvRzKbM3DJx2EmIF4C8Ovxz/GI9
         ZHTheXWqwAuc+muC7W2AXcGQq5+gAsHYHZV22ls8=
From:   Easwar Hariharan <eahariha@linux.microsoft.com>
To:     robin.murphy@arm.com
Cc:     catalin.marinas@arm.com, corbet@lwn.net,
        eahariha@linux.microsoft.com, easwar.hariharan@microsoft.com,
        iommu@lists.linux-foundation.org, iommu@lists.linux.dev,
        joro@8bytes.org, krckatom@amazon.de,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, nicolinc@nvidia.com,
        sashal@kernel.org, stable@vger.kernel.org, will@kernel.org,
        yangyicong@hisilicon.com
Subject: Re: [PATCH v3 5.15 4/6] iommu/arm-smmu-v3: Document MMU-700 erratum 2812531
Date:   Mon,  7 Aug 2023 16:37:45 -0700
Message-Id: <e5b7d4fe-c99d-e545-875-33ad683c62e@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <919ab857-30cf-00a5-1a40-fb180678792e@arm.com>
References: <919ab857-30cf-00a5-1a40-fb180678792e@arm.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <919ab857-30cf-00a5-1a40-fb180678792e@arm.com>
References: <919ab857-30cf-00a5-1a40-fb180678792e@arm.com>
Fcc:    sent-mail
In-Reply-To: <919ab857-30cf-00a5-1a40-fb180678792e@arm.com>
References: <20230802170227.1590187-1-eahariha@linux.microsoft.com> <20230802170227.1590187-5-eahariha@linux.microsoft.com> <919ab857-30cf-00a5-1a40-fb180678792e@arm.com>
X-Reply-UID: (2 > )(1 1589327539 7556)/var/spool/mail/eahariha
X-Reply-Mbox: inbox
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
X-Spam-Status: No, score=-17.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Aug 2023, Robin Murphy wrote:

> On 2023-08-02 18:02, Easwar Hariharan wrote:
>>  From: Robin Murphy <robin.murphy@arm.com>
>>
>>  commit 309a15cb16bb075da1c99d46fb457db6a1a2669e upstream
>>
>>  To work around MMU-700 erratum 2812531 we need to ensure that certain
>>  sequences of commands cannot be issued without an intervening sync. In
>>  practice this falls out of our current command-batching machinery
>>  anyway - each batch only contains a single type of invalidation command,
>>  and ends with a sync. The only exception is when a batch is sufficiently
>>  large to need issuing across multiple command queue slots, wherein the
>>  earlier slots will not contain a sync and thus may in theory interleave
>>  with another batch being issued in parallel to create an affected
>>  sequence across the slot boundary.
>>
>>  Since MMU-700 supports range invalidate commands and thus we will prefer
>>  to use them (which also happens to avoid conditions for other errata),
>>  I'm not entirely sure it's even possible for a single high-level
>>  invalidate call to generate a batch of more than 63 commands,
>
> Out of interest, have you observed a case where this actually happens?

Not so far, but this was more of a proactive pickup since the erratum was
published and we have some hardware being tested.

>>  but for
>>  the sake of robustness and documentation, wire up an option to enforce
>>  that a sync is always inserted for every slot issued.
>>
>>  The other aspect is that the relative order of DVM commands cannot be
>>  controlled, so DVM cannot be used. Again that is already the status quo,
>>  but since we have at least defined ARM_SMMU_FEAT_BTM, we can explicitly
>>  disable it for documentation purposes even if it's not wired up anywhere
>>  yet.
>
> Note that there seems to be a slight issue with this patch that I missed, 
> under discussion here:
>
> https://lore.kernel.org/linux-iommu/27c895b8-1fb0-be88-8bc3-878d754684c8@huawei.com/T/#t
>

Thanks for the heads up. I did not backport the TTL patch for this series,
or the ones for 6.1 or 6.4, but I'll track the discussion.
Could you CC any fixup patch you may create for this to stable for 5.15+
as well?

Thanks,
Easwar

> Thanks,
> Robin.
>
<snip>
