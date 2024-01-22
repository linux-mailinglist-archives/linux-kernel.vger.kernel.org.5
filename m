Return-Path: <linux-kernel+bounces-33983-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 61E32837161
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 19:58:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9452B1C29F24
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 18:58:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A192B4F5F1;
	Mon, 22 Jan 2024 18:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="rgP6a9lU"
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF86D4F5F3
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 18:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705948047; cv=none; b=KPVzh2bSov2NmPWhSRlvsKcBceH8778j1PgmuqHtyELMwM1uj/6sFhON75mb5Rm4oiIR09m6W/p2FuzO3c0rSEM1pfQSTxxsSdcyk3pjSy1EGtqCSOmkUO71nMbub2uq4ZJm4mS50YDeUyLGaqxklWjGv1kOuIQMkNTvsH56gQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705948047; c=relaxed/simple;
	bh=5LcgpOOqbLj9qSMEPJ2zpvvrKBU2HoNgldi9XXiwmX0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jqrNURNWos2pP+evbtZQvoFK/RvUFKrbVz9IWMHPL7WWwBPny9rDvpAFmTSS1gUgp4pq9jSePBVhFA2GXpdaHs9HxZ6CbFSb4z2zBqmfwQc4Hgy67YrXa2TXBSsRkBKbRi+plpW1Yop7DkmJ2YTUN6OVAf5iQn+gIw4OAyyQr30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=rgP6a9lU; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1705948044;
	bh=5LcgpOOqbLj9qSMEPJ2zpvvrKBU2HoNgldi9XXiwmX0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=rgP6a9lU+BoP0ILl/Vl3hBdqjULkPu9a2J/VUgqK17YN0EOz6A6WCRYYnnPm2J7w6
	 vrEVuEX8fumCAVC8zc5Lkx6NSAPCLrd1vHMTMKN5tyrF+VXvA6AqbPdFJYvvDVqrVn
	 H5QsCE63Fi2YAj20Ns77Dc69htC1/0VVIT6A01em2mCTwO1YpVADDu1TEzmDTqtzGF
	 jTneemoWOw0T8UtmPPWwAjczT61WJAi4DXMsxB3ms0iPXCd6APkfkgV8APrRY/A7kI
	 EsqqBvzwqLXWfiHeLkApQfrOKZ8bmvgGJa7HPJZOZadB1joTWAKvdH9UMruO6lJ7Bg
	 7aXoef/eWl17Q==
Received: from [172.16.0.134] (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4TJdx81lXRzTQC;
	Mon, 22 Jan 2024 13:27:24 -0500 (EST)
Message-ID: <bb90c70d-85fa-4228-a333-ab91eea945b2@efficios.com>
Date: Mon, 22 Jan 2024 13:27:25 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [for-linus][PATCH 1/3] eventfs: Have the inodes all for files and
 directories all be the same
Content-Language: en-US
To: Linus Torvalds <torvalds@linux-foundation.org>,
 Steven Rostedt <rostedt@goodmis.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
 Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
 Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Christian Brauner <brauner@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>,
 Ajay Kaher <ajay.kaher@broadcom.com>
References: <20240117143548.595884070@goodmis.org>
 <20240117143810.531966508@goodmis.org>
 <CAMuHMdXKiorg-jiuKoZpfZyDJ3Ynrfb8=X+c7x0Eewxn-YRdCA@mail.gmail.com>
 <20240122100630.6a400dd3@gandalf.local.home>
 <CAMuHMdXD0weO4oku8g2du6fj-EzxGaF+0i=zrPScSXwphFAZgg@mail.gmail.com>
 <20240122114743.7e46b7cb@gandalf.local.home>
 <CAHk-=wiq5mr+wSb6pmtt7QqBhQo_xr7ip=yMwQ5ryWVwCyMhfg@mail.gmail.com>
 <CAHk-=wjGxVVKvxVf=NDnMhB3=eQ_NMiEY3onG1wRAjJepig=aw@mail.gmail.com>
 <CAHk-=wiLqJYT2GGSBhKuJS-Uq1DVq3S32oP0SwqQiATuBivxcg@mail.gmail.com>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <CAHk-=wiLqJYT2GGSBhKuJS-Uq1DVq3S32oP0SwqQiATuBivxcg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-01-22 13:19, Linus Torvalds wrote:
> On Mon, 22 Jan 2024 at 09:39, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
>>
>> Actually, why not juist add an inode number to your data structures,
>> at least for directories? And just do a static increment on it as they
>> get registered?
>>
>> That avoids the whole issue with possibly leaking kernel address data.
> 
> The 'nlink = 1' thing doesn't seem to make 'find' any happier for this
> case, sadly.
> 
> But the inode number in the 'struct eventfs_inode' looks trivial. And
> doesn't even grow that structure on 64-bit architectures at least,
> because the struct is already 64-bit aligned, and had only one 32-bit
> entry at the end.
> 
> On 32-bit architectures the structure size grows, but I'm not sure the
> allocation size grows. Our kmalloc() is quantized at odd numbers.
> 
> IOW, this trivial patch seems to be much safer than worrying about
> some pointer exposure.

My only concern about the simple ino_counter static increment is what
happens in the unlikely scenario of a 32-bit overflow. This is why
I suggested using a bitmap to track inode allocation. It's compact, and
we don't care that much about the linear bitmap scan overhead because
it's far from being a fast path.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com


