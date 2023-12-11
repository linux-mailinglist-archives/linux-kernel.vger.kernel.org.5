Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BF6180C2BB
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 09:07:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233931AbjLKIHn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 03:07:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233904AbjLKIHm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 03:07:42 -0500
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36DABED
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 00:07:46 -0800 (PST)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3BB877gp041704;
        Mon, 11 Dec 2023 02:07:07 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1702282027;
        bh=nQh0szUKn1fiUjn2eBJrcs5FIE908EQzylNliKwbDHc=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=Z1RSwQy3EJtECrlifpYfXVA13frkJ+cxKdh8d0QPx9GDYqAKIO7CDGgG3+bCmG+r7
         qSuoM0i7UvwN9H+stxX/2iCMcrKoGwVpSvjDZKS3uP8cWwOZxtYlqXhP73P6vCrPCK
         +FJr9qrkxOoJHI4pHhAxcygAmtiyX/jSWaxTpSbM=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3BB877hF073914
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 11 Dec 2023 02:07:07 -0600
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 11
 Dec 2023 02:07:07 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 11 Dec 2023 02:07:06 -0600
Received: from [172.24.227.25] (uda0496377.dhcp.ti.com [172.24.227.25])
        by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3BB871nQ074015;
        Mon, 11 Dec 2023 02:07:02 -0600
Message-ID: <f6af46e0-aadb-450a-9349-eec1337ea870@ti.com>
Date:   Mon, 11 Dec 2023 13:37:00 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] drm/bridge: tc358767: Fix
 DRM_BRIDGE_ATTACH_NO_CONNECTOR case
To:     Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sam Ravnborg <sam@ravnborg.org>,
        <dri-devel@lists.freedesktop.org>, <marex@denx.de>
CC:     <linux-kernel@vger.kernel.org>
References: <20231108-tc358767-v2-0-25c5f70a2159@ideasonboard.com>
 <3537389.iIbC2pHGDl@steina-w>
 <511f437b-89b5-4963-ae7d-dd66ab6db4fc@ideasonboard.com>
Content-Language: en-US
From:   Aradhya Bhatia <a-bhatia1@ti.com>
In-Reply-To: <511f437b-89b5-4963-ae7d-dd66ab6db4fc@ideasonboard.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 06/12/23 17:41, Tomi Valkeinen wrote:
> Hi,
> 
> On 08/11/2023 14:45, Alexander Stein wrote:
>> Hi Tomi,
>>
>> Am Mittwoch, 8. November 2023, 12:27:21 CET schrieb Tomi Valkeinen:
>>> These two patches are needed to make tc358767 work in the
>>> DRM_BRIDGE_ATTACH_NO_CONNECTOR case, at least when using a DP connector.
>>>
>>> I have tested this with TI AM654 EVM with a tc358767 add-on card
>>> connected to a DP monitor.
>>
>> Just a question regarding the usage of this DSI-DP bridge.
>> What is the state of the DSI lanes after the DSI host has been
>> initialized,
>> but before calling atomic_pre_enable? AFAIK this bridge requires LP-11
>> on DSI
>> at any time for accessing the AUX channel.

+ Marek

Marek, Alexander,

A quick grep tells me that you have added devicetree for tc358767 in DSI
to (e)DP mode on other platforms. Could you please test these patches
and report if you find any issue?

Regards
Aradhya

> 
> We haven't received any test reports for the DSI-DP case... I was
> looking at the datasheet, and I wonder, why do you say the bridge
> requires DSI to be up for the AUX transactions?
> 
>  Tomi
> 
>> Best regards,
>> Alexander
>>
>>> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
>>> ---
>>> Changes in v2:
>>> - Update the format negotiation patch as discussed in
>>> https://lore.kernel.org/all/7ddf0edb-2925-4b7c-ad07-27c030dd0232@ti.com/ -
>>> Link to v1:
>>> https://lore.kernel.org/r/20231031-tc358767-v1-0-392081ad9f4b@ideasonboard.
>>> com
>>>
>>> ---
>>> Aradhya Bhatia (1):
>>>        drm/bridge: tc358767: Add format negotiation hooks for DPI/DSI to
>>> (e)DP
>>>
>>> Tomi Valkeinen (1):
>>>        drm/bridge: tc358767: Fix link properties discovery
>>>
>>>   drivers/gpu/drm/bridge/tc358767.c | 32
>>> ++++++++++++++++++++++++++++++++
>>>   1 file changed, 32 insertions(+)
>>> ---
>>> base-commit: 9d7c8c066916f231ca0ed4e4fce6c4b58ca3e451
>>> change-id: 20231031-tc358767-58e3ebdf95f0
>>>
>>> Best regards,
>>
>>
> 
