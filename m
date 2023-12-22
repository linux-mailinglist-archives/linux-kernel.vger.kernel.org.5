Return-Path: <linux-kernel+bounces-9307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D44D81C3C4
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 05:14:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C285F1C24C5E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 04:14:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D53B06138;
	Fri, 22 Dec 2023 04:14:36 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8F356120
	for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 04:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 6048B68AFE; Fri, 22 Dec 2023 05:14:28 +0100 (CET)
Date: Fri, 22 Dec 2023 05:14:28 +0100
From: Christoph Hellwig <hch@lst.de>
To: Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: Maxim Kochetkov <fido_max@inbox.ru>, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org, robh@kernel.org, mpe@ellerman.id.au,
	aou@eecs.berkeley.edu, palmer@dabbelt.com, paul.walmsley@sifive.com,
	Conor Dooley <conor@kernel.org>, hch@lst.de
Subject: Re: [PATCH 1/1] riscv: set ARCH_DMA_DEFAULT_COHERENT if
 RISCV_DMA_NONCOHERENT is not set
Message-ID: <20231222041428.GA2803@lst.de>
References: <20231221185152.327231-1-fido_max@inbox.ru> <20231221-discount-decade-e306e5878c46@spud> <f31d929c-fa0a-4046-be05-38e92afa5d92@flygoat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f31d929c-fa0a-4046-be05-38e92afa5d92@flygoat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Dec 21, 2023 at 10:27:33PM +0000, Jiaxun Yang wrote:
>
>
> 在 2023/12/21 20:29, Conor Dooley 写道:
>> + Christoph
>>
>> I don't think this patch is correct. Regardless of whether we support
>> cache management operations, DMA is assumed to be coherent unless
>> peripherals etc are specified to otherwise in DT (or however ACPI deals
>> with that kind of thing).
>>
>> What problem are you trying to solve here?
>>
>> On Thu, Dec 21, 2023 at 09:51:52PM +0300, Maxim Kochetkov wrote:
>>> Not all the RISCV are DMA coherent by default.
>
> Sorry for chime in here.
> IMO if your platform is not coherent by default, just insert 
> "dma-noncoherent"
> at devicetree root node.

Exactly.  ARCH_DMA_DEFAULT_COHERENTis a setting that just says for
a given architecture assumes coherent unless otherwise specified,
which has historically been the case for mips.  Not setting it means
non-coherent unless specified, which has historially been the case
for arm.

RISC-V starte out without support for non-coherent DMA, and high ups
in RISCV still told me in 2019 that RISC-V doesn't need cache
management instructions because no new hardware would ever not be
dma coherent.  Yeah, right..

Anyay, Linux for RISC-V has historically been coherent only and then
coherent default, so this option is wrong, and you need to mark
you platform as non-coherent by inserting dma-noncoherent somewhere.


