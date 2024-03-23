Return-Path: <linux-kernel+bounces-112442-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F29C88879E7
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 19:22:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92E0B1F21720
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 18:22:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82CA05491E;
	Sat, 23 Mar 2024 18:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W/sNN4to"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8F0218E20
	for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2024 18:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711218131; cv=none; b=ecSBVYQsw5RUX4QZnH2cxbr7Hn903pmKcMHR6dAsG+0jPwhwl0SNUz7XfFslHVpXV3Sa0MQGh3WogxHMh0tXQAjBFTFEiLZoLCXvaWLll659WC+siPmycfiYbmYxy/4Ah6byHeupPT3r36is9JyMoHbf1KFnejGvr40wLD1fr+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711218131; c=relaxed/simple;
	bh=qEKaqECtaD+QVRVzEOmQc7FxWOj+XhOPB3xcovL758A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f7WJZkx6RefpEzrkG2NlTTGKyQNC4nM/2fBoKfPThaYjfeJiM5PmKptrRaVOFLU5T+Hn/LIXHBJHNsvRSQYA5biIqbfwG8ltvga4DFdUGWOkVsnAQgB5QUFs3wZ9YH/O9fHmvECTai9QNNkT4BAJY0r/KGn+7a+vNZSe8qaZbto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W/sNN4to; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45DFDC433C7;
	Sat, 23 Mar 2024 18:22:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711218131;
	bh=qEKaqECtaD+QVRVzEOmQc7FxWOj+XhOPB3xcovL758A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=W/sNN4toO4QK8xqsuogZFCFrBC506WXgAURAqKIfvTw1GhgChNwNundMlEUL/Zkvg
	 89INL+YK3fwOFOps2k+TwbLZjQmG3Ky+0O8ucRKHfMnDYA360QdlKyJf6X7iHB6TK3
	 OVFJXA3rGIBxeEkO2FHNGnE8+fMBtvn3n58j4ogcSHyRMHbKcmoVpQ4AGKFOk6ho5D
	 YUKtUqFUOMI6K1oCap8k5poU8hPVNdfDuNYKsCJYyymX5VOEzl0DqaNVmqDKaaUj6u
	 FKEtppGq3CX1FOZtZrUeomctNt8EFlMK1Tvf4dIkykhRRX9FgKJoviAOYp7G+9kofG
	 l8no1Ac7Opo7w==
Date: Sat, 23 Mar 2024 11:22:09 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: LuMingYin <lumingyindetect@163.com>
Cc: linux-kernel@vger.kernel.org, peterz@infradead.org
Subject: Re: [PATCH] tools:Fix a memory leak related to variable name
Message-ID: <20240323182209.xqzb6rsswvfbg74n@treble>
References: <20240323084526.662556-1-lumingyindetect@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240323084526.662556-1-lumingyindetect@163.com>

On Sat, Mar 23, 2024 at 04:45:26PM +0800, LuMingYin wrote:
> In the elf_create_prefix_symbol function defined in the /linux/tools/objtool/elf.c file, two pointer variables sym and name are defined. The program allocates dynamic memory for the pointer sym using the calloc function at line 822, and for the pointer name using the malloc function at line 824. When the if statement at line 826 returns true, the program returns at line 828. The content of the if statement at line 828 is if (sym==NULL || name==NULL), which checks if either sym or name is NULL. If this condition returns true, it indicates a situation where one of the pointers has successfully allocated memory but the other has not. Therefore, if the if statement returns true, directly returning may lead to memory leak issues. Hence, in the code, I have added checks separately for whether sym and name are NULL, and if they are not NULL, the corresponding dynamic memory spaces are freed.
> 
> Signed-off-by: LuMingYin <lumingyindetect@163.com>

Thanks for the patch.  In general we don't care about memory leaks in
objtool (particularly in error or exit paths), as it's a short-running
tool.  When it exits, all the memory will be freed anyway.  So it's
faster to not free the memory manually.

-- 
Josh

