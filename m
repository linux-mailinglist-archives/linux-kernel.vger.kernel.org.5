Return-Path: <linux-kernel+bounces-26459-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C47282E13D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 21:05:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED2B5283830
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 20:05:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EFC718EB2;
	Mon, 15 Jan 2024 20:05:29 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3357C18E2A
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 20:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CF7A82F4;
	Mon, 15 Jan 2024 12:06:12 -0800 (PST)
Received: from [192.168.178.6] (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 190513F73F;
	Mon, 15 Jan 2024 12:05:23 -0800 (PST)
Message-ID: <0880d81b-9c80-423c-95e6-2fe973e7d739@arm.com>
Date: Mon, 15 Jan 2024 21:05:22 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] Scheduler changes for v6.8
Content-Language: en-US
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Qais Yousef <qyousef@layalina.io>, Wyes Karny <wkarny@gmail.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
 Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>,
 Juri Lelli <juri.lelli@redhat.com>, Steven Rostedt <rostedt@goodmis.org>,
 Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
 Daniel Bristot de Oliveira <bristot@redhat.com>,
 Valentin Schneider <vschneid@redhat.com>
References: <CAHk-=wiXpsxMcQb7MhL-AxOityTajK0G8eWeBOzX-qBJ9X2DSw@mail.gmail.com>
 <CAHk-=wjK28MUqBZzBSMEM8vdJhDOuXGSWPmmp04GEt9CXtW6Pw@mail.gmail.com>
 <20240114091240.xzdvqk75ifgfj5yx@wyes-pc> <ZaPC7o44lEswxOXp@vingu-book>
 <20240114123759.pjs7ctexcpc6pshl@wyes-pc>
 <CAKfTPtCz+95dR38c_u6_7JbkVt=czj5N2dKYVV-zk9dgbk16hw@mail.gmail.com>
 <20240114151250.5wfexq44o3mdm3nh@airbuntu>
 <CAKfTPtAMxiTbvAYav1JQw+MhjzDPCZDrMLL2JOfsc0GWp+FnOA@mail.gmail.com>
 <20240114195815.nes4bn53tc25djbh@airbuntu>
 <CAKfTPtCGgJiFDrZYpynCiHBnQx48A9RsAY9-6Hshduo4ymGJLQ@mail.gmail.com>
 <20240115120915.fukpcdumntdsllwi@airbuntu>
 <CAKfTPtAMacH4hKLyttLuQJjzc=D4m864MFaEEwZLG4K8RKTDYA@mail.gmail.com>
 <dfde5b4f-0d5e-49b6-a787-0766eff23f91@arm.com>
 <CAKfTPtB72Oa8XvH_xRFiKy+bfyEKUMdndKphFAD3dixePBUohQ@mail.gmail.com>
From: Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <CAKfTPtB72Oa8XvH_xRFiKy+bfyEKUMdndKphFAD3dixePBUohQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 15/01/2024 16:26, Vincent Guittot wrote:
> On Mon, 15 Jan 2024 at 15:03, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
>>
>> On 15/01/2024 14:26, Vincent Guittot wrote:
>>> On Mon, 15 Jan 2024 at 13:09, Qais Yousef <qyousef@layalina.io> wrote:
>>>>
>>>> On 01/15/24 09:21, Vincent Guittot wrote:

[...]

> Now, util can't be higher than max to handle clamping use cases
> whereas it could be the case before. The jump to next OPP was
> previously done with util being higher than max and it's now done with
> freq being higher than policy->cur

Ah, OK:

  util = map_util_perf(util)     <- (1) util *= 1.25

in the old code was doing this. And you do this now via frequency for
the !freq_inv case. I just saw that you already mention this in the
patch header of:
https://lkml.kernel.org/r/20240114183600.135316-1-vincent.guittot@linaro.org

