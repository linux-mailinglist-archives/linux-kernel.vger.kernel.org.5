Return-Path: <linux-kernel+bounces-130827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE103897D93
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 04:07:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A34851C2579C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 02:07:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA0E618C3B;
	Thu,  4 Apr 2024 02:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="braSIoFj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF8314400
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 02:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712196425; cv=none; b=Baztx8CX/Fq98a/oJ/ixF9ulP3iRC9QgYIZk2h0LIKq+/Ge/ltqZEpbpLgFR3JdQQARnsvcE5ps8qMxtpB1FrorAXOD1zlL3445wctkcj2x/SbhWXEkZHT1bJuDXxp/y5YY8K5EMSJ894Epev3EnVa4IwZULNSDlOQt+8spWmz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712196425; c=relaxed/simple;
	bh=rGl64jsFu4NFCV8xif7fw43EZgnfWoX5tPGbLV8aYnc=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=kSau5FYeBDCgH2rDSNgvfDsL80t9OL10wQnQD1wyV0DbnSqKBySXABdNA44J5fEUHNyccuZeZJPM3dPVe0Jur2sJtSZqd+gJl/+R1vn/+3hFRXOEgmGwgLpKFV20G4s/yZqDD+UHcMb/Y3ep5FEAzG4R44Ufx1tI6fIOP338UkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=braSIoFj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 404EBC433C7;
	Thu,  4 Apr 2024 02:07:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1712196424;
	bh=rGl64jsFu4NFCV8xif7fw43EZgnfWoX5tPGbLV8aYnc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=braSIoFjIbIaY3sxJmyqNH9ciXzMsbgT0MQUJv483n4/7dDqMxpWYDmjKjgzAV088
	 m5UOTVSbwC4S7khMoULqhJiIE/l4c0Dgdc2nL2Kz3k1jd3G1Lzz3ustZ6AYU0izZTy
	 joobb9mjm8cXnxb7AqSrah+25GiFn//jUuA5EM6g=
Date: Wed, 3 Apr 2024 19:07:03 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, muchun.song@linux.dev,
 willy@infradead.org
Subject: Re: [PATCH v2 0/3] Hugetlb fault path to use struct vm_fault
Message-Id: <20240403190703.3faa039cc207f9f9bd175fdb@linux-foundation.org>
In-Reply-To: <20240401202651.31440-1-vishal.moola@gmail.com>
References: <20240401202651.31440-1-vishal.moola@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  1 Apr 2024 13:26:48 -0700 "Vishal Moola (Oracle)" <vishal.moola@gmail.com> wrote:

> This patchset converts the hugetlb fault path to use struct vm_fault.
> This helps make the code more readable, and alleviates the stack by
> allowing us to consolidate many fault-related variables into an
> individual pointer.

The .text shrunk a little.  x86_64 defconfig:

 52873	   4015	  13796	  70684	  1141c	mm/hugetlb.o-before
 52617	   4015	  13796	  70428	  1131c	mm/hugetlb.o-after


