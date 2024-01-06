Return-Path: <linux-kernel+bounces-18694-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D76B826123
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 19:54:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4AD0D1C2117E
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 18:54:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ABF2E575;
	Sat,  6 Jan 2024 18:54:38 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from cae.in-ulm.de (cae.in-ulm.de [217.10.14.231])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1722CE541
	for <linux-kernel@vger.kernel.org>; Sat,  6 Jan 2024 18:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c--e.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=c--e.de
Received: by cae.in-ulm.de (Postfix, from userid 1000)
	id 407181401B4; Sat,  6 Jan 2024 19:54:26 +0100 (CET)
Date: Sat, 6 Jan 2024 19:54:26 +0100
From: "Christian A. Ehrhardt" <lk@c--e.de>
To: Tigran Aivazian <aivazian.tigran@gmail.com>
Cc: Xiaochen Zou <xzou017@ucr.edu>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs/bfs: Null check to prevent null-ptr-deref bug
Message-ID: <ZZmh4rdZzj4YgrOG@cae.in-ulm.de>
References: <20240105193331.1180331-1-xzou017@ucr.edu>
 <CAK+_RLm93haEd13Z0hVPSRqG4STsDHMHfu4FBdaBW1QP0m_c6w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK+_RLm93haEd13Z0hVPSRqG4STsDHMHfu4FBdaBW1QP0m_c6w@mail.gmail.com>


Hi,

On Sat, Jan 06, 2024 at 08:38:02AM +0000, Tigran Aivazian wrote:
> Hello,
> 
> On Fri, 5 Jan 2024 at 19:33, Xiaochen Zou <xzou017@ucr.edu> wrote:
> > Similar to ea2b62f3058 (fs/sysv: Null check to prevent
> > null-ptr-deref bug), bfs is lack of return value check for
> > sb_getblk(). Adding a null check to prevent null-ptr-defer bug
> 
> > diff --git a/fs/bfs/file.c b/fs/bfs/file.c
> > index adc2230079c6..35688424bde3 100644
> > --- a/fs/bfs/file.c
> > +++ b/fs/bfs/file.c
> > @@ -39,6 +39,8 @@ static int bfs_move_block(unsigned long from, unsigned long to,
> >         if (!bh)
> >                 return -EIO;
> >         new = sb_getblk(sb, to);
> > +       if (unlikely(!new))
> > +               return -ENOMEM;
> 
> Thank you, yes, that makes sense. Please apply the patch.

What's with the bh in this case? Wouldn't we need a brelse or something?

> 
> Acknowledged-By; Tigran Aivazian <aivazian.tigran@gmail.com>
> 
> 

regards   Christian


