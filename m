Return-Path: <linux-kernel+bounces-132464-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 28EED899527
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 08:16:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BEA8AB22DA1
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 06:16:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 401B9225DD;
	Fri,  5 Apr 2024 06:16:31 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4599D22612
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 06:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712297790; cv=none; b=cI4evWpbk6TZCo/ZWJM0qzhR1KBKBp4uo72pBhSt3zizU0IV3PFMrgie1pzc+QKKioH48Cpe+DubbYM1rySGbvnJt6mPwETqtQnTOyOmJAXlTjTGSbofGO5NDBbc/iww4AcvjfYoe2l80cJ4eOGkgOKbpZZTs/LDmS8H3yoZvyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712297790; c=relaxed/simple;
	bh=f7YjR+Pr4pA5TXDvpEHMiIFNiuTLf721psXAU0xMLkc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NwMKLxmP5A4M2ihsk2VZ0K6ZEdPIMfmfLtXmCsqOvkf4JlyjwQv9nypqes53RXwfUvSX7LQFNUERPwqbpVGAwmOA6HnTUpXO/OIj0/eoC3lccBEc0fCpH5AmF3GHZXeMazX9GgeUBNRaPz5A79xqj3ctp2LMmNaB2smr+9AEv5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 9E16C68D07; Fri,  5 Apr 2024 08:16:25 +0200 (CEST)
Date: Fri, 5 Apr 2024 08:16:24 +0200
From: Christoph Hellwig <hch@lst.de>
To: Daniel Wagner <dwagner@suse.de>
Cc: James Smart <james.smart@broadcom.com>, Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/5] nvme: authentication error are always
 non-retryable
Message-ID: <20240405061624.GA3107@lst.de>
References: <20240404154500.2101-1-dwagner@suse.de> <20240404154500.2101-2-dwagner@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240404154500.2101-2-dwagner@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)

> --- a/drivers/nvme/host/fabrics.c
> +++ b/drivers/nvme/host/fabrics.c
> @@ -467,7 +467,7 @@ int nvmf_connect_admin_queue(struct nvme_ctrl *ctrl)
>  		if (result & NVME_CONNECT_AUTHREQ_ASCR) {
>  			dev_warn(ctrl->device,
>  				 "qid 0: secure concatenation is not supported\n");
> -			ret = NVME_SC_AUTH_REQUIRED;
> +			ret = NVME_SC_AUTH_REQUIRED | NVME_SC_DNR;

This is still abusing on the wire status code for in-kernel return
codes.  Can we please sort this out properly?


