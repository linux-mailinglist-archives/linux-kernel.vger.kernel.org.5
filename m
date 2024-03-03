Return-Path: <linux-kernel+bounces-89795-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5227886F5C7
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 16:18:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6D8C1F22DD2
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 15:18:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B153B67A1F;
	Sun,  3 Mar 2024 15:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="haAhgkiu"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6028B59B64;
	Sun,  3 Mar 2024 15:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709479085; cv=none; b=XvzdJABm3FzqdM7BPSVMe34jxnFwCLdperNiIYqhOr9hnQqDdq6Uz4Es3BR1XeY3kpEx0BdWgaMMy+zplMCWz7Q75HPimKyJMrHwQXYImO4vwBlkYKRWQN79PfPoPauCFHrFEt4G0S8Yf9f0aPquB5eivzHlP3970J72k9QR6jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709479085; c=relaxed/simple;
	bh=VdelDbsA2ZNySY6RHIIrxK8D2M27bvjac4Unpg8R/s8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ooQnZcjG/+nNeOshOXZTeCLi9QKux7486OYNnzLMCFLxhCP/qK+Zw83hcCUthuL3vjMaAaLbtuyODrHYdxlXdwkp53nczcW7IBb69XgSAvTIx3S2WTxL0daHnfJJFWI/zsBCXkavsAa8qhTBYMrsd40yg0kRDWrPcXfUKfwOah8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=haAhgkiu; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 6961C418B6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1709479080; bh=tppw+lgGjMZp8U83win4SSdLcazQsKVrmLJiu1b3yCQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=haAhgkiud3Ph/pRBQhGKVz4pc7KHteynpczh/F5R5kEjSVQCPGs1bxmeqhK52tzJS
	 8ZJRubgY73/MVa6QrdEKfx+xcW1kd91mGO/MIX2GulZSJE6M6sU1hCWdAr1a3L5K9m
	 XoJiJq54FhmdGLHkoAUcmNfvkVoI1QVoF1vkiQkkXSKYar28fIW0Q7y/uEQzzzaw3V
	 smid1OiCLavssfI9xk+FM0iFxrAxZbrveAvCJsOanjRmiwKrNr/mMh00Q1tTDlk5gJ
	 msfVosTXcd5SJYMQ27FX9lEvjRYyRN+av6ox5F3jjhweqNpjxfH9pkDTEaadEIxsIw
	 I7dKDA2zpy2ZA==
Received: from localhost (mdns.lwn.net [45.79.72.68])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 6961C418B6;
	Sun,  3 Mar 2024 15:18:00 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Lukas Bulwahn <lukas.bulwahn@gmail.com>, Mauro Carvalho Chehab
 <mchehab@kernel.org>, Vegard Nossum <vegard.nossum@oracle.com>, Akira
 Yokosawa <akiyks@gmail.com>, Jani Nikula <jani.nikula@linux.intel.com>,
 Randy Dunlap <rdunlap@infradead.org>, linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: Re: [PATCH v2] docs: drop the version constraints for sphinx and
 dependencies
In-Reply-To: <20240301141800.30218-1-lukas.bulwahn@gmail.com>
References: <20240301141800.30218-1-lukas.bulwahn@gmail.com>
Date: Sun, 03 Mar 2024 08:17:59 -0700
Message-ID: <87jzmjz6mw.fsf@meer.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Lukas Bulwahn <lukas.bulwahn@gmail.com> writes:

> As discussed (see Links), there is some inertia to move to the recent
> Sphinx versions for the doc build environment.
>
> As first step, drop the version constraints and the related comments. As
> sphinx depends on jinja2, jinja2 is pulled in automatically. So drop that.
> Then, the sphinx-pre-install script will fail though with:
>
>   Can't get default sphinx version from ./Documentation/sphinx/requirements.txt at ./scripts/sphinx-pre-install line 305.
>
> The script simply expects to parse a version constraint with Sphinx in the
> requirements.txt. That version is used in the script for suggesting the
> virtualenv directory name.
>
> To suggest a virtualenv directory name, when there is no version given in
> the requirements.txt, one could try to guess the version that would be
> downloaded with 'pip install -r Documentation/sphinx/requirements.txt'.
> However, there seems no simple way to get that version without actually
> setting up the venv and running pip. So, instead, name the directory with
> the fixed name 'sphinx_latest'.
>
> Finally update the Sphinx build documentation to reflect this directory
> name change.
>
> Link: https://lore.kernel.org/linux-doc/874jf4m384.fsf@meer.lwn.net/
> Link: https://lore.kernel.org/linux-doc/20240226093854.47830-1-lukas.bulwahn@gmail.com/
> Reviewed-by: Akira Yokosawa <akiyks@gmail.com>
> Tested-by: Vegard Nossum <vegard.nossum@oracle.com>
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> ---
> v1 -> v2:
>   drop jinja2 as suggested by Vegard.
>   add tags from v1 review
>
>  Documentation/doc-guide/sphinx.rst    | 11 ++++++-----
>  Documentation/sphinx/requirements.txt |  7 ++-----
>  scripts/sphinx-pre-install            | 19 +++----------------
>  3 files changed, 11 insertions(+), 26 deletions(-)

I've applied this - thanks.

jon

