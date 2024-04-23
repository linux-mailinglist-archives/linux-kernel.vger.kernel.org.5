Return-Path: <linux-kernel+bounces-155725-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A2838AF63A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 20:04:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C480E1F230A8
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 18:04:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AA0F13E05F;
	Tue, 23 Apr 2024 18:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Ps30MgGU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51C5213DDA5;
	Tue, 23 Apr 2024 18:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713895478; cv=none; b=WriMD6PrO84D2+L6VSWd9ivk16w3gyY+aSVziAlK1HCfLJSR49wHWWKKIsFhJFTJgffUlxTnt//hAva1BKcP2SEPWeHHUlCjPGGVa+zJ7nIwTWWplNXjjvIttKN9D84kVO46evkIRUx4M9C18yRTWLcVNSe78YOYNNRqeVTDal8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713895478; c=relaxed/simple;
	bh=Cn74BPHtpjOJgshJQZ4iXhIa8/T0sNEp7Eia/9C6Jko=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=VoiCbLEEFLxREgQ18fvzHjy4ebcTl4JqflymmY56JZlGnJP/U8ur3V+6YUlHCNXiEwOozUX9QWgwFPGMjbqTXxmsHDrS56TFeBvjG36T3xTFbPASlkEYOvzEfaNHP+mNSvNtu93vQM3vf7eAvx+qzEh+cEG010y8pJf2w0XsRG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Ps30MgGU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73FB0C116B1;
	Tue, 23 Apr 2024 18:04:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1713895476;
	bh=Cn74BPHtpjOJgshJQZ4iXhIa8/T0sNEp7Eia/9C6Jko=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Ps30MgGUiU9lFBVCW5O/mFNhptLJxXnA4oBeSaQ/QSfnqnmaFDgdtGGFihoP+DVpz
	 83/Hn9B8ZA6N65TRwJMSyTUw69MqKhUIurOL+1gIDrisex1AdspW8NAyaZBqcz4Bl5
	 nR9RGWdr+Ixf0WWlZXud1QzV5k7n0IwdlqtNVmPA=
Date: Tue, 23 Apr 2024 11:04:35 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Maxwell Bland <mbland@motorola.com>
Cc: linux-mm@kvack.org,
 "Maxwell Bland <mbland@motorola.com> Catalin Marinas"
 <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Jonathan Corbet
 <corbet@lwn.net>, Ard Biesheuvel <ardb@kernel.org>, Mark Rutland
 <mark.rutland@arm.com>, Christophe Leroy <christophe.leroy@csgroup.eu>,
 Alexandre Ghiti <alexghiti@rivosinc.com>,
 linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ptdump: add non-leaf descriptor support
Message-Id: <20240423110435.c84aa2a0e4cb5a17fb1ab18d@linux-foundation.org>
In-Reply-To: <20240423121820.874441838-1-mbland@motorola.com>
References: <20240423121820.874441838-1-mbland@motorola.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 23 Apr 2024 12:18:20 -0500 Maxwell Bland <mbland@motorola.com> wrote:

> Add an optional note_non_leaf parameter to ptdump, causing note_page to
> be called on non-leaf descriptors. Implement this functionality on arm64
> by printing table descriptors along with table-specific permission sets.

I was going to queue this while awaiting acks from arm people, but
there's a large reject in Documentation/arch/arm64/ptdump.rst.  Please
update to latest mainline?


