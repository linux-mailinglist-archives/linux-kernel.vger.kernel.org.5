Return-Path: <linux-kernel+bounces-105426-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CD3687DDBA
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 16:04:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90E49281373
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 15:04:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4959D1C696;
	Sun, 17 Mar 2024 15:04:37 +0000 (UTC)
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
	by smtp.subspace.kernel.org (Postfix) with SMTP id A44821BF35
	for <linux-kernel@vger.kernel.org>; Sun, 17 Mar 2024 15:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.131.102.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710687876; cv=none; b=D5wOUqp+gI2cNEOn3YOg2rsVaQs7nfojOOEyPQr/oKsXxpeLJaZQ9zw7yNghmw4d5ybey3zKiDTTjhLIdE5dW/yzHMkL3hGJWsuk/5rv/lYXV1JD/+VooKYyHfitmm3+tzlXC6iWajcbTmHY+iwEdnIONzGjRw4dLlEpswAIaXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710687876; c=relaxed/simple;
	bh=cEBWygA37gsqfLBFhtl6suQR4GExIWOd2AcEt4hWdlk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mEtjWSGQgi3Eh3J/2/dA8376HUGBbFDUMfWhmSrEbcLvvlLixQupyBxsogpwZm348ZlidfEJw4dxU9AjpwU3YTAKm4qMrBNd12pAvrs5AQhQNX/nZSZ1w9aSNQfb9u08OxAKUrrh3AANvE0g6x8bWyRgExC6Gz9r/KOBRcaaqQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=rowland.harvard.edu; spf=pass smtp.mailfrom=netrider.rowland.org; arc=none smtp.client-ip=192.131.102.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netrider.rowland.org
Received: (qmail 548205 invoked by uid 1000); 17 Mar 2024 11:04:33 -0400
Date: Sun, 17 Mar 2024 11:04:33 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: xingwei lee <xrivendell7@gmail.com>
Cc: gregkh@linuxfoundation.org, usb-storage@lists.one-eyed-alien.net,
  linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
  samsun1006219@gmail.com, syzkaller-bugs@googlegroups.com
Subject: Re: divide error in alauda_transport
Message-ID: <cc7eb13f-b61d-4a4c-8c35-394a833d5917@rowland.harvard.edu>
References: <CABOYnLw8=VM4LxgBsrwTi3HzdvGV7cYJU=4t7MMYTnrDCaDKAQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABOYnLw8=VM4LxgBsrwTi3HzdvGV7cYJU=4t7MMYTnrDCaDKAQ@mail.gmail.com>

On Sun, Mar 17, 2024 at 04:31:01PM +0800, xingwei lee wrote:
> Hello I found a bug in latest upstream titled "divide error in
> alauda_transport", and maybe is realted with usb.
> I comfired in the latest upstream the poc tree can trigger the issue.
> 
> If you fix this issue, please add the following tag to the commit:
> Reported-by: xingwei lee <xrivendell7@gmail.com>
> Reported-by: yue sun <samsun1006219@gmail.com>
> 
> kernel: upstream 9187210eee7d87eea37b45ea93454a88681894a4
> config: https://syzkaller.appspot.com/text?tag=KernelConfig&x=1c6662240382da2
> with KASAN enabled
> compiler: gcc (Debian 12.2.0-14) 12.2.0
> 
> divide error: 0000 [#1] PREEMPT SMP KASAN NOPTI
> CPU: 2 PID: 8229 Comm: usb-storage Not tainted 6.8.0-05202-g9187210eee7d #20
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
> 1.16.2-1.fc38 04/01/2014
> RIP: 0010:alauda_read_data drivers/usb/storage/alauda.c:954 [inline]
> RIP: 0010:alauda_transport+0xcaf/0x3830 drivers/usb/storage/alauda.c:1184

Can you please test the patch below?

Alan Stern



Index: usb-devel/drivers/usb/storage/alauda.c
===================================================================
--- usb-devel.orig/drivers/usb/storage/alauda.c
+++ usb-devel/drivers/usb/storage/alauda.c
@@ -951,7 +951,6 @@ static int alauda_read_data(struct us_da
 		unsigned int lba_offset = lba - (zone * uzonesize);
 		unsigned int pages;
 		u16 pba;
-		alauda_ensure_map_for_zone(us, zone);
 
 		/* Not overflowing capacity? */
 		if (lba >= max_lba) {
@@ -961,6 +960,8 @@ static int alauda_read_data(struct us_da
 			break;
 		}
 
+		alauda_ensure_map_for_zone(us, zone);
+
 		/* Find number of pages we can read in this block */
 		pages = min(sectors, blocksize - page);
 		len = pages << pageshift;

