Return-Path: <linux-kernel+bounces-41563-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D8E083F49D
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 09:29:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF8511C21365
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 08:29:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88562DDAE;
	Sun, 28 Jan 2024 08:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="x+4TLVPJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9A23DDA3
	for <linux-kernel@vger.kernel.org>; Sun, 28 Jan 2024 08:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706430586; cv=none; b=PHRUL1ajMpV3MF4qAL1PIE2+f2D6zvPqCExJDUxpIUqgs1p+ow25ZGAY5HdWyC8F8nQL4Zv5yab6go/OBMnEd9+lo87Z564uxncqjpqwrZ6PPOg0V3+IjwnlHiMrtCg1rMddWuEofbLMCsTbvcqv4RsSZESf93QWFLN0qDNE3oA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706430586; c=relaxed/simple;
	bh=s8ybe+Xn1UXuN6JMIrAasuzSdxDeJyXPRRtAliFpCh4=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=QScE3VKAqPtTxkRSBDmViYXTOSOjd8bylqKS81jhKV/QpRerTlbq7pgYpyv59NQLTYRjP2XJZvNj4hP1fJsTRO3fpX8k1AHyOXM3hCeD2c8rXzfITOehMrVi1av8BgGm00hdCulsquMKBpbDk37925u3hE95tHAd1s99iHAYP/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=x+4TLVPJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4ABF7C433F1;
	Sun, 28 Jan 2024 08:29:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1706430586;
	bh=s8ybe+Xn1UXuN6JMIrAasuzSdxDeJyXPRRtAliFpCh4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=x+4TLVPJfWVheR3Z9js3trzsdpP8DumY5oO+sJhi+3/V8OC+lhyvahAFEbCpMf7zM
	 /ZDFQtpN0hXZOXhGaiFuD7qfjrBaOmFf9hcpI/74AD8EfIs7SlWsilQWDsdewHiHSK
	 RJWOwrXWcVDrh5HfkPGmelGUVGvojNcpisvJYQkg=
Date: Sun, 28 Jan 2024 00:29:42 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Chunsheng Luo <luochunsheng@ustc.edu>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mempolicy: check home_node is in the nodes of policy
Message-Id: <20240128002942.b0dbede1fcc4b80d2a398d15@linux-foundation.org>
In-Reply-To: <20240126132240.24518-1-luochunsheng@ustc.edu>
References: <20240126132240.24518-1-luochunsheng@ustc.edu>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 26 Jan 2024 08:22:40 -0500 Chunsheng Luo <luochunsheng@ustc.edu> wrote:

> set_mempolicy_home_node should be used after setting the memory
> policy. If the home_node isn't in the nodes of policy, we should
> return failure to avoid misunderstanding.

Thanks.  Under what circumstances does userspace trigger this issue?

