Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F7537B7594
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 01:58:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237180AbjJCX6N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 19:58:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236304AbjJCX6L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 19:58:11 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0944AAD
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 16:58:08 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1c5ff5f858dso11807345ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 03 Oct 2023 16:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696377487; x=1696982287; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=D0ejyvO1VmyNmqGZR0peDZ1Ss5kJZ8OUA5dfHpOPqQw=;
        b=csmvCMLpA+Sm01Ahvo1CG8z9n5RWPHkd96+5EslNwuXEQqK/WcEGSK44oKuG67GdI3
         r9n5iKIr2uhmhXRb3050p15JGN6MBDIIV7PqsFaOqN4uNdxIgAeE07DQ4yz9uv8XhNfA
         AeUfwKCpka5UKdu78syLA6h1nLJtN8clrCl6w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696377487; x=1696982287;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D0ejyvO1VmyNmqGZR0peDZ1Ss5kJZ8OUA5dfHpOPqQw=;
        b=BRoWd7IQ1v1MCaenYhASvEDW2CYxgke4QtuayLYhodoTJ1IK40mDP0A0klKLjOlqPV
         hW0/sJAEtvvaUwepQZsKrm+tC47kaH4BIBIY9agnN4fdN4FrCEYolN+dYaN2mQjrHnNh
         N+12UOSK7C0HTnjiPQY0NCoTovj167fjOCruVS2bEmZMH12OdOkYwsxx6E/cCzQsf2rO
         UPjE2QwR6lr12E24LOgeavuHGc9K6VnRSUTPy3cJZnX+yoiBkKUsNC0Pwvw6QLlue32g
         7XwIRuWGia9H3N8WJT4oQ2BQ+DFKq8jpmNpulqYOGCNS4XQPdiBy31kwxEmXr8MmOV0K
         Xt3g==
X-Gm-Message-State: AOJu0Yx7QLP1FECZb+3KZURqIO/hXel1BA3ORYlZhALXBnPll2Nm8zxk
        Y8HRM1uaP4Lwzp3sP8EHRfzVEfEHue/oziXIpRQ=
X-Google-Smtp-Source: AGHT+IECXb9VSq6vwoIn3tL2WBUXitXZEtZMFEEeusPgmWy8lRWL5m7VZnSdjHnAJKpQp+xgxWZ8bQ==
X-Received: by 2002:a17:902:e852:b0:1b8:af7f:6331 with SMTP id t18-20020a170902e85200b001b8af7f6331mr1037553plg.55.1696377487516;
        Tue, 03 Oct 2023 16:58:07 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id g6-20020a170902c38600b001b567bbe82dsm2207537plg.150.2023.10.03.16.58.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 16:58:07 -0700 (PDT)
Date:   Tue, 3 Oct 2023 16:58:05 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Justin Sanders <justin@coraid.com>,
        Justin Stitt <justinstitt@google.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org, Xu Panda <xu.panda@zte.com.cn>,
        Yang Yang <yang.yang29@zte.com>
Subject: Re: [PATCH v2] aoe: replace strncpy with strscpy
Message-ID: <202310031657.79DC1C570F@keescook>
References: <20230919-strncpy-drivers-block-aoe-aoenet-c-v2-1-3d5d158410e9@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230919-strncpy-drivers-block-aoe-aoenet-c-v2-1-3d5d158410e9@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 19, 2023 at 05:27:45AM +0000, Justin Stitt wrote:
> `strncpy` is deprecated for use on NUL-terminated destination strings [1].
> 
> `aoe_iflist` is expected to be NUL-terminated which is evident by its
> use with string apis later on like `strspn`:
> | 	p = aoe_iflist + strspn(aoe_iflist, WHITESPACE);
> 
> It also seems `aoe_iflist` does not need to be NUL-padded which means
> `strscpy` [2] is a suitable replacement due to the fact that it
> guarantees NUL-termination on the destination buffer while not
> unnecessarily NUL-padding.
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Xu Panda <xu.panda@zte.com.cn>
> Cc: Yang Yang <yang.yang29@zte.com>
> Signed-off-by: Justin Stitt <justinstitt@google.com>

Friendly ping on this patch. Jens, do you want to pick this up?

-- 
Kees Cook
