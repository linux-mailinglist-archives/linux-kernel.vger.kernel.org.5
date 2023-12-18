Return-Path: <linux-kernel+bounces-4168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5056E8178B9
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 18:29:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EE133B24213
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 17:29:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 036085D730;
	Mon, 18 Dec 2023 17:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="E5k/M/ce"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 604705D73B
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 17:29:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E2BCC433C8;
	Mon, 18 Dec 2023 17:29:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1702920543;
	bh=ynjI4k0Sr9W4fKkiz4LK5kOla2xoyYoQCxBA58AjXe0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=E5k/M/cevF1JpfantAKOdadkXEaBzQr18LSpDNV+KkWjeJQm8Z7yGIwVUutpN0+rL
	 pcbqzMYKUCvcgCG7a9tIXnzPdus2F24TETbxOjZBjGzBU11ltvt82zQI8o7IbNAxSN
	 KMQRyPWltAyCd3lVkb18dI8lEhAg/vHV1St9gksw=
Date: Mon, 18 Dec 2023 09:29:02 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Yuntao Wang <ytcoode@gmail.com>
Cc: linux-kernel@vger.kernel.org, kexec@lists.infradead.org, x86@kernel.org,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Baoquan He <bhe@redhat.com>, Vivek Goyal
 <vgoyal@redhat.com>, Dave Young <dyoung@redhat.com>, Hari Bathini
 <hbathini@linux.ibm.com>, Sean Christopherson <seanjc@google.com>, Takashi
 Iwai <tiwai@suse.de>
Subject: Re: [PATCH 2/2] crash_core: fix out-of-bounds access check in
 crash_exclude_mem_range()
Message-Id: <20231218092902.9fae480cfcad3874e9e7236f@linux-foundation.org>
In-Reply-To: <20231218081915.24120-3-ytcoode@gmail.com>
References: <20231218081915.24120-1-ytcoode@gmail.com>
	<20231218081915.24120-3-ytcoode@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 18 Dec 2023 16:19:15 +0800 Yuntao Wang <ytcoode@gmail.com> wrote:

> mem->nr_ranges represents the current number of elements stored in
> the mem->ranges array, and mem->max_nr_ranges represents the maximum number
> of elements that the mem->ranges array can hold. Therefore, the correct
> array out-of-bounds check should be mem->nr_ranges >= mem->max_nr_ranges.
> 

This does not apply after your own "crash_core: fix and simplify the
logic of crash_exclude_mem_range()".  What should be done?

