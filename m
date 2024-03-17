Return-Path: <linux-kernel+bounces-105555-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD62587E01E
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 21:59:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 189101C20F5D
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 20:59:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BDB3208AF;
	Sun, 17 Mar 2024 20:59:42 +0000 (UTC)
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 8115C21103
	for <linux-kernel@vger.kernel.org>; Sun, 17 Mar 2024 20:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.131.102.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710709181; cv=none; b=b1dByBXkY64cjADsPZ5AKJtEdIZqR2M9LbmzfRGTCc5FRS4dfkGbSIO37CIyOXLrta6tdRg9HvNjb/YLVsUCWHiobRDrsZ05zeEzuR6aFBUjWLZjHJdPZTKYlXSut9UC75DlmTfAx0ceJsFPXFNbP8qb3pq5Rh6avGwHY+0WDXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710709181; c=relaxed/simple;
	bh=E46WGYTxVpxINiD796UEBciVP7zBrNW3GFOo+iEKT3A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qHj29RV2QR49QQmI44JvouLwHP8tcxRThOrl60xvFFezpotb9d/F8ZKE2gbq5zlLvBLUTwJ+UYvPKH1OIFLdoPHQPgn/5/NR4zegS4n5bFim6jRr9mEeBKtYC+PQ8vugI0Zxwau0nBcVvJc7dpvp6Uw0JLUM/0LuyBM0f78xa7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=rowland.harvard.edu; spf=pass smtp.mailfrom=netrider.rowland.org; arc=none smtp.client-ip=192.131.102.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netrider.rowland.org
Received: (qmail 555635 invoked by uid 1000); 17 Mar 2024 16:59:32 -0400
Date: Sun, 17 Mar 2024 16:59:32 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: xingwei lee <xrivendell7@gmail.com>
Cc: gregkh@linuxfoundation.org, usb-storage@lists.one-eyed-alien.net,
  linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
  samsun1006219@gmail.com, syzkaller-bugs@googlegroups.com
Subject: Re: divide error in alauda_transport
Message-ID: <6fa0a6e9-7123-4538-8a98-660a594e72d7@rowland.harvard.edu>
References: <CABOYnLw8=VM4LxgBsrwTi3HzdvGV7cYJU=4t7MMYTnrDCaDKAQ@mail.gmail.com>
 <cc7eb13f-b61d-4a4c-8c35-394a833d5917@rowland.harvard.edu>
 <CABOYnLx1pyG3qjoB9yuRPtDcb3TRbSqTktngXhkPq9UNVd4jLg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABOYnLx1pyG3qjoB9yuRPtDcb3TRbSqTktngXhkPq9UNVd4jLg@mail.gmail.com>

On Sun, Mar 17, 2024 at 11:57:58PM +0800, xingwei lee wrote:
> On Mar 17, 2024, at 23:04, Alan Stern <stern@rowland.harvard.edu> wrote:
> 
> On Sun, Mar 17, 2024 at 04:31:01PM +0800, xingwei lee wrote:
> 
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

> Hi Alan
> 
> I apply your patch in my upstream commit
> 9187210eee7d87eea37b45ea93454a88681894a4

> However, the poc still trigger the bug like below:

> [  146.141945][ T8215] divide error: 0000 [#1] PREEMPT SMP KASAN NOPTI
> [  146.143565][ T8215] CPU: 1 PID: 8215 Comm: usb-storage Not tainted
> 6.8.0-05202-g9187210eee7d-dirty #21
> [  146.145319][ T8215] Hardware name: QEMU Standard PC (i440FX + PIIX,
> 1996), BIOS 1.16.2-1.fc38 04/01/2014
> [  146.146720][ T8215] RIP: 0010:alauda_transport+0xc65/0x38b0

The line in your original bug report, alauda.c:954, was a call to 
alauda_ensure_map_for_zone(), which my patch moves to a different 
location so that a test for overflow can run first.  It's hard to tell 
whether the divide error occurs before the function call, within the 
function, or after.

Furthermore, alauda_ensure_map_for_zone() calls alauda_read_map(), and 
it's hard to tell if the divide error occurs before that function call 
or within the function.

Can you try adding some pr_info() statements to those places so we can 
determine exactly where the error occurs?  The only divisions that I see 
are by 2 or by uzonesize, which should always be nonzero.  Maybe you can 
print out the value of uzonesize so we can verify this.

Thanks,

Alan Stern

