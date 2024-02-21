Return-Path: <linux-kernel+bounces-75295-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2863685E5FF
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 19:29:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3A055B228C3
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 18:29:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15F438529C;
	Wed, 21 Feb 2024 18:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PKoaqBO5"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B769533F7
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 18:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708540139; cv=none; b=ElHyHVcyZe+yZDc3a8q5Tw21tTy9bYJ/uTW0vVXV/JxliBQuQAp54qB991b409JNiug5apd9bEDOgsrrH8/7OCLV4eXNbLejt8dt0qBtYTnZyIjbMZPg0euBL9kRec8HV9edanDW4XHsxU3+QBvtTxCM/3M5teT+JlzW4JeVTYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708540139; c=relaxed/simple;
	bh=WW7HccMmnxlLe5+R36X1kn/6bBjyn6Mj3hjctIdKLy4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tao/7qLBy00hONEkd/r+fQlTfWKWYOnN8BTZi5tLbmkukGSEoyvetiQ+fWpYpRjbekxUQNngtayqKtT02xp9IObJzjLdStfB/e96FHIWk9cs0RnSvZTuzQdf1VhLaL9r/alEldfHRHqb/6z1X9fEg2B7mON11AwvZKXA94Vni6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PKoaqBO5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708540136;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fl61rMDVYKSFPNkJ2EAe4MRHeQ5aYKO1cplhSodx/a8=;
	b=PKoaqBO5hj9c+lmWDJ+7zoZoPvNtZ6e7JIUr00wYD9+d0ggAmrF5trXajDvRA0KjwqeKKd
	B6wPCw+ryzGb/iGo+T+wDOAVndG1OF0n7z3NpfyyRLiUKyHGTe4904F3eLQzcNBIUHg840
	Wnln04GgJsLVCtCtZ8PX+15DeDnmGZ4=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-170-C4bKxuDaNM-zwiSkF50OtQ-1; Wed, 21 Feb 2024 13:28:52 -0500
X-MC-Unique: C4bKxuDaNM-zwiSkF50OtQ-1
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-2d2549572e7so8417371fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 10:28:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708540131; x=1709144931;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fl61rMDVYKSFPNkJ2EAe4MRHeQ5aYKO1cplhSodx/a8=;
        b=T7QLO3GCCQYhDPRFE1WTvnJHpPNzvxwet2fHmb+Awba25K7BW+q0SYRB7Zt2gN0v8X
         gxJQz2Hepe3oDCeSFK4T/sTXkpROzAnJRTxJOgt8Smr9ySpsOSg7puzWDOcK4w4By+zH
         o9fl22cqviIHwS9K+Z47d2ZiapHUghEaWksoaY6tQuW4VieVS24t8sgkrWljq8AZp+zR
         XFFN9cYrDmyRB9q1Fvcyx3bCQDEM+zwFliBCNAZSfyJTvrRKhwFXScJM09eHtsPBAVQo
         ZALnqYaNHmXD4q1fCutOdNtc9j4tAI238HY1pyKAWzQ508uLMSqd7JDt702Q05wgFX2p
         xJjg==
X-Forwarded-Encrypted: i=1; AJvYcCUiTATUK1an11XTkVVoa5NX/J4fW2nhlSpccC9WwyiuJHN/at1qvnnjVx1MkrB47G7BIxahzdGYWuOiGhNhH8PaFm0SC9frBilGVj0q
X-Gm-Message-State: AOJu0YxUCyb9lul1TK7GWpksIbmo8wfd0uLq6soscyBcFGpEhGUYS5ul
	+asI+JXsqLX9VlS7Ibw9WXDvyNFNG02d+Ye8bm0KZ7fW98EdnnNBq+vLy+ReqsDf10JxyXj+RGW
	4gFSU+piGWHqrw9XVdzl9VvVaZuj1k9lJAu6u3ZAUPljVGXjBw/EF29H/7jTR7U2HMwJk2S+Xmf
	N+noRE/SO9HE7CwYbCrC9XfjDq6o1pdAYkRq5t
X-Received: by 2002:a2e:9b52:0:b0:2d2:44cb:b0a3 with SMTP id o18-20020a2e9b52000000b002d244cbb0a3mr4236260ljj.48.1708540131387;
        Wed, 21 Feb 2024 10:28:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHH0Sp3pU7Tk9xr1Tr8/pddQaszA+lFG9scEelev2TBKiavPn7plzTtgEk+wdbqpEADlBK1v+sfcNRS+b8JxDQ=
X-Received: by 2002:a2e:9b52:0:b0:2d2:44cb:b0a3 with SMTP id
 o18-20020a2e9b52000000b002d244cbb0a3mr4236250ljj.48.1708540131061; Wed, 21
 Feb 2024 10:28:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240201233400.3394996-1-cleech@redhat.com>
