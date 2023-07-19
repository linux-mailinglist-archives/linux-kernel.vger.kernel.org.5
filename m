Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A22C37592F7
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 12:28:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231134AbjGSK2S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 06:28:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231337AbjGSK1j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 06:27:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DD9A2690;
        Wed, 19 Jul 2023 03:26:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3FA6460DFA;
        Wed, 19 Jul 2023 10:26:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DF1FC433C8;
        Wed, 19 Jul 2023 10:26:39 +0000 (UTC)
Message-ID: <cd0a1ec0-5ab9-dc14-b1ca-c990b062b3c5@xs4all.nl>
Date:   Wed, 19 Jul 2023 12:26:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 1/2] media: i2c: st_mipid02: cascade s_stream call to the
 source subdev
Content-Language: en-US
To:     Alain Volmat <alain.volmat@foss.st.com>,
        Benjamin Mugnier <benjamin.mugnier@foss.st.com>,
        Sylvain Petinot <sylvain.petinot@foss.st.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230711123211.794838-1-alain.volmat@foss.st.com>
 <20230711123211.794838-2-alain.volmat@foss.st.com>
From:   Hans Verkuil <hverkuil@xs4all.nl>
In-Reply-To: <20230711123211.794838-2-alain.volmat@foss.st.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/07/2023 14:32, Alain Volmat wrote:
> Cascade the s_stream call to the source subdev whenever the bridge
> streaming is enable / disabled.
> 
> Signed-off-by: Alain Volmat <alain.volmat@foss.st.com>
> ---
>  drivers/media/i2c/st-mipid02.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/media/i2c/st-mipid02.c b/drivers/media/i2c/st-mipid02.c
> index 906553a28676..703d2f06f552 100644
> --- a/drivers/media/i2c/st-mipid02.c
> +++ b/drivers/media/i2c/st-mipid02.c
> @@ -547,6 +547,13 @@ static int mipid02_stream_disable(struct mipid02_dev *bridge)
>  	struct i2c_client *client = bridge->i2c_client;
>  	int ret;
>  
> +	if (!bridge->s_subdev)
> +		goto error;

I'm getting this compiler warning:

media-git/drivers/media/i2c/st-mipid02.c: In function 'mipid02_stream_disable':
media-git/drivers/media/i2c/st-mipid02.c:568:12: warning: 'ret' may be used uninitialized [-Wmaybe-uninitialized]
  568 |         if (ret)
      |            ^
media-git/drivers/media/i2c/st-mipid02.c:548:13: note: 'ret' was declared here
  548 |         int ret;
      |             ^~~

I'm dropping this series, waiting for a v2.

Regards,

	Hans

> +
> +	ret = v4l2_subdev_call(bridge->s_subdev, video, s_stream, 0);
> +	if (ret)
> +		goto error;
> +
>  	/* Disable all lanes */
>  	ret = mipid02_write_reg(bridge, MIPID02_CLK_LANE_REG1, 0);
>  	if (ret)
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

