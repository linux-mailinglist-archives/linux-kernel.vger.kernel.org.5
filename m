Return-Path: <linux-kernel+bounces-141660-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DF308A218E
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 00:03:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6FDF61C23E0E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 22:03:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D0E23B798;
	Thu, 11 Apr 2024 22:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="DnrthXIl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8AFC3D977;
	Thu, 11 Apr 2024 22:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712873012; cv=none; b=fZAMDRlnodAARXJwFE551Bsoyo6n4JC0SiIub33EzxNlTi4ug9fMCsCnkD4mhaVIONb5sdd6Oz1xCJCEkaB3MWm6v7w8zfKIzDPnPKO2DZck/Nn3z9qZzs8CrZIZQJvJYiI6l9RRguYKeQJIG9spUaZphUDr+fxPe6w65LcU0jQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712873012; c=relaxed/simple;
	bh=qqiG4gjR0DzHS4DsfgwclPeP2DaIfNonMpXMI2/MFsI=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=lP0evufv73DTWtV+mK1AHV7KBhDDeVrUPz8YAdVScB/qtX0zxVwovxa5Ynlz3SAhmbrwAeOXAdXprW1b1CnBG4xLOjlK7Zg4uKXPMyml783beOQ71qTWYfe5KlLn3ukkkYcmfeat9MBk11pSucHtLCjJ4Qm7hBiKQfoC6uOj1Xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=DnrthXIl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAE26C072AA;
	Thu, 11 Apr 2024 22:03:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1712873012;
	bh=qqiG4gjR0DzHS4DsfgwclPeP2DaIfNonMpXMI2/MFsI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DnrthXIlwyx1UgqWB8QM03BAn4vaTi683GRYY96npAV0FIdX9RXBGgoqCjacfp2gy
	 /gB9Td6IdCtOsYUbU6ga+G4/ZRoneRNBqGGIHksjJMD6VZz4h81F+kjZ2z/ZmnBTfc
	 RhfwyHanyseL71aO5cHo5oyMMAAnS4G+MPBnFzUE=
Date: Thu, 11 Apr 2024 15:03:31 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Michal =?ISO-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Steven
 Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Christian Brauner
 <brauner@kernel.org>, Oleg Nesterov <oleg@redhat.com>, Kent Overstreet
 <kent.overstreet@linux.dev>, Kees Cook <keescook@chromium.org>, Tycho
 Andersen <tandersen@netflix.com>, Jens Axboe <axboe@kernel.dk>, Aleksa
 Sarai <cyphar@cyphar.com>
Subject: Re: [PATCH 2/3] kernel/pid: Remove default pid_max value
Message-Id: <20240411150331.84f57aeb42b0907536997fa6@linux-foundation.org>
In-Reply-To: <uu7pzw6cib324p6orccxonr5dqhgy5zdrjgpdqtt7yuf6b76o5@5nbw3mm64p7w>
References: <20240408145819.8787-1-mkoutny@suse.com>
	<20240408145819.8787-3-mkoutny@suse.com>
	<20240408132955.70d10145d2ea1b0b12b7a5d0@linux-foundation.org>
	<uu7pzw6cib324p6orccxonr5dqhgy5zdrjgpdqtt7yuf6b76o5@5nbw3mm64p7w>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On Thu, 11 Apr 2024 17:40:02 +0200 Michal Koutn=FD <mkoutny@suse.com> wrote:

> Hello.
>=20
> On Mon, Apr 08, 2024 at 01:29:55PM -0700, Andrew Morton <akpm@linux-found=
ation.org> wrote:
> > That seems like a large change.
>=20
> In what sense is it large?

A large increase in the maximum number of processes.  Or did I misinterpret?



