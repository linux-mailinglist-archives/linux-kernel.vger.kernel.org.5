Return-Path: <linux-kernel+bounces-159143-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C280D8B29DC
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 22:31:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 644071F231A7
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 20:31:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C17172C19B;
	Thu, 25 Apr 2024 20:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="2rffjAJ2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0250B18EAB
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 20:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714077083; cv=none; b=Ld8V/9Kg0su6Tc2I5xRIC1K3JJR+hgGKFzFMjwjaoC8dpYizTKII8OprCPaBuDZ1x7x0JHgQCYj49XsYtuje1Woq1DC9pprE2Ocfge5RHAv2AlVJNZZqytohvmMPOXT0Pyd1CWmt+xiuaT/yW8JNMJ5yO7aA3FsKaGxp0ek7ejQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714077083; c=relaxed/simple;
	bh=yQtpb8KZ0XV1IAw2iLybrQtu/RFQGtz9q1DGWOkv7s8=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=QJKtjbfkIM6oV4FHLlRrYy3HST5OVPKfAjee4EJkLwVkm7ddOsHiNpauviEMK+GKQcSBdHmZtWZEvJ6Q7G++fwS23Jcq9QQfJwAXCFw/cc4jpngkaj+ZwDweBZVUnU6+iU80asMDoDSwCnR5FZTtjik9HCvzbSDa326t1XsxJqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=2rffjAJ2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36EBBC113CC;
	Thu, 25 Apr 2024 20:31:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1714077082;
	bh=yQtpb8KZ0XV1IAw2iLybrQtu/RFQGtz9q1DGWOkv7s8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=2rffjAJ2EQPwVvmxmdfSPdf20O+ADL2Tt8xyAy43S1hxG+hakDIU7QIsuQ+ueNsU5
	 hOJesWEqmuDJaXW676KIE79iVf2KmSxZId2bh6QtW39gL9qRnmBG7Hw9Z/bnWE5A81
	 92p7wTwKhXQ/OC3YL525SOvZDQZ56xgTj3GspBck=
Date: Thu, 25 Apr 2024 13:31:21 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Alexander Potapenko <glider@google.com>
Cc: elver@google.com, dvyukov@google.com, ojeda@kernel.org,
 linux-kernel@vger.kernel.org,
 syzbot+355c5bb8c1445c871ee8@syzkaller.appspotmail.com
Subject: Re: [PATCH] kmsan: compiler_types: declare __no_sanitize_or_inline
Message-Id: <20240425133121.efd1f9da094be454a6366cf2@linux-foundation.org>
In-Reply-To: <20240425092859.3370297-1-glider@google.com>
References: <20240425092859.3370297-1-glider@google.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 25 Apr 2024 11:28:59 +0200 Alexander Potapenko <glider@google.com> wrote:

> It turned out that KMSAN instruments READ_ONCE_NOCHECK(), resulting in
> false positive reports, because __no_sanitize_or_inline enforced inlining.
> 
> Properly declare __no_sanitize_or_inline under __SANITIZE_MEMORY__,
> so that it does not inline the annotated function.
> 
> Reported-by: syzbot+355c5bb8c1445c871ee8@syzkaller.appspotmail.com

I'll add

Link: https://lkml.kernel.org/r/000000000000826ac1061675b0e3@google.com

And I think a cc:stable is justifiable.  A Fixes: target would be nice?

