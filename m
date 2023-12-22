Return-Path: <linux-kernel+bounces-9809-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A672E81CBB3
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 16:04:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 620181F27C33
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 15:04:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16AF623776;
	Fri, 22 Dec 2023 15:04:33 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD9C023749
	for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 15:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 96F8668BEB; Fri, 22 Dec 2023 16:04:18 +0100 (CET)
Date: Fri, 22 Dec 2023 16:04:17 +0100
From: Christoph Hellwig <hch@lst.de>
To: Conor Dooley <conor@kernel.org>
Cc: Maxim Kochetkov <fido_max@inbox.ru>, Christoph Hellwig <hch@lst.de>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	robh@kernel.org, mpe@ellerman.id.au, aou@eecs.berkeley.edu,
	palmer@dabbelt.com, paul.walmsley@sifive.com
Subject: Re: [PATCH 1/1] riscv: set ARCH_DMA_DEFAULT_COHERENT if
 RISCV_DMA_NONCOHERENT is not set
Message-ID: <20231222150417.GA23363@lst.de>
References: <20231221185152.327231-1-fido_max@inbox.ru> <20231221-discount-decade-e306e5878c46@spud> <f31d929c-fa0a-4046-be05-38e92afa5d92@flygoat.com> <20231222041428.GA2803@lst.de> <c53c22dd-c482-4808-bdd7-e81c01c04f9e@inbox.ru> <20231222-outburst-spoiling-75082a7826dd@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231222-outburst-spoiling-75082a7826dd@spud>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, Dec 22, 2023 at 02:54:19PM +0000, Conor Dooley wrote:
> > of_dma_is_coherent() affects only DT devices. And we can override it with
> > "dma-coherent"/"dma-noncoherent". ACPI devices can specify by
> > "attr == DEV_DMA_COHERENT". But all other devices (platform_device, usb,
> 
> I would have expected that usb devices "inherit" the value from the usb
> controller whose bus they are on. Similarly, platform devices are on a
> bus that should be marked as non-coherent if that is the case.
> Christoph certainly knows better how things operate here however.

usb is not a DMAable devices, you need to use the USB layer helpers
that call the DMA API on the host controller's device.  platform_device
must have a device tree and the dma-noncoherent attribute somewhere in
the hierarchy.

