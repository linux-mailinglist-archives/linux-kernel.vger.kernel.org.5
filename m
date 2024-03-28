Return-Path: <linux-kernel+bounces-123299-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 30BC5890643
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 17:50:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B02472A2A8D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 16:50:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A0CC12F59E;
	Thu, 28 Mar 2024 16:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="GF/LGX26"
Received: from 008.lax.mailroute.net (008.lax.mailroute.net [199.89.1.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6EDF2C6AD;
	Thu, 28 Mar 2024 16:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711644435; cv=none; b=hMiDjZBLZFh3MYxV4mPNUREzxmuNGuOihaws8LcR95PuT9lT7+xT41A+9tGCaNIuPWYWq+Soq1mOi78rUREhGjqQE3hgdxUiL/nddSYcLX+CNXnI53oM8HVmeWzC4EDyrLe7OC48iXCWCg9I4GQxi0uDFUtu4108pxQsyR0OtZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711644435; c=relaxed/simple;
	bh=zYBptg0Q4ids4Qp/xFxn+pDwZGbc5lhp6j/rsmPcXwk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Tgw3OFZkdq9uwsLm9CduPcFKFJ6YHmhzlM6QHqcmJUIAbJRjrimcXEfKrXplT4UC5baAYO4xFDMQmfom166F+DouHmg54zIceQieURdU5qOG8i8RnoUZ4bghKg31a2IVLmWTrVD0OzBiVJd1r9TdsaHm+yeUxmGbPyzgOoUkifs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=GF/LGX26; arc=none smtp.client-ip=199.89.1.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 008.lax.mailroute.net (Postfix) with ESMTP id 4V58Zy5wtlz6Cnk8t;
	Thu, 28 Mar 2024 16:47:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:references:content-language:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1711644423; x=1714236424; bh=/CRDH2chuqf02kQLgOdJTq8k
	eMEI7k1Ir0dHZtq22A0=; b=GF/LGX26GsWodplyf+K20fwnLrdN8nvelpJmkcXl
	bU7JBclDhPB5Y/x9kk67Z+M0A+fW6YaQI0WqUn44TyCApwy4dw/oFVFFXF7jNpWa
	MnN9LRPM/vrEBtTWn734zCzjqdW+PQ4PyEvVLRWmc3Eo/GmffaYx+PHqaMgr09XI
	/FwAJqOnBI8Gjw3JV6jZhLGisluYTVhpgwHQRj+fs0tVY+HnKbizWMpzhCuZ1RN4
	AYNfV1v2eu26gpXbiv1oVJGleUltd+Gw/poNIr8vwYwJV1clM31tY/uy3noMHyUv
	VkduUjI4u2oCWoq8TGR592QFzwz+OcRL9u/QQ0rLHhi0jw==
X-Virus-Scanned: by MailRoute
Received: from 008.lax.mailroute.net ([127.0.0.1])
 by localhost (008.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id XfpEE5bIkp4V; Thu, 28 Mar 2024 16:47:03 +0000 (UTC)
Received: from [100.96.154.173] (unknown [104.132.1.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 008.lax.mailroute.net (Postfix) with ESMTPSA id 4V58Zs2P7Cz6Cnk8m;
	Thu, 28 Mar 2024 16:47:00 +0000 (UTC)
Message-ID: <73de2cd5-9770-453c-b002-7cd561bdbc7b@acm.org>
Date: Thu, 28 Mar 2024 09:46:58 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/11] scsi: devinfo: rework scsi_strcpy_devinfo()
Content-Language: en-US
To: Arnd Bergmann <arnd@kernel.org>, linux-kernel@vger.kernel.org,
 "James E.J. Bottomley" <jejb@linux.ibm.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Chris Down <chris@chrisdown.name>,
 Petr Mladek <pmladek@suse.com>, linux-scsi@vger.kernel.org
References: <20240328140512.4148825-1-arnd@kernel.org>
 <20240328140512.4148825-3-arnd@kernel.org>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20240328140512.4148825-3-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/28/24 07:04, Arnd Bergmann wrote:
> diff --git a/drivers/scsi/scsi_devinfo.c b/drivers/scsi/scsi_devinfo.c
> index ba7237e83863..58726c15ebac 100644
> --- a/drivers/scsi/scsi_devinfo.c
> +++ b/drivers/scsi/scsi_devinfo.c
> @@ -290,18 +290,28 @@ static struct scsi_dev_info_list_table *scsi_devinfo_lookup_by_key(int key)
>   static void scsi_strcpy_devinfo(char *name, char *to, size_t to_length,
>   				char *from, int compatible)
>   {
> -	size_t from_length;
> +	int ret;
>   
> -	from_length = strlen(from);
> -	/* This zero-pads the destination */
> -	strncpy(to, from, to_length);
> -	if (from_length < to_length && !compatible) {
> -		/*
> -		 * space pad the string if it is short.
> -		 */
> -		memset(&to[from_length], ' ', to_length - from_length);
> +	if (compatible) {
> +		/* This zero-pads and nul-terminates the destination */
> +		ret = strscpy_pad(to, from, to_length);
> +	} else {
> +		/* no nul-termination but space-padding for short strings */
> +		size_t from_length = strlen(from);
> +		ret = from_length;
> +
> +		if (from_length > to_length) {
> +			from_length = to_length;
> +			ret = -E2BIG;
> +		}
> +
> +		memcpy(to, from, from_length);
> +
> +		if (from_length < to_length)
> +			memset(&to[from_length], ' ', to_length - from_length);
>   	}
> -	if (from_length > to_length)
> +
> +	if (ret < 0)
>   		 printk(KERN_WARNING "%s: %s string '%s' is too long\n",
>   			__func__, name, from);
>   }

Please eliminate the variable 'ret'. I think that will improve
readability of the new code.

Thanks,

Bart.

