Return-Path: <linux-kernel+bounces-137778-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 12F0789E6FD
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 02:40:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2A8F1F221FD
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 00:40:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79CF2A55;
	Wed, 10 Apr 2024 00:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nZMj6yha"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B188938F;
	Wed, 10 Apr 2024 00:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712709650; cv=none; b=f3Z+XQtzDzylegnP3nSskBG8ZpRHSKm403TkpqBGg0ey499LWBS6ld1+ksBlOb8xbcV1JKUmgST4F4vgQGqiL7NhVc1uBx0vN31QwVqNMQu0+CQy+nxa1XwOcw3NilNrsfNOLS+d2f1zkzlLhNU/8WDbAUcYv3tDMqXXbgWagZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712709650; c=relaxed/simple;
	bh=cNDBDCOlR3wvzU4N2h7QYqddvVul6slsihlZgPXf2mI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=deFKTzr3nE1PNjlEck9FbMph88SNwa4ao+hhqJWS7iBi6ljp/GygGBu2xwlnMBXvz6C2uMZvPjOHW+yaezB11Q95cOsJ2VN8aym1ixRjK7jkw5PhTkWV91rnvx6ZXcGr2LRzfxG8x5yk4giJe6UxM0ShqFh5wIVajhyPIR4x7IE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nZMj6yha; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D964C433C7;
	Wed, 10 Apr 2024 00:40:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712709650;
	bh=cNDBDCOlR3wvzU4N2h7QYqddvVul6slsihlZgPXf2mI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nZMj6yhaheTRBHPsH0YXKapB66D4S2cJ0mpvzSIpBlZH8f0+V8UrPonQF4aR/uPfU
	 cWhtNbTnuBTjnAYIxagduGjw3LKi6YbQfmbqfnvxMYIM89FCYyQWrTe8L4+3gMBXRH
	 +DEG+LanPaTjfbt8/diqqyE2fJC5kigbs7tbbMoQ/PkqeMQkYZwbzlfKYLb+I/Obf0
	 QDinWLz5WSCeMv7Xx0nKicjKqT6jBbcGXbmU5F8ZzS2U/Uacanc4O8h+UOU95/RNVy
	 JmulJgGBLFNtjLFfTx1DVMUt28maX3g2iZbQ9UH4FpTYbtdoO8NvgF7hAYYtV575KF
	 qx86CcSp3+Psg==
Date: Tue, 9 Apr 2024 17:40:49 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Justin Stitt <justinstitt@google.com>
Cc: Christoph Hellwig <hch@infradead.org>,
	Chandan Babu R <chandan.babu@oracle.com>, linux-xfs@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] xfs: xattr: replace strncpy and check for truncation
Message-ID: <20240410004049.GT6390@frogsfrogsfrogs>
References: <20240405-strncpy-xattr-split2-v1-1-90ab18232407@google.com>
 <ZhVDgbRoF9X7JSdt@infradead.org>
 <CAFhGd8pwoBSvLDRLX8ekRk+u9uX6s6mcAfTz8E15E6EBsvuSag@mail.gmail.com>
 <CAFhGd8qwCwycW=PpUWUGxAdU54jwi9D=k3xrNgC62CvM-Q+ukg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFhGd8qwCwycW=PpUWUGxAdU54jwi9D=k3xrNgC62CvM-Q+ukg@mail.gmail.com>

On Tue, Apr 09, 2024 at 05:27:34PM -0700, Justin Stitt wrote:
> On Tue, Apr 9, 2024 at 5:23 PM Justin Stitt <justinstitt@google.com> wrote:
> >
> > Hi,
> >
> > On Tue, Apr 9, 2024 at 6:32 AM Christoph Hellwig <hch@infradead.org> wrote:
> > >
> > > On Fri, Apr 05, 2024 at 07:45:08PM +0000, Justin Stitt wrote:
> > > > -     memcpy(offset, prefix, prefix_len);
> > > > -     offset += prefix_len;
> > > > -     strncpy(offset, (char *)name, namelen);                 /* real name */
> > > > -     offset += namelen;
> > > > -     *offset = '\0';
> > > > +
> > > > +     combined_len = prefix_len + namelen;
> > > > +
> > > > +     /* plus one byte for \0 */
> > > > +     actual_len = scnprintf(offset, combined_len + 1, "%s%s", prefix, name);
> > > > +
> > > > +     if (actual_len < combined_len)
> > >
> > > Shouldn't this be a != ?
> >
> > I guess it could be. It's a truncation check so I figured just
> > checking if the amount of bytes actually copied was less than the
> > total would suffice.
> >
> > >
> > > That being said I think this is actually wrong - the attr names are
> > > not NULL-terminated on disk, which is why we have the explicit
> > > zero terminataion above.
> >
> > Gotcha, in which case we could use the "%.*s" format specifier which
> > allows for a length argument. Does something like this look better?
> >
> > diff --git a/fs/xfs/xfs_xattr.c b/fs/xfs/xfs_xattr.c
> > index 364104e1b38a..1b7e886e0f29 100644
> > --- a/fs/xfs/xfs_xattr.c
> > +++ b/fs/xfs/xfs_xattr.c
> > @@ -206,6 +206,7 @@ __xfs_xattr_put_listent(
> >  {
> >   char *offset;
> >   int arraytop;
> > + size_t combined_len, actual_len;
> >
> >   if (context->count < 0 || context->seen_enough)
> >   return;
> > @@ -220,11 +221,16 @@ __xfs_xattr_put_listent(
> >   return;
> >   }
> >   offset = context->buffer + context->count;
> > - memcpy(offset, prefix, prefix_len);
> > - offset += prefix_len;
> > - strncpy(offset, (char *)name, namelen); /* real name */
> > - offset += namelen;
> > - *offset = '\0';
> > +
> > + combined_len = prefix_len + namelen;
> > +
> > + /* plus one byte for \0 */
> > + actual_len = scnprintf(offset, combined_len + 1, "%.*s%.*s",
> > +        prefix_len, prefix, namelen, name);
> > +
> > + if (actual_len < combined_len)
> > + xfs_warn(context->dp->i_mount,
> > + "cannot completely copy context buffer resulting in truncation");
> >
> >  compute_size:
> >   context->count += prefix_len + namelen + 1;
> > ---
> 
> I copy pasted from vim -> gmail and it completely ate all my tabs.
> When I actually send the new patch, if needed, it will be formatted
> correctly :)

Yeah, the "%.*s" version looks better.

> >
> >
> >
> > >
> > > How was this tested?
> >
> > With https://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git/about/
> >
> > but using scripts + image from: https://github.com/tytso/xfstests-bld
> >
> > here's the output log: https://pastebin.com/V2gFhbNZ wherein I ran the
> > 5 default ones (I think?):
> >
> > |        Ran: generic/475 generic/476 generic/521 generic/522 generic/642
> > |        Passed all 5 tests

Would you mind adding "-g attr,label" into the mix so that you're running all
the functional tests for xattr and fs label functionality?

--D

> >
> > Thanks
> > Justin
> 

