Return-Path: <linux-kernel+bounces-61946-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 156738518D0
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 17:17:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9732228296D
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 16:17:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 962423D0D2;
	Mon, 12 Feb 2024 16:17:03 +0000 (UTC)
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0A833D0B6;
	Mon, 12 Feb 2024 16:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707754623; cv=none; b=XFpIcMo+wADh4TZIX5BQBpfK3DkkuGswYjIpcgGDFEyr2uqINJnCcg7e5y5hKQY7B4aZCNuZmZHpFhxGv474jBj1Yja9J1ySdj1iu/+ThsNfXsyhlNNvSpLSVmvM6rZ/Yh27DQmWicsUsErrW2uvfiHk0l4OFb/Pyz6YitFtYIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707754623; c=relaxed/simple;
	bh=XiSCSWQLPVABFex+zdas6pNksSgMX3x6uGMmE8PYqjo=;
	h=Message-ID:Date:MIME-Version:From:To:Cc:Subject:Content-Type; b=V9E/lX84xJNNQFbj5xmwEjHgEF8DQshE11Z/FAa15L8vhtPKiKaKp4OEbMB0BKmcG1F3fBuIBWHZ2ZoHBHBwWEy8zZnjhzpgHBnstSwo11oIkQhMENvZfggrpul8OWvl6Fn6WYqS/hGMP+xoqTVpXNrqWSONy4KHohHVWDb1S10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1rZYzK-0002Kc-Tp; Mon, 12 Feb 2024 17:16:58 +0100
Message-ID: <f9f89284-0f48-4971-ad8d-86938a82fafc@leemhuis.info>
Date: Mon, 12 Feb 2024 17:16:58 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US, de-DE
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
To: Greg KH <gregkh@linuxfoundation.org>, Sasha Levin <sashal@kernel.org>,
 David Laight <David.Laight@ACULAB.COM>
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>,
 Linux kernel regressions list <regressions@lists.linux.dev>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
Subject: [regression] linux-6.6.y, minmax: virtual memory exhausted in i586
 chroot during kernel compilation
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1707754621;0deb7cf8;
X-HE-SMSGID: 1rZYzK-0002Kc-Tp

Hi Greg, Sasha, and David,

I noticed a regression report in bugzilla.kernel.org that seems to be
specific to the linux-6.6.y series:

Quoting from https://bugzilla.kernel.org/show_bug.cgi?id=218484 :

> After upgrading to version 6.6.16, the kernel compilation on a i586
> arch (on a 32bit chroot in a 64bit host) fails with a message:
> 
> virtual memory exhausted: Cannot allocate memory
> 
> this happens even lowering the number of parallel compilation
> threads. On a x86_64 arch the same problem doesn't occur. It's not
> clear whether some weird recursion is triggered that exhausts the
> memory, but it seems that the problem is caused by the patchset
> 'minmax' added to the 6.6.16 version, in particular it seems caused
> by these patches:
> 
> - minmax-allow-min-max-clamp-if-the-arguments-have-the-same-signedness.patch
> - minmax-fix-indentation-of-__cmp_once-and-__clamp_once.patch
> - minmax-allow-comparisons-of-int-against-unsigned-char-short.patch
> - minmax-relax-check-to-allow-comparison-between-unsigned-arguments-and-signed-constants.patch
> 
> Reverting those patches fixes the memory exhaustion problem during compilation.

The reporter later added:

> From a quick test the same problem doesn't occur in 6.8-rc4.
See the ticket for more details.

Note, you have to use bugzilla to reach the reporter, as I sadly[1] can
not CCed them in mails like this.

[TLDR for the rest of this mail: I'm adding this report to the list of
tracked Linux kernel regressions; the text you find below is based on a
few templates paragraphs you might have encountered already in similar
form.]

BTW, let me use this mail to also add the report to the list of tracked
regressions to ensure it's doesn't fall through the cracks:

#regzbot introduced: 204c653d5d0c79940..9487d93f172acef
https://bugzilla.kernel.org/show_bug.cgi?id=218484
#regzbot title: minmax: virtual memory exhausted in 6.6.16 with i586 chroot
#regzbot ignore-activity

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.

[1] because bugzilla.kernel.org tells users upon registration their
"email address will never be displayed to logged out users"

