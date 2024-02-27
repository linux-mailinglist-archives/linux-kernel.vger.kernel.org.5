Return-Path: <linux-kernel+bounces-83271-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BCE3786911A
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 13:58:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 714011F21FB1
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 12:58:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2C1613A89B;
	Tue, 27 Feb 2024 12:57:47 +0000 (UTC)
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 294E0135A5C
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 12:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709038667; cv=none; b=Fwnu8AdyW9CHJePQOS8uYdzUbgSVS5RWzDMca472WKuhUmGaKIKF4k58tsog3l5w0Q5fjnyRVyyqZ7dKM32N66CWmibJnjlU+4K9l+1MWXQ8QHdD+WEXukAlR/N26NBhoXW+0OFs6WFAjk5PoO9wGGM0IbUljuxnjyCz6px1CWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709038667; c=relaxed/simple;
	bh=rLuWRYY4nrBUkzXuyIyoCtcyMvzxxNjHaMWHuiSTGqo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R84fzr3nZRt/1ZqfLq6ljmcc7+4mZKdBqZUk+ZRNDhTNMNLJU1Pk2v9+HidOZ+xwFxXyqz6Kaq+YZtgr12FsQ0bAKzdvq/7xrxkZcwnYDATru2rFLPVnQ1bxOPyz3SbzCuk+Y1Fi2dgiiiW6jmVnjPPG+lMTxMwe8CD8GcB1LP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.96.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1rex1I-0004YG-2F;
	Tue, 27 Feb 2024 12:57:16 +0000
Date: Tue, 27 Feb 2024 12:57:07 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Zhihao Cheng <chengzhihao1@huawei.com>
Cc: Richard Weinberger <richard@nod.at>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mtd: ubi: fix NVMEM over UBI volumes on 32-bit systems
Message-ID: <Zd3cIw5NZOW2KtXe@makrotopia.org>
References: <186fa96ae25f7033ff8b6f0f7fcfb1e602f556fc.1708971705.git.daniel@makrotopia.org>
 <ab2b4573-58ce-d895-0aae-69e3647e0a68@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ab2b4573-58ce-d895-0aae-69e3647e0a68@huawei.com>

On Tue, Feb 27, 2024 at 10:23:17AM +0800, Zhihao Cheng wrote:
> 在 2024/2/27 2:23, Daniel Golle 写道:
> > A compiler warning related to sizeof(int) != 8 when calling do_div()
> > is triggered when building on 32-bit platforms.
> > Address this by using integer types having a well-defined size where
> > appropriate.
> > 
> > Fixes: 3ce485803da1 ("mtd: ubi: provide NVMEM layer over UBI volumes")
> > Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> > ---
> >   drivers/mtd/ubi/nvmem.c | 5 ++++-
> >   1 file changed, 4 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/mtd/ubi/nvmem.c b/drivers/mtd/ubi/nvmem.c
> > index b7a93c495d172..5820a170d2512 100644
> > --- a/drivers/mtd/ubi/nvmem.c
> > +++ b/drivers/mtd/ubi/nvmem.c
> > @@ -23,14 +23,17 @@ struct ubi_nvmem {
> >   static int ubi_nvmem_reg_read(void *priv, unsigned int from,
> >   			      void *val, size_t bytes)
> >   {
> > -	int err = 0, lnum = from, offs, bytes_left = bytes, to_read;
> > +	uint32_t bytes_left, offs, to_read;
> >   	struct ubi_nvmem *unv = priv;
> >   	struct ubi_volume_desc *desc;
> > +	uint64_t lnum = from;
> > +	int err = 0;
> >   	desc = ubi_open_volume(unv->ubi_num, unv->vol_id, UBI_READONLY);
> >   	if (IS_ERR(desc))
> >   		return PTR_ERR(desc);
> > +	bytes_left = bytes;
> The 'bytes' is a size_t type, which has 64 bits on 64-bit platforms. This
> assignment will lead a type truncation, so should we add a explicit type
> conversion here to avoid compiler warning?

Oh right. I reckon the best is to declare 'bytes' as 'size_t' type as well
then. I will send v2 with that change shortly.


> >   	offs = do_div(lnum, unv->usable_leb_size);
> >   	while (bytes_left) {
> >   		to_read = unv->usable_leb_size - offs;
> > 
> 
> 
> ______________________________________________________
> Linux MTD discussion mailing list
> http://lists.infradead.org/mailman/listinfo/linux-mtd/

