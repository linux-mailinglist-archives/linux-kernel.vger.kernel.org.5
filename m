Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BDB07EE7AB
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 20:45:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345396AbjKPTps (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 14:45:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbjKPTpq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 14:45:46 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CE4F196
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 11:45:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700163940;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sPv6+1Sa94rgfObfXMphmchW6ouivMuvY1saNAx/w4Q=;
        b=FWhcCpMD3ejjS2BYpUofqsqAusy9F94CxXkEeGo4AGHq64mZXpSIZLYDuwHou7cBgxYzVD
        fN5deP89YCb819GBRnpNzGM1rxMir8MA2zNZa+NXp+QGR0HkDT4Z//ReOEIpS/ssFe3U7v
        xfpP63pn7WyYJ46XWdbMzFbdSCAWN9g=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-13-PgsDdbSqOEyMHJs-T3_PLA-1; Thu, 16 Nov 2023 14:45:39 -0500
X-MC-Unique: PgsDdbSqOEyMHJs-T3_PLA-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-9e1fb0308d6so85585866b.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 11:45:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700163938; x=1700768738;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sPv6+1Sa94rgfObfXMphmchW6ouivMuvY1saNAx/w4Q=;
        b=D8cYVLiFqqT2As8TanAJJFPafaeHf00n+lz7iXFGuuF5nuq+KsLG59tTytvTs1cC3g
         CM3M1JUzBeduVz5yxX7Y3pP8yS2FPp59Gws9QdjOan1euk3yO0tor6qSVG9i0PXAFcPT
         kBoCA8yeHe2fFyC26phqST7Q+E1DtnUjcFhKcBodqgScmqOLyrBUbpllQNZnAysbPand
         0HNMOmFHTq1LYw4ebN08Fy3XCZL4DFm1qeErNxy5Qcq65eXBAYz/znpW3LhUpbZ/NPeP
         x6WnAWI9CIY7ABlF3p+vdcEfm67PAE2sjEShYn6msw9dLSeIeBgE4UueSQ2MS7YCgFZW
         K88w==
X-Gm-Message-State: AOJu0Yz7MW4Vf+P8c+Sy8k+snH63hv2S+rkQYTHO1TD1zXdplKm4e8oU
        aZd65u3xgllITl2o8gVRhOUMNkcW4+ukbfX+dwIjJngrVLZbJvSG7N/P3J25YlP8lkQdtUSGtHM
        Llk4NdqssXaOJVQBCb7IbYuLr
X-Received: by 2002:a17:906:6d4e:b0:9ba:1d08:ad43 with SMTP id a14-20020a1709066d4e00b009ba1d08ad43mr12608771ejt.70.1700163937814;
        Thu, 16 Nov 2023 11:45:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHq5/tnfwnzHJdeqlubHm24XqYASLf5h9KV93zPhLD7kixnisyCvTTF1mPX7goyJbwx62HiBA==
X-Received: by 2002:a17:906:6d4e:b0:9ba:1d08:ad43 with SMTP id a14-20020a1709066d4e00b009ba1d08ad43mr12608750ejt.70.1700163937326;
        Thu, 16 Nov 2023 11:45:37 -0800 (PST)
Received: from pollux ([2a02:810d:4b3f:de9c:abf:b8ff:feee:998b])
        by smtp.gmail.com with ESMTPSA id y3-20020a17090629c300b009b94fe3fc47sm8733916eje.159.2023.11.16.11.45.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Nov 2023 11:45:36 -0800 (PST)
Date:   Thu, 16 Nov 2023 20:45:34 +0100
From:   Danilo Krummrich <dakr@redhat.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Karol Herbst <kherbst@redhat.com>, Lyude Paul <lyude@redhat.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, nouveau@lists.freedesktop.org,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH][next] nouveau/gsp: replace zero-length array with
 flex-array member and use __counted_by
Message-ID: <ZVZxXiXYIzEwUE3N@pollux>
References: <ZVZbX7C5suLMiBf+@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZVZbX7C5suLMiBf+@work>
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gustavo,

