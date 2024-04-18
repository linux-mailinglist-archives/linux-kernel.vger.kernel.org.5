Return-Path: <linux-kernel+bounces-149619-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 363B18A9388
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 08:51:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B8B1AB20F21
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 06:51:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 579922CCC2;
	Thu, 18 Apr 2024 06:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Q/WYvIij"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A05E29A1
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 06:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713423058; cv=none; b=R5ex1+HnnG1rkR+OgHtI0PZ1u+rDsYGkiLGMkf5K/NVwDgvGKHpfG2U+0cN/AR7P9ttxdvvX+qDN+NtG8t167mO7C9hYK38CYQRYYTfcR4vd4x+tZR/J/2RjjfItlQWc8CO0YWrgZ+cPLVECYtONHNdlJyu8mTyM+uPr9Tv4VFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713423058; c=relaxed/simple;
	bh=WaYWNrxAeIq3qm2grzE5tnanXShMVTdyKXEkKKhPw10=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bes5iMpv/8eGKSRNqL+OrVU+LwUgzExUYXerVw8294CCCXB/8yfLruWGFzsdaZgav3CP/CiEcJYE/xMcVH+tJxAHT6YsaJd2I3lssrB2q2GXirqHz32ubAs+J/UHmVngaqrPEjl9B3u63cb18TbJFmz2vSryu/a4yao8Pujzb3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Q/WYvIij; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=WaYWNrxAeIq3qm2grzE5tnanXShMVTdyKXEkKKhPw10=; b=Q/WYvIij6klQ9NVt6qf8y9T6r9
	EJlUweKDuguJCdtSmulpV6aybwqEQvG/RCNNr0mluynz8arRxX3LOEZaAjHnyALc1mTkWUxeVEZxS
	0kRTuCGmOPlOUFrIU1D+lP6WElaukeqYmxMjF9DpAmJCskXZhbdK9uA+dhqWy0hKP3Bx4v/QB7s9b
	fxThAlYH8/Oa0tRPtdyYE91fDnRbkPPWSvOyQ43+QlrC0lfvLGelfdNoZFMElo42sPcUFdExcfIUZ
	70BlBvqG5z+5SMcTXmFG4vCGuA+9x17LGlzln7371TDbSn7X1hwMk3odyZE9DUjvf3G8Ub/C9Ifth
	Squll11w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rxLbj-00000001BIg-0Wsv;
	Thu, 18 Apr 2024 06:50:55 +0000
Date: Wed, 17 Apr 2024 23:50:55 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Daniel Sneddon <daniel.sneddon@linux.intel.com>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Alexandre Chartre <alexandre.chartre@oracle.com>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sean Christopherson <seanjc@google.com>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Nikolay Borisov <nik.borisov@suse.com>,
	KP Singh <kpsingh@kernel.org>, Waiman Long <longman@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH v3] x86/bugs: Only harden syscalls when needed
Message-ID: <ZiDCz3_0cy1ulw9S@infradead.org>
References: <eda0ec65f4612cc66875aaf76e738643f41fbc01.1713296762.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eda0ec65f4612cc66875aaf76e738643f41fbc01.1713296762.git.jpoimboe@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Apr 16, 2024 at 04:02:21PM -0700, Josh Poimboeuf wrote:
> Syscall hardening (i.e., converting the syscall indirect branch to a
> series of direct branches) may cause performance regressions in certain
> scenarios.

Maybe spell out the scenarios, as this just sounds like hand waiving
right now..


