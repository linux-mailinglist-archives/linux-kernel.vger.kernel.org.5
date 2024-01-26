Return-Path: <linux-kernel+bounces-39985-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D96283D81E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 11:29:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A05561C2D736
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 10:29:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22BD61BDEA;
	Fri, 26 Jan 2024 10:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RfzQFS+a"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68E6A1BDDE
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 10:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706263906; cv=none; b=NiBy6j6s0iNBwAKYLagU1wXVkk/+leLzzOfiGrsoIEubCzvpwV0s6rDjsJA7xGjlCAno7Rxr3nkL6L5zkUKu6EaGnUo+uh1M6NRouOOZJcVgZyqbQEWAdqO+0ql2l4MFZkNCmQEHtg5Q22Xl9T+Yvm+XHIIsIwfqp39r+Shh9NM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706263906; c=relaxed/simple;
	bh=TAv9DV4puJdZUA0crlN66HTjsLolk5sxqpiUuYqaIu4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L1MF6dhjVxetGFOWhWapmAmh4M5HJQ7hqpoT9hSes41AHV7ObgrgsMPfh5p7t1hHfECkW54UDK7wB31JSBQZ1FH6GBD+YhlT9C0P0/RtgYHFQaAtm9utonjNIUjVY1qtSPRO91famDpJs6yjuNOoVO2JE0+SuxBZgLuXjH4E+KE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RfzQFS+a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F29B4C43390;
	Fri, 26 Jan 2024 10:11:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706263906;
	bh=TAv9DV4puJdZUA0crlN66HTjsLolk5sxqpiUuYqaIu4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RfzQFS+aCWeMvQWduIhztJsz/I4OsTPumEhCp4OwMD8mcknHuLkU9GScJ5EeaIWy5
	 mKfrPkkxDMiTrNwuLFqCfNqD8jBc0etrY0+z5HUV+uQrv2BdBztIZOtE4rzYHop6UW
	 Thp7JWz17LjFBrfj+8gm2abVuVUCCA/9W5f5fT72n3nhy5sC95RYROg03SCLAs1h/T
	 JUtVVl7VTjbwhvrwlUM/z4jywI7lXIVogoQnn+jJSr3RIdDnmu4vC0CAvJmwRuNuBh
	 XM1yB58WhSDXFsLMtas7qsC1kwHh+TSTFAPI+u/1XKBXo3UK6otS5vVqjyAkq1X1if
	 E+DlhV5x5qN4A==
Date: Fri, 26 Jan 2024 11:11:39 +0100
From: Christian Brauner <brauner@kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Al Viro <viro@zeniv.linux.org.uk>, Ajay Kaher <ajay.kaher@broadcom.com>
Subject: Re: [for-linus][PATCH 1/3] eventfs: Have the inodes all for files
 and directories all be the same
Message-ID: <20240126-wirksam-wenngleich-cd9573d8cb28@brauner>
References: <CAMuHMdXD0weO4oku8g2du6fj-EzxGaF+0i=zrPScSXwphFAZgg@mail.gmail.com>
 <20240122114743.7e46b7cb@gandalf.local.home>
 <CAHk-=wiq5mr+wSb6pmtt7QqBhQo_xr7ip=yMwQ5ryWVwCyMhfg@mail.gmail.com>
 <CAHk-=wjGxVVKvxVf=NDnMhB3=eQ_NMiEY3onG1wRAjJepig=aw@mail.gmail.com>
 <CAHk-=wiLqJYT2GGSBhKuJS-Uq1DVq3S32oP0SwqQiATuBivxcg@mail.gmail.com>
 <20240122144443.0f9cf5b9@gandalf.local.home>
 <20240125-deportation-sogenannten-2d57a7ce8f81@brauner>
 <20240125130731.3b0e2a42@gandalf.local.home>
 <20240125130821.0a1cd3a7@gandalf.local.home>
 <CAMuHMdU-+RmngWJwpHYPjVcaOe3NO37Cu8msLvqePdbyk8qmZA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMuHMdU-+RmngWJwpHYPjVcaOe3NO37Cu8msLvqePdbyk8qmZA@mail.gmail.com>

On Fri, Jan 26, 2024 at 09:07:06AM +0100, Geert Uytterhoeven wrote:
> Hi Steven.
> 
> On Thu, Jan 25, 2024 at 7:08 PM Steven Rostedt <rostedt@goodmis.org> wrote:
> > On Thu, 25 Jan 2024 13:07:31 -0500
> > Steven Rostedt <rostedt@goodmis.org> wrote:
> > > Actually, inodes isn't the biggest issue of tar, as tar *is* a common
> > > operation on tracefs.
> >
> > Correction. tar would be a common operation if it worked ;-)
> 
> What would be needed to fix that?  I regularly use tar on other virtual
> file systems (e.g. /sys/firmware/devicetree/), which works fine.

The size would be one thing. The other is that tar requires unique inode
numbers for all files iirc (That's why we have this whole btrfs problem
- let's not get into this here -  where inode numbers aren't unique and
are duplicated per subvolume.).

