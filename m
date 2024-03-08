Return-Path: <linux-kernel+bounces-97307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EB0C876888
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 17:31:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 99C6EB22272
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 16:31:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AC803217;
	Fri,  8 Mar 2024 16:31:08 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0A7B36D
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 16:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709915468; cv=none; b=q3rRZdHYZcx3EGOUkUXXYK9zARknv5qs2sHQm64UIACW9K4N114woDlkBfxtX9mboAw3a7nimCOYMfFmjbpctJyr8XnrEv+nXsCzOUnhQrTtfXqpeBD1PruorosO3sgNdgeiGh2qNK4CDJpTkEa8mGzPZpDOmstFy5DWn0dOOQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709915468; c=relaxed/simple;
	bh=VDWDiLdmqr+T1PQP0/4dq0GNhOIGoR3DDqgHxEUcyy4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UxXMMl1oDN7fSBAgtszAv+dSNhpmZScR3eum8ClYVNbYlphhSOLzgA3PKXZi+FEdC5kQFnq2nbmBFHhIoWRfSPZuzfKrKteLjE44sqg4WOpO5bKPcwSAejXRmFQJxA01xfV4gTZf3XUQfkMOod1UdLUvpflbfMhewqHTs6Qcnmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 5A70A68BEB; Fri,  8 Mar 2024 17:31:01 +0100 (CET)
Date: Fri, 8 Mar 2024 17:31:00 +0100
From: Christoph Hellwig <hch@lst.de>
To: =?utf-8?B?6K645pil5YWJ?= <brookxu.cn@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>, kbusch@kernel.org, axboe@kernel.dk,
	sagi@grimberg.me, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] nvme: fix reconnection fail due to reserved tag
 allocation
Message-ID: <20240308163100.GA17078@lst.de>
References: <20240308015435.100968-1-brookxu.cn@gmail.com> <20240308144208.GA9194@lst.de> <CADtkEefTzbYN4qEAgAXDTB-+HMxfENw2m+xcoxzy83YW-bGEhA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADtkEefTzbYN4qEAgAXDTB-+HMxfENw2m+xcoxzy83YW-bGEhA@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Sat, Mar 09, 2024 at 12:29:27AM +0800, 许春光 wrote:
> This works now, but I donot know whether
> nvme_alloc_admin_tag_set()/nvme_alloc_io_tag_set()
> will be suitable for all driver in future, such as driver for apple
> device not use these two funcs
> to init tagset (anyway it not use these two macros too), so maybe new
> driver would use these
> value in other position.

nvme-apply should realy be converted to use the generic helpers,
I just need some help from the maintainers.  I'll ping them.

But I'm fine with just taking this bug fix as-is and clean this up
later.

