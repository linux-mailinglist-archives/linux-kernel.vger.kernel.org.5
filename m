Return-Path: <linux-kernel+bounces-18323-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAAA6825B8A
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 21:24:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8572C281B5B
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 20:24:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3AE936091;
	Fri,  5 Jan 2024 20:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V9X+Oye8"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C43D3608B
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jan 2024 20:24:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 196E1C433C7;
	Fri,  5 Jan 2024 20:24:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704486286;
	bh=1a7qWhc3IkRvMd9r5UgVqn8LxrHXD9LTb10cVXrSdHY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=V9X+Oye8z7iu0w0FhhhYTZrfJwWTudlLZKoWWlJ2DeeCV6H1loJsfBnEpixFaw+Gw
	 GzBskTlenX/upnXYUhtpC6KxEOD8KLUBVhiPK45hEOSkbeKbU8OgfHPsGDPWkqUGrC
	 PMpMY0rMLQ9mvxtUAFQLSkzbtve95f4rckMLmrmCxyeQn1bi/OJ43nANLdRa/bd7jV
	 FhnaOMygpMPl+LGZWtIrZGOWJrwqPuABKu3f30cV4ht7zDvhzN+JVjwsdvpllRfiwJ
	 2GYsgpwd8Ggbs78f2kUXgTYWT6YxUDF5GPEfsLMIEDPZPCT5TZOYtOq/6Lx/SfkyWj
	 tGPYmO7g53SEQ==
Date: Fri, 5 Jan 2024 13:24:43 -0700
From: Keith Busch <kbusch@kernel.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, Arnd Bergmann <arnd@arndb.de>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] nvmet: re-fix tracing strncpy() warning
Message-ID: <ZZhli2FWXwP1XSRG@kbusch-mbp>
References: <20240103155702.4045835-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240103155702.4045835-1-arnd@kernel.org>

On Wed, Jan 03, 2024 at 04:56:55PM +0100, Arnd Bergmann wrote:
> @@ -53,8 +53,7 @@ static inline void __assign_req_name(char *name, struct nvmet_req *req)
>  		return;
>  	}
>  
> -	strncpy(name, req->ns->device_path,
> -		min_t(size_t, DISK_NAME_LEN, strlen(req->ns->device_path)));
> +	strscpy_pad(name, req->ns->device_path, DISK_NAME_LEN);
>  }

I like this one, however Daniel has a different fix for this already
staged in nvme-6.8:

 https://git.infradead.org/nvme.git/commitdiff/8f6c0eec5fad13785fd53a5b3b5f8b97b722a2a3

