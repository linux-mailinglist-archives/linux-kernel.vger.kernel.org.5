Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9FD77653A5
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 14:23:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234018AbjG0MXa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 08:23:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233983AbjG0MXE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 08:23:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D31EC3C06
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 05:22:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D1A4061E52
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 12:22:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6A94C433C9;
        Thu, 27 Jul 2023 12:22:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690460569;
        bh=CjouWXKodtJu9Fn3v1ot7CiT9hW+Xib+CioPa1HCqyo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=apNNueKs8OEJEt8llqBxCGkSI5uiiP2pgk/E6SGFHtrJQiHavYvid3dL6SLgqxJxD
         pgxP6OR/fIzkpEvFM4d8T907wQUTvo1isevg22gZWUfHPoTIdgcRJHGz3kjhxJake+
         pC0wNIU6f8JzvMfeU8l305YsZNlYytJTZ4Mr1wqTfdCMiivwLUyFBJd7gqjNzySCDQ
         0ghLc8+3OcubGMqis6T6C2Ze3N6GcSJfj1SamtsnPtxK4EcvmTBpII4VmF3zhwxyJJ
         DP7PnzWWMYOSkSiBk9K4OhaOMJ7LYvZneuKhfnXqjwoi+87Hm26zvsJq4YkjCAB45t
         fSL8JILsUNa6Q==
From:   Will Deacon <will@kernel.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        david@redhat.com, Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH] arm64/mm: Set only the PTE_DIRTY bit while preserving the HW dirty state
Date:   Thu, 27 Jul 2023 13:22:28 +0100
Message-Id: <169045304407.2141816.3145617634232707253.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230713071518.628440-1-anshuman.khandual@arm.com>
References: <20230713071518.628440-1-anshuman.khandual@arm.com>
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

On Thu, 13 Jul 2023 12:45:18 +0530, Anshuman Khandual wrote:
> pte_mkdirty() creates dirty states both in SW and HW bits, which is really
> not required, either in pte_wrprotect() or pte_modify() for preserving the
> HW dirty state. Because pte_mkdirty() sets PTE_DIRTY and clears PTE_RDONLY
> as pte_write() always evaluates to be true - otherwise pte_hw_dirty() will
> not test out in the first place. Clearing PTE_RDONLY again is not required
> here because the pte is already in pte_hw_dirty() but might soon loose its
> dirty state thus requiring preservation in SW dirty bit i.e PTE_DIRTY.
> 
> [...]

Applied to arm64 (for-next/mm), thanks!

[1/1] arm64/mm: Set only the PTE_DIRTY bit while preserving the HW dirty state
      https://git.kernel.org/arm64/c/6477c3886ae1

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
