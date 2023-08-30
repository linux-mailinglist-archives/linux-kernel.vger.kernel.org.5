Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 044CB78DDB0
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 20:56:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243432AbjH3SxL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 14:53:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343949AbjH3Rfe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 13:35:34 -0400
Received: from rere.qmqm.pl (rere.qmqm.pl [91.227.64.183])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B0BC193
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 10:35:32 -0700 (PDT)
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 4RbWfB5rTkz9y;
        Wed, 30 Aug 2023 19:35:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1693416930; bh=6UmhFhfxlN12h7ng0iUTss971nuo4NsmdZFSHjlVNAQ=;
        h=Date:Subject:From:To:Cc:From;
        b=AT06V2jidt25v5ntA7GPi9+hMTOHi0gf0J5egjfY+FdBe9qc4R3cSVEho2MH6R3JP
         od69GKQ5aNEEKwMqEL2vLrGp2SO1X6DCBEwmzzAhn7HGf/wctCqA72i3c/2iALBgCD
         gq9fbJlgBqbmsSOEpMR+hnzBOtkOAw6jxsGRpmS7GDluPcDOHiq5DN6fTHbAD64TYf
         OeLkpdWamRcviWJRrYIFhGi+tLjhNkudkE/st9E9N488yIioXGMbflbI0cTINSMhDE
         1EPbiiNXG32efpkx+Bc7/C4lkhRPlLKbMGKdhKJmIXjIQOL3i2cD9APoZvemfSN5Qw
         g+rtKp0QW8mng==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.103.8 at mail
Date:   Wed, 30 Aug 2023 19:35:30 +0200
Message-Id: <cover.1693416477.git.mirq-linux@rere.qmqm.pl>
Subject: [PATCH v2 0/7] regulator: core: locking cleanups, part 1/inf
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
From:   =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Douglas Anderson <dianders@chromium.org>,
        linux-kernel@vger.kernel.org, Stephen Boyd <swboyd@chromium.org>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series aims to reduce regulator locking code complexity. There is
a consmetic fix (patch #6) included (applies to unexpected/unlikely
errors only). v2 adds a regulator_lock_contended() function to make the
ww_mutex locking sequence easier to understand.

Michał Mirosław (7):
  regulator/core: regulator_lock_nested: remove `lock`
  regulator/core: regulator_lock_nested: skip extra lock for -EDEADLK
  regulator/core: regulator_lock_nested: simplify nested locking
  regulator/core: regulator_resolve_supply: remove gotos
  regulator/core: regulator_lock_contended: wrap ww_mutex lock sequence
    restart
  regulator/core: regulator_lock_two: propagate error up
  regulator/core: regulator_lock_two: remove duplicate locking code

 drivers/regulator/core.c | 133 +++++++++++++++++----------------------
 1 file changed, 59 insertions(+), 74 deletions(-)

-- 
2.39.2

