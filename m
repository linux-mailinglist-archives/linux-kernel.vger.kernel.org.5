Return-Path: <linux-kernel+bounces-66074-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 79F2E855645
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 23:44:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36C42281DE5
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 22:44:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 993C7250F6;
	Wed, 14 Feb 2024 22:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="YGFbItPG"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F2CF182DF;
	Wed, 14 Feb 2024 22:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707950634; cv=none; b=UlBergziAmnQMBm2xgz2Fuz+Uvdssz3QqRR/BCNuc5YwW/XOWKPdqMB2pPEise7Jq6gGnSPEUyN5mWrcJm50i32Gw9isOv55GQPXpco+kRYyr8JfCjdNyd/F1jXh+IgV4nmoGFC62Z2EDDnZvm+MGeTCT5V5Ukay0TDassMBvuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707950634; c=relaxed/simple;
	bh=ozy3eY52BCzdxwYNrkegqDtr6aSiveEHhiT1/sfW+no=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nLxJnFFpY1tuBo5Rp3kdPpL0krk6AurX4HyUyW+FqY+lQvz4vCXQulrmyHhM2BIF9HNJjFezE9DTTfN8xKZ/QKFTJZbOzbO/d54d1RcKUJqJdIXtgttjF4RuffHuQMCpn34YTnS/1Q6Xwn9B2OvKYZbghwKQEsw3mNO63T83SF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=YGFbItPG; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net A2D0942A45
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1707950631; bh=xaJ+V2r7Ez5taqTevwtdhM0tEE3KY83I5dtgbNBvmWs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=YGFbItPGI0RhSBJIOvznLLflKfNC0RzO/HGoROZh36+sg8j6VPoBcuK48rLgH9gnf
	 wyuHMk/am8i15ueGloiH46g4KIN2HdQeDEXvSp/9vAOe6wXlvZdQLTBQaFm/G28EP4
	 RZw/q9IeZWEZQvAbwM9gRGsvpmgS4rybxJyVvnAoQusn30VoU5OxtJjsX/G1FaFv/n
	 HbWW3I+tUK7/iblhoIqLyURnUpX3Q+QJTlh90psrAJ2EaSn3LiOvbWkV/ZpbzBTc+Z
	 flaXGVWxmroW0NdJnQucJjfoJv0VaaYxmRppPD2c9IEf8mH1HtF9trzh/g/LtrBQMY
	 dkcNnSd+JoUaA==
Received: from localhost (unknown [IPv6:2601:280:5e00:625:67c:16ff:fe81:5f9b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id A2D0942A45;
	Wed, 14 Feb 2024 22:43:51 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Thorsten Blum <thorsten.blum@toblux.com>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Thorsten Blum
 <thorsten.blum@toblux.com>
Subject: Re: [PATCH] docs: Makefile: Fix make cleandocs by deleting
 generated .rst files
In-Reply-To: <20240208145001.61769-1-thorsten.blum@toblux.com>
References: <20240208145001.61769-1-thorsten.blum@toblux.com>
Date: Wed, 14 Feb 2024 15:43:51 -0700
Message-ID: <874jeazmxk.fsf@meer.lwn.net>
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

Applied, thanks.

jon

