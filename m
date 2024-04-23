Return-Path: <linux-kernel+bounces-154791-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCEA58AE10D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 11:32:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4FBCBB22ACD
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 09:32:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0459E58ABC;
	Tue, 23 Apr 2024 09:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WMswpRVE"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF9445820E
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 09:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713864731; cv=none; b=S/KcLLhz1kSR9f7sWAODXxKpjcJ6JNqVOKvtTvvwOUhiq73Z+fT4cxfUD9yZ9A9EI0iUKMmA9P3KfAhwKHMwpySDf6GNyjbs7OqTH6MnFeJo83lNqsn4UtjdRtJcZBCcyw6uXOlCuzfM9J7kNk/0ziI8YSDG0IiZZVmff2o1nmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713864731; c=relaxed/simple;
	bh=LdO/nreoe2L4sevFypjtMadn+EKT8D2kRiKGDBbpSy4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tV5s0aYLZ8cipoH2uNDPDmZyASQXu7+NRVMJNV92B7pRHepDnmntI3KCmZtPzkCPZ0Wt/ZNt6zxLrvfVxU+oDo3NFqhkOvY1HNgWxIIPtlZijOTSyUypcFMuVrj+cynVsIH0ppMQNHbFZxfut+ZjHPpEE0Qd0sZiRIV4AZb7b/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WMswpRVE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713864728;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rrBGJotUcgHqpi6O/DfS++qUvwL5rymvBmbeSDD6nCk=;
	b=WMswpRVEOFOgCSu0p6c3oraX6Lh6qC08172oIqZ0NuLXxN5oa7iL8Vd7A34dNotE/tyTb5
	ASS0lE2BJ/y+IYTJfvJjtKMLhwSZmjnGgZiizRSq2+lPPqN1kROOmORDqWdS6iVoQc5weo
	g/D6bGuP9/LeSFadAluamImELUV60Jc=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-26-q0-KX9-fNaebq4cliqmCCA-1; Tue, 23 Apr 2024 05:32:06 -0400
X-MC-Unique: q0-KX9-fNaebq4cliqmCCA-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-343ee356227so3557385f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 02:32:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713864726; x=1714469526;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rrBGJotUcgHqpi6O/DfS++qUvwL5rymvBmbeSDD6nCk=;
        b=Xzh/tG59dFqjQmrPO3i4bnDSeA23qibc33gO6/y9CWRWt6O/6z014Y8LkL0cJty2J4
         D3c22jBZbyUuxc02RLYDwwkVdjg7+DAsQbQpDCN273cCQpWK6XFWslvro0wtOnsSyaPM
         aCuAfi9Z5tAdS3A/4ZEzAriq8PZiM/YwpwimfHv7rcnSMbfRdNhx9wrcaqbjEw+iJLGt
         JFSsEtV/UU499/RikhZ2hEp2LPpHDGSnhlFC19ZeX5bSmlpR2YwpR+9Mm6LtX/fRpGQJ
         lmP34wwfmngOFnjAdkp3sObuk+3g7VvgCTasdUcOn73vKv0ecIkWv4wTQ3Dm3g69qizt
         0MFA==
X-Forwarded-Encrypted: i=1; AJvYcCU8TRYFOnU2ppAATwo7VApmFLG8/pEnODQe95WuxPHmBA/eHzP4U2I3i7EuyFROjgJQZ7Afn+ccVRBjjuQB1yVsE/3P4vWlo+BnTSZW
X-Gm-Message-State: AOJu0YwB/YWp5+TDkoiZlQGZQ4MyLDzGJqjpvvc9KfJMAz3+oqbBusZn
	DLpTE8ucz0JEd5AhnjVviioY9zS1OV31+ekYCwir6P00GetK/xi2Maq1AFDrVhLZP9UG8ppcl0W
	NFg+vRUXJar9YfEgeuS9G0R42hq45+LF75nIX/upuJ4h+GZSgJUFFMzcjh+V2Lw==
X-Received: by 2002:a05:6000:1291:b0:34b:4afc:5d52 with SMTP id f17-20020a056000129100b0034b4afc5d52mr2733446wrx.9.1713864725716;
        Tue, 23 Apr 2024 02:32:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH8P3x/S8bRNyl81Q2vOnuSsr15f1ZuacBaA2F08NubH2sSjaSh2fGkeB9/2DMmz8GUM0JX7Q==
X-Received: by 2002:a05:6000:1291:b0:34b:4afc:5d52 with SMTP id f17-20020a056000129100b0034b4afc5d52mr2733411wrx.9.1713864724960;
        Tue, 23 Apr 2024 02:32:04 -0700 (PDT)
Received: from redhat.com ([2a06:c701:7429:3c00:dc4a:cd5:7b1c:f7c2])
        by smtp.gmail.com with ESMTPSA id z14-20020adfe54e000000b00344a8f9cf18sm14193711wrm.7.2024.04.23.02.32.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Apr 2024 02:32:04 -0700 (PDT)
Date: Tue, 23 Apr 2024 05:32:01 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: David Hildenbrand <david@redhat.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
	Andrew Morton <akpm@linux-foundation.org>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>,
	Suren Baghdasaryan <surenb@google.com>
Subject: Re: linux-next: manual merge of the vhost tree with the mm tree
Message-ID: <20240423053045-mutt-send-email-mst@kernel.org>
References: <20240423145947.142171f6@canb.auug.org.au>
 <e07add5b-e772-4a8c-b71f-79f1fe74580a@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e07add5b-e772-4a8c-b71f-79f1fe74580a@redhat.com>

On Tue, Apr 23, 2024 at 10:21:55AM +0200, David Hildenbrand wrote:
> On 23.04.24 06:59, Stephen Rothwell wrote:
> > Hi all,
> > 
> > Today's linux-next merge of the vhost tree got a conflict in:
> > 
> >    drivers/virtio/virtio_mem.c
> > 
> > between commit:
> > 
> >    c22e503ced5b ("fix missing vmalloc.h includes")
> > 
> > from the mm-unstable branch of the mm tree and commit:
> > 
> >    4ba509048975 ("virtio-mem: support suspend+resume")
> > 
> > from the vhost tree.
> > 
> > I fixed it up (see below) and can carry the fix as necessary. This
> > is now fixed as far as linux-next is concerned, but any non trivial
> > conflicts should be mentioned to your upstream maintainer when your tree
> > is submitted for merging.  You may also want to consider cooperating
> > with the maintainer of the conflicting tree to minimise any particularly
> > complex conflicts.
> > 
> 
> Easy header conflict. @MST, @Andrew, do we simply want to take that
> virtio-mem patch via the MM tree to get rid of the conflict completely?

ok by me:

Acked-by: Michael S. Tsirkin <mst@redhat.com>

Andrew if you pick this let me know pls and I will drop it.

> -- 
> Cheers,
> 
> David / dhildenb


