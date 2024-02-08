Return-Path: <linux-kernel+bounces-58797-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DE5A84EBE7
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 23:52:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3A601F22C32
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 22:52:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50E285025F;
	Thu,  8 Feb 2024 22:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="FErf5knS"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 363C950253;
	Thu,  8 Feb 2024 22:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707432731; cv=none; b=pSFz2Dm7Tcg4jkCW0qWLu19KiQS8/fANJTk/lJ4dpcSb7bn1VaOLdaZcdY5UnakNd2bvVUN5Lu5j7B9F07qj4MmkWd2xPj1e3EBgJBY8vQPjN9zJXX1uEf/tXe+sHiAlyXerlaHfd1o8ltzVDGaPrCewu67U244ETH1PHCByKiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707432731; c=relaxed/simple;
	bh=FXldPRMidLA55x+Hx/mIMRwupZQ/ec2lSqkWMdAcMXg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Alr6Xu+1PsN2rScdGykD8Oju5kOo7MT8CErCJZuzC08tIpInt87uK8r+jNkuT5cr6k+iShNFRAszSgoVCryWULq9ndpET+IrE5WsBE9++uajsCGv4NQmeFEI/qvBPawCfMsRVyfky/wPTXHGw6u2PCwl1IHz3J30Z52tGHQHhzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=FErf5knS; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 8B37545917
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1707432729; bh=3TgYkOcRC2sSgpj6cJafcSQeo2zp3995bRHryh4idG8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=FErf5knSwzEnT4RPdR6837+qZGmBdLkKqgWLqoQGTzLUOMKQHFlQB3jfvtEfBI9Yh
	 oxwSDDqUPq850t93+eCkhKymFHjQchhZAsNDmLUw4383x5ProoDVQ3phOaGc4lIHCR
	 dudUtgm7kOpyBYdHsqK109HN5k3Jm5j4mCjQT9XwXy9oSTuphvIa0yRK+7XtNX/nOQ
	 a0o3TiX/rCNNjBBBoUYIhKsJEzGlRX64RcVis7T5BvttIzCAmqTq8jASNqVuIokd58
	 DSV2TbRoRWZY1STOF0JRGzc5hbECIr23sA6zgsYW6fMHe74d5ZmuMaxDfN5AfSPxN2
	 YnqPp/CArr34w==
Received: from localhost (unknown [IPv6:2601:280:5e00:625::646])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 8B37545917;
	Thu,  8 Feb 2024 22:52:09 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Thorsten Blum <thorsten.blum@toblux.com>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Thorsten Blum
 <thorsten.blum@toblux.com>, Vegard Nossum <vegard.nossum@oracle.com>,
 Breno Leitao <leitao@debian.org>
Subject: Re: [PATCH] docs: Makefile: Fix make cleandocs by deleting
 generated .rst files
In-Reply-To: <20240208145001.61769-1-thorsten.blum@toblux.com>
References: <20240208145001.61769-1-thorsten.blum@toblux.com>
Date: Thu, 08 Feb 2024 15:52:08 -0700
Message-ID: <87a5oafu1z.fsf@meer.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Thorsten Blum <thorsten.blum@toblux.com> writes:

> The script tools/net/ynl/ynl-gen-rst.py (YNL_TOOL) generates several .rst
> files (YNL_INDEX, YNL_RST_FILES) in Documentation/networking/netlink_spec
> (YNL_RST_DIR) which are not deleted by make cleandocs.
>
> Fix make cleandocs by deleting the generated .rst files.
>
> Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
> ---
>  Documentation/Makefile | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/Makefile b/Documentation/Makefile
> index 3885bbe260eb..4479910166fc 100644
> --- a/Documentation/Makefile
> +++ b/Documentation/Makefile
> @@ -176,6 +176,7 @@ refcheckdocs:
>  	$(Q)cd $(srctree);scripts/documentation-file-ref-check
>  
>  cleandocs:
> +	$(Q)rm -f $(YNL_INDEX) $(YNL_RST_FILES)
>  	$(Q)rm -rf $(BUILDDIR)
>  	$(Q)$(MAKE) BUILDDIR=$(abspath $(BUILDDIR)) $(build)=Documentation/userspace-api/media clean

So this seems worth doing ... except that there has been talk about not
depositing those files into the source tree in the first place.  Adding
Vegard and Breno to see if they have any thoughts on the matter...

Thanks,

jon

