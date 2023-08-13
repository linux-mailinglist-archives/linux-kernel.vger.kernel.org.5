Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 366FC77A73D
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Aug 2023 17:02:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230211AbjHMPCM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Aug 2023 11:02:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231421AbjHMPB5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Aug 2023 11:01:57 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2122F9F
        for <linux-kernel@vger.kernel.org>; Sun, 13 Aug 2023 08:01:59 -0700 (PDT)
Received: from [2a02:8108:8980:2478:5054:ff:feb3:8f48] (helo=regzbot.fritz.box); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1qVCbN-0005Dw-EE; Sun, 13 Aug 2023 17:01:57 +0200
From:   "Regzbot (on behalf of Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
To:     LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux regressions mailing list <regressions@lists.linux.dev>
Subject: Linux regressions report  for mainline [2023-08-13]
Date:   Sun, 13 Aug 2023 15:01:56 +0000
Message-Id: <169193884982.322301.2963227405402975023@leemhuis.info>
X-Mailer: git-send-email 2.40.1
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1691938919;55391693;
X-HE-SMSGID: 1qVCbN-0005Dw-EE
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus. Not much to report from by side – but I'm on vacation since
Thursday (for a bit more that two weeks) and thus didn't monitor lists
as closely as I usually do, so I might have missed recent reports. But
nevertheless here are three things of note where you might or might not
want to take action yourself:

 * a regression in nouveau causes boot problems on some cards:
https://lore.kernel.org/all/97730.1690408399@warthog.procyon.org.uk/

