Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21FE27D5049
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 14:51:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234382AbjJXMvY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 08:51:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234453AbjJXMvU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 08:51:20 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5149DD
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 05:51:18 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A000C433C8;
        Tue, 24 Oct 2023 12:51:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698151878;
        bh=yUqmS2rHgmnuEo9r4tpmyeM3nOTkeWVpIc0QPvb2jz8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bRrubPXYXNxfhQjEby70TnP2Hji6KBy3wKAcsRWaIJbYyEr0V9GM49CLPZ3LxqwU0
         r7r/nwLL1NdRIzVcki3HNAkmMxYbLE1W7Ub+FZMASxEUYo7G8xiGNFXhUTLjS2OqsI
         zMOdWQrmVH8wjv2DdZxW8zNWj8izXc+a1828grrt1lLKBVfsPUqcwKShj0qmIOSwh3
         CUvIHm8cDc7abGPrqmiLX4GtgCxze/xlHpE5I5A71Eb7peH+tyWGpaYmz8zP3LgRwa
         o9jJWbsUtaPlozNz7/xTki0+wdH2l7cenSseAPM5iFQZWqre50mf3/YRltLAmFTEen
         cpqNr7laUmTkg==
From:   Will Deacon <will@kernel.org>
To:     mark.rutland@arm.com, jonathan.cameron@huawei.com,
        linux-kernel@vger.kernel.org, Junhao He <hejunhao3@huawei.com>
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>, linuxarm@huawei.com,
        linux-arm-kernel@lists.infradead.org, prime.zeng@hisilicon.com,
        yangyicong@huawei.com, shenyang39@huawei.com
Subject: Re: [PATCH] perf: hisi: Fix use-after-free when register pmu fails
Date:   Tue, 24 Oct 2023 13:51:11 +0100
Message-Id: <169815060330.4017353.11368415377173827667.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20231024113630.13472-1-hejunhao3@huawei.com>
References: <20231024113630.13472-1-hejunhao3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Oct 2023 19:36:30 +0800, Junhao He wrote:
> When we fail to register the uncore pmu, the pmu context may not been
> allocated. The error handing will call cpuhp_state_remove_instance()
> to call uncore pmu offline callback, which migrate the pmu context.
> Since that's liable to lead to some kind of use-after-free.
> 
> Use cpuhp_state_remove_instance_nocalls() instead of
> cpuhp_state_remove_instance() so that the notifiers don't execute after
> the PMU device has been failed to register.
> 
> [...]

Applied to will (for-next/perf), thanks!

[1/1] perf: hisi: Fix use-after-free when register pmu fails
      https://git.kernel.org/will/c/b805cafc604b

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
