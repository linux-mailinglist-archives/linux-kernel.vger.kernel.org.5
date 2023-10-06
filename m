Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B13FE7BC08A
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 22:41:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233565AbjJFUl1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 16:41:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233527AbjJFUlW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 16:41:22 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19886C5
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 13:41:21 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-690d2441b95so2011920b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 06 Oct 2023 13:41:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696624880; x=1697229680; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RA6Sc7k2eYudohPOyjS2xNwEbkA0LuukS0jdW+sshIU=;
        b=KnhAYIbYofbLdRZzQedmFGPtAW4ACp7+OYSB3BKlpT1JZJbYezQdp1RNZxQaB0s8qT
         o/nRZdUPQgkSF69MyKiEJDCVCR5Ko2j2yusuyn0YjFpJqsMeK3wwg5W+7K+j2llAyUaW
         y//kPdOAFZSmXDTNKesN+s8SzpsbtnyVY6NNw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696624880; x=1697229680;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RA6Sc7k2eYudohPOyjS2xNwEbkA0LuukS0jdW+sshIU=;
        b=mDI0k+mjMJ4RtTdA+CzpS8XMw1IwovIa6rfNJSaIUuw1KZzmn7mcniZx9sjAHx+2OA
         vqo6q9z9TRxDEs190CYoI7AId51B4tIBjEXEA9XL+s84C+O8hhlYY8YxN3HAQVuknBQQ
         fJmZ7MZAWhZZpayCF2vrlsnwqTHAWhQC5cjYL3tSYh1jDBM81S7PyN/1SxruylxhkRv7
         heSY4LSRlEmOuWmjROZK/4mSm1TkFWYRPYi78hknlw8NPk4F1M8bnTw+oKYHVba13HLf
         e7ieyqzXy1IPZ1KJc8Wplaqx+VC7jfyxQsDZ85nmS/+eR/9uFyjrp+8oq0gHlh9rLzgk
         MYPg==
X-Gm-Message-State: AOJu0YxVAu2K8tX37We/m3X2tYD06bpPFjUPJoy3+vKUvHe0+HtYGnLN
        OTiQTsdjzzG2yW3n/F09QsRZHw==
X-Google-Smtp-Source: AGHT+IFSmFU6FkhA8Oz6MBMj4ikhUHOgSULluvCcw1BxoKIl88jeZRsxIUFaVyPPQ1RvqNgCCc7Y6g==
X-Received: by 2002:a05:6a00:a1b:b0:68f:cbd3:5b01 with SMTP id p27-20020a056a000a1b00b0068fcbd35b01mr8784952pfh.13.1696624880594;
        Fri, 06 Oct 2023 13:41:20 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id a25-20020a62e219000000b0068fe7e07190sm1905152pfi.3.2023.10.06.13.41.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Oct 2023 13:41:19 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Andy Gross <agross@kernel.org>, Kees Cook <keescook@chromium.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] drivers: thermal: tsens: Annotate struct tsens_priv with __counted_by
Date:   Fri,  6 Oct 2023 13:41:09 -0700
Message-Id: <169662486916.2156024.11406030732291665443.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230922175341.work.919-kees@kernel.org>
References: <20230922175341.work.919-kees@kernel.org>
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

On Fri, 22 Sep 2023 10:53:41 -0700, Kees Cook wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
> (for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> As found with Coccinelle[1], add __counted_by for struct tsens_priv.
> 
> [...]

Since this is a trivial change and it's been 2 week without further
discussion, I'll snag this patch.

Applied to for-next/hardening, thanks!

[1/1] drivers: thermal: tsens: Annotate struct tsens_priv with __counted_by
      https://git.kernel.org/kees/c/aa0a14629c2d

Take care,

-- 
Kees Cook

