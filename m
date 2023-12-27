Return-Path: <linux-kernel+bounces-12293-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BB1EF81F26D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 23:24:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57EAF1F21AE9
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 22:24:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81F754988B;
	Wed, 27 Dec 2023 22:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="kxfkBm24"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8DA049888
	for <linux-kernel@vger.kernel.org>; Wed, 27 Dec 2023 22:24:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03086C433C7;
	Wed, 27 Dec 2023 22:24:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1703715882;
	bh=zEUsrdgnAUQ23oCewBpxTW3MR3vDO/bpQtbcXr3pDjc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kxfkBm24tZLUhSzuj1G9mlNxxOsSkyEYKXhboHPkPONc5qOzT++VqXm0Q2glImzWi
	 Aavyw9UfxCSIjZcJyQqu1SCP/l+VUQTpbja9KWMnCdTAUZYmScN0jPP+PLk++7mW/x
	 ow1H1GE5sIDv41GwED6cxHcnm6VHsq8SvQKIx9Yw=
Date: Wed, 27 Dec 2023 14:24:41 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Deepak Gupta <debug@rivosinc.com>
Cc: rick.p.edgecombe@intel.com, broonie@kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] mm: abstract shadow stack vma behind
 arch_is_shadow_stack_vma
Message-Id: <20231227142441.f9a76fa3c8b9b79eea8f93a2@linux-foundation.org>
In-Reply-To: <CAKC1njTry42zAkZWq3pAgoe3YFaHN6UcB4i56BDQRxYbTEigRw@mail.gmail.com>
References: <20231222235248.576482-1-debug@rivosinc.com>
	<20231227134514.13629032c39decdf1dddcc75@linux-foundation.org>
	<CAKC1njTry42zAkZWq3pAgoe3YFaHN6UcB4i56BDQRxYbTEigRw@mail.gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Wed, 27 Dec 2023 14:20:36 -0800 Deepak Gupta <debug@rivosinc.com> wrote:

> On Wed, Dec 27, 2023 at 1:45 PM Andrew Morton <akpm@linux-foundation.org> wrote:
> >
> > On Fri, 22 Dec 2023 15:51:04 -0800 Deepak Gupta <debug@rivosinc.com> wrote:
> >
> > > x86 has used VM_SHADOW_STACK (alias to VM_HIGH_ARCH_5) to encode shadow
> > > stack VMA. VM_SHADOW_STACK is thus not possible on 32bit. Some arches may
> > > need a way to encode shadow stack on 32bit and 64bit both and they may
> > > encode this information differently in VMAs.
> >
> > Is such a patch in the pipeline?  Otherwise we're making a change that
> > serves no purpose.
> 
> Yes I do have patches in the pipeline for riscv.
> On riscv, presence of only `VM_WRITE` (i.e. (flags & (VM_READ |
> VM_WRITE | VM_EXEC))
> == VM_WRITE) would mean a shadow stack.
> And yes there would be  relevant patches to ensure that existing consumers using
> `PROT_WRITE` gets translated to (VM_WRITE | VM_READ)

OK, please plan to carry this patch in whatever tree contains the above.



