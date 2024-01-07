Return-Path: <linux-kernel+bounces-18926-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 27477826533
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 18:00:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9C9A1F214EF
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 17:00:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E92913AE4;
	Sun,  7 Jan 2024 17:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RqHr65cn"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBB13134DA;
	Sun,  7 Jan 2024 17:00:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5372BC433C7;
	Sun,  7 Jan 2024 17:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704646833;
	bh=dliAwrpexB9Ja5rGo+n5Vqbsk8yWfBmlkRq0wah/zLY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=RqHr65cnT5K8xrdUuZhJ1t9yLb6Pj9Bn0t96M2XEPJUrEUhtLAjodTdGuw2JR1lQl
	 A3iOpF7asquLoE3TcbkuQB67HMCVM4XbPeABN7y6WsqDmPY13THwF2v6GPrvZPdhQ9
	 RNVCxQB9Wd9Wuf90CCxKCiqu2lzcSZhZBLNiyx8fI1uTy4QKnX56rkDqVLf8EOIXer
	 buCBaIdCqrlp0mOl4ATcz5wIEOhypTGpeqv+C9meXpct807e0SxBPP+L8AglkKylc5
	 wTZ/meiFKwtX2LFi7wHhJ0UizGzmjorGkBNNF+xjpUxfuMNOtndJoJ8yV8QUSr7u05
	 WKYlfWG7sO6DA==
Date: Sun, 7 Jan 2024 17:00:26 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Petre Rodan <petre.rodan@subdimension.ro>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, Lars-Peter
 Clausen <lars@metafoo.de>
Subject: Re: [PATCH 1/1] tools: iio: fix iio_generic_buffer
Message-ID: <20240107170026.6baccc49@jic23-huawei>
In-Reply-To: <ZZrRRNTUbXaDIgRU@sunspire>
References: <20240104101253.25896-1-petre.rodan@subdimension.ro>
	<20240104101253.25896-2-petre.rodan@subdimension.ro>
	<20240107155333.0e43b041@jic23-huawei>
	<ZZrRRNTUbXaDIgRU@sunspire>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.39; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 7 Jan 2024 18:28:52 +0200
Petre Rodan <petre.rodan@subdimension.ro> wrote:

> Hi Jonathan,
> 
> On Sun, Jan 07, 2024 at 03:53:33PM +0000, Jonathan Cameron wrote:
> > On Thu,  4 Jan 2024 12:12:45 +0200
> > Petre Rodan <petre.rodan@subdimension.ro> wrote:
> >   
> > > Fix code flow problem and floating point exception caused by improper
> > > directory stream positioning.
> > > 
> > > Fixes: <e58537ccce733> ("staging: iio: update example application.")
> > > Signed-off-by: Petre Rodan <petre.rodan@subdimension.ro>  
> > Hi Petre,
> > 
> > This doesn't really explain 'why' seeekdir(dp, 0) is wrong.
> > My assumption is that telldir() would not have returned 0 on this particular
> > system?  Could you confirm that and update the message to explain why
> > seekdir(dp, 0) is not equivalent to rewinddir(dp).  
> 
> it looks like there is a 32-bit specific bug in one of the glibc patches that
> the stable Gentoo Linux is using [1]. telldir returns (u32)(-1) if seekdir is
> used which ends up in a floating point exception.
> 
> it so happens that the rewinddir() function (which is equivalent) works
> correctly. so it is a fix for Gentoo users and should not impact anyone else.
> 
> [1] https://sourceware.org/bugzilla/show_bug.cgi?id=31212
> 
> my very best regards,
> peter

I'd be happy to take the same change as a cleanup if you want to resubmit it
with a different patch description.

Thanks,

Jonathan

> 
> > Thanks,
> > 
> > Jonathan
> >   
> > > ---
> > >  tools/iio/iio_utils.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/tools/iio/iio_utils.c b/tools/iio/iio_utils.c
> > > index 6a00a6eecaef..c5c5082cb24e 100644
> > > --- a/tools/iio/iio_utils.c
> > > +++ b/tools/iio/iio_utils.c
> > > @@ -376,7 +376,7 @@ int build_channel_array(const char *device_dir, int buffer_idx,
> > >  		goto error_close_dir;
> > >  	}
> > > 
> > > -	seekdir(dp, 0);
> > > +	rewinddir(dp);
> > >  	while (ent = readdir(dp), ent) {
> > >  		if (strcmp(ent->d_name + strlen(ent->d_name) - strlen("_en"),
> > >  			   "_en") == 0) {
> > > --
> > > 2.41.0  


