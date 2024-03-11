Return-Path: <linux-kernel+bounces-99639-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 74905878B05
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 23:58:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2AD9D1F21757
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 22:58:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B32F58AA1;
	Mon, 11 Mar 2024 22:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M4VEhTUl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD30957876;
	Mon, 11 Mar 2024 22:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710197900; cv=none; b=a0XNCTr4p6VvJJGeLV83Ox1zelmIyqteJdri7/8FqoykYRsEaPrMeOjF1L9NJndwj0P14KSrs9QaIvnnUkDPgBpIK0m+TuqMWKzQ5EAQ8J7nEeSnLK9CZZezv6RqJxaXubh6T8mDDA7+JV/wC+aHJym2Ctoh4ptgM6FrmPHcZhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710197900; c=relaxed/simple;
	bh=UDJUaW9fKpvISgtM1JIdyaO7SN7so5LoytZehMrUhmI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ow3MLmp4nzJAddF3+wxew5Xg2XZdedEKaYYAf8Bn5BJo1XScsVXG/COi1GsuyWPaCgU7p2g0ODB+DixU029ywb0/BRAmkPFmvP3Oh77Nikmgk0i50Kl72dhyQUZ/2gzgUZCL2DPzzNqqVm9vtFvNqUE7PnWN9JocbXsVXqqFPLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M4VEhTUl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9E2EC433C7;
	Mon, 11 Mar 2024 22:58:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710197900;
	bh=UDJUaW9fKpvISgtM1JIdyaO7SN7so5LoytZehMrUhmI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=M4VEhTUlbAP/4EM7xXv/NG5fC2Y81OBW/jTMbgnlN19H8Gbs7a+pIS3oa62IS/8Dw
	 dYoerWvLl8bxJpcd81Ebsu48KoPp/o6pk+IQvEZFYOEIjLDXdrQC8QGH7gijxXYC86
	 j30fLVOUIwggl7ErvrvYV+Ton5UdiQwZnQTE0owML4QDDvU2N1z7ZcO9GnnRwEDbIV
	 gV0QmzF9tZV8IFc1l1wVcaNVTS3jqW6NUDn6Ve3+PjZSCpLgSCm4rXWNOIPf2r37Fo
	 wyglWDadTaZ3ZKi071bvRZp3VXEPOD1Pl2GfBnl+SyJqEjfz+xHIMWUcEYSHuVMERC
	 8HF6AKvQPVS7A==
Date: Mon, 11 Mar 2024 15:58:18 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Subbaraya Sundeep <sbhatta@marvell.com>
Cc: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
 <sgoutham@marvell.com>, <lcherian@marvell.com>, <gakula@marvell.com>,
 <hkelam@marvell.com>, <naveenm@marvell.com>, <horms@kernel.org>
Subject: Re: [net PATCH 1/5] octeontx2: Detect the mbox up or down message
 via register
Message-ID: <20240311155818.03e20c05@kernel.org>
In-Reply-To: <1710184612-29027-2-git-send-email-sbhatta@marvell.com>
References: <1710184612-29027-1-git-send-email-sbhatta@marvell.com>
	<1710184612-29027-2-git-send-email-sbhatta@marvell.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 12 Mar 2024 00:46:48 +0530 Subbaraya Sundeep wrote:
>  static int mcs_notify_pfvf(struct mcs_intr_event *event, struct rvu *rvu)
>  {
>  	struct mcs_intr_info *req;
> -	int err, pf;
> +	int pf;
>  
>  	pf = rvu_get_pf(event->pcifunc);
>  
> +	mutex_lock(&rvu->mbox_lock);
> +
>  	req = otx2_mbox_alloc_msg_mcs_intr_notify(rvu, pf);
>  	if (!req)
>  		return -ENOMEM;

missing unlock here?

> @@ -135,10 +137,11 @@ static int mcs_notify_pfvf(struct mcs_intr_event *event, struct rvu *rvu)
>  	req->hdr.pcifunc = event->pcifunc;
>  	req->lmac_id = event->lmac_id;
>  
> -	otx2_mbox_msg_send(&rvu->afpf_wq_info.mbox_up, pf);
> -	err = otx2_mbox_wait_for_rsp(&rvu->afpf_wq_info.mbox_up, pf);
> -	if (err)
> -		dev_warn(rvu->dev, "MCS notification to pf %d failed\n", pf);
> +	otx2_mbox_wait_for_zero(&rvu->afpf_wq_info.mbox_up, pf);
> +
> +	otx2_mbox_msg_send_up(&rvu->afpf_wq_info.mbox_up, pf);
> +
> +	mutex_unlock(&rvu->mbox_lock);
-- 
pw-bot: cr

