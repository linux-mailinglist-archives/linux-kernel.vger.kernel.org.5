Return-Path: <linux-kernel+bounces-3746-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 97BC581707C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 14:28:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BE641F25083
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 13:28:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD906129EC6;
	Mon, 18 Dec 2023 13:28:45 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D167C129EC5;
	Mon, 18 Dec 2023 13:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Sv0wF0wzHz6K9bZ;
	Mon, 18 Dec 2023 21:26:37 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 4F879140B55;
	Mon, 18 Dec 2023 21:28:39 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 18 Dec
 2023 13:28:38 +0000
Date: Mon, 18 Dec 2023 13:28:37 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Ira Weiny <ira.weiny@intel.com>
CC: Fan Ni <nifan.cxl@gmail.com>, Dave Jiang <dave.jiang@intel.com>,
	<linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Huai-Cheng Kuo
	<hchkuo@avery-design.com.tw>
Subject: Re: [PATCH v2 2/2] cxl/cdat: Fix header sum value in CDAT checksum
Message-ID: <20231218132837.00001424@Huawei.com>
In-Reply-To: <20231117-fix-cdat-cs-v2-2-715399976d4d@intel.com>
References: <20231117-fix-cdat-cs-v2-0-715399976d4d@intel.com>
	<20231117-fix-cdat-cs-v2-2-715399976d4d@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Wed, 29 Nov 2023 17:33:04 -0800
Ira Weiny <ira.weiny@intel.com> wrote:

> The addition of the DCD support for CXL type-3 devices extended the CDAT
> table large enough that the checksum being returned was incorrect.[1]
> 
> This was because the checksum value was using the header length field
> rather than each of the 4 bytes of the length field.  This was
> previously not seen because the length of the CDAT data was less than
> 256 thus resulting in an equivalent checksum value.
> 
> Properly calculate the checksum for the CDAT header.
> 
> [1] https://lore.kernel.org/all/20231116-fix-cdat-devm-free-v1-1-b148b40707d7@intel.com/
> 
> Fixes: aba578bdace5 ("hw/cxl/cdat: CXL CDAT Data Object Exchange implementation")
> Cc: Huai-Cheng Kuo <hchkuo@avery-design.com.tw>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> 
> ---
> Changes from V1:
> [djiang: Remove do {} while (0);]
> ---
>  hw/cxl/cxl-cdat.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/cxl/cxl-cdat.c b/hw/cxl/cxl-cdat.c
> index 24829cf2428d..67e44a4f992a 100644
> --- a/hw/cxl/cxl-cdat.c
> +++ b/hw/cxl/cxl-cdat.c
> @@ -49,6 +49,7 @@ static void ct3_build_cdat(CDATObject *cdat, Error **errp)
>      g_autofree CDATTableHeader *cdat_header = NULL;
>      g_autofree CDATEntry *cdat_st = NULL;
>      uint8_t sum = 0;
> +    uint8_t *buf;
This results in a shadowing variable warning. I'll rename it to hdr_buf or something
like that.
>      int ent, i;
>  
>      /* Use default table if fopen == NULL */
> @@ -95,8 +96,12 @@ static void ct3_build_cdat(CDATObject *cdat, Error **errp)
>      /* For now, no runtime updates */
>      cdat_header->sequence = 0;
>      cdat_header->length += sizeof(CDATTableHeader);
> -    sum += cdat_header->revision + cdat_header->sequence +
> -        cdat_header->length;
> +
> +    buf = (uint8_t *)cdat_header;
> +    for (i = 0; i < sizeof(*cdat_header); i++) {
> +        sum += buf[i];
> +    }
> +
>      /* Sum of all bytes including checksum must be 0 */
>      cdat_header->checksum = ~sum + 1;
>  
> 


