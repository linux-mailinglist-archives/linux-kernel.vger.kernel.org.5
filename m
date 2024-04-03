Return-Path: <linux-kernel+bounces-128855-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 576E8896093
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 02:18:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0CE631F24291
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 00:18:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B522115B7;
	Wed,  3 Apr 2024 00:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IGG9SKGd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00F2417E9;
	Wed,  3 Apr 2024 00:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712103475; cv=none; b=tmh+n21Q8G+qlH/307t3aZ9zw1nefmdFA8F/e+/nJ4NCcqrC7GFXF/cox+3vll16Qt35VTw6smVlWXz6vfZdauYoSy+SibIdy6H0GbAaPUktR+TJmytRgYrPOHXMBWeBsLejw78kjbKUTGaeSYGNxXM4UuysDg5mPRiv1jVkdFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712103475; c=relaxed/simple;
	bh=sHgvd1fTo2VqtFJgQPfEcu4tn8JHo+ny6Y4xG9wOshA=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=GVmEhBv9nkru3WFIu46a+7ZT7sx52sbu/rZseEGgWT64fBDjxdwseV031CJJe3v1ji3AQovvIbCnB+N++q2S3Hc65+HiDldbRQlOYh621Q2F5WEhCWPljh5LLYckVSu7QHR3pG8l9Xpr+klQfyJfb0nQLjtXLjNhHxH2rpIUhh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IGG9SKGd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D0FEC433F1;
	Wed,  3 Apr 2024 00:17:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712103474;
	bh=sHgvd1fTo2VqtFJgQPfEcu4tn8JHo+ny6Y4xG9wOshA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=IGG9SKGdduYj61/8ncQMRZFotBcnc7tRhF98LvdNe1q5Trd/Q95VMynAj6IFwZV2d
	 +Hr+r7WPeX78rfqwHUfmPmLNWecOltGKTP3n1KqgR+MdhdSLcoRyAeNd5VJ9ubsadR
	 es3irfdWZVP1NY58WcfE4/Jg2eJ8Ig/r8i7NHxoycHzW65apX6ZX9gavvY5QrxdmI1
	 Y3p7uw4bWxHWutbYzkkBHA9npG4sdmllsKB/+ZqRD1T/8IcNm9t5egnMeBEB8Rtyv4
	 yMSKPA7AYz5891OEgJxTHXc7PlRiGNrp67guTGR900TpeoHZSPGYC7qIMIGn9RwEIV
	 4QTtIM3llzOvg==
Date: Wed, 3 Apr 2024 09:17:48 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Valentin Obst <kernel@valentinobst.de>
Cc: Borislav Petkov <bp@alien8.de>, Dave Hansen
 <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Ingo
 Molnar <mingo@kernel.org>, Ingo Molnar <mingo@redhat.com>, Thomas Gleixner
 <tglx@linutronix.de>, Andreas Hindborg <a.hindborg@samsung.com>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, John Baublitz
 <john.m.baublitz@gmail.com>, Masami Hiramatsu <mhiramat@kernel.org>, Miguel
 Ojeda <ojeda@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Sergio
 =?UTF-8?B?R29uesOhbGV6?= Collado <sergio.collado@gmail.com>,
 linux-kernel@vger.kernel.org, x86@kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v3] x86/tools: fix line number reported for malformed
 lines
Message-Id: <20240403091748.ee180a7a1d4bf92e0c46fb8a@kernel.org>
In-Reply-To: <20240329-x86-insn-decoder-line-fix-v3-1-ec97e21d63bf@valentinobst.de>
References: <20240329-x86-insn-decoder-line-fix-v3-1-ec97e21d63bf@valentinobst.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 29 Mar 2024 12:31:58 +0100
Valentin Obst <kernel@valentinobst.de> wrote:

> Commit 35039eb6b199 ("x86: Show symbol name if insn decoder test failed")
> included symbol lines in the post-processed objdump output consumed by
> the insn decoder test. This broke the `instuction lines == total lines`
> property that `insn_decoder_test.c` relied upon to print the offending
> line's number in error messages. This has the consequence that the line
> number reported on a test failure is unreated to, and much smaller than,
> the line that actually caused the problem.
> 
> Add a new variable that counts the combined (insn+symbol) line count and
> report this in the error message.

This looks good to me. Thanks!

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

> 
> Fixes: 35039eb6b199 ("x86: Show symbol name if insn decoder test failed")
> Cc: stable@vger.kernel.org
> Reviewed-by: Miguel Ojeda <ojeda@kernel.org>
> Tested-by: Miguel Ojeda <ojeda@kernel.org>
> Reported-by: John Baublitz <john.m.baublitz@gmail.com>
> Debugged-by: John Baublitz <john.m.baublitz@gmail.com>
> Signed-off-by: Valentin Obst <kernel@valentinobst.de>
> ---
> See v2's commit message and [1] for context why this bug made debugging a
> test failure harder than necessary.
> 
> [1]: https://rust-for-linux.zulipchat.com/#narrow/stream/291565-Help/topic/insn_decoder_test.20failure/near/421075039
> 
> Changes in v3:
> - Add Cc stable tag in sign-off area.
> - Make commit message less verbose.
> - Link to v2: https://lore.kernel.org/r/20240223-x86-insn-decoder-line-fix-v2-1-cde49c69f402@valentinobst.de
> 
> Changes in v2:
> - Added tags 'Reviewed-by', 'Tested-by', 'Reported-by', 'Debugged-by',
>   'Link', and 'Fixes'.
> - Explain why this patch fixes the commit mentioned in the 'Fixes' tag.
> - CCed the stable list and sent to all x86 maintainers.
> - Link to v1: https://lore.kernel.org/r/20240221-x86-insn-decoder-line-fix-v1-1-47cd5a1718c6@valentinobst.de
> ---
>  arch/x86/tools/insn_decoder_test.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/tools/insn_decoder_test.c b/arch/x86/tools/insn_decoder_test.c
> index 472540aeabc2..727017a3c3c7 100644
> --- a/arch/x86/tools/insn_decoder_test.c
> +++ b/arch/x86/tools/insn_decoder_test.c
> @@ -114,6 +114,7 @@ int main(int argc, char **argv)
>  	unsigned char insn_buff[16];
>  	struct insn insn;
>  	int insns = 0;
> +	int lines = 0;
>  	int warnings = 0;
> 
>  	parse_args(argc, argv);
> @@ -123,6 +124,8 @@ int main(int argc, char **argv)
>  		int nb = 0, ret;
>  		unsigned int b;
> 
> +		lines++;
> +
>  		if (line[0] == '<') {
>  			/* Symbol line */
>  			strcpy(sym, line);
> @@ -134,12 +137,12 @@ int main(int argc, char **argv)
>  		strcpy(copy, line);
>  		tab1 = strchr(copy, '\t');
>  		if (!tab1)
> -			malformed_line(line, insns);
> +			malformed_line(line, lines);
>  		s = tab1 + 1;
>  		s += strspn(s, " ");
>  		tab2 = strchr(s, '\t');
>  		if (!tab2)
> -			malformed_line(line, insns);
> +			malformed_line(line, lines);
>  		*tab2 = '\0';	/* Characters beyond tab2 aren't examined */
>  		while (s < tab2) {
>  			if (sscanf(s, "%x", &b) == 1) {
> 
> ---
> base-commit: 4cece764965020c22cff7665b18a012006359095
> change-id: 20240221-x86-insn-decoder-line-fix-7b1f2e1732ff
> 
> Best regards,
> --
> Valentin Obst <kernel@valentinobst.de>
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

