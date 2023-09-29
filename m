Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 764AE7B3C2F
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 23:54:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233869AbjI2VyN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 17:54:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233739AbjI2VyK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 17:54:10 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62EDDEB
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 14:54:08 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id 98e67ed59e1d1-27927d37ec7so1449188a91.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 14:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696024448; x=1696629248; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MHH0ku3cnEfuovvq4TN+nU7rjq4fes2yQy9ZicPmfy0=;
        b=XdDICizWyyfUBOGS9Hcy1AaKWGaDIypGxhUi/T+9/Q/RpQsqwPveiS5QSGo4Ffu+io
         XQyanX5pQ6m4GHWNDjk1Uw1HHiHHfmfTfpX+DAPjV5FL8htsmTJkf1R2UbNh+u49lQ8n
         WPQLauN5vYq4Yz3ZwTdVNehSn7UInlAhDsK3I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696024448; x=1696629248;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MHH0ku3cnEfuovvq4TN+nU7rjq4fes2yQy9ZicPmfy0=;
        b=r9nqua93DPyDpOnPwRuRapb+o1BSzTboscfXDAt/k7eM1pUbXtIgCHyV55DLZDrrCd
         F+sJ08rK0BpfDGFLZH3/j+Mn/qLdFQS8Fz7mLxBJgw3y+W7/M3u6WpkUOje4TlAhncI3
         inEioc+KjAsnY4NflCknJ5ldGiqXjJ9GVVWkKpk8UGKsJo7bF3rkNB4a+BUfEjMhit5V
         BS3dmYMYOyr4k6Eq8qONIUcB8+9HQK6O88YtAp+rKpbOSAGUJZPfmmbja5njRE1D27Af
         gtLyaXLpRyxLAL9N4JQmbQcjo45gBw4Zfq873jibp2Hyw39U8o3cBpORlQ44nhGQgrXc
         3UEQ==
X-Gm-Message-State: AOJu0YykBKZx6vSGegHi0TNbW19yIDG6kBhodKV5UQ8ZJquGOl1YbSwq
        Dx/G6yWb+S7nG56VHIv2esB1hPr4lOKfoFdUGzA=
X-Google-Smtp-Source: AGHT+IHoF/OLpRNDzLcj85xtbvZ3DJsBh49hVBXu73MEqXR3MZRoTXPQbKi7O4iIRyczmIbUISS/lw==
X-Received: by 2002:a17:90b:8c6:b0:26d:2bac:a0bb with SMTP id ds6-20020a17090b08c600b0026d2baca0bbmr5064809pjb.6.1696024447861;
        Fri, 29 Sep 2023 14:54:07 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id 11-20020a17090a004b00b00273fc850342sm2114438pjb.20.2023.09.29.14.54.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 14:54:07 -0700 (PDT)
Date:   Fri, 29 Sep 2023 14:54:06 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-riscv@lists.infradead.org, llvm@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] riscv: mm: Update mmap_rnd_bits_max
Message-ID: <202309291452.66ED9B4D83@keescook>
References: <20230929211155.3910949-4-samitolvanen@google.com>
 <20230929211155.3910949-6-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230929211155.3910949-6-samitolvanen@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 29, 2023 at 09:11:58PM +0000, Sami Tolvanen wrote:
> ARCH_MMAP_RND_BITS_MAX is based on Sv39, which leaves a few
> potential bits of mmap randomness on the table if we end up enabling
> 4/5-level paging. Update mmap_rnd_bits_max to take the final address
> space size into account. This increases mmap_rnd_bits_max from 24 to
> 33 with Sv48/57.
> 
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>

I like this. Is RISCV the only arch where the paging level can be chosen
at boot time?

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
