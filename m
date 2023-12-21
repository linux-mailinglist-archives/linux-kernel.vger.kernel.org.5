Return-Path: <linux-kernel+bounces-9107-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F397C81C098
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 22:58:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C36C1F22997
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 21:58:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22B747765C;
	Thu, 21 Dec 2023 21:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="xNEDNhz5"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6190F58224;
	Thu, 21 Dec 2023 21:58:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78050C433C8;
	Thu, 21 Dec 2023 21:58:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1703195914;
	bh=GenD/ytiRuCbl0Hb/SKAjNHtBD9mpn1hrqVXcpK5Xq0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=xNEDNhz5QlzjnZRZ2nhBDfI7zoTlNezwdFp8dZqLiICEvy7+vFd1kD6XRoQl7MuF1
	 KmXh1xrzzp6i3wZqWF6wfAnWe6MmxscaVpkqCHEV14iU4XbXXSXUr7watwCyFxq7AZ
	 aTxGfkZwPa+2sbtytnrbxkQTG9uQLytZxlOrHG2I=
Date: Thu, 21 Dec 2023 13:58:33 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: David Hildenbrand <david@redhat.com>
Cc: Oliver Sang <oliver.sang@intel.com>, Matthew Wilcox
 <willy@infradead.org>, oe-lkp@lists.linux.dev, lkp@intel.com, Linux Memory
 Management List <linux-mm@kvack.org>, linux-kernel@vger.kernel.org
Subject: Re: [linux-next:master] [mm] bbcbf2a3f0: kernel_BUG_at_mm/memory.c
Message-Id: <20231221135833.92b8b2a97b28ad0545977f6c@linux-foundation.org>
In-Reply-To: <e0e7d631-0af4-46fc-b606-78de07ebb88a@redhat.com>
References: <202312192319.fa8f5709-oliver.sang@intel.com>
	<20231220141135.cb4241442b657104f0aeae34@linux-foundation.org>
	<ZYQgGmYNfF8j4JqL@xsang-OptiPlex-9020>
	<e0e7d631-0af4-46fc-b606-78de07ebb88a@redhat.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 21 Dec 2023 12:32:04 +0100 David Hildenbrand <david@redhat.com> wrote:

> On 21.12.23 12:23, Oliver Sang wrote:
> > hi, Andrew Morton,
> > 
> > On Wed, Dec 20, 2023 at 02:11:35PM -0800, Andrew Morton wrote:
> >> On Tue, 19 Dec 2023 23:46:50 +0800 kernel test robot <oliver.sang@intel.com> wrote:
> >>
> >>>
> >>>
> >>> Hello,
> >>>
> >>> kernel test robot noticed "kernel_BUG_at_mm/memory.c" on:
> >>>
> >>> commit: bbcbf2a3f05f74f9d268eab57abbdce6a65a94ad ("mm: convert ksm_might_need_to_copy() to work on folios")
> >>
> >> I assume this is a bisection result, so it's quite repeatable?
> > 
> > yes, we bisect to this commit, it's quite repeatable:
> > 
> > ddd06bb63d9793ce bbcbf2a3f05f74f9d268eab57ab
> > ---------------- ---------------------------
> >         fail:runs  %reproduction    fail:runs
> >             |             |             |
> >             :6          100%           6:6     dmesg.Kernel_panic-not_syncing:Fatal_exception
> >             :6          100%           6:6     dmesg.RIP:do_swap_page
> >             :6          100%           6:6     dmesg.invalid_opcode:#[##]
> >             :6          100%           6:6     dmesg.kernel_BUG_at_mm/memory.c
> > 
> > 
> 
> Can you try with the snipped I sent? Please let me know if you need a 
> full patch for testing purposes.

I think a full patch would be better, please.

