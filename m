Return-Path: <linux-kernel+bounces-110804-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E6027886424
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 00:53:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 67BBAB22AEC
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 23:53:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B265131A8F;
	Thu, 21 Mar 2024 23:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dCCm2QrS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFF5D1DFD2;
	Thu, 21 Mar 2024 23:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711065188; cv=none; b=EzweBJBtSh+XcDvWEapGhmTseC/vi7eGP+h2KWp3s7Nk43wcmtQ1H3yagIdVF+Mu3rRUqLdInahdnTsFxxr+hVcV+6ojMdGT20RIPzQ3d7fH8Hg4tF3YDttRuzAF4aQSt301ko9XJ3hzrGkBn8LjqKg0Mn6UZrDMTPkwP75V9Dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711065188; c=relaxed/simple;
	bh=KRlBfszq8wJPr+l3EMoQdukOyWe0TiNmQleRwmFZaDM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f+nZeCUWzZHxa8dR5wXU4WIuw9fPGOjqnFMHVVaf9im+wACDDzdhqmA7o7MhRkRl4oSxFdB3aTg2LBtSwzmlvWj58j9j9VTpdIefYFuQ35BMCDjsiejv80nJBwqqMHFuEoA+E3AWHTtW7fBzFoP5MVOE1ytdY0f43nFycuIEC4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dCCm2QrS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3860AC433F1;
	Thu, 21 Mar 2024 23:53:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711065187;
	bh=KRlBfszq8wJPr+l3EMoQdukOyWe0TiNmQleRwmFZaDM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=dCCm2QrSGzL/rVDaasXnkgUynntP7mmYHd+38zepdXZK7utT31tRlAZI+j+cfAmkC
	 62QX8s2TMHdznqFe1D/mrPbAqz/PvXOVrx69qJ0QEzW+mKF7P6zSOW1MM+MweZnvog
	 IMADa93sRzg4m8m/6dPhc6Ss9/lpWSTCc0mt7yR59ZhRnGaLzI3k3unM4QUIrMIAML
	 KDrjPsBuzLiTK6v04/fZdoA/svHJLN7TGJOfApCTTvqDti4fw7crpjPWhIB/LGNls4
	 6Tt84x32NMCdxZVOkkbCm41mBRhbIIpfU24ZujylB4nz+2fNuIBjwulkXlXIfuCXnn
	 21LMD5a/XU6RQ==
Message-ID: <0049877f-a6c0-4dc5-977f-13aa193cd38b@kernel.org>
Date: Fri, 22 Mar 2024 08:53:04 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.10/5.15] scsi: add a length check for
 VARIABLE_LENGTH_CMD commands
To: Mikhail Ukhin <mish.uxin2012@yandex.ru>, Jens Axboe <axboe@kernel.dk>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
 Niklas Cassel <cassel@kernel.org>, Pavel Koshutin
 <koshutin.pavel@yandex.ru>, Artem Sadovnikov <ancowi69@gmail.com>,
 Mikhail Ivanov <iwanov-23@bk.ru>
References: <20240321110229.9534-1-mish.uxin2012@yandex.ru>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20240321110229.9534-1-mish.uxin2012@yandex.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/21/24 20:02, Mikhail Ukhin wrote:
> Fuzzing of 5.10 stable branch reports a slab-out-of-bounds error in
> ata_scsi_pass_thru.
> 
> The error is fixed in 5.18 by commit
> ce70fd9a551af7424a7dace2a1ba05a7de8eae27.
> Backporting this commit would require significant changes to the code so
> it is bettter to use a simple fix for that particular error.
> 
> The problem is that the length of the received SCSI command is not
> validated if scsi_op == VARIABLE_LENGTH_CMD. It can lead to out-of-bounds
> reading if the user sends a request with SCSI command of length less than
> 32.
> 
> Found by Linux Verification Center (linuxtesting.org) with Syzkaller.
> 
> Signed-off-by: Artem Sadovnikov <ancowi69@gmail.com>
> Signed-off-by: Mikhail Ivanov <iwanov-23@bk.ru>

Looks OK to me, but the patch title prefix is incorrect since this is not a scsi
patch. Please make that:

ata: libata-scsi: check cdb length for VARIABLE_LENGTH_CMD commands

> ---
>  drivers/ata/libata-scsi.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
> index dfa090ccd21c..77589e911d3d 100644
> --- a/drivers/ata/libata-scsi.c
> +++ b/drivers/ata/libata-scsi.c
> @@ -4065,6 +4065,9 @@ int __ata_scsi_queuecmd(struct scsi_cmnd *scmd, struct ata_device *dev)
>  
>  	if (unlikely(!scmd->cmd_len))
>  		goto bad_cdb_len;
> +
> +	if (scsi_op == VARIABLE_LENGTH_CMD && scmd->cmd_len < 32)
> +		goto bad_cdb_len;
>  
>  	if (dev->class == ATA_DEV_ATA || dev->class == ATA_DEV_ZAC) {
>  		if (unlikely(scmd->cmd_len > dev->cdb_len))

-- 
Damien Le Moal
Western Digital Research


