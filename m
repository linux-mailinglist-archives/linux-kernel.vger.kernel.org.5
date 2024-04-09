Return-Path: <linux-kernel+bounces-137139-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F65989DD6B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 16:59:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B2D41F26EE2
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 14:59:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 470B712FF6D;
	Tue,  9 Apr 2024 14:58:54 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC86685276;
	Tue,  9 Apr 2024 14:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712674733; cv=none; b=Jv06jEx6oeTzCR0A014YJ2xFrREbsHV3CTsrEbGr2EIG5+aEnIqee0iecEnG5qN9JRxERzlBOziMmJkHRqkfvQK8h3vowNLtq9MRZ6vbD369FfR5K+DMhcDthh2C6E1TmqwoK7DOXXuZwz/qYmrXA79HWSyen61sDM1/S33B5ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712674733; c=relaxed/simple;
	bh=wGwVQPo5a62UbnM0Pfv8vXp1bEYX3+DG+IPrfybv2w8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rwVViOyIDbjjzGdlx2eTmn98/qbKyTCuRfJfo8dGXPatkArpDLqZ0Lz+DwIs7xGBksJtxPZgX4XES+vFUf3ZJf+QAMzBW11DSa27w06igKawH3fxgTWWfndy3gZGJ6z3UkB1i0DMGeAD0UIPVZIjSwn81hdGREKA9jKLB17kks8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E417AC433C7;
	Tue,  9 Apr 2024 14:58:51 +0000 (UTC)
Date: Tue, 9 Apr 2024 11:01:26 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Michal =?UTF-8?B?S291dG7DvQ==?= <mkoutny@suse.com>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Masami
 Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Christian Brauner <brauner@kernel.org>,
 Oleg Nesterov <oleg@redhat.com>, Kent Overstreet
 <kent.overstreet@linux.dev>, Kees Cook <keescook@chromium.org>, Andrew
 Morton <akpm@linux-foundation.org>, Tycho Andersen <tandersen@netflix.com>,
 Jens Axboe <axboe@kernel.dk>, Aleksa Sarai <cyphar@cyphar.com>
Subject: Re: [PATCH 1/3] tracing: Remove dependency of saved_cmdlines_buffer
 on PID_MAX_DEFAULT
Message-ID: <20240409110126.651e94cb@gandalf.local.home>
In-Reply-To: <20240408145819.8787-2-mkoutny@suse.com>
References: <20240408145819.8787-1-mkoutny@suse.com>
	<20240408145819.8787-2-mkoutny@suse.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon,  8 Apr 2024 16:58:17 +0200
Michal Koutn=C3=BD <mkoutny@suse.com> wrote:

> @@ -294,7 +295,7 @@ static void __trace_find_cmdline(int pid, char comm[])
>  		return;
>  	}
> =20
> -	tpid =3D pid & (PID_MAX_DEFAULT - 1);
> +	tpid =3D pid % PID_MAP_SIZE;

Does that compile to the same? This is a fast path.

-- Steve


>  	map =3D savedcmd->map_pid_to_cmdline[tpid];
>  	if (map !=3D NO_CMDLINE_MAP) {
>  		tpid =3D savedcmd->map_cmdline_to_pid[map];

