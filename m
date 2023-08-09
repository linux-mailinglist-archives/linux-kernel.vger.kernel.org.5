Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE488775708
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 12:27:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231608AbjHIK1a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 06:27:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbjHIK13 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 06:27:29 -0400
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13F031BFB
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 03:27:27 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 532CC40E01A2;
        Wed,  9 Aug 2023 10:27:25 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=fail (4096-bit key)
        reason="fail (body has been altered)" header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id atR8U43Jhv0V; Wed,  9 Aug 2023 10:27:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1691576842; bh=Gi8XwvZynD55Z7D1kmvLGz4KuMxRH6qe4bgPLVQU8TE=;
        h=From:To:Cc:Subject:Date:From;
        b=KTxUVqu7jxL1XaTzF++uyKQGdv5L/YS7LFhZC+eNS5TBVQDq+QoCBHHxIoa65jihe
         Rdqi3PpRHcovm8iquWQdtiCuxwg4eirDZxBaB0+2sIKZJXdBnIu872q56pPJX83Gsy
         Yj9ShjdWQmPc/ZkkibcqxF4RBLj+ByMXEMMeUgHH5+tYvGZshhvrX8SeCayc03f9Gc
         20DTezR0Q30FLDDvFVJQL7lh/pC5bEYEX1KASfFLuNjnD5VlU/z0DvBh8HqT1cpjWG
         7Vh1QgbZnfztbcd+bWLuoKIdyjYTvbZDQX4qt2gMMyPi2EIUlAMfZhHUmWx6kgj4Ws
         pZiQvgqLNgREYv5ezsHGQ7Md9rnycOS9mxnWMk4H0MGwlPM19U9U6S7TOA+HM+zxcc
         gqn+EgH59h2nkNTA6q0mo2YDRTkxHGW7zFKu1u8pQ2JdRBtn1Rr9IDR2ODGy25WPiq
         Q1JTcIrfMhx9VbGpXDYqWYHk3TuqZyusejdMeD2U3IEpzpy71YZOmSHtAg3U49FWjl
         JKYIx4iL+I/imFMKwKXqrv/cvKVNwWvykb9jMsx7g8392H6T95NV1tSn/QoAJNpFTK
         IsGXn6fj0NOfg5qNn93T1qmkEqDohjc+biVVuk3nv5mZ4D3UWHHkBwUyaa6ua2xlTB
         14dacK+quy3yeYzRhBZNEDdw=
Received: from zn.tnic (pd9530d32.dip0.t-ipconnect.de [217.83.13.50])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 7F9C440E0140;
        Wed,  9 Aug 2023 10:27:19 +0000 (UTC)
From:   Borislav Petkov <bp@alien8.de>
To:     X86 ML <x86@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/3] x86/bugs: Some SRSO fixes
Date:   Wed,  9 Aug 2023 12:26:57 +0200
Message-ID: <20230809102700.29449-1-bp@alien8.de>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Borislav Petkov (AMD)" <bp@alien8.de>

Hi all,

those are the leftover smaller fixes which can go after the release
date. I'll queue them next week.

Thx.

Borislav Petkov (AMD) (3):
  Documentation/hw-vuln: Unify filename specification in index
  driver core: cpu: Unify redundant silly stubs
  Documentation/srso: Document IBPB aspect and fix formatting

 Documentation/admin-guide/hw-vuln/index.rst | 12 +--
 Documentation/admin-guide/hw-vuln/srso.rst  | 71 ++++++++++-------
 drivers/base/cpu.c                          | 86 +++++----------------
 3 files changed, 68 insertions(+), 101 deletions(-)

--=20
2.41.0