On Thu, Nov 16, 2023 at 12:11:43PM -0600, Gustavo A. R. Silva wrote:
> Fake flexible arrays (zero-length and one-element arrays) are deprecated,
> and should be replaced by flexible-array members. So, replace
> zero-length array with a flexible-array member in `struct
> PACKED_REGISTRY_TABLE`.
> 
> Also annotate array `entries` with `__counted_by()` to prepare for the
> coming implementation by GCC and Clang of the `__counted_by` attribute.
> Flexible array members annotated with `__counted_by` can have their
> accesses bounds-checked at run-time via `CONFIG_UBSAN_BOUNDS` (for array
> indexing) and `CONFIG_FORTIFY_SOURCE` (for strcpy/memcpy-family functions).
> 
> This fixes multiple -Warray-bounds warnings:
> drivers/gpu/drm/nouveau/nvkm/subdev/gsp/r535.c:1069:29: warning: array subscript 0 is outside array bounds of 'PACKED_REGISTRY_ENTRY[0]' [-Warray-bounds=]
> drivers/gpu/drm/nouveau/nvkm/subdev/gsp/r535.c:1070:29: warning: array subscript 0 is outside array bounds of 'PACKED_REGISTRY_ENTRY[0]' [-Warray-bounds=]
> drivers/gpu/drm/nouveau/nvkm/subdev/gsp/r535.c:1071:29: warning: array subscript 0 is outside array bounds of 'PACKED_REGISTRY_ENTRY[0]' [-Warray-bounds=]
> drivers/gpu/drm/nouveau/nvkm/subdev/gsp/r535.c:1072:29: warning: array subscript 0 is outside array bounds of 'PACKED_REGISTRY_ENTRY[0]' [-Warray-bounds=]
> 
> While there, also make use of the struct_size() helper, and address
> checkpatch.pl warning:
> WARNING: please, no spaces at the start of a line
> 
> This results in no differences in binary output.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
>  .../nvrm/535.113.01/nvidia/generated/g_os_nvoc.h   | 14 +++++++-------
>  drivers/gpu/drm/nouveau/nvkm/subdev/gsp/r535.c     |  2 +-
>  2 files changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/gpu/drm/nouveau/include/nvrm/535.113.01/nvidia/generated/g_os_nvoc.h b/drivers/gpu/drm/nouveau/include/nvrm/535.113.01/nvidia/generated/g_os_nvoc.h
> index 754c6af42f30..259b25c2ac6b 100644
> --- a/drivers/gpu/drm/nouveau/include/nvrm/535.113.01/nvidia/generated/g_os_nvoc.h
> +++ b/drivers/gpu/drm/nouveau/include/nvrm/535.113.01/nvidia/generated/g_os_nvoc.h
> @@ -28,17 +28,17 @@
>  
>  typedef struct PACKED_REGISTRY_ENTRY
>  {
> -    NvU32                   nameOffset;
> -    NvU8                    type;
> -    NvU32                   data;
> -    NvU32                   length;
> +	NvU32                   nameOffset;
> +	NvU8                    type;
> +	NvU32                   data;
> +	NvU32                   length;
>  } PACKED_REGISTRY_ENTRY;
>  
>  typedef struct PACKED_REGISTRY_TABLE
>  {
> -    NvU32                   size;
> -    NvU32                   numEntries;
> -    PACKED_REGISTRY_ENTRY   entries[0];
> +	NvU32                   size;
> +	NvU32                   numEntries;
> +	PACKED_REGISTRY_ENTRY   entries[] __counted_by(numEntries);
>  } PACKED_REGISTRY_TABLE;

Thanks for the fix!

However, I have some concerns about changing those header files, since they're
just copied over from Nvidia's driver [1].

Once we add the header files for a new firmware revision, we'd potentially run
into the same issue, applying the same fix again.

As I already mentioned for Timur's patch [2], I'd prefer to get a fix upstream
(meaning [1] in this case). Of course, that's probably more up to Timur to tell
if this will work out.

If we can't get a fix upstream, I'd probably prefer to silence warning
elsewhere.

[1] https://github.com/NVIDIA/open-gpu-kernel-modules
[2] https://lore.kernel.org/all/20231107234726.854248-1-ttabi@nvidia.com/T/

>  
>  #endif
> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/r535.c b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/r535.c
> index dc44f5c7833f..228335487af5 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/r535.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/r535.c
> @@ -1048,7 +1048,7 @@ r535_gsp_rpc_set_registry(struct nvkm_gsp *gsp)
>  	char *strings;
>  	int str_offset;
>  	int i;
> -	size_t rpc_size = sizeof(*rpc) + sizeof(rpc->entries[0]) * NV_GSP_REG_NUM_ENTRIES;
> +	size_t rpc_size = struct_size(rpc, entries, NV_GSP_REG_NUM_ENTRIES);
>  
>  	/* add strings + null terminator */
>  	for (i = 0; i < NV_GSP_REG_NUM_ENTRIES; i++)
> -- 
> 2.34.1
> 

