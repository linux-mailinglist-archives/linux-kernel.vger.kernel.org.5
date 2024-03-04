Return-Path: <linux-kernel+bounces-91345-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AF00870FD5
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 23:12:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DA289B26826
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 22:12:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCCCD7F48F;
	Mon,  4 Mar 2024 22:08:47 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68A727BAFD
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 22:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709590127; cv=none; b=YpfCVnpnh4dtqcExsoXaaOdVS7HEPCwkfnkwV8lBsCcdRkMqfb9H6IelsXNhCdlbmFoEXYa2axSMLz4nahueIOu9VfSWJ0Xy8nAnuE+LaKzTcHCMB+8+mdq9YpK8K/vYyWiRxeXoi5rZTv9BuwlAE8/1t2YILYbJMDAdq+jly34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709590127; c=relaxed/simple;
	bh=troFpq8k35BWXLnesXmRO+Fl54Smbk9Y7MSRfar35pw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M6WprVTvADXNjLAKv0kM6WEOeW0pzWH4fGFlSBBl1FDGx+L8KVE7V0Lmk2tFzB2tgAP4jo9IKQfQ9w9aZgJu1Q/J29HefF0rTyMFMP5rqPq9gp+rNir/dTMreBDhug/ipwazNQI04iEU33TzIbWVrxYdUzcPc2bkQjtvwUSAnW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56449C433C7;
	Mon,  4 Mar 2024 22:08:46 +0000 (UTC)
Date: Mon, 4 Mar 2024 17:10:34 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Sachin Sant <sachinp@linux.ibm.com>
Subject: Re: [GIT PULL] tracing: Prevent trace_marker being bigger than
 unsigned short
Message-ID: <20240304171034.08d037aa@gandalf.local.home>
In-Reply-To: <CAHk-=wgwy-p_zodT0JvkVkkd5MWy9NffC3jiDiczMMHPj1eQ9w@mail.gmail.com>
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
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 4 Mar 2024 13:50:13 -0800
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Mon, 4 Mar 2024 at 13:40, Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> > As I mentioned that the design is based on that the allocated buffer size is
> > the string length rounded up to the word size, all I need to do is to make
> > sure that there's a nul terminating byte within the last word of the
> > allocated buffer. Then "%s" is all I need.  
> 
> Please don't add pointless code that helps nothing.
> 
> > Would this work for you?  
> 
> No. This code only adds debug code, and doesn't actually improve anything.
> 
> We *have* debug code already. Things like KASAN already find array
> overruns, and your ex-tempore debug code adds zero actual value.

Sorry I thought debug code was OK. But I guess I was mistaken. KASAN isn't
run in the field, where this would trigger. But I get your point. If it's
passing my tests (which I do run with KASAN), I guess that's good enough
for you.

> 
> That, btw, is why your old stupid precision code was not only
> triggering warnings, but was ACTIVELY DETRIMENTAL.
> 
> All that precision code could ever do was to potentially hide bugs if
> the string wasn't NUL-terminated.
> 
> So no. I absolutely do NOT want you to write more code to hide bugs or
> do half-arsed checking.

Well, it wouldn't hide it. It would trigger a big fat warning if it was
missing a nul terminator.

> 
> I want you to *simplify* the code, and put proper limits in place for strings.
> 
> I want to see the code that actually notices when somebody generates a
> crazy string, and stops that garbage in its tracks.
> 
> What I do *not* want to see is more ad-hoc code that tries to deal
> with the symptoms of you not having done so.

This warning is just making sure the code is nul terminated. It has nothing
to do with size. The bug that triggered when I was working on other code
was a miscalculation of the input. I didn't write the entire string into
the ring buffer which meant that the terminating nul was also missing. On
reading the string, it crashed the kernel.

I put in the precision when debugging the code, and that's where I found the
mismatch in string size vs writing to the buffer. I then kept the precision
just in case I hit a similar bug. Which is what you have issues with.

Fine, I'll just remove the precision as that's not needed. There was no
other overflows involved here.

-- Steve

