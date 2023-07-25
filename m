Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F509760C7E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 09:57:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231941AbjGYH5E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 03:57:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231714AbjGYH5C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 03:57:02 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B240BF;
        Tue, 25 Jul 2023 00:57:00 -0700 (PDT)
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36P5AZTf027943;
        Tue, 25 Jul 2023 09:56:50 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=9ZV785p8IMVr0nD8KXmAR86qRA4i/cYx3WyPNy2LyDk=;
 b=oSvGYs5GiJjzbiWhJxQITAnR8wr4jWyDESjNmt/fBhngdl1RiWvuQvpM3b1oalZ1BInr
 vDRccXPvNMZuh3F/tI6Ar/5r0eLs0gQfEIDKG+Qj7ayQNvJGnMD1a8++8e60v73jqO9c
 AKjCOHVGejVQ3GX95vAjkeTe2Ar5oFDqKr/Lgc/ooEPdX9vmrC5NVc1kI0L4g/uiSsYc
 6eJUqC36V1zvufRC0C5zoUT4X95au+vbmBrXg66g0Y3506IuFWuT1tInUEotecymxB91
 uJaG0RLsTcZwRLj9M6p+3cNgWW5Pr7xjtSluh5Vb12rITA/4Q7CJXaooGaDoUOsOH+md cg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3s280nrxnx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Jul 2023 09:56:50 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 84E38100048;
        Tue, 25 Jul 2023 09:56:49 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 6DF5E215BE5;
        Tue, 25 Jul 2023 09:56:49 +0200 (CEST)
Received: from [10.129.166.114] (10.129.166.114) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Tue, 25 Jul
 2023 09:56:49 +0200
Message-ID: <3f593961-ab8a-8498-9b34-1ce729a5f026@foss.st.com>
Date:   Tue, 25 Jul 2023 09:56:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 1/2] media: i2c: st_mipid02: cascade s_stream call to
 the source subdev
To:     Alain Volmat <alain.volmat@foss.st.com>,
        Sylvain Petinot <sylvain.petinot@foss.st.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
CC:     <linux-media@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230721120316.1172445-1-alain.volmat@foss.st.com>
 <20230721120316.1172445-2-alain.volmat@foss.st.com>
Content-Language: en-US
From:   Benjamin Mugnier <benjamin.mugnier@foss.st.com>
In-Reply-To: <20230721120316.1172445-2-alain.volmat@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.129.166.114]
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-25_02,2023-07-24_01,2023-05-22_02
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alain,

Reviewed-By: Benjamin Mugnier <benjamin.mugnier@foss.st.com>

On 7/21/23 14:03, Alain Volmat wrote:
> Cascade the s_stream call to the source subdev whenever the bridge
> streaming is enable / disabled.
> 
> Signed-off-by: Alain Volmat <alain.volmat@foss.st.com>
> ---
> v2: correct uninitialized ret variable in mipid02_stream_disable
> 
>  drivers/media/i2c/st-mipid02.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/media/i2c/st-mipid02.c b/drivers/media/i2c/st-mipid02.c
> index 906553a28676..ee456bd4cf76 100644
> --- a/drivers/media/i2c/st-mipid02.c
> +++ b/drivers/media/i2c/st-mipid02.c
> @@ -545,7 +545,14 @@ static int mipid02_configure_from_code(struct mipid02_dev *bridge)
>  static int mipid02_stream_disable(struct mipid02_dev *bridge)
>  {
>  	struct i2c_client *client = bridge->i2c_client;
> -	int ret;
> +	int ret = -EINVAL;
> +
> +	if (!bridge->s_subdev)
> +		goto error;
> +
> +	ret = v4l2_subdev_call(bridge->s_subdev, video, s_stream, 0);
> +	if (ret)
> +		goto error;
>  
>  	/* Disable all lanes */
>  	ret = mipid02_write_reg(bridge, MIPID02_CLK_LANE_REG1, 0);
> @@ -633,6 +640,10 @@ static int mipid02_stream_enable(struct mipid02_dev *bridge)
>  	if (ret)
>  		goto error;
>  
> +	ret = v4l2_subdev_call(bridge->s_subdev, video, s_stream, 1);
> +	if (ret)
> +		goto error;
> +
>  	return 0;
>  
>  error:

-- 
Regards,

Benjamin
