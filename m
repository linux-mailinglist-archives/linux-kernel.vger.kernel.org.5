Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EDB87F1092
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 11:42:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233093AbjKTKmN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 05:42:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232305AbjKTKmL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 05:42:11 -0500
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB7C1C5
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 02:42:07 -0800 (PST)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id B352240E0191;
        Mon, 20 Nov 2023 10:42:05 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=fail (4096-bit key)
        reason="fail (body has been altered)" header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id s3Bk66p57ugy; Mon, 20 Nov 2023 10:42:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1700476921; bh=a498UqCdgqI7n4Pzky75DyfxOL9DOYfatF1tLA69gmE=;
        h=From:To:Cc:Subject:Date:From;
        b=Y2XnooKrIU6CgKkGZl1uH6BTm2yeh0H/V46Py3DiJU7skXypcgxzlD8OtlIn2K/sa
         BP2RIzuGlHZ4yfl0chrqZ23mzR5LV5dPRN8ZJkql67C5aZKjaJ1xdjB7MUjk4MZT60
         jWfeK7pMIQraxZe/KKTJo+bcAPHL8obFX5qsCV5zt7rzFBg2mttBegducL7Q7KU73G
         fHsvZ7zBaqbdmtmHtoGES/0f9Ybk1hc2oHu7P6hmg+Zfkk4PT1cUtFK0iD8ZqrbQ8o
         yKWyspK8xEzKbTg5PCIphAMSDKIMqW60KO0GDvQ9gR0A8Wpz4R9hMR1Y/rfTFfJbSL
         g3JWelwH7LyAOsGbAjaxZ8XX45Jp+Ly6zPB7KWL8XqLhUl8YD1985gm8Z3/mYyXqIU
         v6EuIeCM9EfgvynhqXN1fITsIT2FkCnqLWDe7OshtadImuCWEEpukKXiYsPLiE7Yyc
         wYvrqFd7A4ReKczogyBCcyAtkw7zPW8JGy4lwWl3ZzJQ/bltjnPrjHb0Y1G76nWRHx
         wr43nfks35IVL+SeLkrUVREpRvmsWj3u51MQA4pTW4z2/pTckOOhdpgLU4ioYpYMMN
         lDwad5CXsg5I9dJ9QmUw7Pv4b2bjWy1bbz7VTZF8Roz3c3JA5kJgAe7ncunRpMCOHk
         DtzcBErIsIh+/yW4HWxAr90c=
Received: from zn.tnic (pd95304da.dip0.t-ipconnect.de [217.83.4.218])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 77E9C40E0030;
        Mon, 20 Nov 2023 10:41:59 +0000 (UTC)
From:   Borislav Petkov <bp@alien8.de>
To:     X86 ML <x86@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 00/13] x86/CPU/AMD: Rework Zen family detection and other fun
Date:   Mon, 20 Nov 2023 11:41:39 +0100
Message-ID: <20231120104152.13740-1-bp@alien8.de>
X-Mailer: git-send-email 2.42.0.rc0.25.ga82fb66fed25
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Borislav Petkov (AMD)" <bp@alien8.de>

Add Zen generation flags which will be used to check on what type of Zen
the kernel runs. Distribute the per-generation init work into the
respective functions and cleanup amd.c properly.

As a result, drop the errata checking gunk which is not needed anymore.

There should be no functionality change resulting from these changes.

Borislav Petkov (AMD) (13):
  x86/CPU/AMD: Add ZenX generations flags
  x86/CPU/AMD: Carve out the erratum 1386 fix
  x86/CPU/AMD: Move the Zen3 BTC_NO detection to the Zen3 init function
  x86/CPU/AMD: Move erratum 1076 fix into the Zen1 init function
  x86/CPU/AMD: Call the spectral chicken in the Zen2 init function
  x86/CPU/AMD: Rename init_amd_zn() to init_amd_zen_common()
  x86/CPU/AMD: Move Zenbleed check to the Zen2 init function
  x86/CPU/AMD: Move the DIV0 bug detection to the Zen1 init function
  x86/CPU/AMD: Get rid of amd_erratum_1054[]
  x86/CPU/AMD: Get rid of amd_erratum_383[]
  x86/CPU/AMD: Get rid of amd_erratum_400[]
  x86/CPU/AMD: Get rid of amd_erratum_1485[]
  x86/CPU/AMD: Drop now unused CPU erratum checking function

 arch/x86/include/asm/cpufeatures.h |   6 +-
 arch/x86/kernel/cpu/amd.c          | 266 ++++++++++++++---------------
 2 files changed, 135 insertions(+), 137 deletions(-)

--=20
2.42.0.rc0.25.ga82fb66fed25

