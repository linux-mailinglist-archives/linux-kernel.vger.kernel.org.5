Return-Path: <linux-kernel+bounces-63019-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40A3385294D
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 07:43:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 680321C2332A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 06:43:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6891F179A1;
	Tue, 13 Feb 2024 06:42:48 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E9C81773E;
	Tue, 13 Feb 2024 06:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707806567; cv=none; b=qsQFrJP5sm+M++fWYe8o364eCHwCXjTJI+A+CuhGCSoKgmN5HXXihwIK8whlVBoamK70CKZJPL8WQPf9d/oTKUnXYlz4oU2ttqERvsNs4cx2U2cZe+MLR7agpm+FJ8GqMxC99tp76OgUImOyaw1JBphhPP086etR3dYK/FP7XHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707806567; c=relaxed/simple;
	bh=uC2tEYwBHe5RMliLRaXid2jZdO+0EXK8jN6VwjiNZEY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rJpWCNR0k7zV/uZykFOYrPX2uFZV6DST3lI7FDDPnHsw5JgX57DQM1sYQlWNnmtlih+7npiJnlufRhdMjBzkzLVQgDZjlhvzg6xZuVwNRM9wagXkAD68ZVuYhmorLKjGNEnXK8piNxSzkUNog6BhF4aJycA+GlxhW/kcTh1pXZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 3643D227A87; Tue, 13 Feb 2024 07:42:42 +0100 (CET)
Date: Tue, 13 Feb 2024 07:42:41 +0100
From: Christoph Hellwig <hch@lst.de>
To: John Garry <john.g.garry@oracle.com>
Cc: axboe@kernel.dk, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
	jejb@linux.ibm.com, martin.petersen@oracle.com, djwong@kernel.org,
	viro@zeniv.linux.org.uk, brauner@kernel.org, dchinner@redhat.com,
	jack@suse.cz, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	tytso@mit.edu, jbongio@google.com, linux-scsi@vger.kernel.org,
	ming.lei@redhat.com, ojaswin@linux.ibm.com, bvanassche@acm.org,
	Alan Adamson <alan.adamson@oracle.com>
Subject: Re: [PATCH v3 15/15] nvme: Ensure atomic writes will be executed
 atomically
Message-ID: <20240213064241.GC23305@lst.de>
References: <20240124113841.31824-1-john.g.garry@oracle.com> <20240124113841.31824-16-john.g.garry@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240124113841.31824-16-john.g.garry@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

If we don't end up doing the checks in the block layer:

> +	/*
> +	 * Ensure that nothing has been sent which cannot be executed
> +	 * atomically.
> +	 */
> +	if (req->cmd_flags & REQ_ATOMIC) {
> +		struct nvme_ns_head *head = ns->head;
> +		u32 boundary_bytes = head->atomic_boundary;

.. please split the checks into a helper.  And merge them into the
previous patch.


