Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 153FD7CD8F2
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 12:16:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230386AbjJRKQG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 06:16:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbjJRKQE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 06:16:04 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 713D695
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 03:16:03 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 912F9C433C8;
        Wed, 18 Oct 2023 10:16:01 +0000 (UTC)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Will Deacon <will@kernel.org>, Steven Price <steven.price@arm.com>,
        Peter Collingbourne <pcc@google.com>,
        Ryan Roberts <ryan.roberts@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] arm64/mm: Hoist synchronization out of set_ptes() loop
Date:   Wed, 18 Oct 2023 11:15:59 +0100
Message-Id: <169762410085.3624197.15162390059059851386.b4-ty@arm.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231005140730.2191134-1-ryan.roberts@arm.com>
References: <20231005140730.2191134-1-ryan.roberts@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 05 Oct 2023 15:07:30 +0100, Ryan Roberts wrote:
> set_ptes() sets a physically contiguous block of memory (which all
> belongs to the same folio) to a contiguous block of ptes. The arm64
> implementation of this previously just looped, operating on each
> individual pte. But the __sync_icache_dcache() and mte_sync_tags()
> operations can both be hoisted out of the loop so that they are
> performed once for the contiguous set of pages (which may be less than
> the whole folio). This should result in minor performance gains.
> 
> [...]

Applied to arm64 (for-next/misc), thanks!

[1/1] arm64/mm: Hoist synchronization out of set_ptes() loop
      https://git.kernel.org/arm64/c/3425cec42c3c

Also pushed the fix to mark 'addr' __always_unused.

-- 
Catalin

