Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6026A7F42CF
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 10:50:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235195AbjKVJuy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 04:50:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235374AbjKVJuP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 04:50:15 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4D083256
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 01:49:03 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0048C433CB;
        Wed, 22 Nov 2023 09:49:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700646543;
        bh=HquTgPuZlA4Yd/i15aPhlrVGsHZcZNtBHiTfzoBfy24=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=I7U8cpjF5LN+Br7G9Bfg6N2BL/ceOCkIYMQ+CUFRDVjQhiF8BsTxZfTW89k7TKlm/
         CdD4+fAwkVRkZRzvcYqsA6lJYvWgMzEF/pcbEdIzXoqfgY6MHic7G67nPmuhoC0yNy
         O1KwSEXIKxPpTNxZxIDPVu4FFnaPkj5cfsoNwI72bQjsK/rwy/E+3+j20AVZO0E2m9
         w6LTT++PeHx7h/9cgJ727JFaX7KmQC2r0kwK+bs2be9QNPySg7oA4jbbcA8YzXoOJ7
         UC1uJGnY9iE6B8Q/rtgufLehrmwIl4p2QkRHFxOS4dCT5Wj3qrgzVbhkS4aTOL/Ry2
         fcFjdc5RVYSPA==
Date:   Wed, 22 Nov 2023 09:48:57 +0000
From:   Will Deacon <will@kernel.org>
To:     Huang Shijie <shijie@os.amperecomputing.com>
Cc:     catalin.marinas@arm.com, mark.rutland@arm.com,
        suzuki.poulose@arm.com, broonie@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        anshuman.khandual@arm.com, robh@kernel.org, oliver.upton@linux.dev,
        maz@kernel.org, patches@amperecomputing.com
Subject: Re: [PATCH 0/4] arm64: an optimization for AmpereOne
Message-ID: <20231122094857.GA2959@willie-the-truck>
References: <20231122092855.4440-1-shijie@os.amperecomputing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231122092855.4440-1-shijie@os.amperecomputing.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 22, 2023 at 05:28:51PM +0800, Huang Shijie wrote:
> 0) Background:
>    We found that AmpereOne benefits from aggressive prefetches when
>    using 4K page size.

We tend to shy away from micro-architecture specific optimisations in
the arm64 kernel as they're pretty unmaintainable, hard to test properly,
generally lead to bloat and add additional obstacles to updating our
library routines.

Admittedly, we have something for Thunder-X1 in copy_page() (disguised
as ARM64_HAS_NO_HW_PREFETCH) but, frankly, that machine needed all the
help it could get and given where it is today I suspect we could drop
that code without any material consequences.

So I'd really prefer not to merge this; modern CPUs should do better at
copying data. It's copy_to_user(), not rocket science.

Will
