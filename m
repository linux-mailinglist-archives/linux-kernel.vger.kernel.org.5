Return-Path: <linux-kernel+bounces-71048-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E39E859FFA
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 10:40:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A57C280C44
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 09:40:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EB4624B24;
	Mon, 19 Feb 2024 09:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="HXHbO1Ha"
Received: from out-176.mta0.migadu.com (out-176.mta0.migadu.com [91.218.175.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EC4D249E0
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 09:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708335611; cv=none; b=uPR0V8RbaTNUxtjit83pVd9T3QVAxJKyb0KlFCnUmCVbsWzfYrToQOdYBHCVNJ6istAtq8ewoYQCBUdRefPckiPoHDYStpw+IkzSeVJCFX84EPBEyVq4tf2ipdH5QK74NyXkJL9AEuGfE9UlVA8yVBWPPw+1Nh4OmxeF1TirXYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708335611; c=relaxed/simple;
	bh=iNShBvkReSuu3CObKikmHEsOyAXAVtv2YtxF61VShtk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gOYCpDgpN7hpOXKwOxKWrLRnYNJLz48ZJKMLSELmAItY969yN5JNIh8fsJWJwdcu7QsuVBKWjcsbcMnBJtkmXgbp4YVq9ci5hrFkqXgbTxBdMcVBtc+f99zzQnSb3UND8r3lXDlfFTPDGdfmEHNavl+pkfuiI92s/lVwepjqs/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=HXHbO1Ha; arc=none smtp.client-ip=91.218.175.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 19 Feb 2024 04:40:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1708335607;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZSvzriXmD4pK+Pgn1DkXZoJ6hH/hBfzEAXXtTbSS1J4=;
	b=HXHbO1HaXD3vfobQgbk+7mC2negYDTsMZEjy5mJ/qZMuSNKJjUvhQKC+EoIT+r75vI0ESD
	AxjQsKWW0H3YvwEu30cPRfi0az1/cD7aebrQOd/97d70JvCH9XylQFuCkCsxHTZ2sbaRsw
	BkEqvNHi97Y8p6skgyxGQVO7wPuByGY=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Arnd Bergmann <arnd@arndb.de>, Calvin Owens <jcalvinowens@gmail.com>, 
	Dave Martin <Dave.Martin@arm.com>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, 
	"linux-bcachefs@vger.kernel.org" <linux-bcachefs@vger.kernel.org>
Subject: Re: [PATCH] arm: Silence gcc warnings about arch ABI drift
Message-ID: <xs2splnjhlj257uca5yae64fp4solc4ugbxrkczoyd75n42r66@42boyzdcmyj4>
References: <fe51512baa18e1480ce997fc535813ce6a0b0721.1708286962.git.jcalvinowens@gmail.com>
 <431dd956-ad31-4da8-ad42-34f7380824bb@app.fastmail.com>
 <ZdMe24xN1Ej4QoVU@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZdMe24xN1Ej4QoVU@shell.armlinux.org.uk>
X-Migadu-Flow: FLOW_OUT

On Mon, Feb 19, 2024 at 09:26:51AM +0000, Russell King (Oracle) wrote:
> On Mon, Feb 19, 2024 at 07:21:11AM +0100, Arnd Bergmann wrote:
> > I think these should be addressed in bcachefs instead.
> > While it's not the fault of bcachefs that the calling
> > convention changed between gcc versions, have a look at
> > the actual structure layout:
> > 
> > struct bch_val {
> >         __u64           __nothing[0];
> > };
> > struct bpos {
> >         /*
> >          * Word order matches machine byte order - btree code treats a bpos as a
> >          * single large integer, for search/comparison purposes
> >          *
> >          * Note that wherever a bpos is embedded in another on disk data
> >          * structure, it has to be byte swabbed when reading in metadata that
> >          * wasn't written in native endian order:
> >          */
> > #if __BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__
> >         __u32           snapshot;
> >         __u64           offset;
> >         __u64           inode;
> > #elif __BYTE_ORDER__ == __ORDER_BIG_ENDIAN__
> >         __u64           inode;
> >         __u64           offset;         /* Points to end of extent - sectors */
> >         __u32           snapshot;
> > #else
> > #error edit for your odd byteorder.
> > #endif
> > } __packed
> > struct bch_backpointer {
> >         struct bch_val          v;
> >         __u8                    btree_id;
> >         __u8                    level;
> >         __u8                    data_type;
> >         __u64                   bucket_offset:40;
> >         __u32                   bucket_len;
> >         struct bpos             pos;
> > } __packed __aligned(8);
> > 
> > This is not something that should ever be passed by value
> > into a function.
> 
> +1 - bcachefs definitely needs fixing. Passing all that as an argument
> not only means that it has to be read into registers, but also when
> accessing members, it has to be extracted from those registers as well.
> 
> Passing that by argument is utterly insane.

If the compiler people can't figure out a vaguely efficient way to pass
a small struct by value, that's their problem - from the way you
describe it, I have to wonder at what insanity is going on there.

