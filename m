Return-Path: <linux-kernel+bounces-111867-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B5CAD8871E4
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 18:27:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 536FC1F22B3F
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 17:27:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57F205FBBA;
	Fri, 22 Mar 2024 17:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R53Y9fMA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 986131C6AB;
	Fri, 22 Mar 2024 17:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711128449; cv=none; b=ZmUWqMtQ3Lw3iSXgsXGPs9ZZxHaU6/Zo9XjJX1nj4tnhZxblC/j/x3xP9lyNf+SySfkd/tDs79G1FfM+f21ywLqIa2rbN6Bn2tVGG7p2NMzPOJ0rLNg7CVLTExr8v2ikrfmQ1yDyEi0iumhleY0aDIhpvl40SiV4bYuZFLM5D84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711128449; c=relaxed/simple;
	bh=8jU4Y94EgTZ2cjnSSp7l1TCrtVwVdXwRUYY1Hz25hzk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wc9h6FJYU0m25x2uzEWF4UiACoevHMluYaqFJ+Zr3V54bEOe8PK1ySuNeGudKxhVmf+jws0ujgaLVs1seyekUqEwc1EBAMb89j4ruUyDPt3eJJcqHDs6BE7MMTdFJn0fd04sL/JMFEG7I6HWn2TeSgaXEpjQzFtB7KKCS9poJQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R53Y9fMA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91BCCC433F1;
	Fri, 22 Mar 2024 17:27:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711128449;
	bh=8jU4Y94EgTZ2cjnSSp7l1TCrtVwVdXwRUYY1Hz25hzk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=R53Y9fMA3e14/1ff1d4IvrBB//jd7qQ4DJBGT7ibVt+eMuvh38Rvn6sZrEF+/FYtE
	 VZ+nNoz9Rt+JFCmCu36RheRF34nBzeRhg+RHFM5hQ8q3ArZq8pbantXKE7oDHHVZxz
	 /V0M7fO/sZz8xqjkKf3P6SgxNNnplgeYLT+uXtb0F45wzDfaSzV/IQIwNlGbXvgdxg
	 Sa1BH5llQw6qrJHN1WxqDARsTXm8t1g2QkA9sgV3IxZXiLCoejc9lUeoOVKoJbZNPd
	 zSk5faKwi1g3MOpndx9FuXlZVO/ieMWSGF5oVLud//r8LlX0dOPO2KnE3qlMfNlofO
	 TbV5ExZWDEnuw==
Date: Fri, 22 Mar 2024 14:27:26 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Alan Maguire <alan.maguire@oracle.com>
Cc: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas@fjasle.eu>, bpf@vger.kernel.org,
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kbuild: disable pahole multithreading for reproducible
 builds
Message-ID: <Zf2_fgs0cqW82zEu@x1>
References: <20240322-pahole-reprodicible-v1-1-3eaafb1842da@weissschuh.net>
 <49fa2bd1-bd6e-4404-a1c7-2170d37f0194@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <49fa2bd1-bd6e-4404-a1c7-2170d37f0194@oracle.com>

On Fri, Mar 22, 2024 at 10:07:00AM +0000, Alan Maguire wrote:
> On 22/03/2024 08:31, Thomas Weiﬂschuh wrote:
> > A BTF type_id is a numeric identifier allocated by pahole through
> > libbpfd. Ids are incremented for each allocation.
> > Running pahole multithreaded makes the sequence of allocations
> > non-deterministic which also makes the type_id itself non-deterministic.
> > As the type_id end up in the binary this breaks reproducibility.
> > 
> > Therefore, if the kernel is built reproducibly as indicated by
> > KBUILD_BUILD_TIMESTAMP, disable threading in pahole.
> > 
> > Fixes: b4f72786429c ("scripts/pahole-flags.sh: Parse DWARF and generate BTF with multithreading.")
> > Fixes: 72d091846de9 ("kbuild: avoid too many execution of scripts/pahole-flags.sh")
> > Signed-off-by: Thomas Weiﬂschuh <linux@weissschuh.net>
> 
> Yep, we've talked about sorting final BTF in various ways but until that
> is implemented, non-parallel execution of pahole is the best way to get
> reliabily-reproducing BTF ids. We should probably update the pahole

So, the problem is about parallel BTF encoding, not so much about
parallel DWARF loading, which speeds up the whole process and could
continue if we make sure that we feed the BTF encoder in the same order
as when not doing anything in parallel.

I.e. a serial BTF encoding done at the same time as a parallel DWARF
loading would produce a reproducible build faster than doing
_everything_ serially.

The important point would be to feed the btf encoder the DWARF CUs in
the same order as when doing it serially.

No need to order anything, just create a linked list/array of CUs and
then start loading them and leave the BTF encoder go on taking CUs from
that linked list/array in the order they are in vmlinux.

- Arnaldo

> manpage to warn about parallel non-deterministic id allocation in the
> meantime.
> 
> Reviewed-by: Alan Maguire <alan.maguire@oracle.com>
> 
> > ---
> >  scripts/Makefile.btf | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/scripts/Makefile.btf b/scripts/Makefile.btf
> > index 82377e470aed..2356929e62e4 100644
> > --- a/scripts/Makefile.btf
> > +++ b/scripts/Makefile.btf
> > @@ -10,7 +10,10 @@ endif
> >  
> >  pahole-flags-$(call test-ge, $(pahole-ver), 121)	+= --btf_gen_floats
> >  
> > +# threaded execution randomizes BTF type_id allocation, breaking reproducibility
> > +ifeq ($(KBUILD_BUILD_TIMESTAMP),)
> >  pahole-flags-$(call test-ge, $(pahole-ver), 122)	+= -j
> > +endif
> >  
> >  pahole-flags-$(CONFIG_PAHOLE_HAS_LANG_EXCLUDE)		+= --lang_exclude=rust
> >  
> > 
> > ---
> > base-commit: 8e938e39866920ddc266898e6ae1fffc5c8f51aa
> > change-id: 20240322-pahole-reprodicible-02e904e45686
> > 
> > Best regards,
> 

