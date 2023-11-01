Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FED67DE3D4
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 16:37:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232421AbjKAPE4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 11:04:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjKAPEy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 11:04:54 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CB63FD;
        Wed,  1 Nov 2023 08:04:52 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD3C6C433C9;
        Wed,  1 Nov 2023 15:04:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698851092;
        bh=LRyD/0lfmUMCFmo/dgJzLHKPzw63T5YzFSCKWUKxnG8=;
        h=From:To:Cc:Subject:Date:From;
        b=KvaMMksAdzFxExkmu1Dqn3zYbKkoPOJh+lZOVEIkn3h4JuWRkhC1hRvLl/B/5yh2M
         P8ITZ4RP9JPn5Ahpf1QSQljQI44hVsGGEsA2jH2GBWq1gg1BhIvVkFoJOypRNipJtQ
         mI/ibc4Rhd/eweTmPaQhnSneuXgMc1H+Zw5JwQ4PGNe9H7S8IVgxxSmpd/Zvw7fA9k
         c9Q2wdz2KWtcfu/J+0EU+/k1JME2pTyRoKDkdg1eDjwlzNeo5MKmjypT7Ll++oLL8a
         HwUn+h5b2TliQI+Ie0WzUP6MZ/Ca3Xx/uu0dGlr0UwmQwL8ktMovnIs4mbL+pzpc8M
         hRdQoUtDTwhSA==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Greg Ungerer <gerg@kernel.org>,
        Jack Brennen <jbrennen@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>
Subject: [PATCH 0/7] modpost: fix modpost errors for m68k-uclinux-gcc
Date:   Thu,  2 Nov 2023 00:03:57 +0900
Message-Id: <20231101150404.754108-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Greg Ungerer reports building with m68k-uclinux-gcc toolchain is broken:
https://lore.kernel.org/linux-kbuild/CAK7LNASQ_W5Yva5a4Xx8E2EYi-tN7x3OHgMFhK+93W+BiX1=9Q@mail.gmail.com/T/#m6ff0364f9ca8483c9f6d162619e5005833d1e887

Usually, we do not need to search for export symbols in the .symtab
section, but m68k-uclinux-gcc seems to be an exceptional case.
I do not know what makes it different from other toolchains.
Also, I do not know there exist other toolchains that work like that.

This series extends the symsearch feature in case we need to explicitly
search for export symbols.

Then, the last patch fixes the issue.

This series should be applicable for linux-next.

This series is too late for the current merge window, but I'd like
to fix the issue somehow by the next merge window.



Masahiro Yamada (7):
  modpost: move sym_name() to modpost.h
  modpost: add const qualifier to syminfo table
  modpost: add table_size local variable to symsearch_find_nearest()
  modpost: introduce a filtering feature to symsearch
  modpost: prefer global symbols in symsearch_find_nearest()
  modpost: add symsearch_find_with_name() helper function
  modpost: look up the correct symbol in check_export_symbol()

 scripts/mod/modpost.c   |  39 ++++----
 scripts/mod/modpost.h   |  12 +++
 scripts/mod/symsearch.c | 205 ++++++++++++++++++++++++++++------------
 3 files changed, 180 insertions(+), 76 deletions(-)

-- 
2.40.1

