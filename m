Return-Path: <linux-kernel+bounces-111883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04B12887227
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 18:50:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6D4E0B2236E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 17:50:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53624605B1;
	Fri, 22 Mar 2024 17:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="Qpsv8DC7"
Received: from 008.lax.mailroute.net (008.lax.mailroute.net [199.89.1.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 804D5604A6;
	Fri, 22 Mar 2024 17:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711129811; cv=none; b=E36O6beB75Cz2TVsAV/6FjcJUlVgAns/PbxEZYNLLZ2NboFWGmKzNME8GGLWYCQMiOvrs+m9GcS/02xloLSGBNQJxCTJEdcPfQwlUHgZ8+cF3qeXleat3xGXsdvoE4mEqucnLgMQ6hHC0Lq8r8JvpCmuKwX3AMk27xQxq6LNhrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711129811; c=relaxed/simple;
	bh=tlaxGcQqSo4rsMaZE0sbNHeXStqfwgVpWciJkli4y+E=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=pUdmeTAQO5IdjmOQ9QU9XcsGdDjoTvA6OADnPdZRhI4Lr4xzq23GpEGoGCR81dpjPu+FHn93Cz7d1ClkNDpWQ43cyvHjLvXo00BnHdy2YHqAJpT+0WTIpPIlDcYwV9Hj4MrPIAsPQP9/pzIvFP7GwZ00tUENYPEfyYFI+MG5cNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=Qpsv8DC7; arc=none smtp.client-ip=199.89.1.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 008.lax.mailroute.net (Postfix) with ESMTP id 4V1VGR4j9Yz6Cnk95;
	Fri, 22 Mar 2024 17:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:references:content-language:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1711129797; x=1713721798; bh=afZlcm9O07bvpHWZp13m44cg
	Mjqanzjz1tGTAZQ/1YM=; b=Qpsv8DC7mL/Qcs4xoiwBfXcBY4Y5RAIaatVQz7e0
	NmTdbhx1Xsns+fOdYL4hRE0TSmqH/tkSqTJUfxTbNyGRIE37amKlWJ4sOG/4J9Rq
	E1OlRyafw/bvMN6lPbKPVjJOARn9tI5lwiLNOWFpPp3xY18La+U79Q21j3TRjlFW
	lTuANy7O79bywNMmr3DDk5u73ZNtChsWQ2S637Yrcdw2tU2esITNy61wtZSVyDwF
	auUIvSZmBhD9AD/zmrt+L8xNEeGCgA27jur2s4MC/uU795KGEP3p1XkAOuDP9PvO
	6b4Q0VUPCVm6smHq/cZwoEBSZdEwWvG4HyveTE0u6aEm8g==
X-Virus-Scanned: by MailRoute
Received: from 008.lax.mailroute.net ([127.0.0.1])
 by localhost (008.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id WDCEdahPUwBV; Fri, 22 Mar 2024 17:49:57 +0000 (UTC)
Received: from [100.96.154.173] (unknown [104.132.1.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 008.lax.mailroute.net (Postfix) with ESMTPSA id 4V1VG64fZqz6Cnk8t;
	Fri, 22 Mar 2024 17:49:50 +0000 (UTC)
Message-ID: <7027ccdc-878a-420e-a7ea-5156e1d67b8a@acm.org>
Date: Fri, 22 Mar 2024 10:49:48 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/8] block: add new genhd flag GENHD_FL_NVMEM
Content-Language: en-US
To: Daniel Golle <daniel@makrotopia.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
 Jens Axboe <axboe@kernel.dk>, Dave Chinner <dchinner@redhat.com>,
 Jan Kara <jack@suse.cz>, =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?=
 <linux@weissschuh.net>, Damien Le Moal <dlemoal@kernel.org>,
 Li Lingfeng <lilingfeng3@huawei.com>, Christian Brauner
 <brauner@kernel.org>, Christian Heusel <christian@heusel.eu>,
 Min Li <min15.li@samsung.com>, Adrian Hunter <adrian.hunter@intel.com>,
 Avri Altman <avri.altman@wdc.com>, Hannes Reinecke <hare@suse.de>,
 Christian Loehle <CLoehle@hyperstone.com>, Bean Huo <beanhuo@micron.com>,
 Yeqi Fu <asuk4.q@gmail.com>, Victor Shih <victor.shih@genesyslogic.com.tw>,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 Dominique Martinet <dominique.martinet@atmark-techno.com>,
 "Ricardo B. Marliere" <ricardo@marliere.net>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
 linux-block@vger.kernel.org
References: <cover.1711048433.git.daniel@makrotopia.org>
 <89abd9ab93783da0e8934ebc03d66559f78f6060.1711048433.git.daniel@makrotopia.org>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <89abd9ab93783da0e8934ebc03d66559f78f6060.1711048433.git.daniel@makrotopia.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/21/24 12:33, Daniel Golle wrote:
> Add new flag to destinguish block devices which may act as an NVMEM
> provider.
> 
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> ---
>   include/linux/blkdev.h | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index c3e8f7cf96be9..f2c4f280d7619 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -81,11 +81,13 @@ struct partition_meta_info {
>    * ``GENHD_FL_NO_PART``: partition support is disabled.  The kernel will not
>    * scan for partitions from add_disk, and users can't add partitions manually.
>    *
> + * ``GENHD_FL_NVMEM``: the block device should be considered as NVMEM provider.
>    */
>   enum {
>   	GENHD_FL_REMOVABLE			= 1 << 0,
>   	GENHD_FL_HIDDEN				= 1 << 1,
>   	GENHD_FL_NO_PART			= 1 << 2,
> +	GENHD_FL_NVMEM				= 1 << 3,
>   };

What would break if this flag wouldn't exist?

Thanks,

Bart.


