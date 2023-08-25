Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E2D8789236
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Aug 2023 01:08:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230009AbjHYXIM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 19:08:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230290AbjHYXII (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 19:08:08 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62A252117
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 16:08:06 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-68c0d262933so762306b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 16:08:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1693004886; x=1693609686;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BGD8RLBqVNB4kmg9LQj/IaQhfmnGQcki3nbsh7hZk+8=;
        b=YBDu8Aja6BKRjm5FFQRjlHeOK8tj/IlFyW39z6NGh6TnmxaKkflBY6o1warcrowa8W
         ue9qNS6nE3FxEVPoZv1U3zrKf7ctMfV3M9xhjPZamFAFYwYxDNok3h/q7J4FmkU8ViNi
         lwMjIA9kY9voVDj76fG9rs6kikyu1/dpBveGg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693004886; x=1693609686;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BGD8RLBqVNB4kmg9LQj/IaQhfmnGQcki3nbsh7hZk+8=;
        b=TdqAB66I1lWAnNvzOPb+gOBeJtxGQxxYdEJLTzclBsxoE/5/hci1AwyKEQQb/Zrhv3
         kUDZbXifNMQhnzcDLas5+xL7jwY7i+wM48RuAulExeRJa+jssZvUc56YyNf2lJMATM3u
         XLSpNSeq3RUDYCxTWXEeD4tIbNKDIgch4VEAxGGwAu0o22vAVX8jm+UMJc9leU4qwTCJ
         e2J4S+WA67ollq/MCiIX/lnzjCExI8DTDCMe26Vvy/MRQEEkyCtMFFudErO6tWJbRByD
         Yjs9b9F37gEnJ+eHAWooRQNE9mwJtpY89AOjHhYuJ8f1JqBHEVd7JMLPzxxelhGJumzN
         U6yA==
X-Gm-Message-State: AOJu0YwwSh+3kW+XWTdiLoG5cnTjdU5UOzxRJ5s2l2PDPxkCC32hU2nA
        LUc2XPBz1N3BJUdbTJyZZUCfRw==
X-Google-Smtp-Source: AGHT+IFe1hAe7Lf6wq0l2606gcJN8yUb28I3sQVbEpzoh4vKFlqBPpa+9BRdxsU4JtNnzCmulUYBcg==
X-Received: by 2002:a05:6a20:6a05:b0:130:7803:5843 with SMTP id p5-20020a056a206a0500b0013078035843mr21060026pzk.4.1693004885827;
        Fri, 25 Aug 2023 16:08:05 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id ff5-20020a056a002f4500b006877b0b31c2sm2134013pfb.147.2023.08.25.16.08.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Aug 2023 16:08:05 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     linux-hardening@vger.kernel.org, Kees Cook <keescook@chromium.org>
Cc:     Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>, dm-devel@redhat.com,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Subject: Re: [PATCH] LoadPin: Annotate struct dm_verity_loadpin_trusted_root_digest with __counted_by
Date:   Fri, 25 Aug 2023 16:08:00 -0700
Message-Id: <169300487782.1491255.12127882114694944126.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230817235955.never.762-kees@kernel.org>
References: <20230817235955.never.762-kees@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Aug 2023 16:59:56 -0700, Kees Cook wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
> (for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> As found with Coccinelle[1], add __counted_by for struct dm_verity_loadpin_trusted_root_digest.
> Additionally, since the element count member must be set before accessing
> the annotated flexible array member, move its initialization earlier.
> 
> [...]

Applied to for-next/hardening, thanks!

[1/1] LoadPin: Annotate struct dm_verity_loadpin_trusted_root_digest with __counted_by
      https://git.kernel.org/kees/c/5f536ac6a5a7

Take care,

-- 
Kees Cook

