Return-Path: <linux-kernel+bounces-91425-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34C90871156
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 00:51:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD79F284023
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 23:50:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 690297D3F0;
	Mon,  4 Mar 2024 23:50:54 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E65547D07C
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 23:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709596253; cv=none; b=U85th9VS1GYbg2rhfqSZIlzQ806izk8FC7RLrRa4k0SqUWd5/8ocz5D9Ta0Txtw9HnCwxL7F/7RRC5IZs4/G1hbfi7Rj4NVh94XHOP8IEJmq2OiIevEFHoyDresK9uhmp5SdY917Xn2CgqreScez1UO/VO7h48mQ7ab5rODMNM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709596253; c=relaxed/simple;
	bh=2Iyv7vCZXZDmYiIWZEyPF9Ht4oHgg59/NZd7EBwTIkA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hlrGpL1MKHpgINrde7em5IlPVeYqez97U/ab3BWsSe87srtLzSZ25K31cXNl5HAbyWOYRlcr+CN87HP85YYuNTSK2BFacm0yZ+tDaqtzwvYhz8vpF6BDEPtSrzjL2mifJdfLOvL+2ibSnqAQLscmKLHg6xrrTkDMHOsrNhZnc00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 297EAC433F1;
	Mon,  4 Mar 2024 23:50:53 +0000 (UTC)
Date: Mon, 4 Mar 2024 18:52:41 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Sachin Sant <sachinp@linux.ibm.com>
Subject: Re: [GIT PULL] tracing: Prevent trace_marker being bigger than
 unsigned short
Message-ID: <20240304185241.7ce42097@gandalf.local.home>
In-Reply-To: <20240304184725.55449e70@gandalf.local.home>
References: <20240302111244.3a1674be@gandalf.local.home>
	<CAHk-=wj376WMgZ24wKGEWDs_ojNtod-LDZBedPzDYRRcY60UYA@mail.gmail.com>
	<20240302145958.05aabdd2@rorschach.local.home>
	<CAHk-=wgjhdRj1V847NTF4veMN_tCbrySiEHXO8RO3n05cNeXeA@mail.gmail.com>
	<20240302154713.71e29402@rorschach.local.home>
	<CAHk-=wioeo5vyEWUZcGBKMsf3jnjrnnHc3uJiV=JjSKPdvZOEw@mail.gmail.com>
	<20240303075937.36fc6043@rorschach.local.home>
	<CAHk-=wiLdWetJgKHB72VeDALZsjpggEyyuiZ2KmoY_g+3horwQ@mail.gmail.com>
	<20240303140705.0f655e36@rorschach.local.home>
	<CAHk-=wiTGmAXfHiRB8ku4diLxRpN=Hac_q86=j65oiP3J5uXKg@mail.gmail.com>
	<20240303160024.458d4f91@rorschach.local.home>
	<20240304164205.3245608a@gandalf.local.home>
	<CAHk-=wgwy-p_zodT0JvkVkkd5MWy9NffC3jiDiczMMHPj1eQ9w@mail.gmail.com>
	<20240304171034.08d037aa@gandalf.local.home>
	<CAHk-=wi53cJEKim7UvUXtdhQG1BR7oU5TABPXaOq5SmBKLSKYg@mail.gmail.com>
	<20240304184725.55449e70@gandalf.local.home>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 4 Mar 2024 18:47:25 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> If I remove the precision, as I did in this patch. Then adding a limit is
> not fixing any bug. It's just adding a limit.

Anyway, I can change the limit to 4K and also change the trace_seq size to
just 8K to hold events, instead of using PAGE_SIZE.

But this still isn't fixing anything. It's just adding a limit.

I'll add that as a separate patch.

-- Steve

