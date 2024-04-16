Return-Path: <linux-kernel+bounces-147466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AE0A8A748F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 21:20:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 558E5282C94
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 19:20:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69577139597;
	Tue, 16 Apr 2024 19:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="b2zqqvY7"
Received: from 008.lax.mailroute.net (008.lax.mailroute.net [199.89.1.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51D28137934;
	Tue, 16 Apr 2024 19:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713295211; cv=none; b=Yt+9aqD2vEZasuAGt+GAxwRlinKcEnYGFjiW1X/4U3zO1u2iiuK14lYd2VUxiY49TskUgxF1nTbrMH6ioCbu7MXZcyxS0ZvI/9bF9h9ikTtvs9NWZtM8I93IfDfKNXEzgRTQspuaL9FyWVFesxHIj3E71US198PErJadysewRzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713295211; c=relaxed/simple;
	bh=ogCtVrBRBgX+wHrNXPPVDs4aHPlnhEfxlOiisGGj0kA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VPhz5odAIaK/d7EaVIq+PTknPLGBeqN7Fg5X/A1fJPzIgh3fxe74NBebI4/lhVeQTtLnzpPQV9YOhjPpiEuatrOoILbOp9fS+JU7169x8iyy0BlIvEBswbN07jw9iGcjebSZFx/zhb9MQ4KzS0Pta2fJJl0XihmWDZHeVoDNg00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=b2zqqvY7; arc=none smtp.client-ip=199.89.1.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 008.lax.mailroute.net (Postfix) with ESMTP id 4VJv4n5dDGz6Cnk8s;
	Tue, 16 Apr 2024 19:20:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1713295208; x=1715887209; bh=Xdyvfbt1TIkpxYSFrkkGBbE7
	xEwlKwVi2d5imCHf7/s=; b=b2zqqvY7wz5e6ZOxPCQE6VaPaRXCBNn95peMnK7j
	j1ivgWvHtajM/diwASlsYvhtlLoMPXIGp75uXKvbd9h3sHduXJhFO1CRUx673CRR
	1HdXyKgrQzt7I9e2saiVJqKaIVqegFsNtJjCNvsVy5A5Gtw/083aPLnjussG8OOF
	YljCr8czGkEG6j9W/40gt3d9G6K2qvn87/ULVwRL93tbX2qOAxb7xVp6bkTNW/8q
	gA3hGi3TGvHQ1cFXXedhdJK6wumi2YxgRt7nS5Hs2JO+kpPwiYpwKZe/u038hkKc
	uXOoC1c/55gIddLkF9YDrT6r85hyPCvcpP8X48faw0/ezA==
X-Virus-Scanned: by MailRoute
Received: from 008.lax.mailroute.net ([127.0.0.1])
 by localhost (008.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id HNb3CA8AzuaF; Tue, 16 Apr 2024 19:20:08 +0000 (UTC)
Received: from [100.96.154.26] (unknown [104.132.0.90])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 008.lax.mailroute.net (Postfix) with ESMTPSA id 4VJv4l1xk3z6Cnk8m;
	Tue, 16 Apr 2024 19:20:06 +0000 (UTC)
Message-ID: <0beac395-0c89-4fa6-b4a1-d0565373e60a@acm.org>
Date: Tue, 16 Apr 2024 12:20:05 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] scsi: ufs: core: Make use of guard(mutex)
To: Avri Altman <avri.altman@wdc.com>,
 "Martin K . Petersen" <martin.petersen@oracle.com>
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240416102348.614-1-avri.altman@wdc.com>
 <20240416102348.614-5-avri.altman@wdc.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20240416102348.614-5-avri.altman@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/16/24 03:23, Avri Altman wrote:
> @@ -5682,9 +5681,8 @@ int ufshcd_write_ee_control(struct ufs_hba *hba)
>   {
>   	int err;
>   
> -	mutex_lock(&hba->ee_ctrl_mutex);
> +	guard(mutex)(&hba->ee_ctrl_mutex);
>   	err = __ufshcd_write_ee_control(hba, hba->ee_ctrl_mask);
> -	mutex_unlock(&hba->ee_ctrl_mutex);
>   	if (err)
>   		dev_err(hba->dev, "%s: failed to write ee control %d\n",
>   			__func__, err);

This change moves the dev_err() statement inside the code block
protected by ee_ctrl_mutex. Please do not make such changes in this
patch.

Thanks,

Bart.

