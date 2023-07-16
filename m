Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0CF8755076
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jul 2023 20:38:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbjGPShm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jul 2023 14:37:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjGPShl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jul 2023 14:37:41 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6696E1B5
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jul 2023 11:37:39 -0700 (PDT)
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A90291EC0749;
        Sun, 16 Jul 2023 20:37:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1689532657;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:references;
        bh=okesFLEEOyn70sSxHf50dIjdCRuTwlZ1vZGa/Ncp/TI=;
        b=LM/tzl2LFuZk3r3m5U1GbxpOsfuI8uif0kQTlEJfBgoD42eKjHnOqrxFoO/RPe2+uBJnYb
        aTigchcYd1hK8nTmHVpvaDSt6dYSF1D8OKHPesvJt2IxkvGzQBpKO6M8dcrG23A3Jd5Bnv
        hCdoCmjndkQ7EZ9aCsZexAyTtvwOTks=
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id I9RxKh7pjR-C; Sun, 16 Jul 2023 18:37:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1689532654; bh=okesFLEEOyn70sSxHf50dIjdCRuTwlZ1vZGa/Ncp/TI=;
        h=Date:From:To:Cc:Subject:From;
        b=F+R2HJ2swB008qFVNlwFNYd/fo33+ay+vFMdGPEDc3WVC+1+eTl3OrsLbEOGstLq/
         48MNhsxF05GefEvn/+Y4u9LT2MpW1XuCAU0DsMGX6eoeL1ou2pTTVo7B2nS5ki10vy
         zXOsrQtQVgOuhacdM5W3M8fFbAj/MA+bwHEcBeiMd47ffbnA6/075TjcCpf/z3S6IS
         d4lApi6VJOVjmodpUiFWRzmm+Z5JmzBl/I4Lgdq8eP9HN+4jNDHMXISs8Kz+ZEzenP
         eiNCiqQA+DaVD3U+3EfLMkkWmkEj0EIfv5CNvLotF6GtWSh2SeTYW057gBGXW1kdS1
         68Jk1ht/lQCvlwRDqumiHAoOgg654nJkDXdL9QbIIXiiv+O3sI6Xl0pBYD5FzpCclu
         o5UHT3Lpo6M79j6B2RbaB8S4NEbAFU3tQWToy+zg79iLXcfCFz3WHB8balqx9clahv
         iIM6KcvAe2MFOFTo6onzMJFacpLvCn7APIKr+oxkZ0On5dU1EDYG9TYMo94XWwbTgZ
         yuaoVSp6XGRhng2cjq8FuBpzEJtvMBFEES5G9FYTclghg1HcHXckHBO1fYxTKJxpMc
         bgsoxWnzzYDBjUbBvZyvmOZ4le2TYXNqukR0edz8H4S43MJR2NoBmT1cT5GvlLqw2Q
         cmHldDxQKKdj3xIbEq5xtXlk=
Received: from zn.tnic (pd9530d32.dip0.t-ipconnect.de [217.83.13.50])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 8706C40E00F4;
        Sun, 16 Jul 2023 18:37:31 +0000 (UTC)
Date:   Sun, 16 Jul 2023 20:37:26 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] sched/urgent for v6.5-rc2
Message-ID: <20230716183726.GEZLQ45tOt9L548BJ4@fat_crate.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull two urgent scheduler fixes for 6.5.

Thx.

---

The following changes since commit 06c2afb862f9da8dc5efa4b6076a0e48c3fbaaa5:

  Linux 6.5-rc1 (2023-07-09 13:53:13 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/sched_urgent_for_v6.5_rc2

for you to fetch changes up to aff037078ecaecf34a7c2afab1341815f90fba5e:

  sched/psi: use kernfs polling functions for PSI trigger polling (2023-07-10 09:52:30 +0200)

----------------------------------------------------------------
- Remove a cgroup from under a polling process properly

- Fix the idle sibling selection

----------------------------------------------------------------
Miaohe Lin (1):
      sched/fair: Use recent_used_cpu to test p->cpus_ptr

Suren Baghdasaryan (1):
      sched/psi: use kernfs polling functions for PSI trigger polling

 include/linux/psi.h       |  5 +++--
 include/linux/psi_types.h |  3 +++
 kernel/cgroup/cgroup.c    |  2 +-
 kernel/sched/fair.c       |  2 +-
 kernel/sched/psi.c        | 29 +++++++++++++++++++++--------
 5 files changed, 29 insertions(+), 12 deletions(-)

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
