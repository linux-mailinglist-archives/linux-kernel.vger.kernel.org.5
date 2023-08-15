Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A364377CC4C
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 14:06:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237004AbjHOMGX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 08:06:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237015AbjHOMFw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 08:05:52 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C76CB173C;
        Tue, 15 Aug 2023 05:05:46 -0700 (PDT)
Received: from [192.168.88.20] (91-154-35-171.elisa-laajakaista.fi [91.154.35.171])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 8FB2D6BE;
        Tue, 15 Aug 2023 14:04:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1692101071;
        bh=z0PuRlOPSM7m9+UtKr3fBFzofL+sYR2WdbiV0aUsETk=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Nzcy/V9oMsRCzey3fPoE4VFz10+o86wZSBRDpsc26jiGD5ubPE6AIYGCYdKHhf3c+
         ah+TZZ936iSyctp9zUWZp9+G1CJVh008AlMczR9gDu+9VeP2Pp9vZLcUcZDyfQXGpr
         DoEp8GPaX4naIS08pk9Nv4Ez7gz+/A95COZH+NaY=
Message-ID: <be652e97-24ec-a9e8-88b0-ca71a596921e@ideasonboard.com>
Date:   Tue, 15 Aug 2023 15:05:39 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v9 05/13] media: cadence: csi2rx: Add get_fmt and set_fmt
 pad ops
To:     Jai Luthra <j-luthra@ti.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        niklas.soderlund+renesas@ragnatech.se,
        Benoit Parrot <bparrot@ti.com>,
        Vaishnav Achath <vaishnav.a@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>, nm@ti.com,
        devarsht@ti.com, a-bhatia1@ti.com,
        Martyn Welch <martyn.welch@collabora.com>,
        Julien Massot <julien.massot@collabora.com>
References: <20230811-upstream_csi-v9-0-8943f7a68a81@ti.com>
 <20230811-upstream_csi-v9-5-8943f7a68a81@ti.com>
Content-Language: en-US
From:   Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
In-Reply-To: <20230811-upstream_csi-v9-5-8943f7a68a81@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/08/2023 13:47, Jai Luthra wrote:
> From: Pratyush Yadav <p.yadav@ti.com>
> 
> The format is needed to calculate the link speed for the external DPHY
> configuration. It is not right to query the format from the source
> subdev. Add get_fmt and set_fmt pad operations so that the format can be
> configured and correct bpp be selected.
> 
> Initialize and use the v4l2 subdev active state to keep track of the
> active formats. Also propagate the new format from the sink pad to all
> the source pads.
> 
> Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
> Co-authored-by: Jai Luthra <j-luthra@ti.com>
> Reviewed-by: Maxime Ripard <mripard@kernel.org>
> Signed-off-by: Jai Luthra <j-luthra@ti.com>
> ---
> Changes from v8:
>      - Squash the patch adding RAW8 and RAW10 formats within this one
>      - Single line struct entries in formats[] array
>      - Skip specifiying redundant format.which entry in init_cfg()
> 

Reviewed-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>

  Tomi


