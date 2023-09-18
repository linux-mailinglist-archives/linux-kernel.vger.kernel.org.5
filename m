Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D3457A4685
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 12:02:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239450AbjIRKBh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 06:01:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241184AbjIRKBV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 06:01:21 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C94EF116;
        Mon, 18 Sep 2023 03:01:09 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CE25C433C7;
        Mon, 18 Sep 2023 10:01:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695031268;
        bh=hAjJUc7NjqQrT4nlXjGd4nZM5QnVumDd26WazQmTUog=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FokAqCRotg0mDjp2BYvzUfwtqx2MEPr/isIvp8gs6a+sl/bP7r6TJ6f2ss1xsoAqe
         jRKt7N5kBPjvSRHgEab9Q9TD5/4zKeI+daRoRv5AhPbLxB075yzV2FtwwPyFAB9Cy6
         aGw5ydldaKxqR2xDrXMzgAUICr53BaSZ/ArDUvgr1DHxWuvpLcz00zs+wyHbMOBTP/
         +V66v2sma5fOMiI0bMmikjun2v2es11rqVJtPR4PyU4PUxWkVJRaDSvLL9LDPQi9gb
         aoyrD0IiF/upFPWK+WBOEsjmG86rTrbkpKoVH6wrq/qcVq38v+IkwE8zm6DWRjSGkc
         xPFfneCj6KeFQ==
Date:   Mon, 18 Sep 2023 11:01:02 +0100
From:   Will Deacon <will@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Jonathan Corbet <corbet@lwn.net>,
        James Morse <james.morse@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH 2/2] arm64: errata: Add Cortex-A520 speculative
 unprivileged load workaround
Message-ID: <20230918100102.GA17472@willie-the-truck>
References: <20230912121120.380420-1-robh@kernel.org>
 <20230912121120.380420-2-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230912121120.380420-2-robh@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 12, 2023 at 07:11:15AM -0500, Rob Herring wrote:
> Implement the workaround for ARM Cortex-A520 erratum 2966298. On an
> affected Cortex-A520 core, a speculatively executed unprivileged load
> might leak data from a privileged level via a cache side channel.
> 
> The workaround is to execute a TLBI before returning to EL0. A
> non-shareable TLBI to any address is sufficient.

Can you elaborate at all on how this works, please? A TLBI addressing a
cache side channel feels weird (or is "cache" referring to some TLB
structures rather than e.g. the data cache here?).

Assuming there's some vulnerable window between the speculative
unprivileged load and the completion of the TLBI, what prevents another
CPU from observing the side-channel during that time? Also, does the
TLBI need to be using the same ASID as the unprivileged load? If so, then
a context-switch could widen the vulnerable window quite significantly.

Anyway, hopefully I'm barking up the wrong tree, but it would be helpful
to have some intuition behind the workaround in order to review (and
maintain) this patch.

Cheers,

Will
