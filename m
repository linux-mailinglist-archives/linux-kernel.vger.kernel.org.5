Return-Path: <linux-kernel+bounces-119543-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D567A88CA32
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 18:06:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F3FC3216A6
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 17:06:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17F3C823B8;
	Tue, 26 Mar 2024 17:04:12 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C44941238;
	Tue, 26 Mar 2024 17:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711472651; cv=none; b=Tn2+tC819viwCEo9IMk15gIC69rUMEJD2J128NSkq9b45C3dLjSmzifRcPM7p4bvo0u9X9lIVLu5IypjQitNgcwHC25N0q1+IXNrcDTsOIVU90+U+J8svcR8dsUtMwqWoQfBY1MjIUIXUtMp6R3VLg5gCgWsoNrbtgtryc0Ck6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711472651; c=relaxed/simple;
	bh=pZjdj3qeK+xf3fVi93MKDUGc+A4DhhKeTEO96yEhaMI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=paVZFEbw2V22cCliaKhe4JN7BySgf0x6gpqjexoRa6W/SsNNlfcFbegwtN7rmfW+xMnDoYtzftDBylvCJmXzf1CKfP17oprVp8q+8DC9+8/7jnnUqcD3vFrXwD6PMdZplqivXdbyuADfzW111ZHpGlLyyPXDIFVrYpGoPpJee0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDCEDC43390;
	Tue, 26 Mar 2024 17:04:08 +0000 (UTC)
Date: Tue, 26 Mar 2024 13:06:47 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: linux-kbuild@vger.kernel.org, Masahiro Yamada <masahiroy@kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Masami
 Hiramatsu <mhiramat@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>,
 Nicolas Schier <nicolas@fjasle.eu>, Nathan Chancellor <nathan@kernel.org>,
 Arnd Bergmann <arnd@arndb.de>, Eduard Zingerman <eddyz87@gmail.com>, Song
 Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, Kees Cook
 <keescook@chromium.org>, bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-modules@vger.kernel.org
Subject: Re: [PATCH 11/12] [v4] kallsyms: rework symbol lookup return codes
Message-ID: <20240326130647.7bfb1d92@gandalf.local.home>
In-Reply-To: <20240326145348.3318887-2-arnd@kernel.org>
References: <20240326144741.3094687-1-arnd@kernel.org>
	<20240326145348.3318887-2-arnd@kernel.org>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 26 Mar 2024 15:53:38 +0100
Arnd Bergmann <arnd@kernel.org> wrote:

> -const char *
> +int
>  ftrace_mod_address_lookup(unsigned long addr, unsigned long *size,
>  		   unsigned long *off, char **modname, char *sym)
>  {
>  	struct ftrace_mod_map *mod_map;
> -	const char *ret = NULL;
> +	int ret;

This needs to be ret = 0;

>  
>  	/* mod_map is freed via call_rcu() */
>  	preempt_disable();

As here we have:

	list_for_each_entry_rcu(mod_map, &ftrace_mod_maps, list) {
		ret = ftrace_func_address_lookup(mod_map, addr, size, off, sym);
		if (ret) {
			if (modname)
				*modname = mod_map->mod->name;
			break;
		}
	}
	preempt_enable();

	return ret;
}

Where it is possible for the loop never to be executed.

-- Steve

