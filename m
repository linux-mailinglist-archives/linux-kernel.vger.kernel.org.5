Return-Path: <linux-kernel+bounces-69837-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F383858F56
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 13:27:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 611E21C2186A
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 12:27:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1C306A030;
	Sat, 17 Feb 2024 12:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uYWRbN0U"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E24F281E;
	Sat, 17 Feb 2024 12:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708172833; cv=none; b=b+So1pSmlP9HJM9jAyFwSWBYvUJZBfPv9x6Y41XVNiK/LzkaLAubJjNsSVkfov4vrXGsuFh3hwFZ5fJI+yO7VxPXj7e6eXB02bkBKALHrSI19Khj18P5Hq1ynTARWsv/iG7oZRAPtkhTKlLkMmMyCBItEfLSxloJTrQ1YW0gRcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708172833; c=relaxed/simple;
	bh=CI+mga30EQ/XT42bpPPtbFN8gfOv0yqyoO4Q2QC2UnU=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=qLgv3OYJaJJkpdObvs8alIZcKAjYy1K3jvCK3GiN+QhZRpGHIgHZ4qOzUxbVTGxgBy9+51WJckgkr9X1rC1k59wnNfOvZrEtpZMBohye9eXC+ufl0WE3zH5qRRfY0+vuBStTSsGowy217bgOr3fy3OFUV6ro4byqwpw/C0mECWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uYWRbN0U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35288C433F1;
	Sat, 17 Feb 2024 12:27:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708172832;
	bh=CI+mga30EQ/XT42bpPPtbFN8gfOv0yqyoO4Q2QC2UnU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=uYWRbN0UXsln3U/B+qSgvZSSLiywEOyexYX7sGqT87Ev1/qMA6O0kxq4tMhALRQGy
	 YvfPqu5+SFYI3avgq623xQJnIdyHLPHO+VP9eUOPTkxXhUxBh7fa6OJWb/V/4a4Xu8
	 lnziGJZFJ+5wCztv99t93ultFEqKTF/jUNk2zAL34G1ZPbOns6HHoOiNTSAoiE650q
	 C2PG6thz8pOnwlgGbRmkPH4T9Hf2efl3EE4R37P3gO/ccG2Hm72JZhFcYll4RYTLqj
	 0n6TLDcoF2wsQCQoSNYm+xAA4Q/0KrVCR31kTtOVzXyqqx6/itaz2Vil2O400vbOZ5
	 Ls0hQoNnVXQxg==
Date: Sat, 17 Feb 2024 21:27:08 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org, Steven
 Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH RFC 1/5] tracing/probes: Fix to search structure fields
 correctly
Message-Id: <20240217212708.2e14a88e6c1e9733450459f6@kernel.org>
In-Reply-To: <170791694361.389532.10047514554799419688.stgit@devnote2>
References: <170791693437.389532.6816883363982512874.stgit@devnote2>
	<170791694361.389532.10047514554799419688.stgit@devnote2>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Let me pick this patch because this is a real bugfix.

On Wed, 14 Feb 2024 22:22:23 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Fix to search a field from the structure which has anonymous union
> correctly.
> Since the reference `type` pointer was updated in the loop, the search
> loop suddenly aborted where it hits an anonymous union. Thus it can not
> find the field after the anonymous union. This avoids updating the
> cursor `type` pointer in the loop.
> 
> Fixes: 302db0f5b3d8 ("tracing/probes: Add a function to search a member of a struct/union")
> Cc: stable@vger.kernel.org
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> ---
>  kernel/trace/trace_btf.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/trace/trace_btf.c b/kernel/trace/trace_btf.c
> index ca224d53bfdc..5bbdbcbbde3c 100644
> --- a/kernel/trace/trace_btf.c
> +++ b/kernel/trace/trace_btf.c
> @@ -91,8 +91,8 @@ const struct btf_member *btf_find_struct_member(struct btf *btf,
>  	for_each_member(i, type, member) {
>  		if (!member->name_off) {
>  			/* Anonymous union/struct: push it for later use */
> -			type = btf_type_skip_modifiers(btf, member->type, &tid);
> -			if (type && top < BTF_ANON_STACK_MAX) {
> +			if (btf_type_skip_modifiers(btf, member->type, &tid) &&
> +			    top < BTF_ANON_STACK_MAX) {
>  				anon_stack[top].tid = tid;
>  				anon_stack[top++].offset =
>  					cur_offset + member->offset;
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

