Return-Path: <linux-kernel+bounces-130659-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EF8F3897B14
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 23:57:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81E4F1F22477
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 21:57:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28A61156890;
	Wed,  3 Apr 2024 21:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="l9h/o02G"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A76615099C
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 21:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712181441; cv=none; b=ofZgrn6r5v/LUG8Z9Di2IB+29myd3q96b12RvG+yTwLcoYkNNyJW7bUMI25LAb/x+rNoigHLajMoyT4HIx8StPs3Y6eZLvScfaaOOUsQ3LopmKmyVnHeQZnwnDr2PccfCMXPesKjfCCcP9Yyp8/PXqbx4ne0QoTiEw7X7PNpII0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712181441; c=relaxed/simple;
	bh=swXtrHA3rER2QJ+fD07Evx50D4gtMpu+HnO1sa4c/EA=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=TVZ09V7SplSNWVtch+UjrfM10u18LDQvwVMKDX0eSWlnPxOT4JyM37fZ05VBD/dZIMb7rQiqjyPEKY5As9uxqJYjth0RABOVs2HzKlAcw7gkFG9//w7aXnVkb7mXU9+gT2FZSHnXGQ4dlSgB9B/YTiBEYi1ymmPwQPHYDOLefL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=l9h/o02G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2CFAC433C7;
	Wed,  3 Apr 2024 21:57:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1712181441;
	bh=swXtrHA3rER2QJ+fD07Evx50D4gtMpu+HnO1sa4c/EA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=l9h/o02Ga244YGSNLzrpYM0UcrQRElwNL5U/5YHYYALTPPLZn9YgtrmeyMFLTeySb
	 3xxFIMHilLdG3rmPXE+wbgra/DXAXAqdSoHz4QM9t3LDsmWbSJ6Rk7zsPzVeaqQz15
	 9Z7DiM4D/Y0S1s0nkAwfZoQqJ65CSaIAx5SrRD/s=
Date: Wed, 3 Apr 2024 14:57:19 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Suren Baghdasaryan <surenb@google.com>
Cc: sfr@canb.auug.org.au, kent.overstreet@linux.dev, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH 1/1] lib: do limited memory accounting for modules with
 ARCH_NEEDS_WEAK_PER_CPU
Message-Id: <20240403145719.547d1083fede2cb4ca2c41ef@linux-foundation.org>
In-Reply-To: <20240402180933.1663992-2-surenb@google.com>
References: <20240402180933.1663992-1-surenb@google.com>
	<20240402180933.1663992-2-surenb@google.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  2 Apr 2024 11:09:33 -0700 Suren Baghdasaryan <surenb@google.com> wrote:

> ARCH_NEEDS_WEAK_PER_CPU does not allow percpu variable definitions inside
> a function, therefore memory allocation profiling can't use it. This
> definition is used only for modules, so we still can account core kernel
> allocations and for modules we can do limited allocation accounting by
> charging all of them to a single counter. This is not ideal but better

I'll queue this as a to-be-squashed fix against "lib: add allocation
tagging support for memory allocation profiling", OK?

