Return-Path: <linux-kernel+bounces-32083-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 770B2835647
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 16:24:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 055DE28229B
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 15:24:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74CF33771D;
	Sun, 21 Jan 2024 15:23:51 +0000 (UTC)
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF2153770B;
	Sun, 21 Jan 2024 15:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705850631; cv=none; b=q7nBmnUZbbFt8AVQI7VuMuPemWW4dz/ZLi8jnEYQE8295ssypAg2CwTTlsFnPWMcRGTSE/Dkjo+QXBgAOj+DPEQsE9lnfuo9C4L1f13ujIM3yuv9zh94EJqu+xXtgRqUREe1qNIOVFOhYhLeVtWo0mvKR3KaxELW4Lc8L68XuD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705850631; c=relaxed/simple;
	bh=56tz8bvaCmYn3Xfn9l70uN7AWV2MgAN02cVg6axlrsY=;
	h=From:To:Subject:Date:Message-Id:Content-Type:MIME-Version; b=vFgcLyemMnfOfaQG7T1d1yGJr37lHOm5qtw8AcS1KbskZje780j9a6GVnIR3i4goiPYZ4qiDCPOccGvq+onkZIq59siFzFwwH77eYSmOTbhXhGoiupuX6oveG2lRH6my+OIHJGvwdNvB+QhIz3YPj55IKYFboGcb2tnwQqSyjJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Received: from [2a02:8108:8980:2478:5054:ff:feb3:8f48] (helo=regzbot.fritz.box); authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	id 1rRZfh-0001tI-7B; Sun, 21 Jan 2024 16:23:41 +0100
From: "Regzbot (on behalf of Thorsten Leemhuis)" <regressions@leemhuis.info>
To: LKML <linux-kernel@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Linux regressions mailing list <regressions@lists.linux.dev>
Subject: Linux regressions report  for mainline [2024-01-21]
Date: Sun, 21 Jan 2024 15:23:40 +0000
Message-Id: <170585059505.2778011.9564698506290962184@leemhuis.info>
X-Mailer: git-send-email 2.40.1
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1705850628;1002774c;
X-HE-SMSGID: 1rRZfh-0001tI-7B

Hi Linus. I kept a loose eye on a handful of regressions introduced
during the merge window, but all except a build problem Guenter reported
already got resolved (and Guenter's will likely soon be addressed as
well). I wish we'd be as fast when it comes to regressions that are only
noticed once a proper mainline release is out. Speaking of which:

* Quite a few people reported problems due to a mm change that made it
into 6.7 three days before its release: efa7df3e3bb5 ("mm: align larger
anonymous mappings on THP boundaries"). It among others "breaks 32bit
processes on x86_64 (at least). In particular, 32bit kernel or firefox
builds in our build system." as Jiri noted. For details and other
problems reported see:

  https://lore.kernel.org/linux-mm/d0a136a0-4a31-46bc-adf4-2db109a61672@kernel.org/
  https://lore.kernel.org/linux-mm/CAJuCfpHXLdQy1a2B6xN2d7quTYwg2OoZseYPZTRpU0eHHKD-sQ@mail.gmail.com/
  https://lore.kernel.org/all/1e8f5ac7-54ce-433a-ae53-81522b2320e1@arm.com/
  https://lore.kernel.org/all/a914c7f2-cf9f-44a8-99d4-c25a66d39f1c@arm.com/

  A patch that fixes at least Jiri's problem is up for review:
https://lore.kernel.org/all/20240118180505.2914778-1-shy828301@gmail.com/

  Hope that fix reaches you soon.

* BTW a quick TWIMC: ath11k is crashing during suspend on v6.7; a fix
exists and hopefully will reach mainline next week:

  https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless.git/commit/?id=556857aa1d0855aba02b1c63bc52b91ec63fc2cc

  Sadly lacks a stable tag. I sometimes wish they were mandatory in
cases like this to ensure this the fix makes it to the latest latest
stable series. But whatever, under the current circumstances this it's
not that bad as 6.6.y is a longterm branch.

Ciao, Thorsten

---

Hi, this is regzbot, the Linux kernel regression tracking bot.

Currently I'm aware of 1 regressions in linux-mainline. Find the
current status below and the latest on the web:

https://linux-regtracking.leemhuis.info/regzbot/mainline/

Bye bye, hope to see you soon for the next report.
   Regzbot (on behalf of Thorsten Leemhuis)


========================================================
current cycle (v6.7.. aka v6.7-post), culprit identified
========================================================


[ *NEW* ] spi: qemu emulations quanta-q71l-bmc and almetto-bmc fail to boot
---------------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/lore/3d3a11b1-8396-4d8e-9bb3-61ecb67e7efa@roeck-us.net/
https://lore.kernel.org/lkml/3d3a11b1-8396-4d8e-9bb3-61ecb67e7efa@roeck-us.net/

By Guenter Roeck; 8 days ago; 5 activities, latest 0 days ago.
Introduced in 4d8ff6b0991d

Recent activities from: Guenter Roeck (3), Mark Brown (2)


=============
End of report
=============

All regressions marked '[ *NEW* ]' were added since the previous report,
which can be found here:
https://lore.kernel.org/r/170463193667.1966610.7165124970993807605@leemhuis.info

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

