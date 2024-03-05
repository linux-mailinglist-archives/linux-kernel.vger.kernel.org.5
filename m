Return-Path: <linux-kernel+bounces-92811-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC4C7872641
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 19:07:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE02D1C219C8
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 18:07:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC83D1862A;
	Tue,  5 Mar 2024 18:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="p2dBZ8Lc"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36F6717BCF;
	Tue,  5 Mar 2024 18:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709662047; cv=none; b=RIBaPlCQrPV3qXezh3FCWoIBlFghZ05qIMUTT6DaufOXfSdG9vhXL0DH4MmgWw3HpIUpDJJECc3YGKDhO7tLWV9L2+rJLne9hie3bwlhF5LVHTIZxDMqZ9gS/LULmSNumY0aVStAuibqxVG89zzcolb2OiBQPQL7cpMdapgVEHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709662047; c=relaxed/simple;
	bh=fRvH1A39coLysQaU+TJosea83wCh3mMgVlbTiDxoJ98=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HaQwHzE+jHW/ugC1YK8jfipRBiU8A4ClG02J1jWBoYhzLFVEQru+JXNHBD/zAna9ctAsF/s2zSZWneOl1dQPuTjJpm8bg/mlQ+LJ/zDGhvO2OhBnBmJWnDxXtzEhjuUmeeA1+mJss+ajpCnbwk0YzwH6mmBwLke1S4LMwQHP8mY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=p2dBZ8Lc; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net EF8DB418C2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1709662043; bh=nyMT7rStgBuYBzRKmK59qF223blmDdW15jaZoF38aRo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=p2dBZ8Lc8H+HbEHG1zfkxyu0zmQREynqVsaVx+w4XYQvPeB29ZRk/bNVCSy6xfhVI
	 glaT7q/L8zzhDknyHqM2osy3F1CnbbyH6e1z+RDDheHZIpP44D/ugjWoV5OCbcRZ4s
	 ULX/CmcRl4VwPaBeCYUmHRMV+uitORnqfcpVZeokoeJoxwM8EtHromj1LjuvUMH4gw
	 ahLnUGFmyYX8dRDZqeiE5eNcr0wGa/xPzz0CVA8xiKVRn3w+cURJAihw89t7g+aCAy
	 eMR6EzSyDQGWhxA8gGr48FbZGUwLLrl4U8mgM9cgGbUzIXtRZeBjw3ePDwLW25T4OJ
	 nsV/E8jtLy+UQ==
Received: from localhost (mdns.lwn.net [45.79.72.68])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id EF8DB418C2;
	Tue,  5 Mar 2024 18:07:22 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Akira Yokosawa <akiyks@gmail.com>, linux-doc@vger.kernel.org
Cc: Thorsten Blum <thorsten.blum@toblux.com>, Breno Leitao
 <leitao@debian.org>, Jakub Kicinski <kuba@kernel.org>, "David S. Miller"
 <davem@davemloft.net>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Vegard Nossum <vegard.nossum@oracle.com>,
 Jani Nikula <jani.nikula@linux.intel.com>, Akira Yokosawa
 <akiyks@gmail.com>
Subject: Re: [PATCH] docs: Makefile: Add dependency to $(YNL_INDEX) for
 targets other than htmldocs
In-Reply-To: <e876e3c8-109d-4bc8-9916-05a4bc4ee9ac@gmail.com>
References: <e876e3c8-109d-4bc8-9916-05a4bc4ee9ac@gmail.com>
Date: Tue, 05 Mar 2024 11:07:22 -0700
Message-ID: <878r2wo8md.fsf@meer.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Akira Yokosawa <akiyks@gmail.com> writes:

> Commit f061c9f7d058 ("Documentation: Document each netlink family")
> added recipes for YAML -> RST conversion.
> Then commit 7da8bdbf8f5d ("docs: Makefile: Fix make cleandocs by
> deleting generated .rst files") made sure those converted .rst files
> are cleaned by "make cleandocs".
>
> However, they took care of htmldocs build only.
>
> If one of other targets such as latexdocs or epubdocs is built
> without building htmldocs, missing .rst files can cause additional
> WARNINGs from sphinx-build as follow:
>
>     ./Documentation/userspace-api/netlink/specs.rst:18: WARNING: undefined label: 'specs'
>     ./Documentation/userspace-api/netlink/netlink-raw.rst:64: WARNING: unknown document: '../../networking/netlink_spec/rt_link'
>     ./Documentation/userspace-api/netlink/netlink-raw.rst:64: WARNING: unknown document: '../../networking/netlink_spec/tc'
>     ./Documentation/userspace-api/netlink/index.rst:21: WARNING: undefined label: 'specs'
>
> Add dependency to $(YNL_INDEX) for other targets and allow any targets
> to be built cleanly right after "make cleandocs".
>
> Signed-off-by: Akira Yokosawa <akiyks@gmail.com>
> Cc: stable@vger.kernel.org  # v6.7
> Cc: Thorsten Blum <thorsten.blum@toblux.com>
> Cc: Breno Leitao <leitao@debian.org>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: David S. Miller <davem@davemloft.net>
> ---
> Hi,
>
> While the first offending commit went through the -net tree, 
> I'd like Jon to pick this up provided there is no objection from
> Jakub or davem.

Applied, thanks.

jon

