Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EAFB7E85E3
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 23:53:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229819AbjKJWxq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 17:53:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjKJWxp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 17:53:45 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7E84118
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 14:53:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=tOYDo1cN44RiDSLhxs/Illj/iOMmKhabusTff9O6hu0=; b=v71dnxDYZHCZAkGzhtHw4hR1y6
        a8dMFJswTCTC5/DAovSq9dmPAJ0JabpQZLRHRmFhIftoCZBuQvsPUmbrqlQsg4mhxDVe8js0KQiPL
        CTB/0jhgj8xqMqAWzYScg38eGDA/A1fuQajZ5VQFDhh4pEHKRfbyZLyv6qwZG7J4aNRa/YRtS9rQK
        f2+IelZQwXFWHV9LZXgY1+upS4Gg4+0snZLevvaR7VmCqa4pWktkkiCUNhGDEcyh6Ka9EKA9G5HYD
        MwSDwPq5xhNEADoxPkUFTsbaNJeuxjbGeUIbnZtkReqIoixjBJWgfqgnC+Gr0sgtVM0tGx3JFjt0X
        6VLdZXnA==;
Received: from [50.53.46.231] (helo=[192.168.254.15])
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1r1aNf-009aVR-2f;
        Fri, 10 Nov 2023 22:53:39 +0000
Message-ID: <3027ec81-304a-4501-808f-67596e61fb9f@infradead.org>
Date:   Fri, 10 Nov 2023 14:53:39 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd: Document device reset methods
Content-Language: en-US
To:     =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc:     kernel-dev@igalia.com, alexander.deucher@amd.com,
        christian.koenig@amd.com, ray.huang@amd.com
References: <20231110155548.20599-1-andrealmeid@igalia.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20231110155548.20599-1-andrealmeid@igalia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi--

On 11/10/23 07:55, André Almeida wrote:
> Document what each amdgpu driver reset method does.
> 
> Signed-off-by: André Almeida <andrealmeid@igalia.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index a79d53bdbe13..500f86c79eb7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -504,6 +504,26 @@ struct amdgpu_allowed_register_entry {
>  	bool grbm_indexed;
>  };
>  
> +/**
> + * enum amd_reset_method - Methods for resetting AMD GPU devices
> + *
> + * @AMD_RESET_METHOD_NONE: The device will not be reset.
> + * @AMD_RESET_LEGACY: Method reserved for SI/CIK asics.

                                                    ASICs.

> + * @AMD_RESET_MODE0: High level PCIe reset.
> + * @AMD_RESET_MODE1: Resets each IP block (SDMA, GFX, VCN, etc.) individually.
> + *                   Suitable only for some discrete GPUs.
> + * @AMD_RESET_MODE2: Resets only the GFX block. Useful for APUs, giving that
> + *                   the rest of IP blocks and SMU is shared with the CPU.
> + * @AMD_RESET_BACO: BACO (Bus Alive, Chip Off) method powers off and on the card
> + *                  but without powering off the PCI bus. Suitable only for
> + *                  discrete GPUs.
> + * @AMD_RESET_PCI: Does a full bus reset, including powering on and off the
> + *                 card.
> + *
> + * Methods available for AMD GPU driver for resetting the device. Not all
> + * methods are suitable for every device. User can overwrite the method using

s/overwrite/override/
would make more sense to me.

Otherwise looks good. Thanks.

> + * module parameter `reset_method`.
> + */
>  enum amd_reset_method {
>  	AMD_RESET_METHOD_NONE = -1,
>  	AMD_RESET_METHOD_LEGACY = 0,

-- 
~Randy
