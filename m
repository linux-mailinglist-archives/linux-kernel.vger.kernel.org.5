Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B74017B41F8
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Sep 2023 18:06:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234469AbjI3QGu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Sep 2023 12:06:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231779AbjI3QGr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Sep 2023 12:06:47 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D50FCF;
        Sat, 30 Sep 2023 09:06:45 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id 98e67ed59e1d1-2773f776f49so1235200a91.1;
        Sat, 30 Sep 2023 09:06:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696090005; x=1696694805; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Q8g5zh2+S3KfLdCdYm0vIOGyOHILVZHLfAlpK9xB3iQ=;
        b=d2nZK0kT+gKf6G/FYrksM+5APZ7AyBrpdFtsqF4WPDjbSpXZySYMUucS9kZI6rD9kS
         Q0ZERGUPQf6oGwtmDc4Pe5ORkmdDiicEi5e7qAmgb6baWiUP/TSer8pxHhkoQZ6NOqdL
         sUnCr49I2Nx4d55pS0lOTdkwJWsNqDLImKapMGDh9UcPvxt6//TG0t3oi2zn358V7qQK
         0osFdzZIKIZ/87B9uRhqie0o+x6qn+eunBI4lwugBRyKvw0oI5pWUbRbg8iGle1XQgTM
         chLx1IJl86uPi8VzGMoGGY/7zUreUPXssVC9wfPS8VZwydt/h1kSvT6nhggW25xvFHbM
         2m0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696090005; x=1696694805;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q8g5zh2+S3KfLdCdYm0vIOGyOHILVZHLfAlpK9xB3iQ=;
        b=YL6ayZjUy1fQOwcv7TGXpCEKUULxN83gQpmn7BcHeD1xj8rMaPYMqaKeqAEUaYpTJj
         2/LEX8tZsvt4LJGTdA4rMO+KjtHyv6yCDI6VGf4aSvRF/1ACdsVzpVGvv5+68hlMJk+y
         ns8OhKYgIO3aHue2Cik3B9IHtqNbB4DdCKf9c79iwYocelYKOZ18sbkjEOqprleoyF1r
         iNSqltgEBtptVlWBY1K6eb5wKBj4H2sT/3uEEsmWvxAO3/DrFzpOtwVNDqF08l4dUe0F
         pXkGnB+rKDc5MeGLlg+1bblh/xrdr3VuVnmnu/Cp0R97SGj4//xoC7oYBA1SgeNJgE+/
         dEGQ==
X-Gm-Message-State: AOJu0YzV3fF36HkjzdJvaDH2u6NcrZmB7rkjS4wtxB4/fHF4/6mb05zu
        l+GobjZu4/f0jkDF1wNTTeq+0/BVp9hyiQ==
X-Google-Smtp-Source: AGHT+IGQznklh9nhBZNDU6/vy6sY0noeGGdH4RaF5VT9ZimkO852B5RHvONjkda8SVCMgyV/k3l8Iw==
X-Received: by 2002:a17:90b:190f:b0:279:5a3:d5f with SMTP id mp15-20020a17090b190f00b0027905a30d5fmr11974647pjb.9.1696090004913;
        Sat, 30 Sep 2023 09:06:44 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:a90f:2dad:30c1:d923])
        by smtp.gmail.com with ESMTPSA id cl1-20020a17090af68100b00277246e857esm3346261pjb.23.2023.09.30.09.06.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Sep 2023 09:06:44 -0700 (PDT)
Date:   Sat, 30 Sep 2023 09:06:41 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Justin Stitt <justinstitt@google.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] Input: synaptics-rmi4 - replace deprecated strncpy
Message-ID: <ZRhHkS8MfnwMlQot@google.com>
References: <20230921-strncpy-drivers-input-rmi4-rmi_f34-c-v1-1-4aef2e84b8d2@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230921-strncpy-drivers-input-rmi4-rmi_f34-c-v1-1-4aef2e84b8d2@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 21, 2023 at 09:58:11AM +0000, Justin Stitt wrote:
> `strncpy` is deprecated for use on NUL-terminated destination strings [1]
> 
> Let's use memcpy() as the bounds have already been checked and this
> decays into a simple byte copy from one buffer to another removing any
> ambiguity that strncpy has.
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>

Applied, thank you.

-- 
Dmitry
