Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DD3F7B4236
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Sep 2023 18:37:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234540AbjI3Qh5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Sep 2023 12:37:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232221AbjI3Qh4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Sep 2023 12:37:56 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2281FC6;
        Sat, 30 Sep 2023 09:37:54 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id 41be03b00d2f7-5809d5fe7f7so8071535a12.3;
        Sat, 30 Sep 2023 09:37:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696091873; x=1696696673; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=l5AGtOCX2YLyW25B4ipM/PsTXAr3eNAm1BeKQ+N08Gk=;
        b=Ea0Xi18CY2Vz3U67UQ82EHoV8qng25UYLtf5L+eARrPMFmJ8kYWQJclmSv5cYRmF37
         HWHFH7YodmOqCvoj6J1rHYRcICbRXez+ndlSjGQucwFU7FUDFF5YkVcUMYj2RlQ8Ss3F
         ojNE96bWmS1E9M4nxHTl1k77p8IUF/A1VaFUiAw4+3+j/O7V5YF1cdR0zZ5qo+nLsdX4
         19fERmbrVoPBTid0NbBZQT0Kn+LjrMHIjCwqZo1cQAvMWyurbfpbUNYSnxVfoYc8w6Jv
         +yQWNoeewPHDpIEuCDKeoUUueFQ5brWNykRWlvP61H+Q/lx7reP6D1KYmPCpjav8GTtB
         zxkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696091873; x=1696696673;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l5AGtOCX2YLyW25B4ipM/PsTXAr3eNAm1BeKQ+N08Gk=;
        b=qIMCqw+9CNHKZWyLVmhhJfoq7Y1j6UNZLC7kf/3pvWZ+oRp5YKkhbGMoRe6GidJgeE
         tAmUq6zCccgaLmFTqbnqymWmNHhGRQZ9AHmk+f8AB0CygFLjqK9DNASBovWePAEkXmbM
         5W2WYS/YFcX1g7eWR7SueKFm2qblQXm1jTmTVaMt+9rTgSjZk6OvBT/3wbbhQAu4SjhS
         Tbd532BifnmmPSglCm6Jr/+X7MUIRpRT81oOzDAIzNGi45i7tAETobgNbtAJi/UmO92H
         m932jHT2afTXi5znb7Lv3jTvnLLY5/OjLNJ6aKpCypBvr+Y05Gtjv4xU5GpYaF1GtOi1
         y6Iw==
X-Gm-Message-State: AOJu0Ywaq1YirMIJ8+bVxW/efJuaOa9U5CWDu2oZYc0ZI/BIIOPyDdMd
        vFz8Vks1djN1bxw1cN6mmyI=
X-Google-Smtp-Source: AGHT+IFcD+InxoquI1bZbEdFpDChHT0/gks65lBOkpRCEDjQVecmAWULy2M4IU4Dy2nT3oiXSXv11w==
X-Received: by 2002:a05:6a20:158e:b0:159:b4ba:a5bf with SMTP id h14-20020a056a20158e00b00159b4baa5bfmr7623302pzj.13.1696091873452;
        Sat, 30 Sep 2023 09:37:53 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:a90f:2dad:30c1:d923])
        by smtp.gmail.com with ESMTPSA id ml24-20020a17090b361800b00262e485156esm3334372pjb.57.2023.09.30.09.37.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Sep 2023 09:37:53 -0700 (PDT)
Date:   Sat, 30 Sep 2023 09:37:50 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-input@vger.kernel.org, Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] Input: Annotate struct input_leds with __counted_by
Message-ID: <ZRhO3noTd/bDWjFy@google.com>
References: <20230922175031.work.467-kees@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230922175031.work.467-kees@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 22, 2023 at 10:50:32AM -0700, Kees Cook wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
> (for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> As found with Coccinelle[1], add __counted_by for struct input_leds.
> 
> [1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci
> 
> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Cc: linux-input@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>

Applied, thank you.

-- 
Dmitry
