Return-Path: <linux-kernel+bounces-3274-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A4EF6816A3A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 10:51:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61F3128201E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 09:51:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D841F12B9D;
	Mon, 18 Dec 2023 09:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BxCsjQnu"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21C0C12B61;
	Mon, 18 Dec 2023 09:51:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BECF6C433C8;
	Mon, 18 Dec 2023 09:51:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702893102;
	bh=0ltLchd8OdyqGdbUKNCnj2CSZ8BI8m8JXNh7/DpT4q4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=BxCsjQnuJnhh0O1R4P1jparwYYvwuJzUuts6R9qqR4wY0ZeR5eIdS4bVLOC3EMYJJ
	 BoNRgH9yCu1zFqd3LLzgK0zPtMOLNLbFZHNMmde2Pk9uWDlZcyYUwWCoGkWamIj7z+
	 6rpUoxGi/7Dezk78J9tb+fqCtwrVgkcgKlv4uAYpoF3EewrSfEDGhTfzhUFIDrJCpj
	 /rkjWbHMaVlrNZ0o5NVjhXyj6Av1WNDiETUSkftHjyCb/1JHmJmwomRMHYhW23/dPF
	 a6basN5WJgoh0KWx5ED+pMlx2XZ+osDMzmdwFSeSiaUlHW4oCGvwgJVT6ls7VRD6tS
	 +zPJRqAvMhajw==
Message-ID: <572219b1-c528-475f-9219-8027a3790563@kernel.org>
Date: Mon, 18 Dec 2023 18:51:40 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] sd: only call disk_clear_zoned when needed
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi
 <stefanha@redhat.com>, "Martin K. Petersen" <martin.petersen@oracle.com>,
 dm-devel@lists.linux.dev, linux-kernel@vger.kernel.org,
 virtualization@lists.linux.dev, linux-nvme@lists.infradead.org,
 linux-scsi@vger.kernel.org, linux-btrfs@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
References: <20231217165359.604246-1-hch@lst.de>
 <20231217165359.604246-6-hch@lst.de>
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20231217165359.604246-6-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2023/12/18 1:53, Christoph Hellwig wrote:
> disk_clear_zoned only needs to be called when a device reported zone
> managed mode first and we clear it.  Add a check so that disk_clear_zoned
> isn't called on devices that were never zoned.
> 
> This avoids a fairly expensive queue freezing when revalidating
> conventional devices.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks good.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>


-- 
Damien Le Moal
Western Digital Research


