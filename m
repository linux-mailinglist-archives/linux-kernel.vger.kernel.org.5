Return-Path: <linux-kernel+bounces-68976-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 448488582DD
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 17:45:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FE8B1C21E5D
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 16:45:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BB2C130ADC;
	Fri, 16 Feb 2024 16:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OCN94ZFt"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E921612EBC8;
	Fri, 16 Feb 2024 16:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708101896; cv=none; b=Qcz80kwzdl0cqsAfJvTIcC6MRvxG8bz4GnsFBq4fg3TUiU6Fga9CQQxXbiucbLMYYPEaqVZ/+IkkACwpld1U3fCHcts6SGr9C3tpiAXlz+ixxXmV4XRTdDvl4GNEGWU/X5RDdmC6u0dIwgfKxClv8RJ8JQf634ai7lGnVlcY3JA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708101896; c=relaxed/simple;
	bh=DREtwBpdo744kwdkZr603r+e8INTDQG/jJ9H007lpGU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RxLovDh91sA9PJJeOkPXB7vnFJ626ydfzMpOiSoXkGZ/6bAs0NJjOFK8zHNokVx5V86gi4ml2f1zKbU33AaFD4gFYO7c/0l4xJVodY1QBKbvzfj3Kyjd+z557mw4xcD5i9yYUN/PBfnouqntkRxhld5jCtlnr+0JhxL2wMPPr0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=OCN94ZFt; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=DJeGR7MecqykZ6Yo2+icCQoR/1eFxGrSeBJy2YqSm+M=; b=OCN94ZFtA2QEKgR8FMWB0K+p5s
	10xo3S9zwWVEv2IFIeoXxpbbNNExUy8MZRj0tu1FNV/NY7izR3/2GvWwzHS2/XsaEYF+ukqdDg3MN
	Qv5SSGtzWgcPs7bYwCIe9KA6mt7hrHCgzJpSXdDL3JHSnKsNipkrO74wBTX2Qcf82tdNThyU5SP0l
	1BKYP2iS076KAPaM4V7YHg+OePMJZGawKk8QNT0Gom1sxZxHCPo3qAKGoqs61M88f1QaDG+Ls4B18
	qX1XBOg1OJc9N8wiSkxUWLBcBWp6525NUhTj8vuLe5WU416KrZa4p/zydvGXPT1JSv+uvfOBWEVB0
	HzJd44Rw==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rb1K3-000000058zn-0K4J;
	Fri, 16 Feb 2024 16:44:23 +0000
Date: Fri, 16 Feb 2024 16:44:22 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Petr Tesarik <petrtesarik@huaweicloud.com>
Cc: Dave Hansen <dave.hansen@intel.com>,
	Petr =?utf-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>,
	Jonathan Corbet <corbet@lwn.net>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
	"H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>, Xin Li <xin3.li@intel.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Kees Cook <keescook@chromium.org>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Pengfei Xu <pengfei.xu@intel.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>, Ze Gao <zegao2021@gmail.com>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Kai Huang <kai.huang@intel.com>,
	David Woodhouse <dwmw@amazon.co.uk>,
	Brian Gerst <brgerst@gmail.com>, Jason Gunthorpe <jgg@ziepe.ca>,
	Joerg Roedel <jroedel@suse.de>,
	"Mike Rapoport (IBM)" <rppt@kernel.org>,
	Tina Zhang <tina.zhang@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>,
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	Roberto Sassu <roberto.sassu@huaweicloud.com>,
	David Howells <dhowells@redhat.com>,
	Petr Tesarik <petr.tesarik1@huawei-partners.com>
Subject: Re: [RFC 6/8] KEYS: PGP data parser
Message-ID: <Zc-Q5pVHjngq9lpX@casper.infradead.org>
References: <fb4a40c7-af9a-406a-95ab-406595f3ffe5@intel.com>
 <20240216152435.1575-1-petrtesarik@huaweicloud.com>
 <20240216152435.1575-7-petrtesarik@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240216152435.1575-7-petrtesarik@huaweicloud.com>

On Fri, Feb 16, 2024 at 04:24:33PM +0100, Petr Tesarik wrote:
> From: David Howells <dhowells@redhat.com>
> 
> Implement a PGP data parser for the crypto key type to use when
> instantiating a key.
> 
> This parser attempts to parse the instantiation data as a PGP packet
> sequence (RFC 4880) and if it parses okay, attempts to extract a public-key
> algorithm key or subkey from it.

I don't understand why we want to do this in-kernel instead of in
userspace and then pass in the actual key.


