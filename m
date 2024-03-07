Return-Path: <linux-kernel+bounces-96159-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B703F8757E8
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 21:05:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D189287D2D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 20:05:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CDD01384BC;
	Thu,  7 Mar 2024 20:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LhTi2+K9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43323138499
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 20:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709841901; cv=none; b=OrvYO6M0YnLj/JFzzcABXfNuECWK0gB6R2fI+StYZV8vT8IHvJHzMfxGdo1zmWNHX2FAU8ES6UNRWCanKigsPr1s5X9a5DrHI2tTBAVAGs9VYNH2QLS1DLB8sO+suEXJnhxoBKqIwz9ZVwEMopgMMOUwt3x4ve1Gqbz34Dfv5Z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709841901; c=relaxed/simple;
	bh=hnbb6tUdjXB7TFFgnyS5gUqhC9Bse+zKkY4XzKdzfjk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SWqfQ5bLAWtggZJlpE01aCUP7Oc+KY0olRfMtrpG1YFbYqrj9rwqiVLlfNrTuAbkVOuilutcmYa/Pc4CkixxogXzNrlYXlHXWt+WwPhkvvNnXy1WwR5wvdshJA7+m83qu4SPPxTu1Wc8ZmZrLS7Vn3mwaTZxh/2yA8/5S0tBfT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LhTi2+K9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5346CC43394;
	Thu,  7 Mar 2024 20:05:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709841900;
	bh=hnbb6tUdjXB7TFFgnyS5gUqhC9Bse+zKkY4XzKdzfjk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LhTi2+K9cC+v9o03ho/S+VdmBn1iN/6YX/2Hl8pSg4oziRBcxb9zGiwnpEaf+H784
	 3y42sfnPmi9DIg2ftZOTG+EmLtaibUMLdiwbu9Oncmii2vxuzjkZnFXRa4bHr5MQdv
	 W7FRFSQJDLdxcxmm/pxewb5OyxZDAmUoakwNI/WI=
Date: Thu, 7 Mar 2024 20:04:57 +0000
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Michal Hocko <mhocko@suse.com>, cve@kernel.org,
	linux-kernel@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>
Subject: Re: CVE-2023-52592: libbpf: Fix NULL pointer dereference in
 bpf_object__collect_prog_relos
Message-ID: <2024030725-amicably-squishier-0d6b@gregkh>
References: <2024030645-CVE-2023-52592-4693@gregkh>
 <ZemPuxhM_ZZ-khTh@tiehlicka>
 <2024030706-unscathed-wilt-e310@gregkh>
 <CAEf4BzbvmwmAmZMvzo9gxyUwy9SQvC_2gFQ1wO-Zvw=9BT=J2g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzbvmwmAmZMvzo9gxyUwy9SQvC_2gFQ1wO-Zvw=9BT=J2g@mail.gmail.com>

On Thu, Mar 07, 2024 at 09:50:38AM -0800, Andrii Nakryiko wrote:
> On Thu, Mar 7, 2024 at 5:16 AM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > On Thu, Mar 07, 2024 at 10:58:19AM +0100, Michal Hocko wrote:
> > > On Wed 06-03-24 06:45:50, Greg KH wrote:
> > > > Description
> > > > ===========
> > > >
> > > > In the Linux kernel, the following vulnerability has been resolved:
> > > >
> > > > libbpf: Fix NULL pointer dereference in bpf_object__collect_prog_relos
> > > >
> > > > An issue occurred while reading an ELF file in libbpf.c during fuzzing:
> > > >
> > > >     Program received signal SIGSEGV, Segmentation fault.
> > > >     0x0000000000958e97 in bpf_object.collect_prog_relos () at libbpf.c:4206
> > > >     4206 in libbpf.c
> > > >     (gdb) bt
> > > >     #0 0x0000000000958e97 in bpf_object.collect_prog_relos () at libbpf.c:4206
> > > >     #1 0x000000000094f9d6 in bpf_object.collect_relos () at libbpf.c:6706
> > > >     #2 0x000000000092bef3 in bpf_object_open () at libbpf.c:7437
> > > >     #3 0x000000000092c046 in bpf_object.open_mem () at libbpf.c:7497
> > > >     #4 0x0000000000924afa in LLVMFuzzerTestOneInput () at fuzz/bpf-object-fuzzer.c:16
> > > >     #5 0x000000000060be11 in testblitz_engine::fuzzer::Fuzzer::run_one ()
> > > >     #6 0x000000000087ad92 in tracing::span::Span::in_scope ()
> > > >     #7 0x00000000006078aa in testblitz_engine::fuzzer::util::walkdir ()
> > > >     #8 0x00000000005f3217 in testblitz_engine::entrypoint::main::{{closure}} ()
> > > >     #9 0x00000000005f2601 in main ()
> > > >     (gdb)
> > > >
> > > > scn_data was null at this code(tools/lib/bpf/src/libbpf.c):
> > > >
> > > >     if (rel->r_offset % BPF_INSN_SZ || rel->r_offset >= scn_data->d_size) {
> > > >
> > > > The scn_data is derived from the code above:
> > > >
> > > >     scn = elf_sec_by_idx(obj, sec_idx);
> > > >     scn_data = elf_sec_data(obj, scn);
> > > >
> > > >     relo_sec_name = elf_sec_str(obj, shdr->sh_name);
> > > >     sec_name = elf_sec_name(obj, scn);
> > > >     if (!relo_sec_name || !sec_name)// don't check whether scn_data is NULL
> > > >             return -EINVAL;
> > > >
> > > > In certain special scenarios, such as reading a malformed ELF file,
> > > > it is possible that scn_data may be a null pointer
> > > >
> > > > The Linux kernel CVE team has assigned CVE-2023-52592 to this issue.
> > >
> > > OK, so this one is quite interesting. This is a userspace tooling
> > > gaining a kernel CVE. Is this just an omission or is this really
> > > expected.
> >
> > "omission"?  I don't understand the question.
> >
> > We are responsible for assigning CVEs to stuff that is in the "Linux
> > kernel source tree" (some have tried to get us to assign CVEs to
> > programs like git that are just hosted on kernel.org), so for now, yes,
> > this includes libbpf as well as stuff like perf.
> >
> > > Also what is the security threat model here? If a malformed ELF file is
> > > loaded then the process gets SEGV which is perfectly reasonable thing to
> > > do.
> >
> > Again, we do not do "threat modeling", we do "does this fix a weakness",
> > and I think this does as causing SEGV might not be a good thing, right?
> >
> > But we'll defer to the libbpf maintainers on this, if they feel this is
> > just a "normal bugfix" then we can revoke this (added them to the cc:
> > here.)
> 
> Libbpf isn't meant to be fed untrusted ELF files, as it's normally
> used under root to perform BPF operations. So we generally treat these
> issues of malformed ELF crashing libbpf as just normal bugs, not as a
> security vulnerability. We even had issues where libelf crashed before
> libbpf could do anything at all. But this happens only for
> fuzzer-generated artificial test cases. In practice compilers produce
> valid ELFs and that's what real world applications are ever going to
> use.
> 
> Also note, in-kernel libbpf sources are only used for kernel
> build-time tooling (resolve_btfids) and for running BPF selftests. In
> both cases incoming ELF files are valid and created in a controlled
> environment. All the out-of-kernel users are supposed to use Github
> mirror of libbpf ([0]), which is used for packing libbpf in distros.
> 
> tl;dr: I wouldn't assign CVE for such issues, thanks.

Ok, thanks, I'll go revoke this and we'll figure out a way to add the
libbpf stuff to our filters to not assign stuff in the future.

greg k-h

