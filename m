Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D03C67823E1
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 08:48:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233416AbjHUGr7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 02:47:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230261AbjHUGr7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 02:47:59 -0400
Received: from smtp.smtpout.orange.fr (smtp-22.smtpout.orange.fr [80.12.242.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DE3A83
        for <linux-kernel@vger.kernel.org>; Sun, 20 Aug 2023 23:47:56 -0700 (PDT)
Received: from [192.168.1.18] ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id XyhbqE06S8hXQXyhcqw3V8; Mon, 21 Aug 2023 08:47:53 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1692600473;
        bh=VKY79l4BMS+XNL5J3gXH51QA4MGqOn2fyIFQ894irYI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=oNAWQvmZI2xUCvFd5vsfvc4Rg0xT2d57oXjSqUqVl4pql2iZjSkXoNLUed4xgtROS
         lMtOos2PRov4AvnMnHY3xputg8PHPn6P1PPDAF/JczkmsBgoGlYjAg46MdS/DsZ8xd
         Zu7nxgmgu3aG98h+TmKWs0qboDrUkArStJLQF4YcQzl/DjMsU9IryeQfJEENWxlBVL
         jOLsBDjvexg3I+bBvEyALisDOBRSqYBIz2kGHLko2gokb8cLE/noTRfU7rhg/OAP4x
         GcIDw2ZbeOAPMVq1waCs0uyCnzYsbkm7uKrrJmm76cJvt7AWCcM9G1oWg9DcQ5S4UV
         3qgzUpWmE2JVQ==
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Mon, 21 Aug 2023 08:47:53 +0200
X-ME-IP: 86.243.2.178
Message-ID: <7ac675b6-a000-6ad7-36f3-a3ce186414b6@wanadoo.fr>
Date:   Mon, 21 Aug 2023 08:47:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] drm/amdgpu: Avoid possible buffer overflow
Content-Language: fr
To:     Su Hui <suhui@nfschina.com>, alexander.deucher@amd.com,
        christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@gmail.com,
        daniel@ffwll.ch
Cc:     Hawking.Zhang@amd.com, le.ma@amd.com, lijo.lazar@amd.com,
        yifan1.zhang@amd.com, candice.li@amd.com, Yuliang.Shi@amd.com,
        guchun.chen@amd.com, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
References: <20230821061944.197934-1-suhui@nfschina.com>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20230821061944.197934-1-suhui@nfschina.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 21/08/2023 à 08:19, Su Hui a écrit :
> smatch error:
> drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c:1257 amdgpu_discovery_reg_base_init() error:
> testing array offset 'adev->vcn.num_vcn_inst' after use.
> 
> change the assignment order to avoid buffer overflow.
> 
> Fixes: c40bdfb2ffa4 ("drm/amdgpu: fix incorrect VCN revision in SRIOV")
> Signed-off-by: Su Hui <suhui@nfschina.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> index 8e1cfc87122d..ba95526c3d45 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> @@ -1250,11 +1250,12 @@ static int amdgpu_discovery_reg_base_init(struct amdgpu_device *adev)
>   				 *     0b10 : encode is disabled
>   				 *     0b01 : decode is disabled
>   				 */
> -				adev->vcn.vcn_config[adev->vcn.num_vcn_inst] =
> -					ip->revision & 0xc0;
> +
>   				ip->revision &= ~0xc0;
>   				if (adev->vcn.num_vcn_inst <
>   				    AMDGPU_MAX_VCN_INSTANCES) {
> +					adev->vcn.vcn_config[adev->vcn.num_vcn_inst] =
> +						ip->revision & 0xc0;

Hi,
I don't think that the patch is correct.

Because of the "ip->revision &= ~0xc0" which is now above it, 
"ip->revision & 0xc0" should now always be 0.

Maybe both lines should be moved within the "if"?

CJ





>   					adev->vcn.num_vcn_inst++;
>   					adev->vcn.inst_mask |=
>   						(1U << ip->instance_number);

