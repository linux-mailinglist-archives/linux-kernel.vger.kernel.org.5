Return-Path: <linux-kernel+bounces-53872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61DF984A77A
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 22:34:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94C3B1C27226
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 21:34:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FB1582D9C;
	Mon,  5 Feb 2024 19:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qju3/fpV"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E823982D7A
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 19:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707162670; cv=none; b=OCatOnhpphimyczcEPg0xjEbz8JG5Qi9GVbU3RIMlfMbP/qlM73LYkT4itWGjFMKyHoUQjct8QDvv2WfoviqPLovqCOroxpIzzz6OZnY6jR0ItByo4TgmnrXfJMAM/26Hlwch4VhSPZYRqcCiTgxFgJJT3VhalC95N/ISX4nnv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707162670; c=relaxed/simple;
	bh=32IgZ6ko36r/TNs5ZFOUk3nuGoF25Qi3GhszNhaTrPw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YbzlURrvDzzCfO7iWgm2zfxI5cTJeNVbUHF50MRhwnu+PNt6IijoEzFGM2LeVN4CrWuj490KemQpSDB+KScNjs3aKQfgq8313bMIoEulkT5rycXn1SPoqn10YPJa4NpFgrzr66RzjbGJ5zbc65H6/WGdBad0PSzxsK3xt+Bs9CY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Qju3/fpV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707162667;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+tpfnxQlLNRm4M5QzduLIpK2iI7KFV9K8AqzkgCNCjM=;
	b=Qju3/fpVcH5+N06D0jH0rfrjx3r4FvhdfehMY+dbBGVZjdlseSHPwxLlsdx7bHgGrsKb1D
	IJKpWpPo4oLL7BoX4FUcR4lKhNbY4WPvDtaeZpv/TSDQg6aizauDG2jDuerORDRikCZuk7
	CXtbxiYEYfiU40QL5vizOxUa8kFGfi4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-125-kdFpPILVOoydeVUitL3Emw-1; Mon, 05 Feb 2024 14:51:04 -0500
X-MC-Unique: kdFpPILVOoydeVUitL3Emw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0863F868A00;
	Mon,  5 Feb 2024 19:51:04 +0000 (UTC)
Received: from rhel-developer-toolbox-latest (unknown [10.2.16.180])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id C30A1492BF0;
	Mon,  5 Feb 2024 19:51:02 +0000 (UTC)
Date: Mon, 5 Feb 2024 11:51:00 -0800
From: Chris Leech <cleech@redhat.com>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Nilesh Javali <njavali@marvell.com>, Christoph Hellwig <hch@lst.de>,
	John Meneghini <jmeneghi@redhat.com>, Lee Duncan <lduncan@suse.com>,
	Mike Christie <michael.christie@oracle.com>,
	Hannes Reinecke <hare@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
	GR-QLogic-Storage-Upstream@marvell.com
Subject: Re: [PATCH v5 0/4] UIO_MEM_DMA_COHERENT for cnic/bnx2/bnx2x
Message-ID: <ZcE8JC0o9swkNzmr@rhel-developer-toolbox-latest>
References: <20240201233400.3394996-1-cleech@redhat.com>
 <5228a235-69f4-4a9b-8142-96d9b4a5a1c8@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5228a235-69f4-4a9b-8142-96d9b4a5a1c8@intel.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10

On Mon, Feb 05, 2024 at 05:57:58PM +0100, Alexander Lobakin wrote:
> From: Chris Leech <cleech@redhat.com>
> Date: Thu,  1 Feb 2024 15:33:56 -0800
> 
> > During bnx2i iSCSI testing we ran into page refcounting issues in the
> > uio mmaps exported from cnic to the iscsiuio process, and bisected back
> > to the removal of the __GFP_COMP flag from dma_alloc_coherent calls.
> 
> IIRC Jakub mentioned some time ago that he doesn't want to see
> third-party userspace <-> kernel space communication in the networking
> drivers, to me this looks exactly like that :z

This isn't something anyone likes, but it's an interface that's been in
the kernel and in use since 2009.  I'm trying to see if it can be fixed
"enough" to keep existing users functioning.  If not, maybe the cnic
interface and the stacking protocol drivers (bnx2i/bnx2fc) should be
marked as broken.

- Chris


