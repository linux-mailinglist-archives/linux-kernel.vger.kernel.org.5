Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C7497DEBB9
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 05:16:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348434AbjKBEOe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 00:14:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348268AbjKBEOb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 00:14:31 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F370EA6;
        Wed,  1 Nov 2023 21:14:28 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9AD8F2F4;
        Wed,  1 Nov 2023 21:15:10 -0700 (PDT)
Received: from [10.163.33.23] (unknown [10.163.33.23])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7770B3F67D;
        Wed,  1 Nov 2023 21:14:25 -0700 (PDT)
Message-ID: <afc147f5-4bf5-4d8f-88de-df6067b8ab52@arm.com>
Date:   Thu, 2 Nov 2023 09:44:30 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] coresight: etm4x: Fix width of CCITMIN field
To:     James Clark <james.clark@arm.com>, coresight@lists.linaro.org,
        suzuki.poulose@arm.com
Cc:     stable@vger.kernel.org, Mike Leach <mike.leach@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20231030102940.115078-1-james.clark@arm.com>
Content-Language: en-US
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20231030102940.115078-1-james.clark@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/30/23 15:59, James Clark wrote:
> CCITMIN is a 12 bit field and doesn't fit in a u8, so extend it to u16.
> This probably wasn't an issue previously because values higher than 255
> never occurred.
> 
> But since commit 0f55b43dedcd ("coresight: etm: Override TRCIDR3.CCITMIN
> on errata affected cpus"), a comparison with 256 was done to enable the
> errata, generating the following W=1 build error:
> 
>   coresight-etm4x-core.c:1188:24: error: result of comparison of
>   constant 256 with expression of type 'u8' (aka 'unsigned char') is
>   always false [-Werror,-Wtautological-constant-out-of-range-compare]
> 
>    if (drvdata->ccitmin == 256)
> 
> Cc: stable@vger.kernel.org
> Fixes: 54ff892b76c6 ("coresight: etm4x: splitting struct etmv4_drvdata")
> Signed-off-by: James Clark <james.clark@arm.com>
> ---
>  drivers/hwtracing/coresight/coresight-etm4x.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-etm4x.h b/drivers/hwtracing/coresight/coresight-etm4x.h
> index 20e2e4cb7614..da17b6c49b0f 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x.h
> +++ b/drivers/hwtracing/coresight/coresight-etm4x.h
> @@ -1036,7 +1036,7 @@ struct etmv4_drvdata {
>  	u8				ctxid_size;
>  	u8				vmid_size;
>  	u8				ccsize;
> -	u8				ccitmin;
> +	u16				ccitmin;
>  	u8				s_ex_level;
>  	u8				ns_ex_level;
>  	u8				q_support;

Thanks James, so this takes care of the Smatch static checker
warning as reported by Dan Carpenter earlier.

Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
