Return-Path: <linux-kernel+bounces-79443-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C4DD3862251
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 03:31:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 778A41F24600
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 02:31:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DF68E566;
	Sat, 24 Feb 2024 02:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="0fiBg8Dn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A789214B804
	for <linux-kernel@vger.kernel.org>; Sat, 24 Feb 2024 02:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708741884; cv=none; b=SpLH8EB0QqGB0/4dfgzLCkGOmsJ0+H/nGgrabMpqFaCw9v6N1u7MOtY4W9xoMKn+LI38GCJ97dYvlE+jNqbK66G/yL43kRR4T2FK5OBh/Lrpr4MhUFuO1n3DAccZuVrdGi2kikuhKFBbUE4Yk0SbFre2Cwt+qnq2A8IoRrie7Sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708741884; c=relaxed/simple;
	bh=1CEmqtS0zZbe4uiqBmYpi7kx5BuZ+b8MUxz1tqE7Lbk=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Compmk8EVh3pRYwwwsq8/xwQS4hzIIoDQe52/UcYR0xRIRpNmD9OSKrGnEesxgwmY8nr0knEk15jLSBkRyzBCpUw+l1g4+kgw2BSkqyZlJEqyRPwZI+4W/+Fw7z3ycfQOYN6QoHYiXRKJOT4KZIPntBMX0n+0toOTcD07Oann9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=0fiBg8Dn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B9C3C433C7;
	Sat, 24 Feb 2024 02:31:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1708741884;
	bh=1CEmqtS0zZbe4uiqBmYpi7kx5BuZ+b8MUxz1tqE7Lbk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=0fiBg8DnYGRG+ilbDKB6ZgvnuY74g3WSEIYyB5OnROXbzrAejhSFWoV6ZQ2q2nnbt
	 2C89MdUmEddJu0uOK6A+NhOtOpUqszJ6yijGmiiAGqptS50XbdEGP9BGUfZlz98FoN
	 gpne1CVC7a9MIA2X+IaMjabYfwYtRG4PKAey5IVg=
Date: Fri, 23 Feb 2024 18:31:23 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Cc: stefani@seibold.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] kfifo: add kfifo_out_linear{,_ptr}()
Message-Id: <20240223183123.59efd1d637cf33b9f24d6b2e@linux-foundation.org>
In-Reply-To: <20240223115155.8806-4-jirislaby@kernel.org>
References: <20240223115155.8806-1-jirislaby@kernel.org>
	<20240223115155.8806-4-jirislaby@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 23 Feb 2024 12:51:54 +0100 "Jiri Slaby (SUSE)" <jirislaby@kernel.org> wrote:

> +	return min(n, __kfifo_peek_n(fifo, recsize);

When things like this happen I wonder "was I sent the correct version"
and "was this tested" and "wtf".

Please confirm that with this patch:

--- a/lib/kfifo.c~a
+++ a/lib/kfifo.c
@@ -497,7 +497,7 @@ unsigned int __kfifo_out_linear_r(struct
 	if (tail)
 		*tail = fifo->out + recsize;
 
-	return min(n, __kfifo_peek_n(fifo, recsize);
+	return min(n, __kfifo_peek_n(fifo, recsize));
 }
 EXPORT_SYMBOL(__kfifo_out_linear_r);
 
@@ -609,4 +609,3 @@ unsigned int __kfifo_dma_out_prepare_r(s
 	return setup_sgl(fifo, sgl, nents, len, fifo->out + recsize);
 }
 EXPORT_SYMBOL(__kfifo_dma_out_prepare_r);

we have a fully tested, production quality kernel change?

