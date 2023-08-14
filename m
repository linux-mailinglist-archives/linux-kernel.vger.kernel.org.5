Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7251577B310
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 09:55:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234365AbjHNHzH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 03:55:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234387AbjHNHyo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 03:54:44 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A00F210CE;
        Mon, 14 Aug 2023 00:54:35 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AC2072F4;
        Mon, 14 Aug 2023 00:55:17 -0700 (PDT)
Received: from pluto (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 12ABC3F6C4;
        Mon, 14 Aug 2023 00:54:33 -0700 (PDT)
Date:   Mon, 14 Aug 2023 08:54:23 +0100
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     Sibi Sankar <quic_sibis@quicinc.com>
Cc:     sudeep.holla@arm.com, lukasz.luba@arm.com,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, quic_rjendra@quicinc.com,
        srinivas.kandagatla@linaro.org,
        Chandra Sekhar Lingutla <quic_lingutla@quicinc.com>
Subject: Re: [PATCH] firmware: arm_scmi: Fixup perf microwatt support
Message-ID: <ZNndrw3fHbuYw9x0@pluto>
References: <20230811204818.30928-1-quic_sibis@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230811204818.30928-1-quic_sibis@quicinc.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 12, 2023 at 02:18:18AM +0530, Sibi Sankar wrote:
> The perf power scale value would currently be reported as bogowatts if the
> platform firmware supports microwatt power scale and meets the perf major
> version requirements. Fix this by populating version information in the
> driver private data before the call to protocol attributes is made.
> 
> CC: Chandra Sekhar Lingutla <quic_lingutla@quicinc.com>
> Fixes: 3630cd8130ce ("firmware: arm_scmi: Add SCMI v3.1 perf power-cost in microwatts")
> Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
> ---
>  drivers/firmware/arm_scmi/perf.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 

Hi,

LGTM.

Reviewed-by: Cristian Marussi <cristian.marussi@arm.com>

Thanks,
Cristian

> diff --git a/drivers/firmware/arm_scmi/perf.c b/drivers/firmware/arm_scmi/perf.c
> index c0cd556fbaae..30dedd6ebfde 100644
> --- a/drivers/firmware/arm_scmi/perf.c
> +++ b/drivers/firmware/arm_scmi/perf.c
> @@ -1080,6 +1080,8 @@ static int scmi_perf_protocol_init(const struct scmi_protocol_handle *ph)
>  	if (!pinfo)
>  		return -ENOMEM;
>  
> +	pinfo->version = version;
> +
>  	ret = scmi_perf_attributes_get(ph, pinfo);
>  	if (ret)
>  		return ret;
> @@ -1104,8 +1106,6 @@ static int scmi_perf_protocol_init(const struct scmi_protocol_handle *ph)
>  	if (ret)
>  		return ret;
>  
> -	pinfo->version = version;
> -
>  	return ph->set_priv(ph, pinfo);
>  }
>  
> -- 
> 2.17.1
> 
