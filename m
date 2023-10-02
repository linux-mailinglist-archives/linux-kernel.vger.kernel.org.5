Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C0CB7B5916
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 19:42:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236806AbjJBRl7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 13:41:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236424AbjJBRlz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 13:41:55 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD355C9
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 10:41:52 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id 98e67ed59e1d1-2773f776f49so2365006a91.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Oct 2023 10:41:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696268512; x=1696873312; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4PQ5k5L1vf7U2VTih6tAHOOIpHZFCPz9bxhvZ9xLpPg=;
        b=QnHgHkI54rM2dgH4r1tXPy6tXPBMD5ry1/ifdplX/l0guWws/HGKmd+izNN2lYbyQ8
         ASsK6Oo5Z7sy1Q/Z0kBNIYuCbzpRqXuKX6VuKTPVDI4BqtUsZz1HroIhIotGjXD5xnh5
         nFJxMKr5N8enwmuj+YAiIfixs5OqbH54QmgQk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696268512; x=1696873312;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4PQ5k5L1vf7U2VTih6tAHOOIpHZFCPz9bxhvZ9xLpPg=;
        b=niLq5FbyoUwzVfHEkpEACV7vc1uXgRJeAAbGq7mgHJ8AC098DY3D5KIQAcdGbf2Ysk
         SRrMmQiOTKln9eDTWQl+Z+RvLZ16RL3n4E8ld5Q8k74DpaS7a/T2KeCtBoKVFGqzI41h
         ZgZuM8WUWkrEzo61Ndiai/t3u10+qAzmI+yNaR/6NHc49iZXy3g4BOO1e+JamL+YI5NG
         Yf2dA5lTUxSOw4LLnO1pEHnvfnMVGy7vombtKmRWd2GtkvrbepbqXnNTFzIrj6PlbmRk
         9sqpOIQltzPLN7+ObIvcRhbWGZLv3aeshEloVv83OlOGpu4lgepi6AdCXOOaoC5G2AzA
         FPfg==
X-Gm-Message-State: AOJu0Yysm1P+x9MmZ0FvcBPSBhJbh6BXWsrc17LLMM6HYeHoO3wsVG++
        LDFo6WrPt1g694ZQT0t7XcbPsQ==
X-Google-Smtp-Source: AGHT+IEKwoN8US8SbhoaEXG8I/zbZA98vFUpxqN5OwarkAVod2EsBwbtDvEJWjc/sy7+JQaEzvI/Jw==
X-Received: by 2002:a17:90b:128f:b0:279:c1e:a146 with SMTP id fw15-20020a17090b128f00b002790c1ea146mr341768pjb.23.1696268512222;
        Mon, 02 Oct 2023 10:41:52 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id d24-20020a17090ac25800b00276cb03a0e9sm6392591pjx.46.2023.10.02.10.41.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Oct 2023 10:41:51 -0700 (PDT)
Date:   Mon, 2 Oct 2023 10:41:48 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Justin Stitt <justinstitt@google.com>
Cc:     Sathya Prakash <sathya.prakash@broadcom.com>,
        Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
        Suganath Prabu Subramani 
        <suganath-prabu.subramani@broadcom.com>,
        MPT-FusionLinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] scsi: message: fusion: replace deprecated strncpy with
 strscpy_pad
Message-ID: <202310021041.FA60C9812@keescook>
References: <20230927-strncpy-drivers-message-fusion-mptctl-c-v1-1-bb2eddc1743c@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230927-strncpy-drivers-message-fusion-mptctl-c-v1-1-bb2eddc1743c@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 27, 2023 at 04:06:09AM +0000, Justin Stitt wrote:
> `strncpy` is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> Since all these structs are copied out to userspace let's keep them
> NUL-padded by using `strscpy_pad` which guarantees NUL-termination of
> the destination buffer while also providing the NUL-padding behavior
> that strncpy has.
> 
> Let's also opt to use the more idiomatic strscpy usage of:
> `dest, src, sizeof(dest)` in cases where the compiler can determine the
> size of the destination buffer. Do this for all cases of strscpy...() in
> this file.
> 
> To be abundantly sure we don't leak stack data out to user space let's
> also change a strscpy to strscpy_pad. This strscpy was introduced in
> Commit dbe37c71d1246ec2 ("scsi: message: fusion: Replace all
> non-returning strlcpy() with strscpy()")
> 
> Note that since we are creating these structs with a copy_from_user()
> and modifying fields and then copying back out to the user it is
> probably OK not to explicitly NUL-pad everything as any data leak is
> probably just data from the user themselves. If this is too eager, let's
> opt for `strscpy` which is still in the spirit of removing deprecated
> strncpy usage treewide.
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Cc: Kees Cook <keescook@chromium.org>
> Signed-off-by: Justin Stitt <justinstitt@google.com>

Agreed -- this looks more robust and readable. Thanks!

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
