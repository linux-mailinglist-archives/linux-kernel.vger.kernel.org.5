Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9A1D77EB67
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 23:07:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346305AbjHPVHX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 17:07:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346412AbjHPVHK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 17:07:10 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D79C8E69
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 14:07:09 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-68891000f34so797629b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 14:07:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692220029; x=1692824829;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=r3Yx/ofvM8SKQSiO3tHzoOQnNC0JboOEN9yZBTokARA=;
        b=ZzbqonGaOBv1EZxtYkwzcNc/Pza7vRjEHIfgAoe2wtMO4uUVRTZDOnNVhtsQKZGD+e
         Mfakd4mq9tKyJNO9S0XpGOUmbgB09a8EPzJNB5LhIeqQAA67c6KLpe5RE55XZyvNFdlA
         rjRwK8P6umzK3/QTZma3kszvAnRVjPePnXxkk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692220029; x=1692824829;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r3Yx/ofvM8SKQSiO3tHzoOQnNC0JboOEN9yZBTokARA=;
        b=HQ7d3u4tFWqupHpNE4fdUOE01jH3RzdyUx77QNaNZgFV1eSlC22V8ruDM+ANSm02Ez
         7CD7X82d6L5fxv7NPwuw0i6FzDGQHBq1IiP9ZHQBWUrgxrWRl0/QBQ2Zdr7SqvISYwpA
         JCvpKPV9pO06qPcEePDiy7x9cy80u8PCwgtBhSlVxK3Kpa2/d95tj7yPeFJgs2i3nbU8
         /GlCV98DFxIkB9+s0Ol8PStbZ9SifkszKVyUdYkLxRSk5JjJfZbAaU6wfL3Vw/pR+gmU
         rcTI8F1ekyUam15XghaWhXpeczCtShP06rRfsMXP7NxcRFTo6exBnoIKvYljCtu7ZvOx
         jpsA==
X-Gm-Message-State: AOJu0Yzrb9qnUbJa+ox8cZFO8lxCvW6qONKgBOJIxEBIUu6sq+xlEkMk
        KKyNnN8kpLFV4lvP1vFbYdrlVQ==
X-Google-Smtp-Source: AGHT+IGtyVYYg0njIa2w4f4XfQY20e85rwgXh3WhXGv6SkwlDP1zqM0PSyoWql9zf4cbOAdyz6C0fw==
X-Received: by 2002:a05:6a20:1444:b0:132:cd2d:16fd with SMTP id a4-20020a056a20144400b00132cd2d16fdmr4020731pzi.38.1692220029384;
        Wed, 16 Aug 2023 14:07:09 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id j20-20020aa783d4000000b00682c864f35bsm11916050pfn.140.2023.08.16.14.07.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Aug 2023 14:07:08 -0700 (PDT)
Date:   Wed, 16 Aug 2023 14:07:08 -0700
From:   Kees Cook <keescook@chromium.org>
To:     nathanl@linux.ibm.com
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] powerpc/rtas_flash: allow user copy to flash block
 cache objects
Message-ID: <202308161407.48AAE65CB@keescook>
References: <20230810-rtas-flash-vs-hardened-usercopy-v2-1-dcf63793a938@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230810-rtas-flash-vs-hardened-usercopy-v2-1-dcf63793a938@linux.ibm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 10, 2023 at 10:37:55PM -0500, Nathan Lynch via B4 Relay wrote:
> From: Nathan Lynch <nathanl@linux.ibm.com>
> 
> With hardened usercopy enabled (CONFIG_HARDENED_USERCOPY=y), using the
> /proc/powerpc/rtas/firmware_update interface to prepare a system
> firmware update yields a BUG():
> 
> kernel BUG at mm/usercopy.c:102!
> Oops: Exception in kernel mode, sig: 5 [#1]
> LE PAGE_SIZE=64K MMU=Hash SMP NR_CPUS=2048 NUMA pSeries
> Modules linked in:
> CPU: 0 PID: 2232 Comm: dd Not tainted 6.5.0-rc3+ #2
> Hardware name: IBM,8408-E8E POWER8E (raw) 0x4b0201 0xf000004 of:IBM,FW860.50 (SV860_146) hv:phyp pSeries
> NIP:  c0000000005991d0 LR: c0000000005991cc CTR: 0000000000000000
> REGS: c0000000148c76a0 TRAP: 0700   Not tainted  (6.5.0-rc3+)
> MSR:  8000000000029033 <SF,EE,ME,IR,DR,RI,LE>  CR: 24002242  XER: 0000000c
> CFAR: c0000000001fbd34 IRQMASK: 0
> [ ... GPRs omitted ... ]
> NIP [c0000000005991d0] usercopy_abort+0xa0/0xb0
> LR [c0000000005991cc] usercopy_abort+0x9c/0xb0
> Call Trace:
> [c0000000148c7940] [c0000000005991cc] usercopy_abort+0x9c/0xb0 (unreliable)
> [c0000000148c79b0] [c000000000536814] __check_heap_object+0x1b4/0x1d0
> [c0000000148c79f0] [c000000000599080] __check_object_size+0x2d0/0x380
> [c0000000148c7a30] [c000000000045ed4] rtas_flash_write+0xe4/0x250
> [c0000000148c7a80] [c00000000068a0fc] proc_reg_write+0xfc/0x160
> [c0000000148c7ab0] [c0000000005a381c] vfs_write+0xfc/0x4e0
> [c0000000148c7b70] [c0000000005a3e10] ksys_write+0x90/0x160
> [c0000000148c7bc0] [c00000000002f2c8] system_call_exception+0x178/0x320
> [c0000000148c7e50] [c00000000000d520] system_call_common+0x160/0x2c4
> --- interrupt: c00 at 0x7fff9f17e5e4
> 
> The blocks of the firmware image are copied directly from user memory
> to objects allocated from flash_block_cache, so flash_block_cache must
> be created using kmem_cache_create_usercopy() to mark it safe for user
> access.
> 
> Fixes: 6d07d1cd300f ("usercopy: Restrict non-usercopy caches to size 0")
> Signed-off-by: Nathan Lynch <nathanl@linux.ibm.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
