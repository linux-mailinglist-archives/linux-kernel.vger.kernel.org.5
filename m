Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ECBD763DCB
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 19:37:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229454AbjGZRhh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 13:37:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232569AbjGZRhf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 13:37:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CDA62727
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 10:37:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DE46C61B91
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 17:37:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7731BC433C8;
        Wed, 26 Jul 2023 17:37:29 +0000 (UTC)
Date:   Wed, 26 Jul 2023 18:37:26 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64/sme: Set new vector length before reallocating
Message-ID: <ZMFZ1l6cEc7Qma7O@arm.com>
References: <20230726-arm64-fix-sme-fix-v1-1-7752ec58af27@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230726-arm64-fix-sme-fix-v1-1-7752ec58af27@kernel.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 26, 2023 at 01:12:26PM +0100, Mark Brown wrote:
> As part of fixing the allocation of the buffer for SVE state when changing
> SME vector length we introduced an immediate reallocation of the SVE state,
> this is also done when changing the SVE vector length for consistency.
> Unfortunately this reallocation is done prior to writing the new vector
> length to the task struct, meaning the allocation is done with the old
> vector length and can lead to memory corruption due to an undersized buffer
> being used.
> 
> Move the update of the vector length before the allocation to ensure that
> the new vector length is taken into account.
> 
> For some reason this isn't triggering any problems when running tests on
> the arm64 fixes branch (even after repeated tries) but is triggering
> issues very often after merge into mainline.
> 
> Fixes: d4d5be94a878 ("arm64/fpsimd: Ensure SME storage is allocated after SVE VL changes")
> Signed-off-by: Mark Brown <broonie@kernel.org>

I'll add a cc stable here since the above commit was fixing code that
went in for 5.19.

-- 
Catalin
