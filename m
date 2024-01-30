Return-Path: <linux-kernel+bounces-44564-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A096D842446
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 12:59:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2EB11C26003
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 11:59:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7038F679EF;
	Tue, 30 Jan 2024 11:59:35 +0000 (UTC)
Received: from mail.wantstofly.org (hmm.wantstofly.org [213.239.204.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8907467E60;
	Tue, 30 Jan 2024 11:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.239.204.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706615975; cv=none; b=NIa+2YATVhmbXHbt1N6ckl4+YAlSAqEHm43ZDzEJWQG/1ZiGm5KpOz75O/Y8xPSinPo9O0mQ1Y7DU3zwmKVosEnHzbM0t52BO2jQwJAarlEcezj4241Qfb/Esu/RS40PI58yyX0n7u7kjumy7p73whTyJ8lC7yh8i8lq2IHVuK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706615975; c=relaxed/simple;
	bh=/EbS7QCd5gU5yDybrgjByI/a3znatbuHH67Z4bVG8NA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b2P3qKyXoFezCnBr7eSLPRwWhFtIj+F9XDIpKl1uljx2MUXFVRgf9PyWKtbKjXV82FqKiQa+WuJMEDNZFeYhZIWgDtXgqcgWrjpt4dLfmUSRSpDphkwjDcH7GM2hthnmQXu3bwtVKJhifZEMNfpbqLHn8pGpcbfJTV4ghkqKuOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wantstofly.org; spf=pass smtp.mailfrom=wantstofly.org; arc=none smtp.client-ip=213.239.204.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wantstofly.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wantstofly.org
Received: by mail.wantstofly.org (Postfix, from userid 1000)
	id E87AD7F711; Tue, 30 Jan 2024 13:59:28 +0200 (EET)
Date: Tue, 30 Jan 2024 13:59:28 +0200
From: Lennert Buytenhek <kernel@wantstofly.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Niklas Cassel <cassel@kernel.org>, linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>,
	John Garry <john.g.garry@oracle.com>,
	Joerg Roedel <jroedel@suse.de>,
	Szuying Chen <chensiying21@gmail.com>, Jesse1_Chang@asmedia.com.tw,
	Richard_Hsu@asmedia.com.tw, Chloe_Chen@asmedia.com.tw
Subject: Re: [PATCH] ahci: Extend ASM1061 43-bit DMA address quirk to other
 ASM106x parts
Message-ID: <ZbjkoKotLvDSeJTA@wantstofly.org>
References: <ZbjgTmR5FbAnb-Ua@wantstofly.org>
 <6ab581f1-385c-49af-bff3-aacd1cdbe1d8@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6ab581f1-385c-49af-bff3-aacd1cdbe1d8@kernel.org>

On Tue, Jan 30, 2024 at 08:46:23PM +0900, Damien Le Moal wrote:

> > ASMedia have confirmed that all ASM106x parts currently listed in
> > ahci_pci_tbl[] suffer from the 43-bit DMA address limitation that we ran
> > into on the ASM1061, and therefore, we need to apply the quirk added by
> > commit 20730e9b2778 to the other supported ASM106x parts as well.
> > 
> > Signed-off-by: Lennert Buytenhek <kernel@wantstofly.org>
> 
> I think this needs a cc: stable tag.

The commit that is likely responsible for surfacing this issue is
791c2b17fb40 which went into v6.6 -- so would this then be appropriate,
or do you think this should be backported to older versions as well?

Cc: stable@vger.kernel.org # 6.6.x


> > ---
> >  drivers/ata/ahci.c | 10 +++++-----
> >  1 file changed, 5 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
> > index d2460fa985b7..da2e74fce2d9 100644
> > --- a/drivers/ata/ahci.c
> > +++ b/drivers/ata/ahci.c
> > @@ -606,13 +606,13 @@ static const struct pci_device_id ahci_pci_tbl[] = {
> >  	{ PCI_VDEVICE(PROMISE, 0x3781), board_ahci },   /* FastTrak TX8660 ahci-mode */
> >  
> >  	/* ASMedia */
> > -	{ PCI_VDEVICE(ASMEDIA, 0x0601), board_ahci },	/* ASM1060 */
> > -	{ PCI_VDEVICE(ASMEDIA, 0x0602), board_ahci },	/* ASM1060 */
> > +	{ PCI_VDEVICE(ASMEDIA, 0x0601), board_ahci_43bit_dma },	/* ASM1060 */
> > +	{ PCI_VDEVICE(ASMEDIA, 0x0602), board_ahci_43bit_dma },	/* ASM1060 */
> >  	{ PCI_VDEVICE(ASMEDIA, 0x0611), board_ahci_43bit_dma },	/* ASM1061 */
> >  	{ PCI_VDEVICE(ASMEDIA, 0x0612), board_ahci_43bit_dma },	/* ASM1061/1062 */
> > -	{ PCI_VDEVICE(ASMEDIA, 0x0621), board_ahci },   /* ASM1061R */
> > -	{ PCI_VDEVICE(ASMEDIA, 0x0622), board_ahci },   /* ASM1062R */
> > -	{ PCI_VDEVICE(ASMEDIA, 0x0624), board_ahci },   /* ASM1062+JMB575 */
> > +	{ PCI_VDEVICE(ASMEDIA, 0x0621), board_ahci_43bit_dma },	/* ASM1061R */
> > +	{ PCI_VDEVICE(ASMEDIA, 0x0622), board_ahci_43bit_dma },	/* ASM1062R */
> > +	{ PCI_VDEVICE(ASMEDIA, 0x0624), board_ahci_43bit_dma },	/* ASM1062+JMB575 */
> >  	{ PCI_VDEVICE(ASMEDIA, 0x1062), board_ahci },	/* ASM1062A */
> >  	{ PCI_VDEVICE(ASMEDIA, 0x1064), board_ahci },	/* ASM1064 */
> >  	{ PCI_VDEVICE(ASMEDIA, 0x1164), board_ahci },   /* ASM1164 */

