Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F7EB807960
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 21:29:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379512AbjLFU2r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 15:28:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379405AbjLFU2q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 15:28:46 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 946F012F
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 12:28:52 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id 98e67ed59e1d1-2851a2b30a2so197448a91.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Dec 2023 12:28:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701894532; x=1702499332; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XTBTLAqDXor1l6sg34c9kbUSBjJSEI8UiBBYr9CwL2Q=;
        b=mBSvMCBnLy7316/Qzf9Xd5nmH/+fsGN1n1j+8Fc1nUYVCrxpCr6MxloLVw01Wc9HQe
         3IIobqpHYYGBZvVcvjlmukokNk7MbrHRonhcvwLh6vFndFxS166Ez8Ul+OLOSEgh7/to
         YYkDNXgbiFtLGGw7knY39odkVNoiK40VLKFjo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701894532; x=1702499332;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XTBTLAqDXor1l6sg34c9kbUSBjJSEI8UiBBYr9CwL2Q=;
        b=D3Y3ylcecCqTGkkpRI0N0gvPPBASevHg1V+gzzcUFKbgoZ9ulK7HV11emXr59WzLuz
         Nq35UjC93jGfQMPJelRs45XKtogIfhp8Jbrhs3765mfoOSkxMj9CJUwbL5vPxcFePM6C
         9BhzpdoPD+hxDMHp9XwJTab8kBPi9k0ITJxtCWTTbR6cSk4VV3D6l893AB2m5aTsG8Hv
         TjBJtf4OwI8yjiU+nrIb25OA4tN6AbF0W2wyvAJq/0R/j/S2XB1QZG1i/w59Q1jOmEBW
         U21QNYCCqC0E/QqKzES+hnlklZjAAiQbNNoFGgvVw/vi9qEnVF8R8gJdDTrd+/uNDyLe
         nykg==
X-Gm-Message-State: AOJu0Yzd53Z4bUfMwfa8Q3v1LawxDCY149Q5er/t1tQR4L6d5j9MQl9Z
        /71QzqSRMgnpr+/GFxlsW5kLrA==
X-Google-Smtp-Source: AGHT+IGCJW9aAT/9l5dWk1euSiHsIcWqvf5+MSkN2kUSEvXz1J47cG2MljPvGZxmFTZ5NhzqTZhnjg==
X-Received: by 2002:a17:90a:d796:b0:286:d42d:e7e with SMTP id z22-20020a17090ad79600b00286d42d0e7emr1213709pju.3.1701894532050;
        Wed, 06 Dec 2023 12:28:52 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id fz20-20020a17090b025400b00280a2275e4bsm280195pjb.27.2023.12.06.12.28.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 12:28:51 -0800 (PST)
Date:   Wed, 6 Dec 2023 12:28:50 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     samitolvanen@google.com, Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-riscv@lists.infradead.org,
        llvm@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] riscv: Increase mmap_rnd_bits_max on Sv48/57
Message-ID: <202312061228.B953DE8CA@keescook>
References: <20230929211155.3910949-4-samitolvanen@google.com>
 <mhng-f0a257c6-a1f5-41db-b1c4-c178a77a79e9@palmer-ri-x1c9>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mhng-f0a257c6-a1f5-41db-b1c4-c178a77a79e9@palmer-ri-x1c9>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 06, 2023 at 05:14:26AM -0800, Palmer Dabbelt wrote:
> On Fri, 29 Sep 2023 14:11:56 PDT (-0700), samitolvanen@google.com wrote:
> > Hi all,
> > 
> > We noticed that 64-bit RISC-V kernels limit mmap_rnd_bits to 24
> > even if the hardware supports a larger virtual address space size
> > [1]. These two patches allow mmap_rnd_bits_max to be changed during
> > init, and bumps up the maximum randomness if we end up setting up
> > 4/5-level paging at boot.
> 
> Sorry for missing this, I'm just poking through old stuff in patchwork.  As
> far as I can tell this is still relevant, the discussions are just on the
> mmap() bits (but we'd already screwed that one up and have since fixed it).
> 
> So
> 
> Reviewed-by: Palmer Dabbelt <palmer@rivosinc.com>
> Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
> 
> in case someone else wants to take it, but I'm OK taking that MM patch with
> Kees' review.

Yes, thanks! Please do. I already +1ed it:
https://lore.kernel.org/all/202309291454.436E19663@keescook

-Kees

-- 
Kees Cook
