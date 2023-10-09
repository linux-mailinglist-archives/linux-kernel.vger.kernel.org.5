Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 693BC7BD45D
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 09:32:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345411AbjJIHci (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 03:32:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345374AbjJIHch (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 03:32:37 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF67E8F;
        Mon,  9 Oct 2023 00:32:34 -0700 (PDT)
Received: from ideasonboard.com (93-61-96-190.ip145.fastwebnet.it [93.61.96.190])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 83DAC7E4;
        Mon,  9 Oct 2023 09:32:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1696836751;
        bh=3QK4iSojWRUpmqVExn0tXJeVZEiI3looQsXR+PrQlLY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tlKa28v7z6OEv7n8r6ksdbPCv6oMqJPKgM6vPAbl70l0oiX3GwbHxOfFGls+kNCmx
         DlOrAqqVoDfkAXl+qqrbuA2yH+JUwSnpEmCq76AJssFOz2bOh/8FUAvzrA0GGcJNgA
         +wXcHmD8dlefbCwgDACzsC+JCYUfJQvaZAXybX94=
Date:   Mon, 9 Oct 2023 09:32:28 +0200
From:   Jacopo Mondi <jacopo.mondi@ideasonboard.com>
To:     =?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>
Cc:     linux-rockchip@lists.infradead.org,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Jacopo Mondi <jacopo.mondi@ideasonboard.com>,
        Nicholas Roth <nicholas@rothemail.net>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        "open list:V4L2 CAMERA SENSOR DRIVERS" <linux-media@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] media: i2c: ov8858: Don't set fwnode in the driver
Message-ID: <3if2lurlnceoddef64qdahztus6ysyaz333x6ty3agzqqrugxo@sowcvbdf2tqe>
References: <20231007130004.942369-1-megi@xff.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231007130004.942369-1-megi@xff.cz>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ondřej,

On Sat, Oct 07, 2023 at 03:00:00PM +0200, Ondřej Jirman wrote:
> From: Ondrej Jirman <megi@xff.cz>
>
> This makes the driver work with the new check in
> v4l2_async_register_subdev() that was introduced recently in 6.6-rc1.
> Without this change, probe fails with:
>
> ov8858 1-0036: Detected OV8858 sensor, revision 0xb2
> ov8858 1-0036: sub-device fwnode is an endpoint!
> ov8858 1-0036: v4l2 async register subdev failed
> ov8858: probe of 1-0036 failed with error -22
>
> This also simplifies the driver a bit.
>
> Signed-off-by: Ondrej Jirman <megi@xff.cz>
> ---
>  drivers/media/i2c/ov8858.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/media/i2c/ov8858.c b/drivers/media/i2c/ov8858.c
> index 3af6125a2eee..b862dc9604cc 100644
> --- a/drivers/media/i2c/ov8858.c
> +++ b/drivers/media/i2c/ov8858.c
> @@ -1868,7 +1868,7 @@ static int ov8858_parse_of(struct ov8858 *ov8858)
>  		return -EINVAL;
>  	}
>
> -	ov8858->subdev.fwnode = endpoint;
> +	fwnode_handle_put(endpoint);

ov8858_parse_of() could be further simplified with:

--- a/drivers/media/i2c/ov8858.c
+++ b/drivers/media/i2c/ov8858.c
@@ -1850,9 +1850,9 @@ static int ov8858_parse_of(struct ov8858 *ov8858)
        }

        ret = v4l2_fwnode_endpoint_parse(endpoint, &vep);
+       fwnode_handle_put(endpoint);
        if (ret) {
                dev_err(dev, "Failed to parse endpoint: %d\n", ret);
-               fwnode_handle_put(endpoint);
                return ret;
        }

@@ -1864,12 +1864,9 @@ static int ov8858_parse_of(struct ov8858 *ov8858)
        default:
                dev_err(dev, "Unsupported number of data lanes %u\n",
                        ov8858->num_lanes);
-               fwnode_handle_put(endpoint);
                return -EINVAL;
        }

-       ov8858->subdev.fwnode = endpoint;
-
        return 0;
 }

 Do you think it's worth doing so ?

>
>  	return 0;
>  }
> @@ -1913,7 +1913,7 @@ static int ov8858_probe(struct i2c_client *client)
>
>  	ret = ov8858_init_ctrls(ov8858);
>  	if (ret)
> -		goto err_put_fwnode;
> +		return ret;
>
>  	sd = &ov8858->subdev;
>  	sd->flags |= V4L2_SUBDEV_FL_HAS_DEVNODE | V4L2_SUBDEV_FL_HAS_EVENTS;
> @@ -1964,8 +1964,6 @@ static int ov8858_probe(struct i2c_client *client)
>  	media_entity_cleanup(&sd->entity);
>  err_free_handler:
>  	v4l2_ctrl_handler_free(&ov8858->ctrl_handler);
> -err_put_fwnode:
> -	fwnode_handle_put(ov8858->subdev.fwnode);
>
>  	return ret;
>  }
> @@ -1978,7 +1976,6 @@ static void ov8858_remove(struct i2c_client *client)
>  	v4l2_async_unregister_subdev(sd);
>  	media_entity_cleanup(&sd->entity);
>  	v4l2_ctrl_handler_free(&ov8858->ctrl_handler);
> -	fwnode_handle_put(ov8858->subdev.fwnode);
>
>  	pm_runtime_disable(&client->dev);
>  	if (!pm_runtime_status_suspended(&client->dev))

The rest looks good!

Thanks
  j

> --
> 2.42.0
>