Sadly the patches that causes this also were backported to stable and
Greg likely wants to see it fixed in mainline to pick up the fixes for
stable. Karol was on PTO this week, but ACKed reverting 
ea293f823a8 ("drm/nouveau/kms/nv50-: init hpd_irq_lock for PIOR DP")
2b5d1c29f6c ("drm/nouveau/disp: PIOR DP uses GPIO for HPD, not PMGR AUX interrupts")
752a281032b2 ("drm/nouveau/i2c: fix number of aux event slots"

To fix the regression quickly; but afaics nobody submitted such a
revert. :-/
https://lore.kernel.org/lkml/CACO55ttZUVCVuWpBiTcr1goWWxs2KP1Xxg00X+hYhbpeJzUEFA@mail.gmail.com/

 * a fix for a crypto regression[1] is sitting in next as
6a4b8aa0a91 ("crypto: af_alg - Fix missing initialisation affecting
gcm-aes-s390") for more than a week now :-/
https://lore.kernel.org/lkml/CAAUqJDuRkHE8fPgZJGaKjUjd3QfGwzfumuJBmStPqBhubxyk_A@mail.gmail.com/

 * The developers behind ef492d08030 ("crypto: caam - adjust RNG timing
to support more devices") recently agreed to revert the commit due to a
regression, but afaics nobody submitted a revert yet; I just asked who
will take care of this, so I guess this will happen during next week:
https://lore.kernel.org/lkml/DU0PR04MB95637DD95D05179F36AFAF958E10A@DU0PR04MB9563.eurprd04.prod.outlook.com/

Ciao, Thorsten

---

Hi, this is regzbot, the Linux kernel regression tracking bot.

Currently I'm aware of 5 regressions in linux-mainline. Find the
current status below and the latest on the web:

https://linux-regtracking.leemhuis.info/regzbot/mainline/

Bye bye, hope to see you soon for the next report.
   Regzbot (on behalf of Thorsten Leemhuis)


======================================================
current cycle (v6.4.. aka v6.5-rc), culprit identified
======================================================


crypto: broke CAAM RNG instantiation on an i.MX8MM
--------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/lore/e1f3f073-9d5e-1bae-f4f8-08dc48adad62@pengutronix.de/
https://lore.kernel.org/lkml/e1f3f073-9d5e-1bae-f4f8-08dc48adad62@pengutronix.de/

By Bastian Krause; 27 days ago; 10 activities, latest 0 days ago.
Introduced in ef492d08030 (v6.5-rc1)

Recent activities from: Meenakshi Aggarwal (2), Linux regression
  tracking (Thorsten Leemhuis) (1)

One patch associated with this regression:
* Re: [PATCH] crypto: caam - adjust RNG timing to support more devices
  https://lore.kernel.org/lkml/f673a09e-e212-ee7b-15c3-78afe8c70916@pengutronix.de/
  26 days ago, by Bastian Krause


btrfs: write-bandwidth performance regression with NVMe raid0
-------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/lore/20230731152223.4EFB.409509F4@e16-tech.com/
https://lore.kernel.org/linux-btrfs/20230731152223.4EFB.409509F4@e16-tech.com/

By Wang Yugui; 13 days ago; 18 activities, latest 0 days ago.
Introduced in da023618076 (v6.5-rc1)

Recent activities from: Wang Yugui (2), Chris Mason (1), Christoph
  Hellwig (1)

3 patch postings are associated with this regression, the latest is this:
* Re: btrfs write-bandwidth performance regression of 6.5-rc4/rc3
  https://lore.kernel.org/linux-btrfs/20230811222321.2AD2.409509F4@e16-tech.com/
  2 days ago, by Wang Yugui


ALSA: hda/realtek: Audible "pop" sound whenever audio card goes in or out of sleep
----------------------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/bugzilla.kernel.org/217732/
https://bugzilla.kernel.org/show_bug.cgi?id=217732
https://lore.kernel.org/regressions/bc22f6c4-a147-3032-49ef-0784d0171d9a@leemhuis.info/

By serfreeman1337 and serfreeman1337; 14 days ago; 5 activities, latest 2 days ago.
Introduced in 69ea4c9d02b7 (v6.5-rc3)

Recent activities from: Takashi Iwai (1), The Linux kernel's regression
  tracker (Thorsten Leemhuis) (1)


[ *NEW* ] drm/nouveau: stopped booting
--------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/lore/20230806213107.GFZNARG6moWpFuSJ9W@fat_crate.local/
https://lore.kernel.org/lkml/20230806213107.GFZNARG6moWpFuSJ9W@fat_crate.local/

By Borislav Petkov; 6 days ago; 16 activities, latest 3 days ago.
Introduced in 2b5d1c29f6c4 (v6.5-rc3)

Recent activities from: Karol Herbst (6), Takashi Iwai (5), Borislav
  Petkov (3), Thorsten Leemhuis (2)


kernel pointer dereference regression due to extract_iter_to_sg()
-----------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/lore/CAAUqJDuRkHE8fPgZJGaKjUjd3QfGwzfumuJBmStPqBhubxyk_A@mail.gmail.com/
https://lore.kernel.org/lkml/CAAUqJDuRkHE8fPgZJGaKjUjd3QfGwzfumuJBmStPqBhubxyk_A@mail.gmail.com/

By Ondrej Mosnáček; 31 days ago; 12 activities, latest 6 days ago.
Introduced in c1abe6f570af (v6.5-rc1)

Fix incoming:
* crypto: af_alg - Fix missing initialisation affecting gcm-aes-s390
  https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?h=master&id=6a4b8aa0a916b39a39175584c07222434fa6c6ef


=============
End of report
=============

All regressions marked '[ *NEW* ]' were added since the previous report,
which can be found here:
https://lore.kernel.org/r/169134199152.488860.7520017509596978680@leemhuis.info

Thanks for your attention, have a nice day!

  Regzbot, your hard working Linux kernel regression tracking robot


P.S.: Wanna know more about regzbot or how to use it to track regressions
for your subsystem? Then check out the getting started guide or the
reference documentation:

https://gitlab.com/knurd42/regzbot/-/blob/main/docs/getting_started.md
https://gitlab.com/knurd42/regzbot/-/blob/main/docs/reference.md

The short version: if you see a regression report you want to see
tracked, just send a reply to the report where you Cc
regressions@lists.linux.dev with a line like this:

#regzbot introduced: v5.13..v5.14-rc1

If you want to fix a tracked regression, just do what is expected
anyway: add a 'Link:' tag with the url to the report, e.g.:

Link: https://lore.kernel.org/all/30th.anniversary.repost@klaava.Helsinki.FI/
