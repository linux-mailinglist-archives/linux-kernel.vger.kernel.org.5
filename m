Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19E5475C607
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 13:44:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230228AbjGULod (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 07:44:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbjGULob (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 07:44:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1EAF2D79
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 04:44:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7DEFE61059
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 11:44:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD656C433C8;
        Fri, 21 Jul 2023 11:44:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689939867;
        bh=wSTu2zhBHqsKfvTP6GDkBfU35xeXo0vTnJ6B11t2qGk=;
        h=Date:From:To:Cc:Subject:From;
        b=TFp1jFzDDW/eYM8+VV+62EoE2xWu929cVnPaBUS9PgIye5zvct5nKgVa04CvgRDZW
         96xyjXLprrFmzYjAkMdoxk2XvkkROaSHgYoVA1lm1XL8LtubaasybHsq3woB9kFgCa
         ySed+lB+e5y3DDz1dnCrm6nbPFPmbReAWBHQLyGoU83W8wly7rawD88cJu9mTFHMH9
         zSkGzz9o9u6XQ7Ez7dnpwBFNMhPvnFMIBVg6QARhj/Oiex+Lfn8om0ObWihfdKbKD9
         kEI1kgKi/kV3ojMz7GHFECWhovj8DkWc5GArDwgvzG931biuF9s00MvlQCC470XYh5
         wwoeItvXIcjfw==
Date:   Fri, 21 Jul 2023 12:44:23 +0100
From:   Will Deacon <will@kernel.org>
To:     torvalds@linux-foundation.org
Cc:     catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: [GIT PULL] arm64 fixes for -rc5
Message-ID: <20230721114423.GA12852@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

I've picked up a handful of arm64 fixes while Catalin's been away, so here
they are. The tag has the usual summary, but we have basically have two
cleanups, a fix for an SME crash and a fix for hibernation.

There's a pending issue with memory hot-unplug in some configurations,
but we're still diagnosing that one.

Please pull.

Cheers,

Will

--->8

The following changes since commit 06c2afb862f9da8dc5efa4b6076a0e48c3fbaaa5:

  Linux 6.5-rc1 (2023-07-09 13:53:13 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes

for you to fetch changes up to d4d5be94a87872421ea2569044092535aff0b886:

  arm64/fpsimd: Ensure SME storage is allocated after SVE VL changes (2023-07-21 11:11:09 +0100)

----------------------------------------------------------------
arm64 fixes for -rc3

- Fix saving of SME state after SVE vector length is changed

- Fix sparse warnings for missing vDSO function prototypes

- Fix hibernation resume path when kfence is enabled

- Fix field names for the HFGxTR_EL2 register

----------------------------------------------------------------
Marc Zyngier (1):
      arm64: Fix HFGxTR_EL2 field naming

Mark Brown (1):
      arm64/fpsimd: Ensure SME storage is allocated after SVE VL changes

Nikhil V (1):
      arm64: mm: Make hibernation aware of KFENCE

Zhen Lei (1):
      arm64: vdso: Clear common make C=2 warnings

 arch/arm64/kernel/fpsimd.c             | 33 +++++++++++++++++++++++++--------
 arch/arm64/kernel/vdso/vgettimeofday.c |  4 ++++
 arch/arm64/mm/trans_pgd.c              |  4 +++-
 arch/arm64/tools/sysreg                | 12 ++++++------
 4 files changed, 38 insertions(+), 15 deletions(-)
