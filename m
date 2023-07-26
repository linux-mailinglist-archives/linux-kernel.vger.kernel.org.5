Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 637EB763F40
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 21:09:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231579AbjGZTJo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 15:09:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjGZTJn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 15:09:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22B331FF0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 12:09:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 636B861C2E
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 19:09:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 634E6C433C7;
        Wed, 26 Jul 2023 19:09:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690398580;
        bh=wpXDQkyhqevpCIjGRP6IrCzl4cjAiAQRIDWv3E1gcPQ=;
        h=From:To:Cc:Subject:Date:From;
        b=ASN2DIA0e/2uiBlXaXTYYywEIEdTTahPMEZcPJKy+c6Y6k3ypi/oH34eI0a4uuRbP
         xqkiRmZXVhMWozBRLAWQTQ1cVxyRj0I44uHdwgMd6tRQnOTm10wPnddAF8kvrNHEBb
         1/WgA65rVsjWSpPyZJtatJwkzNognv/5Jzq/Ha7DvDjp8Yw+glIAFUBaqMWY5CwHC8
         9dswwPCe4M+e2HWlU4A3ip0c/bFjmFeajUWye3TruhCKHZNoxDkIREnfTg8vjxOjo1
         mzuDJaaiyfRdUHSAvG4Ig5Xv8tbBJWq0MdaEUEGzB/D0k07xfs8ObLRcTbFT25/Zak
         LKCKszOSaSiZw==
From:   SeongJae Park <sj@kernel.org>
To:     ksummit@lists.linux.dev
Cc:     sj@kernel.org, inux-mm@kvack.org, damon@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [TECH TOPIC] DAMON: Current Status and Future Plans
Date:   Wed, 26 Jul 2023 19:09:26 +0000
Message-Id: <20230726190926.85121-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,


I'm posting my Kernel Summit topic suggestion below.  I will also submit it to
the LPC site.


DAMON[1,2] is a Linux kernel subsystem that provides efficient data access
monitoring and access-aware system operations (DAMON-based Operation Schemes,
a.k.a DAMOS).  A service provider reported that they are showing about a 16%
reduction in memory usages with modest overhead on their products by utilizing
a DAMON-based system operation scheme.

After its initial introduction[3], it has continued to develop in response to
the voices from the users and kernel hackers.  We also proactively tried to get
more feedback by sharing the status and discussing future works in multiple
venues including every kernel summits since 2019[3,4,5,6] and DAMON
community[7,8].  As a result, DAMON made substantial improvements while the
list for future works never emptied.

This talk will aim to continue the sharing and discussion at the kernel summit
of 2023.  We will share what feedback we received, what patches have been
developed or are under development, what requests are still in the planning
stage, and what the plans are.  With that, hopefully we will have discussions
that will be helpful for improving and prioritizing the plans and specific
tasks, and finding new requirements.

Specific sub-topics would include, but are not limited to:

- Efficient ABI and a convenient user-space tool
- Fine-grained DAMOS control
- Partial self-tuning of DAMOS
- Extension of DAMON monitoring targets
- Plan for collaborative memory-overcommit VM system management
- Plan for tiered-memory management
- Plan for DAMON accuracy improvement

Based on the progress until the summit, some items can be added or dropped.

[1] project homepage, https://damonitor.github.io
[2] official doc, https://docs.kernel.org/mm/damon/index.html
[3] ksummit 2019, https://linuxplumbersconf.org/event/4/contributions/548/
[4] ksummit 2020, https://www.linuxplumbersconf.org/event/7/contributions/659/
[5] ksummit 2021, https://linuxplumbersconf.org/event/11/contributions/984/
[6] ksummit 2022, https://lpc.events/event/16/contributions/1224/
[7] DAMON mailing list, https://lore.kernel.org/damon
[8] DAMON meetup, https://lore.kernel.org/damon/20220810225102.124459-1-sj@kernel.org/


Thanks,
SJ
