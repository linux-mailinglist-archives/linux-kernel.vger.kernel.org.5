Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 779B0753114
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 07:20:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234843AbjGNFUl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 01:20:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234821AbjGNFUe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 01:20:34 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94EF430E6
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 22:20:25 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 36E5Jfdk027988;
        Fri, 14 Jul 2023 00:19:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1689311981;
        bh=BHOrpK/ljgXl0AHtCNr8aSY5P0JKLJms+yaIGKw6ih0=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=jEJ3liBcQyVV9f0LSWRObZ1PVZdKL296Lv7B4XjyB62pAQ0GkRIEpM4gQhgMrUrfn
         c58P6Coc+VJ2WGOfzItdFbCqg4ZmlhuthWxmJHOKqbOV3XWZ3tAcHxYo1JDDlD4nQI
         DRrJfHTqtoISo9nCiH4/rJCtlH7S2G4uIqaWUxsI=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 36E5JeN5084901
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 14 Jul 2023 00:19:41 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 14
 Jul 2023 00:19:40 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 14 Jul 2023 00:19:40 -0500
Received: from [172.24.227.132] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 36E5JYQ4022078;
        Fri, 14 Jul 2023 00:19:35 -0500
Message-ID: <5bf5e4d1-546f-19fc-1647-7ece567d52f1@ti.com>
Date:   Fri, 14 Jul 2023 10:49:33 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v7 5/8] drm/bridge: sii902x: Support format negotiation
 hooks
To:     Sam Ravnborg <sam@ravnborg.org>
CC:     Tomi Valkeinen <tomba@kernel.org>, Jyri Sarha <jyri.sarha@iki.fi>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Swapnil Jakhade <sjakhade@cadence.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Francesco Dolcini <francesco@dolcini.it>,
        Nishanth Menon <nm@ti.com>,
        Jayesh Choudhary <j-choudhary@ti.com>,
        Rahul T R <r-ravikumar@ti.com>,
        Devarsh Thakkar <devarsht@ti.com>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        DRI Development List <dri-devel@lists.freedesktop.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Javier Martinez Canillas <javierm@redhat.com>
References: <20230606082142.23760-1-a-bhatia1@ti.com>
 <20230606082142.23760-6-a-bhatia1@ti.com>
 <20230710150822.GA5237@ravnborg.org>
Content-Language: en-US
From:   Aradhya Bhatia <a-bhatia1@ti.com>
In-Reply-To: <20230710150822.GA5237@ravnborg.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sam,

On 10-Jul-23 20:38, Sam Ravnborg wrote:
> Hi Aradhya,
> 
> On Tue, Jun 06, 2023 at 01:51:39PM +0530, Aradhya Bhatia wrote:
>> With new connector model, sii902x will not create the connector, when
>> DRM_BRIDGE_ATTACH_NO_CONNECTOR is set and SoC driver will rely on format
>> negotiation to setup the encoder format.
>>
>> Support format negotiations hooks in the drm_bridge_funcs.
>> Use helper functions for state management.
>>
>> Input format is selected to MEDIA_BUS_FMT_RGB888_1X24 as default, as is
>> the case with older model.
>>
>> Signed-off-by: Aradhya Bhatia <a-bhatia1@ti.com>
>> Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
> 
> As noted by Javier, this patch-set was forgotten, so sorry for not
> providing timely feedback.

Thank you for reviewing my patch nevertheless! =)

> 
> 
>> ---
>>
>> Notes:
>>
>>     changes from v6:
>>     * Add Neil Armstrong's R-b tag.
>>
>>  drivers/gpu/drm/bridge/sii902x.c | 25 +++++++++++++++++++++++++
>>  1 file changed, 25 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/bridge/sii902x.c b/drivers/gpu/drm/bridge/sii902x.c
>> index ef66461e7f7c..70aeb04b7f77 100644
>> --- a/drivers/gpu/drm/bridge/sii902x.c
>> +++ b/drivers/gpu/drm/bridge/sii902x.c
>> @@ -473,6 +473,27 @@ static struct edid *sii902x_bridge_get_edid(struct drm_bridge *bridge,
>>  	return sii902x_get_edid(sii902x, connector);
>>  }
>>  
>> +static u32 *sii902x_bridge_atomic_get_input_bus_fmts(struct drm_bridge *bridge,
>> +						     struct drm_bridge_state *bridge_state,
>> +						     struct drm_crtc_state *crtc_state,
>> +						     struct drm_connector_state *conn_state,
>> +						     u32 output_fmt,
>> +						     unsigned int *num_input_fmts)
>> +{
>> +	u32 *input_fmts;
>> +
>> +	*num_input_fmts = 0;
>> +
>> +	input_fmts = kcalloc(1, sizeof(*input_fmts), GFP_KERNEL);
>> +	if (!input_fmts)
>> +		return NULL;
>> +
>> +	input_fmts[0] = MEDIA_BUS_FMT_RGB888_1X24;
>> +	*num_input_fmts = 1;
>> +
>> +	return input_fmts;
>> +}
> 
> An alternative implementation of the above is:
> {
>         switch (output_fmt) {
>         case MEDIA_BUS_FMT_RGB888_1X24:
>                 break;
> 
>         default:
>         /* Fail for any other formats */
>                *num_input_fmts = 0;
>                 return NULL;
>         }
> 
>        return drm_atomic_helper_bridge_propagate_bus_fmt(bridge, bridge_state,
>                                                          crtc_state, conn_state,
>                                                          output_fmt,
>                                                          num_input_fmts);
> }
> 
> If you agree and have the time to do it it would be nice to use this
> simpler variant.
> Mostly so we avoid more open coded variants like you already did, and
> which we have plenty of already.

I agree with the idea that these hooks should get streamlined.

However, this particular approach will break things when the output_fmt
is defaulted to MEDIA_BUS_FMT_FIXED. Even if we add this format as a
fall-through case along with MEDIA_BUS_FMT_RGB888_1X24, tidss driver
will too then receive MEDIA_BUS_FMT_FIXED as an expected output format
and will throw an error.

The possibility of an equivalent if-check was discussed in the previous
version[1].

> 
> It would be even better to walk through other implementations of
> get_input_bus_fmts and update them accordingly.
> 
> Again, sorry for being late here. Feel free to ignore if you already
> moved on with something else.
> 

I am working on adding OLDI support for tidss, but if we can resolve the
above concern, and Javier agrees, I will be happy to add an incremental
fix for this! =)


Regards
Aradhya

[1]: https://patchwork.freedesktop.org/patch/536008/?series=82765&rev=6
