Return-Path: <linux-kernel+bounces-29430-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F9FE830E1E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 21:41:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 395821C21490
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 20:41:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6912250E8;
	Wed, 17 Jan 2024 20:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="cOy5ZRQC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 026181E53A
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 20:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705524085; cv=none; b=NQMiw0WeZ7WW9Y1CaIygBPhEA/Dxd/A4qSLmyKl976fWvdhCx9zxin5CmPT66KrcvtR7eu5W4PRyB8LI36TnSKkXF5iZ4tAT6CpndBXkL7j41H9FMdX7oJKsXiA0hw4zULwDZJGSt+lHLE+TfslX4QcL6e/GDkQwNcZ2A63VGns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705524085; c=relaxed/simple;
	bh=IVvmBQv90Bz2GeqnuDSf9UaYqRy1BwFXcZwi9OzHnnQ=;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-Id:
	 In-Reply-To:References:X-Mailer:Mime-Version:Content-Type:
	 Content-Transfer-Encoding; b=lT5yGDhcdxmh2yFpazZuJOM39dBzgpNGFeIAOlv8udYdf4qz81j3rOm7yn49Knj85Kp0w0eCvyJzU0fDuIonDTuP7QDQxQZqm1aKHD3yfNZuz40qjTbelg3PiElSRbsTwzE7QiE3tXzsNDt/MzVXkx16TQ6dYVu+4gzPSYuHRao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=cOy5ZRQC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0968EC433F1;
	Wed, 17 Jan 2024 20:41:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1705524083;
	bh=IVvmBQv90Bz2GeqnuDSf9UaYqRy1BwFXcZwi9OzHnnQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=cOy5ZRQC91qO+x48NHRDD9PcOdZ0C5JWYm/pQ1Rx5+P/8DGajvGEZTivNwn+vJny+
	 v/liDapK3mPROd/eGKaHecU5k99Q5QRwc7O5ITeF6tDKkZTyikKjNCUS0iKsp09ZeZ
	 xX9shH42sunLDgmpERJ609zgQyLmCIgg4QfGMnUo=
Date: Wed, 17 Jan 2024 12:41:18 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Lorenzo Stoakes <lstoakes@gmail.com>
Cc: Uladzislau Rezki <urezki@gmail.com>, Nathan Chancellor
 <nathan@kernel.org>, linux-mm@kvack.org, LKML
 <linux-kernel@vger.kernel.org>, Baoquan He <bhe@redhat.com>, Christoph
 Hellwig <hch@infradead.org>, Matthew Wilcox <willy@infradead.org>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>, Dave Chinner
 <david@fromorbit.com>, Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
 kernel test robot <lkp@intel.com>
Subject: Re: [PATCH 1/1] Fix a wrong value passed to __find_vmap_area()
Message-Id: <20240117124118.6cc05209fba27ab307b0a439@linux-foundation.org>
In-Reply-To: <3630611c-c9d5-428a-ad1b-21f4123c69b2@lucifer.local>
References: <20240111121104.180993-1-urezki@gmail.com>
	<20240111155511.GA3451701@dev-arch.thelio-3990X>
	<ZaARXdbigD1hWuOS@pc638.lan>
	<3630611c-c9d5-428a-ad1b-21f4123c69b2@lucifer.local>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 16 Jan 2024 22:13:17 +0000 Lorenzo Stoakes <lstoakes@gmail.com> wrote:

> > There was a type in the vmalloc_dump_obj() function. Instead
> > of passing a real address which is "objp" an "addr" was used
> > what is wrong and not initialized.
> >
> > Reported-by: kernel test robot <lkp@intel.com>
> > Fixes: 86817057732a ("mm: vmalloc: remove global vmap_area_root rb-tree")
> 
> I know the commits are likely to get squashed/messed with (this is now
> d1d9bdd672c4 in my mm-unstable tree), will this get corrected in the commit
> message also? Slightly tricky one.
> 
> Perhaps a note for Andrew unless his scripts do this already - please
> update this to wherever "mm: vmalloc: remove global vmap_area_root rb-tree"
> lands?

Yep, I'll scrunch together

mm-vmalloc-remove-global-vmap_area_root-rb-tree.patch
mm-vmalloc-remove-global-vmap_area_root-rb-tree-fix.patch
mm-vmalloc-remove-global-vmap_area_root-rb-tree-fix-2.patch

before merging it all into mm-stable and shall tidy up the changelog
trail.


