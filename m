Return-Path: <linux-kernel+bounces-70771-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 30446859C03
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 07:26:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA06A1F21684
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 06:25:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9D6D2030F;
	Mon, 19 Feb 2024 06:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="TCrIH9Ao"
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FC63208D7;
	Mon, 19 Feb 2024 06:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708323932; cv=none; b=hyT0xBrUz1+rEbFWEu3035Gdn71fSfpJ8vD6rxJ/e1SPqOANZcDEAnXM2axgVaVdFfM1JCXzEaj0VwAFmU6MpYsdciRyILHhVTq/VBNOcFgqPoWEXsQwPotgaMqUBKzSCXfKU/F+uAZ8FmzIJaa00Ayg6WQW9nRXWtlAseQe628=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708323932; c=relaxed/simple;
	bh=70Ay6BnT3v6YUlVpOlPdzbiXxgRhOAsAQxZhR1uZTMc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u4BodusGdPx5ug/sAYq/yQ9HE42gsnx1wOBGIDYYpxQXVhp4LHoEcraUfLYl8RQ8JTxLllmOmj8UVQ9BZY9SR9BRu4a+J0X6KsTAJC7xCH3TtZXBbRiE04ZxNsLCbXa6YzS2QeHJLqbNzlGzBQkuf3by+xsBAwh10THC4xBs6fA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=TCrIH9Ao; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 19 Feb 2024 01:25:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1708323927;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7d9J/jggDFvXefrkjiCWASipqQmLXrO/7brHX5k4i7E=;
	b=TCrIH9AoO0q1jih7sKPGtaXv5qAHPl5jLrMi26x+lpZwRDXT/lR26HrhrW9hB12r0tz/oc
	EsJ3dBUn2+fVuvoJuyNzS4mXYVwv2/bJpHdxsd8/kWPbWklXztq1DuorGHVLqZrf9k2CtS
	kWH+h8cc+IA5QdmLh2FRWACXLrx+ZoM=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Calvin Owens <jcalvinowens@gmail.com>, 
	Russell King <linux@armlinux.org.uk>, Dave Martin <Dave.Martin@arm.com>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	"linux-bcachefs@vger.kernel.org" <linux-bcachefs@vger.kernel.org>
Subject: Re: [PATCH] arm: Silence gcc warnings about arch ABI drift
Message-ID: <k6cclnrqu2h6mh4wb33hpakhfasq7jec7dnbaiaxlpw525adan@cor5l3bi35u2>
References: <fe51512baa18e1480ce997fc535813ce6a0b0721.1708286962.git.jcalvinowens@gmail.com>
 <431dd956-ad31-4da8-ad42-34f7380824bb@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <431dd956-ad31-4da8-ad42-34f7380824bb@app.fastmail.com>
X-Migadu-Flow: FLOW_OUT

On Mon, Feb 19, 2024 at 07:21:11AM +0100, Arnd Bergmann wrote:
> On Mon, Feb 19, 2024, at 05:09, Calvin Owens wrote:
> > 32-bit arm builds uniquely emit a lot of spam like this:
> >
> >     fs/bcachefs/backpointers.c: In function ‘extent_matches_bp’:
> >     fs/bcachefs/backpointers.c:15:13: note: parameter passing for 
> > argument of type ‘struct bch_backpointer’ changed in GCC 9.1
> >
> > Apply the arm64 change from commit ebcc5928c5d9 ("arm64: Silence gcc
> > warnings about arch ABI drift") to silence them. It seems like Dave's
> > original rationale applies here too.
> >
> > Cc: Dave Martin <Dave.Martin@arm.com>
> > Signed-off-by: Calvin Owens <jcalvinowens@gmail.com>
> > ---
> 
> I think these should be addressed in bcachefs instead.
> While it's not the fault of bcachefs that the calling
> convention changed between gcc versions, have a look at
> the actual structure layout:
> 
> struct bch_val {
>         __u64           __nothing[0];
> };
> struct bpos {
>         /*
>          * Word order matches machine byte order - btree code treats a bpos as a
>          * single large integer, for search/comparison purposes
>          *
>          * Note that wherever a bpos is embedded in another on disk data
>          * structure, it has to be byte swabbed when reading in metadata that
>          * wasn't written in native endian order:
>          */
> #if __BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__
>         __u32           snapshot;
>         __u64           offset;
>         __u64           inode;
> #elif __BYTE_ORDER__ == __ORDER_BIG_ENDIAN__
>         __u64           inode;
>         __u64           offset;         /* Points to end of extent - sectors */
>         __u32           snapshot;
> #else
> #error edit for your odd byteorder.
> #endif
> } __packed
> struct bch_backpointer {
>         struct bch_val          v;
>         __u8                    btree_id;
>         __u8                    level;
>         __u8                    data_type;
>         __u64                   bucket_offset:40;
>         __u32                   bucket_len;
>         struct bpos             pos;
> } __packed __aligned(8);
> 
> This is not something that should ever be passed by value
> into a function.

Why?

