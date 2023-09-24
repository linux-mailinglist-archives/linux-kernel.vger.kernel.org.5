Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7852F7ACAC2
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Sep 2023 18:17:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229693AbjIXQR6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 12:17:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjIXQR5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 12:17:57 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69639DF
        for <linux-kernel@vger.kernel.org>; Sun, 24 Sep 2023 09:17:48 -0700 (PDT)
Received: from [2a02:8108:8980:2478:5054:ff:feb3:8f48] (helo=regzbot.fritz.box); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1qkRnh-0002j1-KF; Sun, 24 Sep 2023 18:17:41 +0200
From:   "Regzbot (on behalf of Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
To:     LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux regressions mailing list <regressions@lists.linux.dev>
Subject: Linux regressions report  for mainline [2023-09-24]
Date:   Sun, 24 Sep 2023 16:17:40 +0000
Message-Id: <169557219938.3206394.2779757887621800924@leemhuis.info>
X-Mailer: git-send-email 2.40.1
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1695572268;692a44c6;
X-HE-SMSGID: 1qkRnh-0002j1-KF
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,PDS_BTC_ID,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus. There is not much to report wrt to regressions introduced
during the current cycle, as many of those I tracked were fixed over the
past week (not totally sure, but I think this includes all Guenter
reported for -rc1). There is only one regression left that I'm aware of
and a fix for that is under discussion already, so there is nothing to
worry about (FWIW, there are also three vague reports, but I'll ignore
those here).

That being said, there are two other recent regression that I want to
tell you about, as I'm not sure if they are handled as you would like
them to be handled.

(1) Userspace nftables v1.0.6 generated incorrect bytecode that hits a
new kernel check introduced in 0ebc1064e4874d ("netfilter: nf_tables:
disallow rule addition to bound chain via NFTA_RULE_CHAIN_ID")
[v6.5-rc4, v6.4.8, v6.1.43, v5.15.124, v5.10.190]). This causes trouble
for Debian users, as the latest version apparently was using such a
nftables release[1]. Pablo provided patches for the Debian devs to fix
their nftables package[2]; I asked if this could be fixed on the kernel
level and got this reply from Florian: "So while this can be
theoretically fixed in the kernel I don't see a sane way to do it.
Error unwinding / recovery from deeply nested errors is already too
complex for my taste."[3]. That's not really how we normally handle the
"no regression" rule, OTOH due to what Florian said might be the right
thing to do; but it's a judgement call, hence I wanted to tell you about it.

[1] https://lore.kernel.org/all/20230911213750.5B4B663206F5@dd20004.kasserver.com/
[2] https://lore.kernel.org/all/ZP+bUpxJiFcmTWhy@calendula/
[3] https://lore.kernel.org/all/20230912102701.GA13516@breakpoint.cc/


(2) Nearly six weeks ago there was a report that 101bd907b4244a ("misc:
rtsx: judge ASPM Mode to set PETXCFG Reg") [v6.5-rc6, v6.4.11, v6.1.46,
v5.15.127] broke booting various laptops (many or all of them are Dell).
This apparently plagues quite a few users, hence there were multiple
reports (see [2] for those I'm aware of). At least Fedora, openSUSE, and
nixOS have meanwhile reverted the change in their latest stable kernels
[3]. I one and a half week proposed to revert the culprit when I fully
noticed it's impact, but Greg wanted to give the developers more time.
We finally have a fix in sight now [5]; someone affected replied that it
helps. Not sure what's the right way forward now. But overall this to me
feels a lot like "this is not how a regression should be handled".
That's why I wanted to bring it up here in case to ensure your are aware
of this.

[1]
https://lore.kernel.org/all/5f968b95-6b1c-4d6f-aac7-5d54f66834a8@sapience.com/
https://lore.kernel.org/all/30b69186-5a6e-4f53-b24c-2221926fc3b4@sapience.com/

[2]
https://bugs.archlinux.org/task/79439#comment221866
https://bugzilla.kernel.org/show_bug.cgi?id=217802
https://bugzilla.suse.com/show_bug.cgi?id=1214428
https://github.com/NixOS/nixpkgs/issues/253418
https://lore.kernel.org/all/5DHV0S.D0F751ZF65JA1@gmail.com/

[3]
https://gitlab.com/cki-project/kernel-ark/-/commit/80c615ec2edb4aadded21fe924e2caa172d59577
https://github.com/openSUSE/kernel-source/commit/1b02b1528a26f4e9b577e215c114d8c5e773ee10
https://github.com/NixOS/nixpkgs/pull/255824

[4]
https://lore.kernel.org/all/2023091333-fiftieth-trustless-d69d@gregkh/

[5]
https://lore.kernel.org/all/37b1afb997f14946a8784c73d1f9a4f5@realtek.com/

Ciao, Thorsten

---

Hi, this is regzbot, the Linux kernel regression tracking bot.

Currently I'm aware of 1 regressions in linux-mainline. Find the
current status below and the latest on the web:

https://linux-regtracking.leemhuis.info/regzbot/mainline/

Bye bye, hope to see you soon for the next report.
   Regzbot (on behalf of Thorsten Leemhuis)


======================================================
current cycle (v6.5.. aka v6.6-rc), culprit identified
======================================================


[ *NEW* ] mm, memcg: runc fails to gather cgroup statistics
-----------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/lore/20230920081101.GA12096@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net/
https://lore.kernel.org/lkml/20230920081101.GA12096@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net/

By Jeremi Piotrowski; 4 days ago; 25 activities, latest 1 days ago.
Introduced in 86327e8eb94c (v6.6-rc1)

Fix incoming:
* mm, memcg: reconsider kmem.limit_in_bytes deprecation
  https://lore.kernel.org/lkml/d44b0746-2aa6-4608-ab22-bcb9efb27a26@leemhuis.info/


=============
End of report
=============

All regressions marked '[ *NEW* ]' were added since the previous report,
which can be found here:
https://lore.kernel.org/r/169436306694.2246708.7828658786502488268@leemhuis.info

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
