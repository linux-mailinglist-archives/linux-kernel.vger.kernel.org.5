Return-Path: <linux-kernel+bounces-29080-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F42083080B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 15:29:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F8A61C24E27
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 14:29:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47868208B8;
	Wed, 17 Jan 2024 14:28:48 +0000 (UTC)
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD8162033F;
	Wed, 17 Jan 2024 14:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705501727; cv=none; b=qsmgo0NQIZ9VzLYoKSf00qE+lzlFD0C6cnT60vDho+RG6rKWnxT+O0gyPFoJG2QozTgLiHsmvDvTp9yAJThyFVflqceHCpsJRUO76NxowmWTboAAM27nfk4b15G83Ku/57RKtOFhWCS6ASEBLhObT2C8qr98qzfhu+Xo+xnHfyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705501727; c=relaxed/simple;
	bh=6a4mlGIcQJ+G6+bnDWd0rmwXDm0BP7zkGsQfwd6vtiU=;
	h=Received:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 Content-Language:To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-bounce-key:X-HE-SMSGID; b=gXJ0zISElznFUK8K7jFAMM9xo8aKFMuHrAV0GQO7VFgj27IPakmNSbqIMbX6RimvbhFhKPr1KiBJCrSSClD49kOvW+aYF8Yxp90fmGE4ENTRd+zMZzjR7TZeI5kl8sW//yy6qtBrTJnjp/7KKbcKCHckMJHeunCfvY366KA6obk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1rQ6u1-0007yx-EK; Wed, 17 Jan 2024 15:28:25 +0100
Message-ID: <7c9a417c-920b-4463-966f-250da3697bbf@leemhuis.info>
Date: Wed, 17 Jan 2024 15:28:24 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sched/fair: Fix frequency selection for non invariant
 case
Content-Language: en-US, de-DE
To: Ingo Molnar <mingo@kernel.org>,
 Vincent Guittot <vincent.guittot@linaro.org>
Cc: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
 dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
 mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com, wkarny@gmail.com,
 torvalds@linux-foundation.org, qyousef@layalina.io, tglx@linutronix.de,
 rafael@kernel.org, viresh.kumar@linaro.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org
References: <20240114183600.135316-1-vincent.guittot@linaro.org>
 <ZaZTlcFZaQefnf1v@gmail.com>
From: Thorsten Leemhuis <regressions@leemhuis.info>
In-Reply-To: <ZaZTlcFZaQefnf1v@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1705501725;80889283;
X-HE-SMSGID: 1rQ6u1-0007yx-EK

On 16.01.24 10:59, Ingo Molnar wrote:
> 
> * Vincent Guittot <vincent.guittot@linaro.org> wrote:
> 
>> When frequency invariance is not enabled, get_capacity_ref_freq(policy)
>> returns the current frequency and the performance margin applied by
>> map_util_perf(), enabled the utilization to go above the maximum compute
>> capacity and to select a higher frequency than the current one.
>> [...]
>> Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
>> Closes: https://lore.kernel.org/lkml/CAHk-=wgWcYX2oXKtgvNN2LLDXP7kXkbo-xTfumEjmPbjSer2RQ@mail.gmail.com/
>> Reported-by: Wyes Karny <wkarny@gmail.com>
>> Closes: https://lore.kernel.org/lkml/20240114091240.xzdvqk75ifgfj5yx@wyes-pc/

Thx for resolving this everyone. Allow me a quick question:

I noticed the two Closes: tags above are missing in the actual commit:
https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?id=e37617c8e53a1f7fcba6d5e1041f4fd8a2425c27

Is there a overeager script here that removes them when it shouldn't?

Just asking, because the lack of these tags makes regression tracking
hard. And Linus really wants those tags in cases like this[1].

Ciao, Thorsten

[1] for details, see:
https://lore.kernel.org/all/CAHk-=wjMmSZzMJ3Xnskdg4+GGz=5p5p+GSYyFBTh0f-DgvdBWg@mail.gmail.com/
https://lore.kernel.org/all/CAHk-=wgs38ZrfPvy=nOwVkVzjpM3VFU1zobP37Fwd_h9iAD5JQ@mail.gmail.com/
https://lore.kernel.org/all/CAHk-=wjxzafG-=J8oT30s7upn4RhBs6TX-uVFZ5rME+L5_DoJA@mail.gmail.com/

