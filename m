Return-Path: <linux-kernel+bounces-97173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD94287667A
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 15:42:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF46C1C2141D
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 14:42:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62C46139B;
	Fri,  8 Mar 2024 14:42:15 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCB841370
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 14:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709908935; cv=none; b=dzzZSrTmxU761TR+FMMp+HOB2mIhR44H+YQsqXSwjsXNdH2wJpZTWXx0iEj9U+AV5WpQoypDK2MaeDnUqrd94VPr8/h6fMmZVO5HSqC9fHlyaCus870TBsSjhRyINr5acdso7d61yFbUUhmGCvFVry5qr9uFuwMoqNBgidLboSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709908935; c=relaxed/simple;
	bh=EwxiSaQ3mxim1g4ESG20w5W3vrSpmDdurPH4l285wYo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hGnl/sqV42HtajZ7/q6j58yhcy9gSaO6kOQ+oZEHTD8KXn1CKH+EFoI/r4dTLJ55NAK+nndc1p5De3xtGhZiKHD1PiSoaxaISfKI67uXKLUYWLs28R6f9rfJW8WHDsElQiVM6VLy6/js2rL62ReMLl718Wewph0OjxqicZv3JPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 6BC4D68BEB; Fri,  8 Mar 2024 15:42:08 +0100 (CET)
Date: Fri, 8 Mar 2024 15:42:08 +0100
From: Christoph Hellwig <hch@lst.de>
To: "brookxu.cn" <brookxu.cn@gmail.com>
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] nvme: fix reconnection fail due to reserved tag
 allocation
Message-ID: <20240308144208.GA9194@lst.de>
References: <20240308015435.100968-1-brookxu.cn@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240308015435.100968-1-brookxu.cn@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

The fix looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

But given that's we consolidate to a single place each for setting
up the tagsets for admin and I/O queues, what about just killing
the symbolic name and moving the assignments and comments directly
into the only users?


