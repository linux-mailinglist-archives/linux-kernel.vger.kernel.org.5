Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FD7F7CBA93
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 08:10:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234490AbjJQGKu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 02:10:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234446AbjJQGKs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 02:10:48 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B11FEAB
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 23:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697523046; x=1729059046;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=fvSUNe12MrPApyrnvzaikJXkNdd9PaAh1gP0bEv8+3k=;
  b=EfuxwCgo9ixVdJcE6mbNaM8evwIwOcJIs0qzOkSD/JVTSwe3mTsWWAoy
   KqnSDzwEYDM/a98tNXiwFGUJf/21ghA8doMZL+hajDYhgceZYPIMFOqvO
   HQs/xF3Kww5jOd34mfauabgnp7rqEopLUZ2/D5f3qxA72N4YHxtElc0iS
   tpNG3qFYaN/d9SDQJ6n/8j4Y5zkMh7VWUL5jIoGysKl/MUKufv9NQ3CSJ
   pM1RjCOSiuytWn6C+BNt3OgBpWPKCAf3pUGNK3ALaVh3mSrPc6Gos473N
   lhFUAp/P4hEHIMjQkDjSpAIpf+v/7ziTFx441JiB9nFUhKNxQpuXXQdHq
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="365059482"
X-IronPort-AV: E=Sophos;i="6.03,231,1694761200"; 
   d="scan'208";a="365059482"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2023 23:10:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="826303833"
X-IronPort-AV: E=Sophos;i="6.03,231,1694761200"; 
   d="scan'208";a="826303833"
Received: from mylly.fi.intel.com (HELO [10.237.72.161]) ([10.237.72.161])
  by fmsmga004.fm.intel.com with ESMTP; 16 Oct 2023 23:10:32 -0700
Message-ID: <696dbfdc-1b08-446d-8983-dda09d861f59@linux.intel.com>
Date:   Tue, 17 Oct 2023 09:10:31 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] i3c: add actual in i3c_priv_xfer
To:     Frank Li <Frank.Li@nxp.com>, alexandre.belloni@bootlin.com,
        miquel.raynal@bootlin.com, conor.culhane@silvaco.com,
        joe@perches.com, linux-i3c@lists.infradead.org,
        linux-kernel@vger.kernel.org, imx@lists.linux.dev
References: <20231016154632.2851957-1-Frank.Li@nxp.com>
 <20231016154632.2851957-3-Frank.Li@nxp.com>
Content-Language: en-US
From:   Jarkko Nikula <jarkko.nikula@linux.intel.com>
In-Reply-To: <20231016154632.2851957-3-Frank.Li@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

On 10/16/23 18:46, Frank Li wrote:
> In MIPI I3C Specification:
> 
> "Ninth Bit of SDR Target Returned (Read) Data as End-of-Data: In I2C, the
> ninth Data bit from Target to Controller is an ACK by the Controller. By
> contrast, in I3C this bit allows the Target to end a Read, and allows the
> Controller to Abort a Read. In SDR terms, the ninth bit of Read data is
> referred to as the T-Bit (for ‘Transition’)"
> 
> I3C allow devices early terminate data transfer. So need "actual" field to
> indicate how much get by i3c_priv_xfer.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>   include/linux/i3c/device.h | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/include/linux/i3c/device.h b/include/linux/i3c/device.h
> index 90fa83464f00..f2fa7ee5d96d 100644
> --- a/include/linux/i3c/device.h
> +++ b/include/linux/i3c/device.h
> @@ -66,6 +66,7 @@ struct i3c_priv_xfer {
>   		void *in;
>   		const void *out;
>   	} data;
> +	u16 actual;
>   	enum i3c_error_code err;
>   };
>   
Would this be more clear if named as "actual_len" and put next after 
"len" field in this structure? Also kerneldoc comment is missing.
