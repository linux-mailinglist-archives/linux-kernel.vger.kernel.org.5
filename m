Return-Path: <linux-kernel+bounces-150743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FE538AA401
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 22:26:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7F5A1F230AB
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 20:26:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16685181BB4;
	Thu, 18 Apr 2024 20:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="06hsNJH/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 594EF2F30
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 20:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713471962; cv=none; b=saA3+cYx4uM6Ly3sQGn6HlFV11rmvc8RxO2BYk87PC1hQoqDgJ5tjbL6qYQEuonQ0suAWAJewhShKOkpUNcDlhA0FKMsKqfdcCxxPxJJ03LXBXU+TBr9My4pdONwx25siIFKRUNHoqGpSJUUsMaQB/bgw/FM4LAOUl7sXrUbBoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713471962; c=relaxed/simple;
	bh=PCvEAVXvgM6u371jplSGRmq+8CDhW77O6b83jGw9Zy4=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=DMAbekO7QBZx0VXTZLM05gLCoxzgyv1+a3rxJgrbuLY+u5a0s7P7P/KRpEm89vwhiHXzLt1/kZE88XWEsRtR2gu7cOyPZy9lKM7avZ/0u82jRTvfVSo0QjSq+u2aIMmpR8WKfZ59uG2dBb7uJ/iWXZuA6bgCUGLr/yIhXDkNrxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=06hsNJH/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9158FC113CC;
	Thu, 18 Apr 2024 20:26:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1713471961;
	bh=PCvEAVXvgM6u371jplSGRmq+8CDhW77O6b83jGw9Zy4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=06hsNJH/gAWkXBp+LDoqehpGxJ+z/bIkR2RDaAaQXkGcfa8njuA90MVWViHHFU2pM
	 ik50i12nj1g2jqhY5R1tV0c7nXntJZQXcUOMyReyObunDFJx6BxtfVAgpHK+EC7msh
	 eHNwNzCqVtQobclwTX7b/4n+bMowJyvL+Sz79LnI=
Date: Thu, 18 Apr 2024 13:26:00 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: tglx@linutronix.de, peterz@infradead.org, yury.norov@gmail.com,
 linux@rasmusvillemoes.dk, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpu: memoise number of possible cpus
Message-Id: <20240418132600.ffbf4d53b39eaaeaffc28198@linux-foundation.org>
In-Reply-To: <20240418041927.3903-1-adobriyan@gmail.com>
References: <20240418041927.3903-1-adobriyan@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 18 Apr 2024 07:19:27 +0300 Alexey Dobriyan <adobriyan@gmail.com> wrote:

> cpu_possible_mask is fixed after boot, so it makes sense
> to calculate number of possible cpus to
> a) make num_possible_cpus() faster (distros ship with _large_ NR_CPUS),
> b) unscrew codegen elsewhere replacing function call
>    with simple memory load.

There are a lot of calls to set_cpu_possible().  Perhaps calculating
num_possible_cpus within there would reduce risk of things getting out
of sync, either now or in the future.

reset_cpu_possible_mask() appears to have no callers.  Kill?



