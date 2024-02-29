Return-Path: <linux-kernel+bounces-87306-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B91786D27D
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 19:41:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F91E2823AD
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 18:41:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06C1B7D099;
	Thu, 29 Feb 2024 18:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YfcX++nt"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44E40160629
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 18:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709232098; cv=none; b=UtU8CbMjAa4PBCvFHB5h7Qd6JOW2D25ppMcbZbQ2tp3L7ULIdcg1tyw4pgB5QFjdzZvxF+7lS+IHTd22/UshrCT6TmjYCvyqkXpeFaVKb+xrv8te5gzmuzjoJdB3UgKoonu8o89k3IjNfXRcCxBrb19qii9QJP4gHPTD9gKbkTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709232098; c=relaxed/simple;
	bh=Fg9exPopaMXgoBeg3T8QjIb2dbC8fu4hOHN1ULOmBgg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E2vz25yuyun9Lcj4/FReFhMf28qk4Zs7rD6mNoqLLTcqX81UnTr33tijgcN/zb6OmbDEXP2scwPlznYwqMXm83c+HlySmuAI0/PeLLciwJIGDaIpV+CtK8IbEkJZzaCg8FpDfD48ZkUOGWDaQ5mYfCv3qbN+tw3sKkAcnHZIaGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YfcX++nt; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709232095;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=imfi9nyY2Ds1zTSvT7FW6iYVGAy7PqxovSx7W2kz8Yk=;
	b=YfcX++nt0xmIih3yaK/yWnJsxMVEIOqCFSKvuBuIp+d/LhauHFL/MOGeU/WUVHyxflAkuq
	zZpouo1b4nQBTF4DV816mPO82Kl4ULGtPG+2zZAUU9sla+Rux7jy1aUKjvwWZhDvN/+yJB
	MBqLbaWaXIoUPcm1zQn8ZCjUnn8nXSE=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-354-HBfG6nMvNqO1SbL0atuuFQ-1; Thu,
 29 Feb 2024 13:41:33 -0500
X-MC-Unique: HBfG6nMvNqO1SbL0atuuFQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5B75629AC011;
	Thu, 29 Feb 2024 18:41:33 +0000 (UTC)
Received: from bfoster (unknown [10.22.32.137])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 23E242166AE1;
	Thu, 29 Feb 2024 18:41:33 +0000 (UTC)
Date: Thu, 29 Feb 2024 13:43:15 -0500
From: Brian Foster <bfoster@redhat.com>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: linux-bcachefs@vger.kernel.org, linux-kernel@vger.kernel.org,
	djwong@kernel.org
Subject: Re: [PATCH 01/21] bcachefs: KEY_TYPE_accounting
Message-ID: <ZeDQQ8cyMTgYaY6D@bfoster>
References: <20240225023826.2413565-1-kent.overstreet@linux.dev>
 <20240225023826.2413565-2-kent.overstreet@linux.dev>
 <Zd4Ef49kHX3g69VT@bfoster>
 <t6cc6gqgla2csyvrsv2znel5lg76vx7t2zna772qpw7zd6pnft@rxdakxza5cab>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <t6cc6gqgla2csyvrsv2znel5lg76vx7t2zna772qpw7zd6pnft@rxdakxza5cab>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6

On Wed, Feb 28, 2024 at 02:39:38PM -0500, Kent Overstreet wrote:
> On Tue, Feb 27, 2024 at 10:49:19AM -0500, Brian Foster wrote:
> > On Sat, Feb 24, 2024 at 09:38:03PM -0500, Kent Overstreet wrote:
> > > New key type for the disk space accounting rewrite.
> > > 
> > >  - Holds a variable sized array of u64s (may be more than one for
> > >    accounting e.g. compressed and uncompressed size, or buckets and
> > >    sectors for a given data type)
> > > 
> > >  - Updates are deltas, not new versions of the key: this means updates
> > >    to accounting can happen via the btree write buffer, which we'll be
> > >    teaching to accumulate deltas.
> > > 
> > > Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
> > > ---
> > >  fs/bcachefs/Makefile                 |   3 +-
> > >  fs/bcachefs/bcachefs.h               |   1 +
> > >  fs/bcachefs/bcachefs_format.h        |  80 +++------------
> > >  fs/bcachefs/bkey_methods.c           |   1 +
> > >  fs/bcachefs/disk_accounting.c        |  70 ++++++++++++++
> > >  fs/bcachefs/disk_accounting.h        |  52 ++++++++++
> > >  fs/bcachefs/disk_accounting_format.h | 139 +++++++++++++++++++++++++++
> > >  fs/bcachefs/replicas_format.h        |  21 ++++
> > >  fs/bcachefs/sb-downgrade.c           |  12 ++-
> > >  fs/bcachefs/sb-errors_types.h        |   3 +-
> > >  10 files changed, 311 insertions(+), 71 deletions(-)
> > >  create mode 100644 fs/bcachefs/disk_accounting.c
> > >  create mode 100644 fs/bcachefs/disk_accounting.h
> > >  create mode 100644 fs/bcachefs/disk_accounting_format.h
> > >  create mode 100644 fs/bcachefs/replicas_format.h
> > > 
> > ...
> > > diff --git a/fs/bcachefs/disk_accounting_format.h b/fs/bcachefs/disk_accounting_format.h
> > > new file mode 100644
> > > index 000000000000..e06a42f0d578
> > > --- /dev/null
> > > +++ b/fs/bcachefs/disk_accounting_format.h
> > > @@ -0,0 +1,139 @@
> > > +/* SPDX-License-Identifier: GPL-2.0 */
> > > +#ifndef _BCACHEFS_DISK_ACCOUNTING_FORMAT_H
> > > +#define _BCACHEFS_DISK_ACCOUNTING_FORMAT_H
> > > +
> > > +#include "replicas_format.h"
> > > +
> > > +/*
> > > + * Disk accounting - KEY_TYPE_accounting - on disk format:
> > > + *
> > > + * Here, the key has considerably more structure than a typical key (bpos); an
> > > + * accounting key is 'struct disk_accounting_key', which is a union of bpos.
> > > + *
> > 
> > First impression.. I'm a little confused why the key type is a union of
> > bpos. I'm possibly missing something fundamental/obvious, but could you
> > elaborate more on why that is here?
> 
> How's this?
> 
>  * More specifically: a key is just a muliword integer (where word endianness   
>  * matches native byte order), so we're treating bpos as an opaque 20 byte                                                                                  
>  * integer and mapping bch_accounting_key to that.
> 

Hmm.. I think the connection I missed on first look is basically
disk_accounting_key_to_bpos(). I think what is confusing is that calling
this a key makes me think of bkey, which I understand to contain a bpos,
so then overlaying it with a bpos didn't really make a lot of sense to
me conceptually.

So when I look at disk_accounting_key_to_bpos(), I see we are actually
using the bpos _pad field, and this structure basically _is_ the bpos
for a disk accounting btree bkey. So that kind of makes me wonder why
this isn't called something like disk_accounting_pos instead of _key,
but maybe that is wrong for other reasons.

Either way, what I'm trying to get at is that I think this documentation
would be better if it explained conceptually how disk_accounting_key
relates to bkey/bpos, and why it exists separately from bkey vs. other
key types, rather than (or at least before) getting into the lower level
side effects of a union with bpos.

Brian


