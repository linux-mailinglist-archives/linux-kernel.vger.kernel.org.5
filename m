Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C77847B7570
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 01:46:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238240AbjJCXqB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 19:46:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237659AbjJCXp7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 19:45:59 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2395DB8
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 16:45:56 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id 98e67ed59e1d1-277336b8717so1012492a91.2
        for <linux-kernel@vger.kernel.org>; Tue, 03 Oct 2023 16:45:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696376755; x=1696981555; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RtHYjR3XxoRF+iJTkvp+E/jMMzI/Fs5RNWq+H0ugZaQ=;
        b=Uv+54UEBZvITyMjEPII19CZmsTxTZvB5NDyFvUS5nkcYu7rsLrGfwtaxdwjj7+JYOW
         INlN5xBxwlyY/IxesJp44tCcAW05pW5ACZ/4CqNs7+0CSGRFuSRd6tEFa5oSFWCaU8bU
         XZUqzdUa7jp42b/HYHusuibM+HM3PWkhob+vU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696376755; x=1696981555;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RtHYjR3XxoRF+iJTkvp+E/jMMzI/Fs5RNWq+H0ugZaQ=;
        b=hD1bg3GaJ3hpKDYo/Oo7BCyOky+mV9fF12BfdTxMYbollJct08CYlagsftKqiVpatR
         M/QfqMBOmivTpDo013YAJydm73MqMpOHKpxzQvdFoNcHhe/0NQWGJbT7LjHxXSCvnvKl
         BnX2kiAt+A3pXz56LjKkH2JjBBoZgKSAjtyP7pauf7CrguAHNXVM34kdibVi3ePFLscQ
         J7oJKxe+9WyCcM3UaT72D5+e0IafZ+wznSCCthZxPHPtFNg9Ezq9t36VJBbYZE5v1IWK
         pj4D2Q+Fajfa9rxMguBa3lDl57uRwYRZuCKLeu28RKa40xFCOD0CblOWr9spiPTMhk1N
         mevQ==
X-Gm-Message-State: AOJu0YxuoXdjB5s62uygu4+J1pgxQud8/nO28JvNsA57Mt6nLIE6ReJ1
        kK3/alobUKx9Uwy6ZH0hNid8bg==
X-Google-Smtp-Source: AGHT+IHujQcVFHUY7j+G/kYmbSjiEDK3lKj5pw/1RC5Ut3/Cx7sRwL7lI9kZJjkyqrtiKpo0Jw7Fag==
X-Received: by 2002:a17:902:e850:b0:1c5:d1a2:c3e8 with SMTP id t16-20020a170902e85000b001c5d1a2c3e8mr1097347plg.5.1696376755493;
        Tue, 03 Oct 2023 16:45:55 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id ji13-20020a170903324d00b001c726147a45sm2196482plb.190.2023.10.03.16.45.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 16:45:55 -0700 (PDT)
Date:   Tue, 3 Oct 2023 16:45:52 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Justin Stitt <justinstitt@google.com>
Cc:     Sathya Prakash <sathya.prakash@broadcom.com>,
        Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
        Suganath Prabu Subramani 
        <suganath-prabu.subramani@broadcom.com>,
        MPT-FusionLinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] scsi: message: fusion: replace deprecated strncpy
 with strscpy
Message-ID: <202310031645.FBD5955@keescook>
References: <20231003-strncpy-drivers-message-fusion-mptsas-c-v2-1-5ce07e60bd21@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231003-strncpy-drivers-message-fusion-mptsas-c-v2-1-5ce07e60bd21@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 03, 2023 at 10:15:45PM +0000, Justin Stitt wrote:
> `strncpy` is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> The only caller of mptsas_exp_repmanufacture_info() is
> mptsas_probe_one_phy() which can allocate rphy in either
> sas_end_device_alloc() or sas_expander_alloc(). Both of which
> zero-allocate:
> |       rdev = kzalloc(sizeof(*rdev), GFP_KERNEL);
> ... this is supplied to mptsas_exp_repmanufacture_info() as edev meaning
> that no future NUL-padding of edev members is needed.
> 
> Considering the above, a suitable replacement is `strscpy` [2] due to
> the fact that it guarantees NUL-termination on the destination buffer
> without unnecessarily NUL-padding.
> 
> Also use the more idiomatic strscpy pattern of (dest, src, sizeof(dest))
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Cc: Kees Cook <keescook@chromium.org>
> Signed-off-by: Justin Stitt <justinstitt@google.com>

Thanks for adjusting the sizes. Looks good!

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
