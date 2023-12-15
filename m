Return-Path: <linux-kernel+bounces-570-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 893C4814313
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 08:59:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B21EB1C2251F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 07:59:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8944810A04;
	Fri, 15 Dec 2023 07:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VWGGsr9g"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8AB610948
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 07:59:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BE0AC433C7;
	Fri, 15 Dec 2023 07:59:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702627161;
	bh=p7XzuqMp9NhCrk0y1WItaCpAXO5MjmBMXA2NzZY47U4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VWGGsr9gihUJo9sHqLqsalKs8SLfqSeu8K1zSrDQTHEwTZkdIAb8DT982rC4P3c9c
	 pfXzw/eFxtDF6elSytfdaf9zBqwhWzjHqnW9aOwYyBmMw7UKaP23tMyfVkpdXhh4Fw
	 xzIlsy2i2p8yh7u8GBjmvjgLn5RFk5trsyBwl6qbrFdqPdC/Pxjdn1O1WffR6WBdQP
	 L9XJZjqTZjwamuppNlD5E5gzbBC8mm8V0jdz7FWbx+Bom2eD1saX08XbT/XEFXnV/w
	 pEBrd5yZbwUrIJzFZaVCJ0vCv7p6snQvbVOUFsVgb8Zh5okjqbRz16XMNfbRB/eyb4
	 kMWZI3VZb2VWw==
Date: Fri, 15 Dec 2023 13:21:44 +0530
From: Naveen N Rao <naveen@kernel.org>
To: Nicholas Miehlbradt <nicholas@linux.ibm.com>
Cc: glider@google.com, elver@google.com, dvyukov@google.com, 
	akpm@linux-foundation.org, mpe@ellerman.id.au, npiggin@gmail.com, 
	christophe.leroy@csgroup.eu, linux-mm@kvack.org, kasan-dev@googlegroups.com, 
	iii@linux.ibm.com, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 07/13] powerpc/kprobes: Unpoison instruction in kprobe
 struct
Message-ID: <xn274hbvxsfwii6lwis72ntnphiixvcob6hkopn5fygutht3qe@j4sau5ejaxwj>
References: <20231214055539.9420-1-nicholas@linux.ibm.com>
 <20231214055539.9420-8-nicholas@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231214055539.9420-8-nicholas@linux.ibm.com>

On Thu, Dec 14, 2023 at 05:55:33AM +0000, Nicholas Miehlbradt wrote:
> KMSAN does not unpoison the ainsn field of a kprobe struct correctly.
> Manually unpoison it to prevent false positives.
> 
> Signed-off-by: Nicholas Miehlbradt <nicholas@linux.ibm.com>
> ---
>  arch/powerpc/kernel/kprobes.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/powerpc/kernel/kprobes.c b/arch/powerpc/kernel/kprobes.c
> index b20ee72e873a..1cbec54f2b6a 100644
> --- a/arch/powerpc/kernel/kprobes.c
> +++ b/arch/powerpc/kernel/kprobes.c
> @@ -27,6 +27,7 @@
>  #include <asm/sections.h>
>  #include <asm/inst.h>
>  #include <linux/uaccess.h>
> +#include <linux/kmsan-checks.h>
>  
>  DEFINE_PER_CPU(struct kprobe *, current_kprobe) = NULL;
>  DEFINE_PER_CPU(struct kprobe_ctlblk, kprobe_ctlblk);
> @@ -179,6 +180,7 @@ int arch_prepare_kprobe(struct kprobe *p)
>  
>  	if (!ret) {
>  		patch_instruction(p->ainsn.insn, insn);
> +		kmsan_unpoison_memory(p->ainsn.insn, sizeof(kprobe_opcode_t));

kprobe_opcode_t is u32, but we could be probing a prefixed instruction.  
You can pass the instruction length through ppc_inst_len(insn).


- Naveen

