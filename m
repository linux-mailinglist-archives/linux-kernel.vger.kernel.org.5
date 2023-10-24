Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91BDB7D5D18
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 23:20:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344440AbjJXVTi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 17:19:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234964AbjJXVTP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 17:19:15 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A858D10E6
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 14:19:10 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id 41be03b00d2f7-5b8c39a2dceso1801246a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 14:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1698182350; x=1698787150; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nf0I5QNq2gKNhp+QWqAtgU2BkAhFb6b7w3QJr2Rt56I=;
        b=QMyilAzbJ+Q8l2faMzH1U1cR8U2WtjYEtMB9fhAIe2RtsGng3XqfEO15rS9HI360mK
         qQ+v8vGkl9xwO/jQb9Slc3/bWyDRp7AWjs8nvuSk2A5XxAqrnL/iahomgj0ozOru8F59
         r0X5xK82ydIgv1UbjMN1/Q/zjNJDgixm+Gd88=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698182350; x=1698787150;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nf0I5QNq2gKNhp+QWqAtgU2BkAhFb6b7w3QJr2Rt56I=;
        b=jj9OilHt3KUvpn2w+q0UJIgJKTEPNMFG2OJrdzTSwDVnYUmY8Qr2bAah9H8MYHD6ob
         sDtoE2bHN/dnDBUV/LrsL+SMt0Z8n1rbfd92RCwIHg9v6vclessCxt/EiURgPqeuSkdV
         5WLKt+nhXjzag8nSOIzioV3kUhUDnpABKMIw++SCxvAO7sDz+w9aDXhJ1dAYlWkdib32
         6greln08PS9sLRtYnTsSw/sgko0yrTdO1D7moKumd6H859iUY9iMMKkJKBX0tZMReayK
         3no8vJ5UiWILkZq5T3TPjkXRpz5KUcYxw1S0TrbFRw7454JrDOrUz3HCgwBNELOZNC0g
         n2UA==
X-Gm-Message-State: AOJu0YxJ4LbofvT9tYb1TF/hOnRgxqWhYkH/xqWeEDHnu1NHACaVXwkA
        wAeOvK7ENaPop28/B9iOhggFCQ==
X-Google-Smtp-Source: AGHT+IG4QxdxC8vQGJgNfcCeZZI6jENfk4ntlbbjFZnDCc1T/n//1rqezHHk0nSA1UzaU5cN06ODAQ==
X-Received: by 2002:a17:90a:d995:b0:27d:4901:b0b7 with SMTP id d21-20020a17090ad99500b0027d4901b0b7mr9801197pjv.30.1698182350137;
        Tue, 24 Oct 2023 14:19:10 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id ci7-20020a17090afc8700b0026b46ad94c9sm7669915pjb.24.2023.10.24.14.19.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Oct 2023 14:19:08 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>
Cc:     kexec@lists.infradead.org, Baoquan He <bhe@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Dave Young <dyoung@redhat.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] kexec: Annotate struct crash_mem with __counted_by
Date:   Tue, 24 Oct 2023 14:18:54 -0700
Message-Id: <169818232965.2100071.5860676864005280334.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230922175224.work.712-kees@kernel.org>
References: <20230922175224.work.712-kees@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Sep 2023 10:52:24 -0700, Kees Cook wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
> (for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> As found with Coccinelle[1], add __counted_by for struct crash_mem.
> 
> [...]

Applied to for-next/hardening, thanks!

[1/1] kexec: Annotate struct crash_mem with __counted_by
      https://git.kernel.org/kees/c/15fcedd43a08

Take care,

-- 
Kees Cook

