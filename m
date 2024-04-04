Return-Path: <linux-kernel+bounces-132105-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59877898FBE
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 22:37:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8AA861C22FFE
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 20:37:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD70613AA27;
	Thu,  4 Apr 2024 20:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="khwTkHXk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B89C135A57
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 20:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712263051; cv=none; b=g4RDQNy84s3r0RRQXE5COZV2cbgngng8WEoQJkCNP9hLPF456PH5O+wJmiPT48Ou/9JqxYbjnTwFGk3tHkxXgu/xjmgibbSV+Oc9qmxV5ckk3i3ALmXu3Ws44WwlrJ9SHSB7DVc790KAiyx/WwFml4EoofO2eTVevs5HK4GEso4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712263051; c=relaxed/simple;
	bh=xOQUEK2idfQXjXTkdK30ijsm3ifktBoOy9VrkQdzNRY=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=fZ8ms88fCc6CKQqrajZCKSLqKUC0VmHPaqiSpCA+0IOlZwgz7+sJpfl0fL3rpglhI9DrfLmegBgF4WutWWQWPn3N7APEEe//wCNQacVww2fyKRn8ehq3UNYqvfbGhGLb+T2OCA3jSR4sVLkP5T78sLGyhmcIVdYLuWvcZC7kuL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=khwTkHXk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34191C43390;
	Thu,  4 Apr 2024 20:37:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1712263050;
	bh=xOQUEK2idfQXjXTkdK30ijsm3ifktBoOy9VrkQdzNRY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=khwTkHXk9LKus1LB5F1FSwOahT01SmpcrJgqZugyKsvzvqOehNBbCIodSj9MVTYXB
	 rjukLs2wHTk4nGnAcWJfS8QPoKK0bIVrOil0WpGxQUlc8ylNnINeG0e3G0z6NGe55V
	 6OZ6a4dZK05g0ipmIjW28Tj3q5/gLd8BlLUqrqW8=
Date: Thu, 4 Apr 2024 13:37:29 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Suren Baghdasaryan <surenb@google.com>
Cc: David Hildenbrand <david@redhat.com>, Matthew Wilcox
 <willy@infradead.org>, Lokesh Gidra <lokeshgidra@google.com>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, kernel-team@android.com,
 aarcange@redhat.com, peterx@redhat.com, zhengqi.arch@bytedance.com,
 kaleshsingh@google.com, ngeoffray@google.com
Subject: Re: [PATCH] userfaultfd: change src_folio after ensuring it's
 unpinned in UFFDIO_MOVE
Message-Id: <20240404133729.df00c3517e0b2cc3fd0d7e3c@linux-foundation.org>
In-Reply-To: <CAJuCfpEyb5tWGFUGMREj1zUBSiE3HNueHSPxGcPFnAwdfw6qmA@mail.gmail.com>
References: <20240404171726.2302435-1-lokeshgidra@google.com>
	<Zg7hrt5HudXLBUn_@casper.infradead.org>
	<CAJuCfpHvb5Jt6J1P9aHVdRWYUHmBL1edfp7QHn=jF88gJRD7RA@mail.gmail.com>
	<adce9a6f-fccf-4c9b-8ca3-3140a6a3d326@redhat.com>
	<CAJuCfpEyb5tWGFUGMREj1zUBSiE3HNueHSPxGcPFnAwdfw6qmA@mail.gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 4 Apr 2024 13:23:08 -0700 Suren Baghdasaryan <surenb@google.com> wrote:

> > Agreed, I don't think it is required for ->index. (I also don't spot any
> > corresponding READ_ONCE)
> 
> Since this patch just got Ack'ed, I'll wait for Andrew to take it into
> mm-unstable and then will send a fix removing those WRITE_ONCE(). That
> way we won't have merge conflicts,

Yes please, it's an unrelated thing.

