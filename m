Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BA9E763EC4
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 20:45:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230453AbjGZSpS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 14:45:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229747AbjGZSpQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 14:45:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D754C269E
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 11:45:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6311F61C43
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 18:45:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D75FCC433C8;
        Wed, 26 Jul 2023 18:45:12 +0000 (UTC)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Will Deacon <will@kernel.org>, Mark Brown <broonie@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64/fpsimd: Don't flush SME register hardware state along with thread
Date:   Wed, 26 Jul 2023 19:45:10 +0100
Message-Id: <169039710582.703186.14988638861645421057.b4-ty@arm.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230724-arm64-dont-flush-smstate-v1-1-9a8b637ace6c@kernel.org>
References: <20230724-arm64-dont-flush-smstate-v1-1-9a8b637ace6c@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Jul 2023 14:09:19 +0100, Mark Brown wrote:
> We recently changed the fpsimd thread flush to flush the physical SME
> state as well as the thread state for the current thread.  Unfortunately
> this leads to intermittent corruption in interaction with the lazy
> FPSIMD register switching.  When under heavy load such as can be
> triggered by the startup phase of fp-stress it is possible that the
> current thread may not be scheduled prior to returning to userspace, and
> indeed we may end up returning to the last thread that was scheduled on
> the PE without ever exiting the kernel to any other task.  If that
> happens then we will not reload the register state from memory, leading
> to loss of any SME register state.
> 
> [...]

Applied to arm64 (for-next/fixes), thanks!

[1/1] arm64/fpsimd: Don't flush SME register hardware state along with thread
      https://git.kernel.org/arm64/c/3421ddbe6d64

-- 
Catalin

