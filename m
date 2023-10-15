Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 284357C97AB
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Oct 2023 04:31:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233405AbjJOCbl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Oct 2023 22:31:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233385AbjJOCbk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Oct 2023 22:31:40 -0400
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com [IPv6:2607:f8b0:4864:20::c34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 364C2D9
        for <linux-kernel@vger.kernel.org>; Sat, 14 Oct 2023 19:31:39 -0700 (PDT)
Received: by mail-oo1-xc34.google.com with SMTP id 006d021491bc7-57b5f0d658dso1968167eaf.0
        for <linux-kernel@vger.kernel.org>; Sat, 14 Oct 2023 19:31:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1697337098; x=1697941898; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=w3UcDOTXVnpUdSv4M3bD1yXTstgPxWK1PeD8ZLVfT6g=;
        b=oY/u8rcl4AHbcP6+ZwJnOKE1gF513xnAESCu4km2p49ybGI9ukmWQkuCriRHzwDpoA
         ors/XvzLzimX45ywSlKAqR5ylt2uroNyp6vKcAQXMTXvZCWP0G1y/5oA+czSpGmnv60P
         ngiNh10wGqw4oS+opfyeIitYNZTkzL+eDcLyc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697337098; x=1697941898;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w3UcDOTXVnpUdSv4M3bD1yXTstgPxWK1PeD8ZLVfT6g=;
        b=OgzZABpTzUr74c3HBrUNlH6bKehQG/OsU+0cEXsC3m9kg0+6b2VeFq2lQk+iNmtBY0
         RB8e4BJsMegR7g+VozMUlkEC9W29bU71Y4c5+jRJIbMowVZKbZG+5oCM2iY14FC9Auq+
         oB2YvoT3BPWx/vBzd1msSvHeX0t8+1EcIelI3tRFnHsFjK8WeH3LI5sLSCRPslg5SPIt
         pI98T4llZgJ785C8/GYz5rfYnlYyzgiFZ21s4ah9ERxhtdJA6QOAm4addwLd8OAhX21O
         kHtzsfToYyZIS6jHzAAJpyVLO9+NcWri5z8gFmGVNFMLJGLbOUOxVBAa4Ouqzha+xNIX
         IECg==
X-Gm-Message-State: AOJu0Yx19dgwCNCcYWUWv02HmomUFqDLP6BIiVXCOXUd3xoEzxPTyso5
        cDybfiiMgi0WB5BUkAN1FK3LWA==
X-Google-Smtp-Source: AGHT+IHHtAlcIGg+Zt50I2CaWbpQ9qgynPGuWlNFgS+CA7bxaLDLrEv2OCfMiEjPuYZ5jDGG/UfOpQ==
X-Received: by 2002:a05:6358:5289:b0:13a:4f34:8063 with SMTP id g9-20020a056358528900b0013a4f348063mr33060407rwa.32.1697337098456;
        Sat, 14 Oct 2023 19:31:38 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id p28-20020aa79e9c000000b006905f6bfc37sm3315559pfq.31.2023.10.14.19.31.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Oct 2023 19:31:37 -0700 (PDT)
Date:   Sat, 14 Oct 2023 19:31:37 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Nick Terrell <nickrterrell@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Nick Terrell <terrelln@meta.com>,
        Kernel Team <Kernel-team@fb.com>,
        Nick Terrell <terrelln@fb.com>,
        syzbot+1f2eb3e8cd123ffce499@syzkaller.appspotmail.com,
        Eric Biggers <ebiggers@kernel.org>
Subject: Re: [PATCH] zstd: Fix array-index-out-of-bounds UBSAN warning
Message-ID: <202310141930.F1F809230@keescook>
References: <20231012213428.1390905-1-nickrterrell@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231012213428.1390905-1-nickrterrell@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 12, 2023 at 02:34:28PM -0700, Nick Terrell wrote:
> From: Nick Terrell <terrelln@fb.com>
> 
> Zstd used an array of length 1 to mean a flexible array for C89
> compatibility. Switch to a C99 flexible array to fix the UBSAN warning.
> 
> Tested locally by booting the kernel and writing to and reading from a
> BtrFS filesystem with zstd compression enabled. I was unable to reproduce
> the issue before the fix, however it is a trivial change.
> 
> Reported-by: syzbot+1f2eb3e8cd123ffce499@syzkaller.appspotmail.com
> Reported-by: Eric Biggers <ebiggers@kernel.org>
> Reported-by: Kees Cook <keescook@chromium.org>
> Signed-off-by: Nick Terrell <terrelln@meta.com>

Thanks! This 1-element conversion doesn't appear to need any sizeof()
related changes, so AFAICT this header change is sufficient.

Reviewed-by: Kees Cook <keescook@chromium.org>


-- 
Kees Cook
