Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B875A7A86A0
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 16:33:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234933AbjITOdU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 10:33:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234561AbjITOdT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 10:33:19 -0400
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 669B8D8
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 07:33:13 -0700 (PDT)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-1c0fcbf7ae4so4518225fac.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 07:33:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695220392; x=1695825192; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=R0M1U7qooz1MSsev8bUf20ajQA/cHs54guIocLK69iQ=;
        b=NH7fwnRZnVpv3Tszg+nBTlfR42h6U3MBPKyVFbN5w7ehPfhDznLe/fjfplxJxpYw87
         PEz1d+xcJe0BxqjmLrbeGAT3t5wq/CImZ0reqXVVP64sz/sInoy32plBOFPHPImNSp2R
         hHHkhjPE2EmJpNn0SIRfnt/68xtraFyj7cR18=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695220392; x=1695825192;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R0M1U7qooz1MSsev8bUf20ajQA/cHs54guIocLK69iQ=;
        b=Ls6xXb4zFIPpdItz/9rFYOWqR8PprtUHB6GETcGLQOHMdGlewfvmMPOoqqNvHhD7Io
         XUHSF0AG+8zLpxbGUAzcwp+gwbhSYEEYu9MEuLNr3QdvNkyCm44HKIsVAWcCLrOppu0x
         g/0yQJ5kbh6bpcUbfmtZ9VofF0JnKHG0N9MhWDzS3i6eKeL7r5DljIq1kFJVvxghNZe+
         nDNlZKk8JET3qdWYGiRsJAIjuvE6+Oh65aD+AmL1R0IS41AIX5tgWWCY5LO787SSCnZ2
         DmsbOPkGmjHjsI+lTB8tyv3zsrnFMOjtYjvNHJ5Xq4XmIRU2BQ/G8OMV6uvIHVFnDAc5
         1seA==
X-Gm-Message-State: AOJu0YxzpByvDBUWnAJkNJ/bV9wy0O+g9bO2VK6gnyFVixZgmKTAJ7Wo
        s+imMBn3DWdXHBr/r5Kf9E4PWcE//l7oZJ5zCJ0=
X-Google-Smtp-Source: AGHT+IHnG2fdejIvfQiUN3o+flnl539Mq0RwoAuzUXucWVFbeZV6npGQfTNnuQS5wk243vtr8CwbVA==
X-Received: by 2002:a05:6870:8926:b0:1be:f4b3:7f49 with SMTP id i38-20020a056870892600b001bef4b37f49mr2879591oao.23.1695220392694;
        Wed, 20 Sep 2023 07:33:12 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id t13-20020a63954d000000b00564be149a15sm9614073pgn.65.2023.09.20.07.33.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 07:33:12 -0700 (PDT)
Date:   Wed, 20 Sep 2023 07:33:11 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Justin Stitt <justinstitt@google.com>
Cc:     Andi Shyti <andi.shyti@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-i2c@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] i2c: replace deprecated strncpy
Message-ID: <202309200732.29C44010F6@keescook>
References: <20230920-strncpy-drivers-i2c-busses-i2c-powermac-c-v1-1-0a3e9a107f8a@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230920-strncpy-drivers-i2c-busses-i2c-powermac-c-v1-1-0a3e9a107f8a@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 20, 2023 at 11:07:35AM +0000, Justin Stitt wrote:
> `strncpy` is deprecated for use on NUL-terminated destination strings [1].
> 
> We should prefer more robust and less ambiguous string interfaces.
> 
> `info.type` is expected to be NUL-terminated judging by its use in
> `i2c_new_client_device()` wherein it is used to populate `client->name`:
> |	strscpy(client->name, info->type, sizeof(client->name));
> 
> NUL-padding is not required and even if it was, `client` is already
> zero-initialized.
> 
> Considering the two points from above, a suitable replacement is
> `strscpy` [2] due to the fact that it guarantees NUL-termination on the
> destination buffer without unnecessarily NUL-padding.
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>

Looks like a straight replacement. Thanks!

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
