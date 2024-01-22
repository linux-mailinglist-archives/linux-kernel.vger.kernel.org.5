Return-Path: <linux-kernel+bounces-34026-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62D7F83720D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 20:12:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 962F41C2AA31
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 19:12:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3381C41234;
	Mon, 22 Jan 2024 18:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UNVl3p/0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A8FE4120E
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 18:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705949429; cv=none; b=cdaMKa/AIqQgNQrqBTazwQOPmwem/l0zJ1c96UXzUFDW7uHLGKumKOaWKiY/XEc7Y0rZCi3R/yC6h1dhKCeLEHS4JtIbjINA+CLmSKB0Kf2yZr/VD2mQwkant/O0EC8UXsUC4OCnHOcAxKgrkiu3noD1jlZFdrn1vI/QcDlZx3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705949429; c=relaxed/simple;
	bh=/NKl3khn0AdbAfqurSfywc0cWamCfjhhQxDzFHWHxDA=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=iQwQE4nKIf6GWZFGC0pR7qHbinHakXvtjhutjvwoh/XxapvcKFOohywtyP3S4PlhpUEZtlZxQROtFJj5ricmnUuRhoiqkF2RYJpfEkIZvhxneNsT2ImsSZqLmuv1T20TeiRPAX3ljDwmwytAdY1MKE2oM4tS/IR03fywyG4s/bY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UNVl3p/0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E87FC433F1;
	Mon, 22 Jan 2024 18:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705949429;
	bh=/NKl3khn0AdbAfqurSfywc0cWamCfjhhQxDzFHWHxDA=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=UNVl3p/0AoAIclpm9FpkMy7YcnOADLF1r1lsciZ4m5bU9930b12vZsYexFLLAtsSo
	 k6MofpY56psM+buurOEMgZBjyCwK9ongB5DHFOSMlYKd20GENbTspKWouAVCtMSHSm
	 jm3/vxXnZwCooOpg/yRnXDDhZ8F1+rdHGt7D57H6iJvseealcldZPF1NkC9Tjdvuhy
	 tVnoHLjg6D2HHRo5iu0D80kWsyKxwImgzlNrEefZdbgFHjOoJ35pCiNVcVZuicYn0J
	 psrz0odY9gAPELhRqJKl21uxpdigWXswibr8gpyQR87G2zXBCvM5LjZnwRE9ule2vn
	 5R86DV+rOWooA==
Date: Mon, 22 Jan 2024 10:50:27 -0800
From: Kees Cook <kees@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>,
 Steven Rostedt <rostedt@goodmis.org>
CC: Geert Uytterhoeven <geert@linux-m68k.org>, Kees Cook <keescook@chromium.org>,
 linux-kernel@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Christian Brauner <brauner@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>,
 Ajay Kaher <ajay.kaher@broadcom.com>
Subject: =?US-ASCII?Q?Re=3A_=5Bfor-linus=5D=5BPATCH_1/3=5D_eventfs=3A_Have_the_ino?= =?US-ASCII?Q?des_all_for_files_and_directories_all_be_the_same?=
User-Agent: K-9 Mail for Android
In-Reply-To: <CAHk-=wiLqJYT2GGSBhKuJS-Uq1DVq3S32oP0SwqQiATuBivxcg@mail.gmail.com>
References: <20240117143548.595884070@goodmis.org> <20240117143810.531966508@goodmis.org> <CAMuHMdXKiorg-jiuKoZpfZyDJ3Ynrfb8=X+c7x0Eewxn-YRdCA@mail.gmail.com> <20240122100630.6a400dd3@gandalf.local.home> <CAMuHMdXD0weO4oku8g2du6fj-EzxGaF+0i=zrPScSXwphFAZgg@mail.gmail.com> <20240122114743.7e46b7cb@gandalf.local.home> <CAHk-=wiq5mr+wSb6pmtt7QqBhQo_xr7ip=yMwQ5ryWVwCyMhfg@mail.gmail.com> <CAHk-=wjGxVVKvxVf=NDnMhB3=eQ_NMiEY3onG1wRAjJepig=aw@mail.gmail.com> <CAHk-=wiLqJYT2GGSBhKuJS-Uq1DVq3S32oP0SwqQiATuBivxcg@mail.gmail.com>
Message-ID: <52051652-617F-44F5-B8BA-B3BC402E8799@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On January 22, 2024 10:19:12 AM PST, Linus Torvalds <torvalds@linux-founda=
tion=2Eorg> wrote:
>On Mon, 22 Jan 2024 at 09:39, Linus Torvalds
><torvalds@linux-foundation=2Eorg> wrote:
>>
>> Actually, why not juist add an inode number to your data structures,
>> at least for directories? And just do a static increment on it as they
>> get registered?

Yeah, this is what I'd suggest too=2E It avoids all the hash complexity=2E=
 Is wrap-around realistic for it?

-Kees

--=20
Kees Cook

