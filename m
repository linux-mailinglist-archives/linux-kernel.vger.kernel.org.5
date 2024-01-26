Return-Path: <linux-kernel+bounces-40123-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 62C5F83DA99
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 14:16:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95A121C21CC3
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 13:16:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 114DF1B7F9;
	Fri, 26 Jan 2024 13:16:17 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C2701B801
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 13:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706274976; cv=none; b=ow9KnxqpEgAPPp37NHv/sdfupl8tLELWW7ZohQ/+gMd2JRUpmo1SYfvklhuJPscrTlPXamMGxJKVI9ur8IbtFEY44PyN2ivSqWN31jbXWz6l9/RuOHfhANELBrrK+bnHJWB9LCM+prKGXl5dxdnlpVLXj++CKXwQZupDHSknhIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706274976; c=relaxed/simple;
	bh=6WEf8P0PdldtUGk1fUeRoFVpMCxznnbJzYhHiJCgxc8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O/57gmcsozt6FV+6wdWWzyx0lvBMG+PT01X0gzxJ0ICyf25o6vCvnPDIydM3NAcg0dXib4I2TQWo9DIU9ZkoofoakUYXOb0VrYvpu7UjKDF5jNrXkpGHmEF7EXcNipqShkkRmus1nn2ynyV5NSdqZi9WqNF4lTkd3OBG5N4tQH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5AC1C433F1;
	Fri, 26 Jan 2024 13:16:14 +0000 (UTC)
Date: Fri, 26 Jan 2024 08:16:16 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Christian Brauner <brauner@kernel.org>, Linus Torvalds
 <torvalds@linux-foundation.org>, Kees Cook <keescook@chromium.org>,
 linux-kernel@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>, Mark
 Rutland <mark.rutland@arm.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>, Al Viro <viro@zeniv.linux.org.uk>, Ajay Kaher
 <ajay.kaher@broadcom.com>
Subject: Re: [for-linus][PATCH 1/3] eventfs: Have the inodes all for files
 and directories all be the same
Message-ID: <20240126081616.28c02f10@gandalf.local.home>
In-Reply-To: <CAMuHMdU-+RmngWJwpHYPjVcaOe3NO37Cu8msLvqePdbyk8qmZA@mail.gmail.com>
References: <20240117143548.595884070@goodmis.org>
	<20240117143810.531966508@goodmis.org>
	<CAMuHMdXKiorg-jiuKoZpfZyDJ3Ynrfb8=X+c7x0Eewxn-YRdCA@mail.gmail.com>
	<20240122100630.6a400dd3@gandalf.local.home>
	<CAMuHMdXD0weO4oku8g2du6fj-EzxGaF+0i=zrPScSXwphFAZgg@mail.gmail.com>
	<20240122114743.7e46b7cb@gandalf.local.home>
	<CAHk-=wiq5mr+wSb6pmtt7QqBhQo_xr7ip=yMwQ5ryWVwCyMhfg@mail.gmail.com>
	<CAHk-=wjGxVVKvxVf=NDnMhB3=eQ_NMiEY3onG1wRAjJepig=aw@mail.gmail.com>
	<CAHk-=wiLqJYT2GGSBhKuJS-Uq1DVq3S32oP0SwqQiATuBivxcg@mail.gmail.com>
	<20240122144443.0f9cf5b9@gandalf.local.home>
	<20240125-deportation-sogenannten-2d57a7ce8f81@brauner>
	<20240125130731.3b0e2a42@gandalf.local.home>
	<20240125130821.0a1cd3a7@gandalf.local.home>
	<CAMuHMdU-+RmngWJwpHYPjVcaOe3NO37Cu8msLvqePdbyk8qmZA@mail.gmail.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 26 Jan 2024 09:07:06 +0100
Geert Uytterhoeven <geert@linux-m68k.org> wrote:

> Hi Steven.
>=20
> On Thu, Jan 25, 2024 at 7:08=E2=80=AFPM Steven Rostedt <rostedt@goodmis.o=
rg> wrote:
> > On Thu, 25 Jan 2024 13:07:31 -0500
> > Steven Rostedt <rostedt@goodmis.org> wrote: =20
> > > Actually, inodes isn't the biggest issue of tar, as tar *is* a common
> > > operation on tracefs. =20
> >
> > Correction. tar would be a common operation if it worked ;-) =20
>=20
> What would be needed to fix that?  I regularly use tar on other virtual
> file systems (e.g. /sys/firmware/devicetree/), which works fine.

Looks like all /sys files have one page in size. I could change the default
file size to one page and it might work (if the inodes had different
numbers), as I don't see any format file greater than 4k.

This would fix the events for tar, but it couldn't do the same for tracing.
As some files don't actually have a size.

-- Steve




