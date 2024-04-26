Return-Path: <linux-kernel+bounces-160076-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EEA138B38BF
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 15:43:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5F2A1F21FC0
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 13:43:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDE8E147C95;
	Fri, 26 Apr 2024 13:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="FkEAqoYu"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E56911F956;
	Fri, 26 Apr 2024 13:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714138989; cv=none; b=SBrt10loVB3O4TdUqV8dSM0K/+cS/ql0tsS1OKM9trfkn/vMFKSHGLZcAVscn6VAxlI/kpBxiZZaelNuVzPfws2kpHWqkfvbVtKu8SLgQ4CcIBO4LGEkZHanL1iHxpMYYJ0p/GhJLo8m3nmUnKuVLPbxk5WdXvbOKRrVKjQHK/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714138989; c=relaxed/simple;
	bh=LU5jFmly0HlXzC9D1rgqIxvuVT/bLuqB/d/UjXKKmWU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JICuWoDZboiAyIVSrtU05GNc7gkXTiDb1pFtVG+MOEHOKTnOlTw3I3kjac4J8yX2y+niqop61zfOvZ3GRujYCO3adwtgqijIAk7Gc8GEQ2SrG16GeA4PFkuh2Wuoso9XCBH+JExQWYiSWnQOgVT9RPaPXP9Cs1Cq1eThgGlsSp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=FkEAqoYu; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 5F6B847C49
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1714138987; bh=/jIYhxL/GvWnAMs1/PbEFqT7J8DDnxxKl+B9NTWtkTs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=FkEAqoYuGD5d2Zajs12NbRSH7pNFVMb4JXGwDEfSs1ooVMNoijpuMpsc8S6X9ufoy
	 3NteCy8ilJ0gZAEcWXmkaGaiOqB5nIkvFNkU0f5cW7YI5dBgldJ6CPg6LeJvNdysyf
	 2d38M7cwqvIN11t1kBkwb1ZX2AqtBkoj6hh3Io5HbPxkrDV5cyX754/1CNGvz34TFW
	 bY07gfyuFBP+ExDWukCtsf5P91/CoKIAU+ZrMykPMKfF0BcfCo6hTBurMCIpu+ZDgm
	 HPpdQYfUF/vfztHillS1pf/0gphg2UOAghmPvds84VLn1jFUIs4gtaDXQd2ttTRp1K
	 V0jdYnCBJ18xQ==
Received: from localhost (unknown [IPv6:2601:280:5e00:625::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 5F6B847C49;
	Fri, 26 Apr 2024 13:43:07 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: "Bilbao, Carlos" <carlos.bilbao@amd.com>, elena.reshetova@intel.com,
 Akira Yokosawa <akiyks@gmail.com>
Cc: bilbao@vt.edu, "Naik, Avadhut" <Avadhut.Naik@amd.com>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Randy Dunlap
 <rdunlap@infradead.org>
Subject: Re: [PATCH v4] docs/MAINTAINERS: Update my email address
In-Reply-To: <139b8cab-009c-4688-be41-c4c526532ea1@amd.com>
References: <97731c94-99b0-46be-8b78-5dac8510f690@amd.com>
 <87cyqetwhh.fsf@meer.lwn.net>
 <139b8cab-009c-4688-be41-c4c526532ea1@amd.com>
Date: Fri, 26 Apr 2024 07:43:06 -0600
Message-ID: <87v844nst1.fsf@meer.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Bilbao, Carlos" <carlos.bilbao@amd.com> writes:

> In the near future, I will not have access to the email address I used as
> maintainer of a number of things, mostly in the documentation. Update that
> address to my personal email address (see Link) so I can continue
> contributing and update .mailmap.
>
> Link: https://lore.kernel.org/all/BL1PR12MB58749FF2BFEDB817DE1FE6CBF82A2@BL1PR12MB5874.namprd12.prod.outlook.com/
> Signed-off-by: Carlos Bilbao <carlos.bilbao@amd.com>
> ---
>
> Changes since v3:
> - Apply on top of docs-next using as base:
>   commit e88c4cfcb7b888ac374916806f86c17d8ecaeb67
>
> Change since v2:
> - Fix .mailmap entry from <old-email> <new-email> to <new-email> <old-email>
>
> Changes since v1:
> - Update .mailmap
> ---
>  .mailmap                                                  | 1 +
>  Documentation/security/snp-tdx-threat-model.rst           | 2 +-
>  Documentation/translations/sp_SP/index.rst                | 2 +-
>  Documentation/translations/sp_SP/memory-barriers.txt      | 4 ++--
>  .../translations/sp_SP/process/code-of-conduct.rst        | 2 +-
>  Documentation/translations/sp_SP/process/coding-style.rst | 2 +-
>  .../translations/sp_SP/process/email-clients.rst          | 2 +-
>  Documentation/translations/sp_SP/process/howto.rst        | 2 +-
>  Documentation/translations/sp_SP/process/kernel-docs.rst  | 2 +-
>  .../sp_SP/process/kernel-enforcement-statement.rst        | 2 +-
>  Documentation/translations/sp_SP/process/magic-number.rst | 2 +-
>  .../translations/sp_SP/process/programming-language.rst   | 2 +-
>  .../translations/sp_SP/process/submitting-patches.rst     | 2 +-
>  MAINTAINERS                                               | 8 ++++----
>  14 files changed, 18 insertions(+), 17 deletions(-)

Applied, thanks.

jon

