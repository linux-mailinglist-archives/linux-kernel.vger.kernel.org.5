Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC0157D24A7
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Oct 2023 18:49:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232096AbjJVQti (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Oct 2023 12:49:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjJVQth (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Oct 2023 12:49:37 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81B63E7
        for <linux-kernel@vger.kernel.org>; Sun, 22 Oct 2023 09:49:34 -0700 (PDT)
Received: from [2a02:8108:8980:2478:5054:ff:feb3:8f48] (helo=regzbot.fritz.box); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1qubds-0001Oj-9E; Sun, 22 Oct 2023 18:49:32 +0200
From:   "Regzbot (on behalf of Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
To:     LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux regressions mailing list <regressions@lists.linux.dev>
Subject: Linux regressions report  for mainline [2023-10-22]
Date:   Sun, 22 Oct 2023 16:49:31 +0000
Message-Id: <169799330468.525178.1969942838211820764@leemhuis.info>
X-Mailer: git-send-email 2.40.1
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1697993374;a456cabc;
X-HE-SMSGID: 1qubds-0001Oj-9E
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus. My list of unresolved regressions from this cycle became quite
short: it's mainly Andy's boot problem on Merrifield exposed by a quota
change (you already know about it, the tricky investigation is ongoing)
and a PowerMac G5 boot problem (will likely be fixed in the next few
days, as the root of the problem was recently found). There is also a
ext4 problem, but it's not bisected and tricky to debug (investigation
is slow, but in the works).

So let me use this opportunity to mention two other regressions I tracke
that were introduced in earlier cycles. I suspect they are not handled
like you want them to be handled, but I'm not totally sure; hence I
decided to mention them here to give you a chance to chime in yourself
or tell me what to do.

- On a Lenovo ThinkPad L570 since 60aebc9559492c ("drivers/firmware:
Move sysfb_init() from device_initcall to subsys_initcall_sync")
[v6.5-rc1] the screen stays dark during boot until the display manager
starts; the reporter was able to work around that by disabling
DRM_SIMPLEDRM (which had been enabled before). But the problem itself
remains and it seems the developer of said commit wants to leave things
as they are due to lack of access to the affected device:
https://lore.kernel.org/dri-devel/7c50e051-eba2-09fc-da9f-023d592de457@ristioja.ee/
https://lore.kernel.org/dri-devel/CAAhV-H4qQW_fOdkTxmT1xbvo4LOapzw_tOw7Kma47xmh0PvpPA@mail.gmail.com/

- Since 3066ff93476c35 ("fuse: Apply flags2 only when userspace set the
FUSE_INIT_EXT") [v6.5-rc3] creating new files or reading existing files
on Android apparently now returns -EFAULT; this was reported with a
patch to revert the culprit a few weeks ago; there was some discussion
(some a few days ago), but doesn't look like the revert or some other
fix is heading your way, unless I missed something:
https://lore.kernel.org/all/20230904133321.104584-1-git@andred.net/
https://lore.kernel.org/all/5cd87a64-c506-46f2-9fed-ac8a74658631@ddn.com/

Ciao, Thorsten

---

Hi, this is regzbot, the Linux kernel regression tracking bot.

Currently I'm aware of 3 regressions in linux-mainline. Find the
current status below and the latest on the web:

https://linux-regtracking.leemhuis.info/regzbot/mainline/

Bye bye, hope to see you soon for the next report.
   Regzbot (on behalf of Thorsten Leemhuis)


======================================================
current cycle (v6.5.. aka v6.6-rc), culprit identified
======================================================


[ *NEW* ] quota: boot on Intel Merrifield after merge commit 1500e7e0726e
-------------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/lore/ZS5hhpG97QSvgYPf@smile.fi.intel.com/
https://lore.kernel.org/linux-fsdevel/ZS5hhpG97QSvgYPf@smile.fi.intel.com/

By Andy Shevchenko; 5 days ago; 41 activities, latest 0 days ago.
Introduced in 024128477809 (v6.6-rc1)

Recent activities from: Andy Shevchenko (23), Jan Kara (7), Linus
  Torvalds (6), andy.shevchenko@gmail.com (2), Kees Cook (1), Baokun
  Li (1), Josh Poimboeuf (1)

2 patch postings are associated with this regression, the latest is this:
* Re: [GIT PULL] ext2, quota, and udf fixes for 6.6-rc1
  https://lore.kernel.org/linux-fsdevel/ZTKUDzONVHXnWAJc@smile.fi.intel.com/
  2 days ago, by Andy Shevchenko


powerpc: new page table range API causes PowerMac G5 to fail booting
--------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/lore/20230929132750.3cd98452@yea/
https://lore.kernel.org/linuxppc-dev/20230929132750.3cd98452@yea/

By Erhard Furtner; 23 days ago; 15 activities, latest 4 days ago.
Introduced in 9fee28baa601 (v6.6-rc1)

Recent activities from: Michael Ellerman (2), Erhard Furtner (1)

3 patch postings are associated with this regression, the latest is this:
* Re: [Bisected] PowerMac G5 fails booting kernel 6.6-rc3 (BUG: Unable to handle kernel data access at 0xfeffbb62ffec65fe)
  https://lore.kernel.org/linuxppc-dev/8734y8zdpb.fsf@mail.lhotse/
  4 days ago, by Michael Ellerman


===================================================
current cycle (v6.5.. aka v6.6-rc), unknown culprit
===================================================


[ *NEW* ] ext4: task hung in ext4_fallocate
-------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/lore/20231017033725.r6pfo5a4ayqisct7@awork3.anarazel.de/
https://lore.kernel.org/linux-ext4/20231017033725.r6pfo5a4ayqisct7@awork3.anarazel.de/

By Andres Freund; 5 days ago; 4 activities, latest 4 days ago.
Introduced in v6.5..v6.6-rc6

Recent activities from: Andres Freund (3), Theodore Ts'o (1)


=============
End of report
=============

All regressions marked '[ *NEW* ]' were added since the previous report,
which can be found here:
https://lore.kernel.org/r/169737193299.624972.12831031401706621880@leemhuis.info

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
