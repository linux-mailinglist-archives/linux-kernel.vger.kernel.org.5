Return-Path: <linux-kernel+bounces-132466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ED9E9899532
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 08:21:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FC681F24FD8
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 06:21:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8895022616;
	Fri,  5 Apr 2024 06:21:01 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8AD32232B
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 06:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712298061; cv=none; b=eCHbiaY7TgCPaGh676Bs/mffM5vv8OEEpMwUwR0fxt4z+fdM21H8gbS63ksx1N+kpVZOQ0x1u3P4Wkc1j3gwtGKtk27rtTFszKjJGzERwhr2DdIZfs2c8cS1FNlPNqAifnPM1gCkxSRRU9qYOX+83pG/odYIIKviQTq8M/EUHZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712298061; c=relaxed/simple;
	bh=cZAm21SU+Jj9MjstbKMYQxrL1VG7W0eKArYSvFonf10=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I8gSMM36y2cwj7AoQhPUx8fyrhrgfNUrnaHC5gOgykKBOq3TsHr5YBLlksOS99YKXElhA3c4gyPlfmFI5cSKH+xsRm9MxQZSfGPhixkbtzN7evgGgcN6NDXv0XfML7YzTNNFXUVALtd/2lW+8L/6FJ3Z81uF8xFwyIRcLhgOHpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id C327168D07; Fri,  5 Apr 2024 08:20:55 +0200 (CEST)
Date: Fri, 5 Apr 2024 08:20:55 +0200
From: Christoph Hellwig <hch@lst.de>
To: Daniel Wagner <dwagner@suse.de>
Cc: James Smart <james.smart@broadcom.com>, Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, Hannes Reinecke <hare@kernel.org>
Subject: Re: [PATCH v4 3/5] nvmet: return DHCHAP status codes from
 nvmet_setup_auth()
Message-ID: <20240405062055.GC3107@lst.de>
References: <20240404154500.2101-1-dwagner@suse.de> <20240404154500.2101-4-dwagner@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240404154500.2101-4-dwagner@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Apr 04, 2024 at 05:44:58PM +0200, Daniel Wagner wrote:
> From: Hannes Reinecke <hare@kernel.org>
> 
> A failure in nvmet_setup_auth() does not mean that the NVMe
> authentication command failed, so we should rather return a
> protocol error with a 'failure1' response than an NVMe status.

Nit: try to use up the 73 characters available for commit logs, this
looks weirdly, um condensed.

> @@ -131,7 +131,6 @@ int nvmet_setup_auth(struct nvmet_ctrl *ctrl)
>  	int ret = 0;
>  	struct nvmet_host_link *p;
>  	struct nvmet_host *host = NULL;
> -	const char *hash_name;
>  
>  	down_read(&nvmet_config_sem);
>  	if (nvmet_is_disc_subsys(ctrl->subsys))
> @@ -149,13 +148,16 @@ int nvmet_setup_auth(struct nvmet_ctrl *ctrl)
>  	}
>  	if (!host) {
>  		pr_debug("host %s not found\n", ctrl->hostnqn);
> -		ret = -EPERM;
> +		ret = NVME_AUTH_DHCHAP_FAILURE_FAILED;
>  		goto out_unlock;

This is now returning returning random on the wire fields that aren't
even the NVMe status codes from a function otherwise returning Linux
errno values.  I can't see how this works or is maintainable long term.


