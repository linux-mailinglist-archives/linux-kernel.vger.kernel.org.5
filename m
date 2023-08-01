Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7009776B6D9
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 16:09:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232174AbjHAOJc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 10:09:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjHAOJa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 10:09:30 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CB27DC;
        Tue,  1 Aug 2023 07:09:29 -0700 (PDT)
Received: from [192.168.88.20] (91-154-35-171.elisa-laajakaista.fi [91.154.35.171])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 22C153D4;
        Tue,  1 Aug 2023 16:08:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1690898904;
        bh=AKhNe9lLGHyfMQW05HQcyrPYYc3XqCqI6N9O18uveiw=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=al87coiPd9LMS5JItxgVCEVmxbEccBqT+I5CEPd3yWlRWSAI9H3YAiOGyuzFJgLYq
         14Atv7/Jh5GZf+Q1e1jhi7CBGWVW/vUt6Utdl1CYreM3UzivntKK0KIryAil6em5tr
         mGJYiTKXb7aD05NNdbqhArrmOc5guYqqMdc0RS5w=
Message-ID: <3a5a3d5a-f2f1-f84b-f189-ad56ff77e431@ideasonboard.com>
Date:   Tue, 1 Aug 2023 17:09:22 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v8 01/16] media: subdev: Export get_format helper for link
 validation
Content-Language: en-US
To:     Jai Luthra <j-luthra@ti.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        niklas.soderlund+renesas@ragnatech.se,
        Benoit Parrot <bparrot@ti.com>,
        Vaishnav Achath <vaishnav.a@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>, nm@ti.com,
        devarsht@ti.com
References: <20230731-upstream_csi-v8-0-fb7d3661c2c9@ti.com>
 <20230731-upstream_csi-v8-1-fb7d3661c2c9@ti.com>
From:   Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
In-Reply-To: <20230731-upstream_csi-v8-1-fb7d3661c2c9@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/07/2023 11:29, Jai Luthra wrote:
> For link validation on video device drivers, it may be required to
> match the formats set on the source subdev with the formats set on the
> video device.
> 
> Export the existing v4l2_subdev_link_validate_get_format() helper so it
> can be reused by such drivers.
> 
> Suggested-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Signed-off-by: Jai Luthra <j-luthra@ti.com>
> ---
> New in v8
> 
>   drivers/media/v4l2-core/v4l2-subdev.c |  8 ++++----
>   include/media/v4l2-subdev.h           | 12 ++++++++++++
>   2 files changed, 16 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/media/v4l2-core/v4l2-subdev.c b/drivers/media/v4l2-core/v4l2-subdev.c
> index 217b8019fb9b..0d3b5ff5cacc 100644
> --- a/drivers/media/v4l2-core/v4l2-subdev.c
> +++ b/drivers/media/v4l2-core/v4l2-subdev.c
> @@ -1130,10 +1130,9 @@ int v4l2_subdev_link_validate_default(struct v4l2_subdev *sd,
>   }
>   EXPORT_SYMBOL_GPL(v4l2_subdev_link_validate_default);
>   
> -static int
> -v4l2_subdev_link_validate_get_format(struct media_pad *pad, u32 stream,
> -				     struct v4l2_subdev_format *fmt,
> -				     bool states_locked)
> +int v4l2_subdev_link_validate_get_format(struct media_pad *pad, u32 stream,
> +					 struct v4l2_subdev_format *fmt,
> +					 bool states_locked)
>   {
>   	struct v4l2_subdev_state *state;
>   	struct v4l2_subdev *sd;
> @@ -1165,6 +1164,7 @@ v4l2_subdev_link_validate_get_format(struct media_pad *pad, u32 stream,
>   
>   	return ret;
>   }
> +EXPORT_SYMBOL_GPL(v4l2_subdev_link_validate_get_format);
>   
>   #if defined(CONFIG_VIDEO_V4L2_SUBDEV_API)
>   
> diff --git a/include/media/v4l2-subdev.h b/include/media/v4l2-subdev.h
> index a012741cc876..ef7007f46889 100644
> --- a/include/media/v4l2-subdev.h
> +++ b/include/media/v4l2-subdev.h
> @@ -1301,6 +1301,18 @@ int v4l2_subdev_link_validate_default(struct v4l2_subdev *sd,
>   				      struct v4l2_subdev_format *source_fmt,
>   				      struct v4l2_subdev_format *sink_fmt);
>   
> +/**
> + * v4l2_subdev_link_validate_get_format - get format for media link validation
> + *
> + * @pad: pad id
> + * @stream: stream id
> + * @fmt: pointer to &struct v4l2_subdev_format
> + * @states_locked: is the subdev state already locked
> + */
> +int v4l2_subdev_link_validate_get_format(struct media_pad *pad, u32 stream,
> +					 struct v4l2_subdev_format *fmt,
> +					 bool states_locked);
> +
>   /**
>    * v4l2_subdev_link_validate - validates a media link
>    *
> 

I don't know about this one... The 
v4l2_subdev_link_validate_get_format() is a bit of an internal function, 
especially with the relatively-new "states_locked" parameter. If it's 
made public, at least the "states_locked" should be renamed to 
"state_locked" (well, it could perhaps be renamed anyway).

But just looking at the function doc above, I think the developer's 
question would be "what does this do?". What does "get format for media 
link validation" mean? Is it similar to 
v4l2_subdev_state_get_stream_format() or v4l2_subdev_get_pad_format()? 
What does states_locked do?

How do you use this with multi-stream support? Do you lock the source, 
then validate all streams (with the help of this function), and then 
unlock? If yes, then all the states_locked stuff is extra, and all the 
function really does is v4l2_subdev_call(sd, pad, get_fmt, state, fmt). 
And if so, would it be clearer to just do that, instead of hiding it 
behind v4l2_subdev_link_validate_get_format()?

  Tomi

