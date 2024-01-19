Return-Path: <linux-kernel+bounces-30784-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 70970832455
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 06:47:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 273701F235BF
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 05:47:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71D9D4A34;
	Fri, 19 Jan 2024 05:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="D10owxLI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB24B6FB1;
	Fri, 19 Jan 2024 05:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705643236; cv=none; b=JIjEEaUNlgZXTByMMMjxmHcJdK2cYRrI56+MSbzh3hsFvmaeXXINTHfwuVXLPoDoRC2fyv8Tqkj1OCyZ5oriAPX8E3y8gsgoSUQxJ9I8kFYx9mef4JkRqueTgbbtxuHIryZUtWqxwfmglllscMtUNTCtpBuK5nW1cdGzplhDhNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705643236; c=relaxed/simple;
	bh=MNDvuNwiiy4+YlotPmen7Gor1toPlR5dd2opwcIDllI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GCw4I+NAoogBYKegmn/mY+s1cvdLsV1VCqD412emHEx4m9iHVEkHwrRMr9yHu9qovDZyxwiAhPRPi+e1g9xf12Se/QDBxWcqHMxsiuOwtvW0KoVGCEjPpXxBDIWtu848ATX2jQimZ69YGeY5kcmtSjRMGcBJa2asvqy9dcbQbWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=D10owxLI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FFC9C433C7;
	Fri, 19 Jan 2024 05:47:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705643236;
	bh=MNDvuNwiiy4+YlotPmen7Gor1toPlR5dd2opwcIDllI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=D10owxLIHodiEVHT3LPgLIOdoqbvjy5pjLddXK71vyCfPvYa/zohlwClepQHngu/e
	 ZzJgAurcNjaFM1b2oQwjlXOQg1VioPBsluBsWOhCqCtvFPNmRml7unBY2KURQpYGZr
	 QWCALOCSEfGjhmz4Z9ixFoAegq3yiOAqlJgKqaEU=
Date: Fri, 19 Jan 2024 06:47:13 +0100
From: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To: David Laight <David.Laight@aculab.com>
Cc: 'Sreenath Vijayan' <sreenath.vijayan@sony.com>,
	"john.ogness@linutronix.de" <john.ogness@linutronix.de>,
	"corbet@lwn.net" <corbet@lwn.net>,
	"jirislaby@kernel.org" <jirislaby@kernel.org>,
	"rdunlap@infradead.org" <rdunlap@infradead.org>,
	"pmladek@suse.com" <pmladek@suse.com>,
	"rostedt@goodmis.org" <rostedt@goodmis.org>,
	"senozhatsky@chromium.org" <senozhatsky@chromium.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
	"taichi.shimoyashiki@sony.com" <taichi.shimoyashiki@sony.com>,
	"daniel.palmer@sony.com" <daniel.palmer@sony.com>,
	"anandakumar.balasubramaniam@sony.com" <anandakumar.balasubramaniam@sony.com>
Subject: Re: [PATCH v3 2/2] tty/sysrq: Dump printk ring buffer messages via
 sysrq
Message-ID: <2024011958-coerce-niece-6301@gregkh>
References: <cover.1705331453.git.sreenath.vijayan@sony.com>
 <57daf43c5270f7532b269b9f0e90d126ca012354.1705331453.git.sreenath.vijayan@sony.com>
 <57f8c1f40ccc4a4f9d29e97f50a36b4f@AcuMS.aculab.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <57f8c1f40ccc4a4f9d29e97f50a36b4f@AcuMS.aculab.com>

On Thu, Jan 18, 2024 at 10:56:59PM +0000, David Laight wrote:
> From: Sreenath Vijayan
> > Sent: 17 January 2024 11:14
> ....
> >  /* Key Operations table and lock */
> >  static DEFINE_SPINLOCK(sysrq_key_table_lock);
> > 
> > @@ -505,7 +523,7 @@ static const struct sysrq_key_op *sysrq_key_table[62] = {
> >  	NULL,				/* A */
> >  	NULL,				/* B */
> >  	NULL,				/* C */
> > -	NULL,				/* D */
> > +	&sysrq_dmesg_dump_op,		/* D */
> >  	NULL,				/* E */
> >  	NULL,				/* F */
> >  	NULL,				/* G */
> 
> That looks like it ought to use C99 initialisers:
> 	['D' - 'A'] = &sysrq_dmesg_dump_op,
> 
> Possible with a #define to hide the offset.

Maybe in the future, but for now, let's leave it as-is please.

thanks,

greg k-h

