Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A122E76CC53
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 14:09:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233737AbjHBMJj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 08:09:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233740AbjHBMJh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 08:09:37 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20D9D1BF9;
        Wed,  2 Aug 2023 05:09:35 -0700 (PDT)
Received: from [192.168.88.20] (91-154-35-171.elisa-laajakaista.fi [91.154.35.171])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 0A4D08DA;
        Wed,  2 Aug 2023 14:08:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1690978110;
        bh=dFHjp0u14PNVIqbD7MDsFSNrr4G9iZZbUmhtrzJ8pZ0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=lXGYLSBlj7V8uWwGIPM0yWgf20TFiBhd2F7+uTiiPGxlwLSOO0N8a87U2TQUwdfw7
         IxADMafWg58moT3hclaJjCvShTZOJ1FQ/kYzNMUGoBni76Vu8DMz006+97q2+Cnvut
         UciMioHBfTnSPbeBqFy0DhBoAU0vSozExkHbgcK0=
Message-ID: <00e1bb24-c2c0-e24b-9852-3b40858859cf@ideasonboard.com>
Date:   Wed, 2 Aug 2023 15:09:29 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v8 16/16] media: ti: Add CSI2RX support for J721E
Content-Language: en-US
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     Jai Luthra <j-luthra@ti.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        niklas.soderlund+renesas@ragnatech.se,
        Benoit Parrot <bparrot@ti.com>,
        Vaishnav Achath <vaishnav.a@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>, nm@ti.com,
        devarsht@ti.com
References: <20230731-upstream_csi-v8-0-fb7d3661c2c9@ti.com>
 <20230731-upstream_csi-v8-16-fb7d3661c2c9@ti.com>
 <d5d9f2cb-9879-9f25-9b5c-b3b43d551658@ideasonboard.com>
 <ZMo6gtN/4sQz44tH@kekkonen.localdomain>
From:   Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
In-Reply-To: <ZMo6gtN/4sQz44tH@kekkonen.localdomain>
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

On 02/08/2023 14:14, Sakari Ailus wrote:
> Moi,
> 
> On Wed, Aug 02, 2023 at 02:04:57PM +0300, Tomi Valkeinen wrote:
>>> +static int ti_csi2rx_enum_fmt_vid_cap(struct file *file, void *priv,
>>> +				      struct v4l2_fmtdesc *f)
>>> +{
>>> +	const struct ti_csi2rx_fmt *fmt = NULL;
>>> +
>>> +	if (f->mbus_code) {
>>> +		if (f->index > 0)
>>> +			return -EINVAL;
>>
>> This fails to enumerate the formats if mbus_code is set, doesn't it?
> 
> This is intentional: if the mbus_code field is set, you're supposed to get
> only format(s) corresponding to that mbus code.

Right. But the above code doesn't do that, does it? It will only return 
the first format, and error for anything else. Ah, the driver only 
supports a single mbus code per fourcc. In that case it's ok.

  Tomi

>>
>>> +
>>> +		fmt = find_format_by_code(f->mbus_code);
>>> +	} else {
>>> +		if (f->index >= num_formats)
>>> +			return -EINVAL;
>>> +
>>> +		fmt = &formats[f->index];
>>> +	}
>>> +
>>> +	if (!fmt)
>>> +		return -EINVAL;
>>> +
>>> +	f->pixelformat = fmt->fourcc;
>>> +	memset(f->reserved, 0, sizeof(f->reserved));
>>> +	f->type = V4L2_BUF_TYPE_VIDEO_CAPTURE;
>>> +
>>> +	return 0;
>>> +}
> 

