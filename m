Return-Path: <linux-kernel+bounces-41973-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCF9683FA2C
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 22:43:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF8731C217E2
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 21:43:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D692A3D0D1;
	Sun, 28 Jan 2024 21:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="V0MskSaK"
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09CF53CF44
	for <linux-kernel@vger.kernel.org>; Sun, 28 Jan 2024 21:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706478224; cv=none; b=QUSuhVsNHoJyCpRykyTDJ7NcE8PhjT5G5SXr/LXw9K3tEpolKY9a/tYQvBO8fh37uljcFQVgvlUqUhKnel7jMsWRI4KsoBDL6H4Q8HiCONq7I41gr+Lnxxf6pHq+iaEcoM2399IIWMTcvIpfCWjTAkiLspibnUyRTPSyJSEFLRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706478224; c=relaxed/simple;
	bh=fCpJiqdtuWKBoG7GGVcaI0FoNRVzqpcV3oHlBKkdDL4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RFShngDhoIkF0qABpmNpx/8OecamVvg77QvNqz4OysszS6V7SU2tcqfvB4Fgw8ZQNCOSPJp1+nTpGzKGyrN5Ls8Y3j0pPlKh3iBs1oPL/tcCWxxl9egWKRkhOgYNT0lY2LA5dp/IdRY5MttLee+usPXSvBpN32uBVzdAMk3Slhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=V0MskSaK; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=aghjsdpgYLrBmeFGIcuf20C/nLugWVgTOFrP/6xOIEs=; b=V0MskSaKTsO8xEB8tJEE9+PzvF
	2fGBIT/id35FGmxoT0omRDpShoANGRKKxKbRjS8HYMTRUXjH5Y52/q8LmHJmHeZbO1fIF12DDWq9H
	u2POCXQJ7JYG3lVMXWC9MmpF7qnNspnjyLqj0jwAlV0I4fUB7ESoWso87NuQ6p1HURiIfhs6EbqKp
	hTgSGDHY5beR68JWbG1ylIRNRgZmXCFEEyGUW3w+MxvySjfV1ZTmn+ekrtWvNx6v/T2cN5kOiD0fe
	xXQL1FtzTzDXyachqbXB91NoOPPG2270hjTqo8vKktnhxH/auETVz6IRknBV1Er/bK8TvZg1GtF1H
	8Zyd0muQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rUCwB-00HY2h-2v;
	Sun, 28 Jan 2024 21:43:36 +0000
Date: Sun, 28 Jan 2024 21:43:35 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Hillf Danton <hdanton@sina.com>
Cc: syzbot <syzbot+da4f9f61f96525c62cc7@syzkaller.appspotmail.com>,
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [overlayfs?] possible deadlock in seq_read_iter (2)
Message-ID: <20240128214335.GE2087318@ZenIV>
References: <0000000000008efd70060ce21487@google.com>
 <20240127114610.961-1-hdanton@sina.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240127114610.961-1-hdanton@sina.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Sat, Jan 27, 2024 at 07:46:10PM +0800, Hillf Danton wrote:
> On Tue, 19 Dec 2023 11:43:27 -0800
> > syzbot has found a reproducer for the following issue on:
> > 
> > HEAD commit:    2cf4f94d8e86 Merge tag 'scsi-fixes' of git://git.kernel.or..
> > git tree:       upstream
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=154aa8d6e80000
> 
> #syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git  2cf4f94d8e86
> 
> --- x/fs/namei.c
> +++ y/fs/namei.c
> @@ -3533,6 +3533,8 @@ static const char *open_last_lookups(str
>  
>  	if (open_flag & (O_CREAT | O_TRUNC | O_WRONLY | O_RDWR)) {
>  		got_write = !mnt_want_write(nd->path.mnt);
> +		if (!got_write && (open_flag & O_CREAT))
> +			return ERR_PTR(-EISDIR);

NAK.

Please, RTFComment just below your addition.  Besides, EISDIR is
obviously bogus in a lot of cases, starting with attempting to
create a new file on a read-only filesystem.  Surely
echo bugger > /mnt/cdrom/no_such_file_there
should *not* fail with "no_such_file_there: Is a directory"?

