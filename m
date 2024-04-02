Return-Path: <linux-kernel+bounces-127933-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 521878952F3
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 14:26:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3386281A3A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 12:26:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A653757EA;
	Tue,  2 Apr 2024 12:26:29 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB8BA762DC;
	Tue,  2 Apr 2024 12:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712060788; cv=none; b=AyIf4eGC6esLVrI20udvMGCWM+i7qlri0+dTIubDWy2wI2NjiRLJOwobCbJlBdCV7JQAUKoxdN5dSgMyDIn+jRPVPdw4w4+E5OIvhjraLSrf0zfF9w/Vds3wNP9iBH9C2+or+ojNZCSKhtse2uY3VeIWz2MpogVdvZjWPCY+Rdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712060788; c=relaxed/simple;
	bh=wRqxX1ZdzTg1ypcfFu9ZTj5oUiFKc90eBb8f5dzWCJ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=so4PYfJ3pdF1BOeADzHKgsT/MThlBPHMNwDiO2kzBk5tGA0Uo1ql184x5qV9I1uiV8ncKcnN8M5u4iof/W0+D8a/I6Yylq5Ph3M2khKrXnT2oeT/qo+xMrSkcv4bevTl+QbzvWMCb1VmoMO/ksXn0iIOFsHaCOx7bFMST9CUhpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 5C1BB68BFE; Tue,  2 Apr 2024 14:26:17 +0200 (CEST)
Date: Tue, 2 Apr 2024 14:26:17 +0200
From: Christoph Hellwig <hch@lst.de>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	eblake@redhat.com, Alasdair Kergon <agk@redhat.com>,
	Mikulas Patocka <mpatocka@redhat.com>, dm-devel@lists.linux.dev,
	David Teigland <teigland@redhat.com>,
	Mike Snitzer <snitzer@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Joe Thornber <ejt@redhat.com>
Subject: Re: [RFC 0/9] block: add llseek(SEEK_HOLE/SEEK_DATA) support
Message-ID: <20240402122617.GA30720@lst.de>
References: <20240328203910.2370087-1-stefanha@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240328203910.2370087-1-stefanha@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Mar 28, 2024 at 04:39:01PM -0400, Stefan Hajnoczi wrote:
> In the block device world there are similar concepts to holes:
> - SCSI has Logical Block Provisioning where the "mapped" state would be
>   considered data and other states would be considered holes.

But for SCSI (and ATA and NVMe) unmapped/delallocated/etc blocks do
not have to return zeroes.  They could also return some other
initialization pattern pattern.  So they are (unfortunately) not a 1:1
mapping to holes in sparse files.


