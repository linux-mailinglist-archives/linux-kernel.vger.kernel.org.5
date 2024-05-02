Return-Path: <linux-kernel+bounces-166515-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4547E8B9BBD
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 15:41:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E35011F22B8B
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 13:41:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FAE913C66C;
	Thu,  2 May 2024 13:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GxMQhdE6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF7AB152788;
	Thu,  2 May 2024 13:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714657279; cv=none; b=bSEJ2/Xs+MsErb9NvXbeJYbSg7TxDHCLBezB1x0xV8hpKK3McCRcSrmmSQKQ22c7Ht+Ovk9DvzMs9jXLiphF1f9Om1zFGADgUhcBfLm2on5KIyGseDpwEQDeHnhWgmQ8eUTBAGaNSFepFIrX5c0n5M+lg1g2cdESXBtUBxHOGEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714657279; c=relaxed/simple;
	bh=CB+xRmbja8EXL2V6uPyB90ifTgbYsPJUyRnMDAgzen0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OkBKiPbpu1x6DNxLaTX7DRjawkRJK+//8kPxvlefm/7KsfFxCaFBj3IivWEcYTtIMO1E6DXjpbSSfjbzu7wt4UU9wdUG2CsOdTFwLXuwETeT3mUdQlU9tW9WNtPfhlnIC8jXRalxLBu5iaWcQOdESMBiFtj8hjuy2LjJ4e1vYbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GxMQhdE6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A493C113CC;
	Thu,  2 May 2024 13:41:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714657279;
	bh=CB+xRmbja8EXL2V6uPyB90ifTgbYsPJUyRnMDAgzen0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GxMQhdE6fxDDDeXHNEVhG/nWF27GTuWmheQfrezBZxUygIOCDKvERrK41LZCkyhfR
	 YfiJo1VT00HqbBXg2EmUiyeg8TcFADnR6cFjV7Cx28PlcQQ0BxPBnLjq5EWrm26mMw
	 B5M+o5BFiknDVT3s/oC/yUHHPyrEqtIA0+o9gAqP3R/NeqxWhUrshsbXIXXL6iWVKp
	 uMHof4bugJQW8JAqdU0xVnyoP9LJhaYJSiLAIDuvFVFxPPo2xohv22WqaeAR1GHocg
	 1uweJlqVtVXkW+5jlI5pqZlW+obLTj1sFKTx5L1QfWWi7IxC9dMBPrjrgGUShKEpmm
	 VyPHgslI7gT/w==
Date: Thu, 2 May 2024 10:41:14 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-kernel@vger.kernel.org, "Chang S. Bae" <chang.seok.bae@intel.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Nikolay Borisov <nik.borisov@suse.com>,
	Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
	Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 02/10] x86/insn: Fix PUSH instruction in x86 instruction
 decoder opcode map
Message-ID: <ZjOX-mE_CUOisltJ@x1>
References: <20240502105853.5338-1-adrian.hunter@intel.com>
 <20240502105853.5338-3-adrian.hunter@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240502105853.5338-3-adrian.hunter@intel.com>

On Thu, May 02, 2024 at 01:58:45PM +0300, Adrian Hunter wrote:
> The x86 instruction decoder is used not only for decoding kernel
> instructions. It is also used by perf uprobes (user space probes) and by
> perf tools Intel Processor Trace decoding. Consequently, it needs to
> support instructions executed by user space also.

I wonder if we should do it this way, i.e. updating both tools/ and
kernel source code in the same patch.

I think the best is to update the kernel bits, then, after that is
merged, do the tooling part.

To avoid possible, yet unlikely, clashes in linux-next, for instance.

- Arnaldo
 
> Opcode 0x68 PUSH instruction is currently defined as 64-bit operand size
> only i.e. (d64). That was based on Intel SDM Opcode Map. However that is
> contradicted by the Instruction Set Reference section for PUSH in the
> same manual.
> 
> Remove 64-bit operand size only annotation from opcode 0x68 PUSH
> instruction.
> 
> Example:
> 
>   $ cat pushw.s
>   .global  _start
>   .text
>   _start:
>           pushw   $0x1234
>           mov     $0x1,%eax   # system call number (sys_exit)
>           int     $0x80
>   $ as -o pushw.o pushw.s
>   $ ld -s -o pushw pushw.o
>   $ objdump -d pushw | tail -4
>   0000000000401000 <.text>:
>     401000:       66 68 34 12             pushw  $0x1234
>     401004:       b8 01 00 00 00          mov    $0x1,%eax
>     401009:       cd 80                   int    $0x80
>   $ perf record -e intel_pt//u ./pushw
>   [ perf record: Woken up 1 times to write data ]
>   [ perf record: Captured and wrote 0.014 MB perf.data ]
> 
>  Before:
> 
>   $ perf script --insn-trace=disasm
>   Warning:
>   1 instruction trace errors
>            pushw   10349 [000] 10586.869237014:            401000 [unknown] (/home/ahunter/git/misc/rtit-tests/pushw)           pushw $0x1234
>            pushw   10349 [000] 10586.869237014:            401006 [unknown] (/home/ahunter/git/misc/rtit-tests/pushw)           addb %al, (%rax)
>            pushw   10349 [000] 10586.869237014:            401008 [unknown] (/home/ahunter/git/misc/rtit-tests/pushw)           addb %cl, %ch
>            pushw   10349 [000] 10586.869237014:            40100a [unknown] (/home/ahunter/git/misc/rtit-tests/pushw)           addb $0x2e, (%rax)
>    instruction trace error type 1 time 10586.869237224 cpu 0 pid 10349 tid 10349 ip 0x40100d code 6: Trace doesn't match instruction
> 
>  After:
> 
>   $ perf script --insn-trace=disasm
>              pushw   10349 [000] 10586.869237014:            401000 [unknown] (./pushw)           pushw $0x1234
>              pushw   10349 [000] 10586.869237014:            401004 [unknown] (./pushw)           movl $1, %eax
> 
> Fixes: eb13296cfaf6 ("x86: Instruction decoder API")
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> ---
>  arch/x86/lib/x86-opcode-map.txt       | 2 +-
>  tools/arch/x86/lib/x86-opcode-map.txt | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/lib/x86-opcode-map.txt b/arch/x86/lib/x86-opcode-map.txt
> index c94988d5130d..4ea2e6adb477 100644
> --- a/arch/x86/lib/x86-opcode-map.txt
> +++ b/arch/x86/lib/x86-opcode-map.txt
> @@ -148,7 +148,7 @@ AVXcode:
>  65: SEG=GS (Prefix)
>  66: Operand-Size (Prefix)
>  67: Address-Size (Prefix)
> -68: PUSH Iz (d64)
> +68: PUSH Iz
>  69: IMUL Gv,Ev,Iz
>  6a: PUSH Ib (d64)
>  6b: IMUL Gv,Ev,Ib
> diff --git a/tools/arch/x86/lib/x86-opcode-map.txt b/tools/arch/x86/lib/x86-opcode-map.txt
> index c94988d5130d..4ea2e6adb477 100644
> --- a/tools/arch/x86/lib/x86-opcode-map.txt
> +++ b/tools/arch/x86/lib/x86-opcode-map.txt
> @@ -148,7 +148,7 @@ AVXcode:
>  65: SEG=GS (Prefix)
>  66: Operand-Size (Prefix)
>  67: Address-Size (Prefix)
> -68: PUSH Iz (d64)
> +68: PUSH Iz
>  69: IMUL Gv,Ev,Iz
>  6a: PUSH Ib (d64)
>  6b: IMUL Gv,Ev,Ib
> -- 
> 2.34.1

