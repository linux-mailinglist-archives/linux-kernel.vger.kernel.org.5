Return-Path: <linux-kernel+bounces-47189-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CBBD844A50
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 22:45:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F3A71C25BD8
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 21:45:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3292539AFC;
	Wed, 31 Jan 2024 21:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PTGyIgiq"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA74239AE8
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 21:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706737509; cv=none; b=r6sy7wGm3SHaZdEGn+ssKkEd3n26G5NLb4mCVJJsmQa99kt4zpgqhm5DrXl6n5j+XoTFzr/LsUrW2smxMxMtcbjqi7X+u/Mv7Br7Y3uRs3hGNM07EWsTe60H3Tjo+u8Dk6Lbl96/zYBB6+MnRbrfMoyycvAaelf9wnpxOvEEJOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706737509; c=relaxed/simple;
	bh=RNO5W0OP+zOfgTSimLFGWc0A4ecEarSa4TiMbXZZvIs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qVbqn9xWaQdxLmDZegw+T8TBsn7dGqxNxT4ft0JhiOPokLeKnYO8iwxVs3GO3Ve1dGRuhwzEZqHmOrdSWGDcWNU/QC3OsyQvxDAwMzCCtjjEWkRBmaGxHTRfbjVJiqXo+ANDYKz5TGg2hnP7CIagwnQzZHHBgQFUrl9SujjzKVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PTGyIgiq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706737506;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7dbCchYRiPga9CCVNutbEbzEx6jSnpAXwCYBNUJ7928=;
	b=PTGyIgiqfzGHIXHjD7mq8aock1j2dMZxNW/68eI7/i5jlbf78lDm1toZygFzd7dwzavgRn
	5nDCPRHQCFIto+MB51PP+B5cfi0JyrwnmfdwgYOhNX3i5xnjA6f0bMLSORFIceM7JnHsKl
	EOPKBhYQ3qu6vixrBSwjKD4AkqJcg4Q=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-192-DVs2aktzOIOW9Noo_NFuoQ-1; Wed, 31 Jan 2024 16:45:03 -0500
X-MC-Unique: DVs2aktzOIOW9Noo_NFuoQ-1
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-2cf30de8dd8so2367321fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 13:45:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706737501; x=1707342301;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7dbCchYRiPga9CCVNutbEbzEx6jSnpAXwCYBNUJ7928=;
        b=TIPwaFjfL2vyQfUZQNnRa2o/fg88kmLQAhDlhgbK/HVRCwrS4zplmItDSPSEwpJQWz
         kDqAMyJ1kZ4NKNcGoErn1xxNntxPKnAzZHAoP/4/9P9YwaU17tm2HG995sQp5oEajyrl
         oqrlSn6ABf55wfEDNztX1U1ejj7r5OfWixhbQnRdpAorpPNx9UHCGHfc0jstPrVdF5xi
         ITjvHP1AyLUlMlVtYX9IVrbQK1c2GxES0QmWN/6HDnGiUMn1b4Wx35PVs52VmWYzmQx0
         aBsAbRYaJ3pAC/9ZDgtKlGcTfEFNC2ixKJ5CuG7NxBueowG0aQubA2g6kWTUNJsq+s9h
         y6vw==
X-Gm-Message-State: AOJu0YzXyc1ncTl+lvGQOTMjCZc8J284FhAn3IUsJv+MbUk4rn0J4iZB
	a3Dnr6LZr/yV+Hi7hJSUstmf8ZK0r+uXlZw6vp+TfZfCr5WbWzTe4DX6me32T6H9+fBXSnnG7MN
	TN7gNjdoxtQLvZw2gjf9nyRrNBkfywvJD7NrIONDlZVU2byKRQkwWbwHQfYPNg/fmHa7LFG/Fja
	Mq3xMRO/kM9iuIzc1jEXybPWGJfwQOHrzjgkCZyfgPmQcv3II=
X-Received: by 2002:a2e:8553:0:b0:2cf:3324:cedd with SMTP id u19-20020a2e8553000000b002cf3324ceddmr2282113ljj.24.1706737501757;
        Wed, 31 Jan 2024 13:45:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF4WSR9c2pT9GcR96S25SGMyV9IZm76XurE8FEjz5Uxf6I4GCo5Gdvvm8H5SrOpe9xqbYz5TXh0mtvDtkpATcA=
X-Received: by 2002:a2e:8553:0:b0:2cf:3324:cedd with SMTP id
 u19-20020a2e8553000000b002cf3324ceddmr2282099ljj.24.1706737501453; Wed, 31
 Jan 2024 13:45:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240131191732.3247996-1-cleech@redhat.com> <20240131191732.3247996-2-cleech@redhat.com>
 <2024013110-greasily-juvenile-73fc@gregkh>
In-Reply-To: <2024013110-greasily-juvenile-73fc@gregkh>
From: Chris Leech <cleech@redhat.com>
Date: Wed, 31 Jan 2024 13:44:50 -0800
Message-ID: <CAPnfmX+c_TECfVgbAgphFgkCOr-=tKEvHmcxPg_vSY-qJRqaQQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] uio: introduce UIO_MEM_DMA_COHERENT type
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Nilesh Javali <njavali@marvell.com>, Christoph Hellwig <hch@lst.de>, 
	John Meneghini <jmeneghi@redhat.com>, Lee Duncan <lduncan@suse.com>, 
	Mike Christie <michael.christie@oracle.com>, Hannes Reinecke <hare@kernel.org>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org, 
	GR-QLogic-Storage-Upstream@marvell.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 31, 2024 at 1:29=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Wed, Jan 31, 2024 at 11:17:31AM -0800, Chris Leech wrote:
> > Add a UIO memtype specifically for sharing dma_alloc_coherent
> > memory with userspace, backed by dma_mmap_coherent.
> >
> > This is mainly for the bnx2/bnx2x/bnx2i "cnic" interface, although ther=
e
> > are a few other uio drivers which map dma_alloc_coherent memory and
> > could be converted to use dma_mmap_coherent as well.
>
> What other drivers could use this?  Patches doing the conversion would
> be welcome, otherwise, again, I am very loath to take this
> one-off-change for just a single driver that shouldn't be doing this in
> the first place :)

uio_pruss and uio_dmem_genirq both appear to mmap dma_alloc_coherent
memory as UIO_MEM_PHYS.  It might not be an issue on that platforms
where those are used, but I'd be happy to include untested patches to
convert them for better adherence to the DMA APIs.

(sorry for the double send on this Greg, missed the reply-all)

- Chris


