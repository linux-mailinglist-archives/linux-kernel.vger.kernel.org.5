Return-Path: <linux-kernel+bounces-139366-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BADB8A01F4
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 23:27:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3148284D8D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 21:27:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58C741836EE;
	Wed, 10 Apr 2024 21:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="AznARsNl"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FCED181BA1;
	Wed, 10 Apr 2024 21:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712784460; cv=none; b=QwwLYd7DE4cmzpvK6IIV/XTWzmLoBVYW13K1CdSdgEuf9MI/metlwog7Y6geyzbgfouazXOHXbJ0D+xqoC9qzGs0XJhEO40syzxiI09qhonRLTrfmarsacmIeNEF5OrySBA6gptojLyLLwGc28CN3bhrz7jKVsTEa9CfduRZgBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712784460; c=relaxed/simple;
	bh=SOU/rQZS2o+jKf46j6gyPHpdHQ1JeR3VtxetWOGthQo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QP2lGbtgHrIidLk+wmwiGvgX0DujuitmNr92zQY+W5aVZbqNBh700v7MltPZLtVgXZsLdHXPQ3VLnQjk8idF6GN9lNnW4rjPYplZc1kjAIuyXR2BmDktWiijPYUQ6+39peMMEXfLZ7hvTpvjGLuMWKLyko2heuDKpZbRy2gpGR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=AznARsNl; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 2B86C47C26
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1712784458; bh=2h0mCjUz+lkc6cFoDOOjKY+TGil3wNwGsaSJv8rWfNQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=AznARsNlSmERn5KPFpkzeAVfvk7ZZTgSWFON+3Nt0MzBvzvqbLc+3rbbowmPD6y0t
	 l31C65IPtWlwcu5S5+kfQaHaYvbSsYjIkYDBZh6cZPPenzlWC7E0uk3ApjdQGGw9U+
	 vLx7jKQcH2M+5k89wd6Y4IS0i7EbNQnBMQLcV7rlsTgcpiZTdnW9qjm9pXFZw14Or2
	 M4LJVIslbkY2504d226tTHN1+q9zqk6j32wGzQcy4hLdBIhDOsaPjtLxdznJLPSFXH
	 dRR45/dwVXjnFby/N5aV7Ss5gTTvcUG6ndPbRvpqBws/K8hzRzJz74vwV0VTBwhTAA
	 K9t+nRnuDIegA==
Received: from localhost (unknown [IPv6:2601:280:5e00:625:67c:16ff:fe81:5f9b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 2B86C47C26;
	Wed, 10 Apr 2024 21:27:38 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Haoyang Liu <tttturtleruss@hust.edu.cn>, Alex Shi <alexs@kernel.org>,
 Yanteng Si <siyanteng@loongson.cn>
Cc: hust-os-kernel-patches@googlegroups.com, Haoyang Liu
 <tttturtleruss@hust.edu.cn>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] docs/zh_CN: Add dev-tools/kmemleak Chinese translation
In-Reply-To: <20240403052552.39292-1-tttturtleruss@hust.edu.cn>
References: <20240403052552.39292-1-tttturtleruss@hust.edu.cn>
Date: Wed, 10 Apr 2024 15:27:36 -0600
Message-ID: <87zfu0sybb.fsf@meer.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Haoyang Liu <tttturtleruss@hust.edu.cn> writes:

> Translate dev-tools/kmemleak.rst into Chinese and add it into
> zh_CN/dev-tools/index.rst.
>
> Signed-off-by: Haoyang Liu <tttturtleruss@hust.edu.cn>
> ---
> v1 -> v2: Adjust line length and keep consistent with the original content
>
>  .../translations/zh_CN/dev-tools/index.rst    |   2 +-
>  .../translations/zh_CN/dev-tools/kmemleak.rst | 229 ++++++++++++++++++
>  2 files changed, 230 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/translations/zh_CN/dev-tools/kmemleak.rst

Applied, thanks.

Incidentally, I see you sent a v3 adding just the reviewed-by tag.  If
you change a patch for other reasons, you should definitely add such
tags (assuming the change isn't one that requires re-review, of course),
but there is no need to send a new version just to be sure that the tag
is picked up - b4 is great for that.

jon

