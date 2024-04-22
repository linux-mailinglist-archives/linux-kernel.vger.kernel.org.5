Return-Path: <linux-kernel+bounces-153432-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 141128ACE0E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 15:20:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 461A01C21372
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 13:20:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8D4B14F13F;
	Mon, 22 Apr 2024 13:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="nRVLNgXG"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D884E14A0A5;
	Mon, 22 Apr 2024 13:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713792039; cv=none; b=P6ZGkrDcnXws5vWXgic3fBdVXgmG8yjL1UbU0vHy8lEmRkIXD+OaR5G3/NcWYed2kBFP4seXHHXaUz31c4IEJm9Ys9m3xSWnPk28frAOcFUBr+PB2L3yxKz5/p1lqpaU+N7Oal7FBLOgmQQVGku82oDZyuZDgEzZvQPyDOO546o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713792039; c=relaxed/simple;
	bh=9PTDdzlg3J4GICnkr5pu6YI2krA76YloflEU0yaageA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lVXOW1MsX26JKxmYTilfyDOAyUxzP5/ZNAYA1cxGsVTP0d8NK1OxIaM/hiEh9IiyWoGaiShb0aMqfnJeBPDnDLs0FnqFZJOvxEv6keM/H9RAKXrRHKskeh62VwUY+516yLBPYY5CUuuFD9sgkCahNm++O+1NrUksoeFWqiBoenI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=nRVLNgXG; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 8254247C2E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1713792031; bh=d1TbXgvvEeqhBi240obyjEDSrnasnWvPwS8968bPFyw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=nRVLNgXGpHERBp1Vpmhh3lyAjt0KCYz+KNio/hQxfK+dn6PdB+f4ZjEKkYjmknzKr
	 u9MmU3zcjpWvUwxXV4spd62he3bUuPgxd0mBNj3410B/9uIUc4VbRTWKL9dijuYK7o
	 2384fli3tvggIn33DTN2CgnQVIesjqplj280MsfOV1k9D43UqGF6XmZw92sJ+KkMhM
	 eqZTxDKhxtXidU/6oXo6OFh4KW+pTe1zuc7iOWLmfPr03zjwkSp+g9SP2fc4NKwMFb
	 rc38Xhphmw6EMxpEw63jqvgblp10yylNPmXL2JLoRTzUuWBCnboXyQ23oHNo0NXufU
	 4SYnvwdTVdWyg==
Received: from localhost (unknown [IPv6:2601:280:5e00:625::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 8254247C2E;
	Mon, 22 Apr 2024 13:20:31 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Cheng Ziqiu <chengziqiu@hust.edu.cn>, Alex Shi <alexs@kernel.org>,
 Yanteng Si <siyanteng@loongson.cn>
Cc: Dongliang Mu <dzm91@hust.edu.cn>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, hust-os-kernel-patches@googlegroups.com,
 Cheng Ziqiu <chengziqiu@hust.edu.cn>
Subject: Re: [PATCH] scripts: add `check-trans-update.py`
In-Reply-To: <20240422065822.1441611-1-chengziqiu@hust.edu.cn>
References: <20240422065822.1441611-1-chengziqiu@hust.edu.cn>
Date: Mon, 22 Apr 2024 07:20:30 -0600
Message-ID: <8734rd4jq9.fsf@meer.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Cheng Ziqiu <chengziqiu@hust.edu.cn> writes:

> The `check-trans-update.py` scripts check whether a translated version
> of a documentation is up-to-date with the english version.
>
> The scripts use `git log` commit to find the latest english commit from
> the translation commit (order by author date) and the latest english
> commits from HEAD. If differences occurs, report the file and commits
> need to be updated.
>
> Signed-off-by: Cheng Ziqiu <chengziqiu@hust.edu.cn>
> ---
>  scripts/check-trans-update.py | 176 ++++++++++++++++++++++++++++++++++
>  1 file changed, 176 insertions(+)
>  create mode 100755 scripts/check-trans-update.py

From a *quick* look I see how this could be a useful tool.  I think a
real requirement, though, is that a script like this start with a nice
comment saying what it does and how to use it.  Most people will simply
stumble across it while looking at files in scripts/; without such a
comment, they will be hard put to know what it's for.

Scripts for the documentation should be well documented :)

Thanks,

jon

