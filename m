Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BBF67513AE
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 00:40:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232282AbjGLWkT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 18:40:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbjGLWkR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 18:40:17 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D08E71FD4
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 15:40:13 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id 41be03b00d2f7-55b83ae9be2so140131a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 15:40:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1689201613; x=1691793613;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=StU3ryhds8B2RWXFKXH9yIswMvNPfFna85+5lQs052k=;
        b=gE/+jswxH5BnMnax9dDPAe7oiW9dZTRVjcv+DvrQThwucqrunr4HUs3M+K3NFaH4nL
         rduk/121iDvivFmP+8mZt/ZpODi/MFXvnKqqwFi6R/hCHU2Gn8gRCqjkouWkkrERTqh1
         zBQ+gATxt+TfjGH9JJlEyTPChy/NNDog//S0I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689201613; x=1691793613;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=StU3ryhds8B2RWXFKXH9yIswMvNPfFna85+5lQs052k=;
        b=NiL6dX2jHPxi7KwPAeIrlvWiF5La75spTVXDc+14h60pFfA5sZ8OuZFIheodRmr+Lk
         N/WJaZKmTWZVEdtCaVNCzFK4I7l7hdhA7GQh6sAMpdBoMvYMDPu03KRZXa+IiZLXNEQi
         ulvOdbY1wK+6wTMzGqC88XvT9epVeVdzgP34ABcMOyXbDqBhNetDBMocFU+JzIlp70d+
         06nc58MTrhsxuYhJuQq2uavz2Gy4/fUbvmXybhaeGoqtoUoQlVXomfPSTi1LZLfx+uTE
         vtWdjKDnPtRTZUnWHO77EVl6aVTJZzu8HuLG5lGiie6KZb716jS0oGAN7ueWPesFXT1t
         fWBA==
X-Gm-Message-State: ABy/qLZKrgF3lkWFiF8PIHkGZIDrBEuXT6gNit+WspVWZJRFCehRTIyj
        GByGqpZ95foigR2o0LJ+ie7eqRbrXDc4PCztDts=
X-Google-Smtp-Source: APBJJlHvjSUHXvfV+I5cnsN0bJUDp8cw5wHgM392XQMX0c73J6Fx/lxlHNienjgRxm49fkQ/lME7+g==
X-Received: by 2002:a17:902:bd03:b0:1ae:10b3:61e9 with SMTP id p3-20020a170902bd0300b001ae10b361e9mr17732285pls.65.1689201613269;
        Wed, 12 Jul 2023 15:40:13 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id bj8-20020a170902850800b001993a1fce7bsm4415779plb.196.2023.07.12.15.40.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 15:40:12 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Nick Desaulniers <ndesaulniers@google.com>,
        Petr Mladek <pmladek@suse.com>, Song Liu <song@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Yonghong Song <yhs@fb.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Fangrui Song <maskray@google.com>, kernel-team@fb.com,
        Leizhen <thunder.leizhen@huawei.com>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH v2] kallsyms: strip LTO-only suffixes from promoted global functions
Date:   Wed, 12 Jul 2023 15:40:09 -0700
Message-Id: <168920160691.3781136.7715367614867053724.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230628181926.4102448-1-yhs@fb.com>
References: <20230628181926.4102448-1-yhs@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 28 Jun 2023 11:19:26 -0700, Yonghong Song wrote:
> Commit 6eb4bd92c1ce ("kallsyms: strip LTO suffixes from static functions")
> stripped all function/variable suffixes started with '.' regardless
> of whether those suffixes are generated at LTO mode or not. In fact,
> as far as I know, in LTO mode, when a static function/variable is
> promoted to the global scope, '.llvm.<...>' suffix is added.
> 
> The existing mechanism breaks live patch for a LTO kernel even if
> no <symbol>.llvm.<...> symbols are involved. For example, for the following
> kernel symbols:
>   $ grep bpf_verifier_vlog /proc/kallsyms
>   ffffffff81549f60 t bpf_verifier_vlog
>   ffffffff8268b430 d bpf_verifier_vlog._entry
>   ffffffff8282a958 d bpf_verifier_vlog._entry_ptr
>   ffffffff82e12a1f d bpf_verifier_vlog.__already_done
> 'bpf_verifier_vlog' is a static function. '_entry', '_entry_ptr' and
> '__already_done' are static variables used inside 'bpf_verifier_vlog',
> so llvm promotes them to file-level static with prefix 'bpf_verifier_vlog.'.
> Note that the func-level to file-level static function promotion also
> happens without LTO.
> 
> [...]

Applied, thanks!

[1/1] kallsyms: strip LTO-only suffixes from promoted global functions
      https://git.kernel.org/kees/c/8cc32a9bbf29

Best regards,
-- 
Kees Cook

