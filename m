Return-Path: <linux-kernel+bounces-20265-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CCE3827C9E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 02:48:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7BE241C2322A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 01:48:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EED721873;
	Tue,  9 Jan 2024 01:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CF4UUbZy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AC8015AE
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 01:48:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82B8BC433C7;
	Tue,  9 Jan 2024 01:48:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704764921;
	bh=P5RIbyvI2gqq2hXY1u6dStIhTRuSZ7BantuUnOE43+o=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=CF4UUbZyHUL/OylxsRyS2Tl17qnc/nUZSS8ZveLtTBd+ATaz9nQ2O+abweryv4JGv
	 I4n/p4CXyKWPoHUw8r39IuEetv3BtHAOyb7kIiMw+Uqx1Xlgej3EjJ7/8OVywVDqzG
	 iVu0IWQGVMqDi29L3ez79Y1zFgot65gMHITzkt+tW9kyreZScWJDdU2tDbLsHf5vXv
	 dH6uYCs3ZVn+wn7vmOIPv5uBMVC8iVd+3M7t2T5JJZzD682M/kRA+6oRnc2W716yer
	 ewU793/PDv1+Oh5f8n9YA2aQcmkypxI0wwxTFebED5osZR4Kc5U+yxMCCfSsciy+BP
	 nloi/7AT2N/0g==
Date: Mon, 08 Jan 2024 17:48:38 -0800
From: Kees Cook <kees@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>,
 Kees Cook <keescook@chromium.org>
CC: linux-kernel@vger.kernel.org, Alexey Dobriyan <adobriyan@gmail.com>,
 Josh Triplett <josh@joshtriplett.org>
Subject: Re: [GIT PULL] execve updates for v6.8-rc1
User-Agent: K-9 Mail for Android
In-Reply-To: <CAHk-=wgznerM-xs+x+krDfE7eVBiy_HOam35rbsFMMOwvYuEKQ@mail.gmail.com>
References: <202401081028.0E908F9E0A@keescook> <CAHk-=wgznerM-xs+x+krDfE7eVBiy_HOam35rbsFMMOwvYuEKQ@mail.gmail.com>
Message-ID: <D01C78AC-830C-4D73-9E9F-7FD38CEF2E82@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On January 8, 2024 4:19:45 PM PST, Linus Torvalds <torvalds@linux-foundati=
on=2Eorg> wrote:
>On Mon, 8 Jan 2024 at 10:35, Kees Cook <keescook@chromium=2Eorg> wrote:
>>
>> Josh Triplett (1):
>>       fs/exec=2Ec: Add fast path for ENOENT on PATH search before alloc=
ating mm
>
>No, we're not doing this=2E
>
>If you want to open the file before the allocations, then dammit, do
>exactly that=2E

This was exactly the feedback I had originally and wrote almost what you s=
uggest:

https://lore=2Ekernel=2Eorg/lkml/202209161637=2E9EDAF6B18@keescook/

>Anyway, I want to repeat: this patch is UNTESTED=2E It compiles for me=2E
>But that is literally all the testing it has gotten apart from a
>cursory "this patch looks sane"=2E
>
>There might be something seriously wrong with this patch, but it at
>least makes sense, unlike that horror that will look up the filename
>twice=2E
>
>I bet whatever benchmark did the original was not using long filenames
>with lots of components, or was only testing the ENOENT case=2E

But the perf testing of my proposed "look it up once" patch showed a net l=
oss to the successful execs which no one could explain=2E In the end we wen=
t with the original proposal=2E

If you think this is too much of a hack, I'm happy to drop it=2E My very f=
irst reaction was "fix userspace; shells use access() not execve()" but it =
seems enough other runtimes (Python?) use execve PATH searches that it woul=
d make a measurable real-world difference=2E

-Kees

--=20
Kees Cook

