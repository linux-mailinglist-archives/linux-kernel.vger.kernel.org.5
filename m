Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1FEF79D9E8
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 22:09:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232978AbjILUJi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 16:09:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230090AbjILUJh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 16:09:37 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AA7610D7
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 13:09:33 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id 6a1803df08f44-64f383be0d4so38240186d6.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 13:09:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1694549372; x=1695154172; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8AmbzuBNjG3pvuD2vEMK+EvxK+MhEsb4d21jgaPxZbE=;
        b=Ga+eexPguoFoOmIE/wJutfdQjQ3YV1AHkxO/Cntys3UfJC9/uQa0bvI+8z3Y/QNDfY
         XHf/s0pSE4hf+qG5K23F9ZUvgtwfC8oosdkw8omD4AFHVOel7LGR83invPnUqlmdvQj2
         dq/Q/N1rVlY5YzHohgysyhKzFVf5osmg+KY0Ymr08SVqbRcjZgl9um2PBX+d+CuJB2QP
         tpE8xeIM2XNROPDmCAVuaIMj3/RLP5nGZDNamIQKHrBHc9nG4Y5B6LSAS74cD2gxmDeD
         k98V1xI4hsTA4oWrPm6JPRw8AN3Fa+l3W6Ydq7JohUe12Qf6vlckWWS7NnJeZCV5cP4o
         FZxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694549372; x=1695154172;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8AmbzuBNjG3pvuD2vEMK+EvxK+MhEsb4d21jgaPxZbE=;
        b=EWj+AEvrVagZGxeMxvvnI0mSnWQyB1m1qjWc9T9eubys4NbFC0OylaUTibr/5Cnvtm
         bFknbFh6ch2OGkULwRUGH1Qu4kF34oF9WNJCeh9z4bX+5dxOcxV6E94JvaS6U/C8kvl7
         eV3onTnqRiu9Cw+lNMYl5OCCJt3IuJQ07kxuUDjMDR9cx8vI/yCWSucJyuqHMVuv2JsT
         QIFdkS8vSNKZs9oiFzr8ZJ40A8uSb9iheH2IujmM1pfMAdTdFo8AhcRxlPLR6Q4yn6Z1
         VBAcsP0oeZ+IsxKOZSdGthE/sCkVm2Rsmnxq75lKZ/nG0e3+CubAcrLuM+IyDQs1RMpk
         oaHw==
X-Gm-Message-State: AOJu0Yz1rXCzZ1z2O542MMlEJnFNDYEcw2xdbjhYEZKpcCS0NOb3yvCY
        NpVyshdFMkEUeQxHKUN4rfsB
X-Google-Smtp-Source: AGHT+IHhm9amGITUC1dlWWjtweGnOTF6yopgBiECKzU9eaLYygbZQmkBEK0hqu7j/mCxHSZaWII3Vw==
X-Received: by 2002:a0c:f08e:0:b0:655:db86:6c95 with SMTP id g14-20020a0cf08e000000b00655db866c95mr379534qvk.37.1694549372344;
        Tue, 12 Sep 2023 13:09:32 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id i3-20020ad44103000000b00655e2d0c268sm2354973qvp.15.2023.09.12.13.09.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 13:09:31 -0700 (PDT)
Date:   Tue, 12 Sep 2023 16:09:31 -0400
Message-ID: <16ef84059b3adaafd3bc2d43ba9c1ccd.paul@paul-moore.com>
From:   Paul Moore <paul@paul-moore.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Eric Paris <eparis@redhat.com>, audit@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] audit: Annotate struct audit_chunk with __counted_by
References: <20230817203501.never.279-kees@kernel.org>
In-Reply-To: <20230817203501.never.279-kees@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Aug 17, 2023 Paul Moore <paul@paul-moore.com> wrote:
> 
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
> (for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> As found with Coccinelle[1], add __counted_by for struct audit_chunk.
> 
> [1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci
> 
> Cc: Paul Moore <paul@paul-moore.com>
> Cc: Eric Paris <eparis@redhat.com>
> Cc: audit@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  kernel/audit_tree.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Merged into audit/next, thanks.

--
paul-moore.com
