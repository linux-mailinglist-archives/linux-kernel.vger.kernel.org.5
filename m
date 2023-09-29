Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B32147B3C30
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 23:55:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233749AbjI2VzH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 17:55:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233081AbjI2VzF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 17:55:05 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE1BE1B3
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 14:55:02 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1c5ff5f858dso85968145ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 14:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696024502; x=1696629302; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8kFisjx+D089Bl0n+c9sa0dcFrh55Nv3CjkrAPKvHaQ=;
        b=XPKNorQzWdiHhidzSTv6sPzxHcNeh7oqxFhbO98zA1CETZMkqUz2psX2XA2dGVDurF
         fMjoWNC2reY/ze60h2Fi9QVoalwvpaTriQ4ewUkpBFPK/Zg3K/xqBLLCxGlU09161MFM
         nm4z4rTd82k1yE55pKJcW9uWkNHIjv1dZ+7KU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696024502; x=1696629302;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8kFisjx+D089Bl0n+c9sa0dcFrh55Nv3CjkrAPKvHaQ=;
        b=rbCrziYf6mvbHwG5BSugsrMHnDQ7NxTL5mYXZlkTZslCQw04k17GFdqUS7at/3Ic+X
         BPR9xDEcML4PFgTXOSJfxyk41CBp77GMpYPDhOV+da59cbumQU94W1/y7vcA/hVT9Oyr
         AbJM6HiXgy5Ej8BG9EB7zdxnaiChYPQHgnUuI2nZLozhKzoRNmCI0CH90+sgM/j7/rZX
         ovhKw+vKHOPdwnR+oMfvYwJL1mpkNByNBqwsVulxF+95+HnQr/7B0txurIQXLXSGe0yk
         VtW08AJsoQuakEYmogL949O6tnANkz7QGW6ORDbdt06D5v9rElCN2UpgAa6jwJnJWjLL
         +G7w==
X-Gm-Message-State: AOJu0YwsTjNcQghLZX9joYMH0wvqniIAXPwAJZmisrGnqWxzIm2AYNk3
        vRSLP8ILrjuhzL19TP955ceMr26yUTZfP2JThtc=
X-Google-Smtp-Source: AGHT+IGnbAGwryCCvO6jabCBmevCmJ/0eVxJN4Y82GDsZjB3QfXDLV1KZNYrwCXcUGHGoTsq/uDbWQ==
X-Received: by 2002:a17:902:ecd0:b0:1c0:c86a:5425 with SMTP id a16-20020a170902ecd000b001c0c86a5425mr6564288plh.19.1696024501806;
        Fri, 29 Sep 2023 14:55:01 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id l13-20020a170902f68d00b001b54d064a4bsm17338377plg.259.2023.09.29.14.55.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 14:55:01 -0700 (PDT)
Date:   Fri, 29 Sep 2023 14:55:00 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-riscv@lists.infradead.org, llvm@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] mm: Change mmap_rnd_bits_max to __ro_after_init
Message-ID: <202309291454.436E19663@keescook>
References: <20230929211155.3910949-4-samitolvanen@google.com>
 <20230929211155.3910949-5-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230929211155.3910949-5-samitolvanen@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 29, 2023 at 09:11:57PM +0000, Sami Tolvanen wrote:
> Allow mmap_rnd_bits_max to be updated on architectures that
> determine virtual address space size at runtime instead of relying
> on Kconfig options by changing it from const to __ro_after_init.
> 
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>

Just the kind of thing __ro_after_init was made for. :)

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
