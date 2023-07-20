Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51FF675AE06
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 14:14:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230029AbjGTMOA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 08:14:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230221AbjGTMN6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 08:13:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13CA72135
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 05:13:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A189061A6D
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 12:13:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 287E7C433C8;
        Thu, 20 Jul 2023 12:13:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689855231;
        bh=/gWyr3G9ndmiNqtAFie3+bUzItu2n5XGaZxCBJHyHvY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=M+JB+4IjcvxBDJOax6FEVkRmV6QYVPLklK/H2CQfQYgqsGaCvXcH2Y7lpP+EABHU+
         V9P7oZUl4i9DfTGPNOIz0muxe0CCOLdsNX9dQoWWVFF/ejaHlAKwYXZ5wHKxz0Kd/R
         f0N4ppu6FzOZcZD9wHWYWt9H2YuKInh7H5uxXr7xyH3wP08zoez2gBxCvEvRruyxdV
         Xi6e0gobzLYnAdYTgu0GWP0EnKmjqJSWVc74PnspHV55pjZFNxEX/Cjr95n8Cj9jsl
         QURpGdef6rV561QMOSwqIkKkStsyrvRZSjvl+9UwuOi+T2IQUifxlA77rv6jwk03s/
         iNUq/ZAZa4qcQ==
From:   Will Deacon <will@kernel.org>
To:     catalin.marinas@arm.com, Nikhil V <quic_nprakash@quicinc.com>
Cc:     kernel-team@android.com, Will Deacon <will@kernel.org>,
        quic_pkondeti@quicinc.com, quic_guptap@quicinc.com,
        quic_charante@quicinc.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: mm: Make hibernation aware of KFENCE
Date:   Thu, 20 Jul 2023 13:13:46 +0100
Message-Id: <168984989072.750295.13436985718136646972.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230713070757.4093-1-quic_nprakash@quicinc.com>
References: <20230713070757.4093-1-quic_nprakash@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Jul 2023 12:37:57 +0530, Nikhil V wrote:
> In the restore path, swsusp_arch_suspend_exit uses copy_page() to
> over-write memory. However, with features like KFENCE enabled, there could
> be situations where it may have marked some pages as not valid, due to
> which it could be reported as invalid accesses.
> 
> Consider a situation where page 'P' was part of the hibernation image.
> Now, when the resume kernel tries to restore the pages, the same page 'P'
> is already in use in the resume kernel and is kfence protected, due to
> which its mapping is removed from linear map. Since restoring pages happens
> with the resume kernel page tables, we would end up accessing 'P' during
> copy and results in kernel pagefault.
> 
> [...]

Applied to arm64 (for-next/fixes), thanks!

[1/1] arm64: mm: Make hibernation aware of KFENCE
      https://git.kernel.org/arm64/c/a8bd38dbc57c

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
