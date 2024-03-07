Return-Path: <linux-kernel+bounces-95582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 16B37874FC8
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 14:16:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1362281B61
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 13:16:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E350C12C532;
	Thu,  7 Mar 2024 13:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="arR+2yp5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 122A912BE94
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 13:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709817390; cv=none; b=V+TFo9u7/7f4vinN2vmfT73I4AD698iRkas5Ot7zY0yeoMw2GeLKVhC11ItRXcOG+nVWU1TnFIQSd0AQUNoOASmGJeSxrGWRapcmhPH55nMSoVE0Bqyg5TQu9Ua4sZX5yPz4yRJzer9rtLULQYL6+Qu0CMFXZyYnnbqpLrmguEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709817390; c=relaxed/simple;
	bh=bITik7f0tV0KfNuQDs2gR/X8OuM8n9clFtDD8njHsaM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LfoelS7Qd9LnD7z9C/4JC+BCfOBmV3/kLycres6FN7s6tW47xFzy67GjFbSIoaW7wwtKLYVhO4Wd/KFFnFzSSrAeZ1hCyu7i2qy3lCTbCQuQbBHAyvPND3mKsisodSCmCepihLEJCYe8QGg+LDhmfPehpP78roQ4HxcQWj3o5JY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=arR+2yp5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53923C433F1;
	Thu,  7 Mar 2024 13:16:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709817389;
	bh=bITik7f0tV0KfNuQDs2gR/X8OuM8n9clFtDD8njHsaM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=arR+2yp5ddEX2qGGCa7cSDJ4m+Y6/WmDPiNjDcEqxfg9zWjnscBdlPA+X8da3ebQL
	 ETHwzMEcwwFp6Dd64u+qGBcJKGPemuxREycWjpFZ1vOlvkfBdylXQrw0ogTMTw+XxD
	 tNkXgS1usqie1mGt+wzWsmzWDaC7fDCnIw1QdHiU=
Date: Thu, 7 Mar 2024 13:16:26 +0000
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Michal Hocko <mhocko@suse.com>
Cc: cve@kernel.org, linux-kernel@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>
Subject: Re: CVE-2023-52592: libbpf: Fix NULL pointer dereference in
 bpf_object__collect_prog_relos
Message-ID: <2024030706-unscathed-wilt-e310@gregkh>
References: <2024030645-CVE-2023-52592-4693@gregkh>
 <ZemPuxhM_ZZ-khTh@tiehlicka>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZemPuxhM_ZZ-khTh@tiehlicka>

On Thu, Mar 07, 2024 at 10:58:19AM +0100, Michal Hocko wrote:
> On Wed 06-03-24 06:45:50, Greg KH wrote:
> > Description
> > ===========
> > 
> > In the Linux kernel, the following vulnerability has been resolved:
> > 
> > libbpf: Fix NULL pointer dereference in bpf_object__collect_prog_relos
> > 
> > An issue occurred while reading an ELF file in libbpf.c during fuzzing:
> > 
> > 	Program received signal SIGSEGV, Segmentation fault.
> > 	0x0000000000958e97 in bpf_object.collect_prog_relos () at libbpf.c:4206
> > 	4206 in libbpf.c
> > 	(gdb) bt
> > 	#0 0x0000000000958e97 in bpf_object.collect_prog_relos () at libbpf.c:4206
> > 	#1 0x000000000094f9d6 in bpf_object.collect_relos () at libbpf.c:6706
> > 	#2 0x000000000092bef3 in bpf_object_open () at libbpf.c:7437
> > 	#3 0x000000000092c046 in bpf_object.open_mem () at libbpf.c:7497
> > 	#4 0x0000000000924afa in LLVMFuzzerTestOneInput () at fuzz/bpf-object-fuzzer.c:16
> > 	#5 0x000000000060be11 in testblitz_engine::fuzzer::Fuzzer::run_one ()
> > 	#6 0x000000000087ad92 in tracing::span::Span::in_scope ()
> > 	#7 0x00000000006078aa in testblitz_engine::fuzzer::util::walkdir ()
> > 	#8 0x00000000005f3217 in testblitz_engine::entrypoint::main::{{closure}} ()
> > 	#9 0x00000000005f2601 in main ()
> > 	(gdb)
> > 
> > scn_data was null at this code(tools/lib/bpf/src/libbpf.c):
> > 
> > 	if (rel->r_offset % BPF_INSN_SZ || rel->r_offset >= scn_data->d_size) {
> > 
> > The scn_data is derived from the code above:
> > 
> > 	scn = elf_sec_by_idx(obj, sec_idx);
> > 	scn_data = elf_sec_data(obj, scn);
> > 
> > 	relo_sec_name = elf_sec_str(obj, shdr->sh_name);
> > 	sec_name = elf_sec_name(obj, scn);
> > 	if (!relo_sec_name || !sec_name)// don't check whether scn_data is NULL
> > 		return -EINVAL;
> > 
> > In certain special scenarios, such as reading a malformed ELF file,
> > it is possible that scn_data may be a null pointer
> > 
> > The Linux kernel CVE team has assigned CVE-2023-52592 to this issue.
> 
> OK, so this one is quite interesting. This is a userspace tooling
> gaining a kernel CVE. Is this just an omission or is this really
> expected.

"omission"?  I don't understand the question.

We are responsible for assigning CVEs to stuff that is in the "Linux
kernel source tree" (some have tried to get us to assign CVEs to
programs like git that are just hosted on kernel.org), so for now, yes,
this includes libbpf as well as stuff like perf.

> Also what is the security threat model here? If a malformed ELF file is
> loaded then the process gets SEGV which is perfectly reasonable thing to
> do.

Again, we do not do "threat modeling", we do "does this fix a weakness",
and I think this does as causing SEGV might not be a good thing, right?

But we'll defer to the libbpf maintainers on this, if they feel this is
just a "normal bugfix" then we can revoke this (added them to the cc:
here.)

thanks,

greg k-h

