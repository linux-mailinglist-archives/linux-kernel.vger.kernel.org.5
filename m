Return-Path: <linux-kernel+bounces-96156-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26BC18757D1
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 21:03:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 591A21C20D7B
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 20:03:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00B02137C4C;
	Thu,  7 Mar 2024 20:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ZVVYJ4IF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BD2A137C43
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 20:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709841802; cv=none; b=lCYSzl4xv42AKMmzfWVrMf177RVneBwe0filpWfdS44NaN935zmlFyRmez8WhLtueV27sAOOkgCPfgoAhglwp3GTpuzv0Vjdr/5wGbrbkZH+w4AgVCpiaXTNwcd6I1XYq+gXMgoiUqBTM/OeVeRfBk9qzhLZRQQ5AinHKs+DrVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709841802; c=relaxed/simple;
	bh=7gzXjcQpe1br0id+cMuvyEEjQ+bjQv6boiSWuc3QOmo=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=ur40ZjQy3nBmA5m5V6vqXFWEBDawWJ/O/XA35TKlvR4kIShhzIaOuOuNchORuGkK5YGTWdOBhMLaR8iplZzkVQwx2Dc2dFZD18CoHLFNMYBayKdOL1so5QNVaCo+89E6b75QMqfzu//wKjdzOCM+Y09dlBsN7tusBYrpFEiu1lE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=ZVVYJ4IF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F4FDC433C7;
	Thu,  7 Mar 2024 20:03:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1709841801;
	bh=7gzXjcQpe1br0id+cMuvyEEjQ+bjQv6boiSWuc3QOmo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZVVYJ4IFHfKsuUlhziAaGn5ufRwnBJgRFlcTGO6XdPkjw88Ejj01S7IdUWIWlDFLj
	 sdCgIU0rBzG9TbrmWzULuR87BDUkfvo/4nIdEtCab5fqSEPBfDYWcEW/SXz7KU0nq6
	 U5dripuf+1G3xloGjXIlmQi/v83wvOrEynMpugc8=
Date: Thu, 7 Mar 2024 12:03:20 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Zi Yan <ziy@nvidia.com>
Cc: Zi Yan <zi.yan@sent.com>, linux-mm@kvack.org, Dan Carpenter
 <dan.carpenter@linaro.org>, "Pankaj Raghav (Samsung)"
 <kernel@pankajraghav.com>, "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 David Hildenbrand <david@redhat.com>, Yang Shi <shy828301@gmail.com>, Yu
 Zhao <yuzhao@google.com>, "Kirill A . Shutemov"
 <kirill.shutemov@linux.intel.com>, Ryan Roberts <ryan.roberts@arm.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] mm/huge_memory: check new folio order when split a
 folio
Message-Id: <20240307120320.fe18b44a912020d77d74156f@linux-foundation.org>
In-Reply-To: <20240307181854.138928-1-zi.yan@sent.com>
References: <20240307181854.138928-1-zi.yan@sent.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  7 Mar 2024 13:18:53 -0500 Zi Yan <zi.yan@sent.com> wrote:

> Link: https://lore.kernel.org/linux-mm/7dda9283-b437-4cf8-ab0d-83c330deb9c0@moroto.mountain/

Oh, there it is.

I'll change this to Reported-by: and Closes:, thanks.