In-Reply-To: <20240201233400.3394996-1-cleech@redhat.com>
From: Chris Leech <cleech@redhat.com>
Date: Wed, 21 Feb 2024 10:28:40 -0800
Message-ID: <CAPnfmXKMHXZw6SbPv36QcSpH_ZsWJ5iH+edR_tBWW4TBRYU_3w@mail.gmail.com>
Subject: Re: [PATCH v5 0/4] UIO_MEM_DMA_COHERENT for cnic/bnx2/bnx2x
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Nilesh Javali <njavali@marvell.com>
Cc: Christoph Hellwig <hch@lst.de>, John Meneghini <jmeneghi@redhat.com>, Lee Duncan <lduncan@suse.com>, 
	Mike Christie <michael.christie@oracle.com>, Hannes Reinecke <hare@kernel.org>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org, 
	GR-QLogic-Storage-Upstream@marvell.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I think all the feedback on these has been addressed, so I'm asking
once more if these UIO additions can be considered for inclusion.

Thanks,
- Chris

On Thu, Feb 1, 2024 at 3:34=E2=80=AFPM Chris Leech <cleech@redhat.com> wrot=
e:
>
> During bnx2i iSCSI testing we ran into page refcounting issues in the
> uio mmaps exported from cnic to the iscsiuio process, and bisected back
> to the removal of the __GFP_COMP flag from dma_alloc_coherent calls.
>
> The cnic uio interface also has issues running with an iommu enabled,
> which these changes correct.
>
> In order to fix these drivers to be able to mmap dma coherent memory via
> a uio device, introduce a new uio mmap type backed by dma_mmap_coherent.
>
> While I understand some complaints about how these drivers have been
> structured, I also don't like letting support bitrot when there's a
> reasonable alternative to re-architecting an existing driver. I believe
> this to be the most sane way to restore these drivers to functioning
> properly.
>
> There are two other uio drivers which are mmaping dma_alloc_coherent
> memory as UIO_MEM_PHYS, uio_dmem_genirq and uio_pruss.
> These drivers are converted in the later patches of this series.
>
> v5:
> - convert uio_pruss and uio_dmem_genirq
> - added dev_warn and comment about not adding more users
> - put some PAGE_ALIGNs back in cnic to keep checks in
>   uio_mmap_dma_coherent matched with uio_mmap_physical.
> - dropped the Fixes trailer
> v4:
> - re-introduce the dma_device member to uio_map,
>   it needs to be passed to dma_mmap_coherent somehow
> - drop patch 3 to focus only on the uio interface,
>   explicit page alignment isn't needed
> - re-add the v1 mail recipients,
>   this isn't something to be handled through linux-scsi
> v3 (Nilesh Javali <njavali@marvell.com>):
> - fix warnings reported by kernel test robot
>   and added base commit
> v2 (Nilesh Javali <njavali@marvell.com>):
> - expose only the dma_addr within uio and cnic.
> - Cleanup newly added unions comprising virtual_addr
>   and struct device
>
> previous threads:
> v1: https://lore.kernel.org/all/20230929170023.1020032-1-cleech@redhat.co=
m/
> attempt at an alternative change: https://lore.kernel.org/all/20231219055=
514.12324-1-njavali@marvell.com/
> v2: https://lore.kernel.org/all/20240103091137.27142-1-njavali@marvell.co=
m/
> v3: https://lore.kernel.org/all/20240109121458.26475-1-njavali@marvell.co=
m/
> v4: https://lore.kernel.org/all/20240131191732.3247996-1-cleech@redhat.co=
m/
>
> Chris Leech (4):
>   uio: introduce UIO_MEM_DMA_COHERENT type
>   cnic,bnx2,bnx2x: use UIO_MEM_DMA_COHERENT
>   uio_pruss: UIO_MEM_DMA_COHERENT conversion
>   uio_dmem_genirq: UIO_MEM_DMA_COHERENT conversion
>
>  drivers/net/ethernet/broadcom/bnx2.c          |  1 +
>  .../net/ethernet/broadcom/bnx2x/bnx2x_main.c  |  2 +
>  drivers/net/ethernet/broadcom/cnic.c          | 25 ++++++----
>  drivers/net/ethernet/broadcom/cnic.h          |  1 +
>  drivers/net/ethernet/broadcom/cnic_if.h       |  1 +
>  drivers/uio/uio.c                             | 47 +++++++++++++++++++
>  drivers/uio/uio_dmem_genirq.c                 | 22 ++++-----
>  drivers/uio/uio_pruss.c                       |  6 ++-
>  include/linux/uio_driver.h                    |  8 ++++
>  9 files changed, 89 insertions(+), 24 deletions(-)
>
>
> base-commit: 861c0981648f5b64c86fd028ee622096eb7af05a
> --
> 2.43.0
>


