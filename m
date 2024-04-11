Return-Path: <linux-kernel+bounces-141734-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 058268A22B9
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 01:58:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 88546B21BE4
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 23:58:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 297AB4C624;
	Thu, 11 Apr 2024 23:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TmungXsz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63E6347A5D;
	Thu, 11 Apr 2024 23:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712879926; cv=none; b=jzS+ceuTc8g6XVolEbSj583kmMEtWSsOLyv7ggGQkPNyRLTTKiG+YURC0oQFs6hlFZXAE2WIKy0NMSvDrVYEas/3tgoX5OaWQsSpCesDRz+DJ8IH82HvdudX6UUPunu/sNQJVqr1WmmPkKQoVrMkIbI/AW7bxi3eSaP/33wkbsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712879926; c=relaxed/simple;
	bh=Rvrx5bIocVoHhqzlQ8FUwZ0hV15oMlthb4VvYCnIU/Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p1fiTk9N4+WtILP+l6qtY5dVfF07shnIxJJM9woAFRWUIF+6iXR5qg+leliuSxrkX0EId2SKVlIUN5cXA05bsHXxP7S1s1BMKuYLue6016ZNQ9XkBB23cBmF1amai5MmtK0tw8iUysVDkiylAKUFLYK/UKAIlPooH2SuCkTHNBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TmungXsz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7166CC072AA;
	Thu, 11 Apr 2024 23:58:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712879926;
	bh=Rvrx5bIocVoHhqzlQ8FUwZ0hV15oMlthb4VvYCnIU/Q=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=TmungXszWLiOZYvkGczuGKN3KtOLrN2pGFzQyi8Puk4Ctie2iAzXuJkRLXMaNCVjl
	 /kzYCjkvIeCLQrL3HxwxMRlfO8nPqijfxt0LiwRoQ/ykurW1NfTIOInCiwwdQDi0Vg
	 euZwhbSNvrSG3w9jdeBEQZmrOXwqa8EZAUKJNMUqJVYg2YY36lAGfyexFg7VPFeRF5
	 bw1Uwi/8OzY09cc/jSldM7byXOrs1IxXPPnIuXidNk9Izf9juIN3uKbVTdCVFEJ3kV
	 wDKyTCzztW/vEVN9an3Riee94rg53JKY4GW0JjwjDtgApT/kebR8MpUMDWC9j7KZZk
	 QtbMexSUEo5Bw==
Message-ID: <a5cc609b-5e96-4e72-aaad-7ee5cf0e6364@kernel.org>
Date: Fri, 12 Apr 2024 08:58:42 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5.10/5.15] ata: libata-scsi: check cdb length for
 VARIABLE_LENGTH_CMD commands
To: Mikhail Ukhin <mish.uxin2012@yandex.ru>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jens Axboe <axboe@kernel.dk>
Cc: stable@vger.kernel.org, linux-ide@vger.kernel.org,
 linux-kernel@vger.kernel.org, Pavel Koshutin <koshutin.pavel@yandex.ru>,
 lvc-project@linuxtesting.org, Artem Sadovnikov <ancowi69@gmail.com>,
 Mikhail Ivanov <iwanov-23@bk.ru>
References: <20240411103013.5547-1-mish.uxin2012@yandex.ru>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20240411103013.5547-1-mish.uxin2012@yandex.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/11/24 19:30, Mikhail Ukhin wrote:
> No upstream commit exists for this patch.
> 
> Fuzzing of 5.10 stable branch reports a slab-out-of-bounds error in
> ata_scsi_pass_thru.
> 
> The error is fixed in 5.18 by commit ce70fd9a551a ("scsi: core: Remove the
> cmd field from struct scsi_request") upstream.
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
> Signed-off-by: Mikhail Ukhin <mish.uxin2012@yandex.ru>
> ---
>  v2: The new addresses were added and the text was updated. 
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

This check should really be in ata_scsi_var_len_cdb_xlat(). Please move it to
that function.

>  
>  	if (dev->class == ATA_DEV_ATA || dev->class == ATA_DEV_ZAC) {
>  		if (unlikely(scmd->cmd_len > dev->cdb_len))

-- 
Damien Le Moal
Western Digital Research


