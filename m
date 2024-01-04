Return-Path: <linux-kernel+bounces-16174-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A5F4823A21
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 02:15:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6FE871C24A61
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 01:15:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2350F1865;
	Thu,  4 Jan 2024 01:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="D0TY6nHa"
X-Original-To: linux-kernel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51532A34
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 01:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=vxU9S5f6FIwALc89E8wXPWdUBFpyV1Du3ti4Xvllcyw=; b=D0TY6nHa5vyi0JeUJngCTHdH8W
	T/GOMmflZqn5LTutVgJl+7IxZtdEG53StFYOnWF4AK1nJoc8whepE1HbP+dwHHvXr/Rr/LaUC8tlv
	9uKPssaDzsBDVKwly64tKmJ5Cns7UACzFkisNrI34uBWE3rIia66c1XGW8HDmzHWQvVpO0R7fD3QV
	yCx9uDCD9F0wqzjkA8iPzb4K7yU4DhUWCIl0c+pOxwTFdK9UEGBax+YSM2/SVRqZQpGXTj2XJHeML
	KvN7VnIqy+7iBhbMfF73tpLHdXeKYmRVp9CiFsbl7xutKBPU04KSIn8kKSgaW863FksvglH+XNPCD
	7O/TopRw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rLCJP-00112g-2i;
	Thu, 04 Jan 2024 01:14:19 +0000
Date: Thu, 4 Jan 2024 01:14:19 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Tanzir Hasan <tanzirh@google.com>
Cc: Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, Nick Desaulniers <nnn@google.com>,
	linux-kernel@vger.kernel.org,
	Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH v2] x86/vdso: shrink vdso/extable.i via IWYU
Message-ID: <20240104011419.GN1674809@ZenIV>
References: <20240104-extable-v2-1-6fdcb64abcb2@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240104-extable-v2-1-6fdcb64abcb2@google.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Thu, Jan 04, 2024 at 12:02:40AM +0000, Tanzir Hasan wrote:

*ugh*

> +#include <linux/stddef.h>
> +#include <linux/types.h>

Do we have _anything_ that would not want stddef.h?  Seriously -
NULL, true, false, offsetof...   At that point I'd rather have
it via -include...

Are we going to spam that include all over the tree?  Because
it'd really be just about everything...

