Return-Path: <linux-kernel+bounces-40338-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DFE3083DEBB
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 17:30:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BBF71C23AA7
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 16:30:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81D611DDF1;
	Fri, 26 Jan 2024 16:30:12 +0000 (UTC)
Received: from shin.romanrm.net (shin.romanrm.net [146.185.199.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC53D1D69B;
	Fri, 26 Jan 2024 16:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=146.185.199.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706286612; cv=none; b=YcieeiZOtyp4Ygyx5qEDXaQxxvHgAm8C0XBj1EyZhptAnzCfKVg/e/w+7u6hAKtnngGWQW7Rzj3bE3B2t9iY3u88tL+daaUnpnCfnxaYvYoJTOPfZuFvJpkIwEqPpPB4ScbbzXuWlv0+obMSnxa4CG/kw9YD9aaVlwCE+LSqCE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706286612; c=relaxed/simple;
	bh=juwBFU+dDgaSzOGfV33Nf3WE1fOrDnyv59tl7BpARXk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jepdFjIo0swIv1i74QHaeI/N8K7Ti2mIXVaZDcOXuynI5DoPET6ueVJwxisxiTxrmoBz27y91A0zaCjqY6YuYZZvCqqMVqOg6pCTmrH8YWufsb4LMocAwuvcexdsgy6CNofasNFYGWfqhrIbkEei2MGvwwB60qI/oiMS4RMXXg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=romanrm.net; spf=pass smtp.mailfrom=romanrm.net; arc=none smtp.client-ip=146.185.199.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=romanrm.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=romanrm.net
Received: from nvm (unknown [IPv6:fd39::4a:3cff:fe57:d6b5])
	by shin.romanrm.net (Postfix) with SMTP id 92F0040BAA;
	Fri, 26 Jan 2024 16:21:55 +0000 (UTC)
Date: Fri, 26 Jan 2024 21:21:50 +0500
From: Roman Mamedov <rm@romanrm.net>
To: Carlos Carvalho <carlos@fisica.ufpr.br>
Cc: Dan Moulding <dan@danm.net>, junxiao.bi@oracle.com,
 gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
 linux-raid@vger.kernel.org, regressions@lists.linux.dev, song@kernel.org,
 stable@vger.kernel.org, yukuai1@huaweicloud.com
Subject: Re: [REGRESSION] 6.7.1: md: raid5 hang and unresponsive system;
 successfully bisected
Message-ID: <20240126212150.4b56ae05@nvm>
In-Reply-To: <ZbMnZnvyIyoWeIro@fisica.ufpr.br>
References: <2ef7d741-3df8-402a-967f-53ec77c73e2c@oracle.com>
	<20240125203130.28187-1-dan@danm.net>
	<ZbMnZnvyIyoWeIro@fisica.ufpr.br>
X-Mailer: Claws Mail 3.11.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 26 Jan 2024 00:30:46 -0300
Carlos Carvalho <carlos@fisica.ufpr.br> wrote:

> Dan Moulding (dan@danm.net) wrote on Thu, Jan 25, 2024 at 05:31:30PM -03:
> > I then created an ext4 file system on the "data" volume, mounted it, and used
> > "dd" to copy 1MiB blocks from /dev/urandom to a file on the "data" file
> > system, and just let it run. Eventually "dd" hangs and top shows that
> > md0_raid5 is using 100% CPU.
> 
> It's known that ext4 has these symptoms with parity raid. To make sure it's a
> raid problem you should try another filesystem or remount it with stripe=0.

If Ext4 wouldn't work properly on parity RAID, then it is a bug that should be
tracked down and fixed, not worked around by using a different FS. I am in
disbelief you are seriously suggesting that, and to be honest really doubt
there is any such high-profile "known" issue that stays unfixed and is just
commonly worked around.

-- 
With respect,
Roman

