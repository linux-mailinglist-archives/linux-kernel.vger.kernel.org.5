Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80EA97891BC
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Aug 2023 00:31:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230139AbjHYWaJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 18:30:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230310AbjHYWaB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 18:30:01 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2DE32120
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 15:29:59 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1c0d0bf18d7so10741685ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 15:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1693002599; x=1693607399;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zjKBWFk7CCFK9RvsGkigHaGte8r8h33Yp95QKxuI3/k=;
        b=cpFDbiK3LGCMITzgeOKD7FHIpmNzrUK/BMljXHn63nFaDiq/+fzObMer5FMu9RS5i2
         zxl7mlhiNeBIuVra0zkmeunDQL3ZWdizLCet3eIvoPK7rLk6D5/mOepZFQHUZsiEJZd7
         0N+qqwGoCu8ZD/+8qW8tvPeLEPjIbHEdx+GKs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693002599; x=1693607399;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zjKBWFk7CCFK9RvsGkigHaGte8r8h33Yp95QKxuI3/k=;
        b=JXOrXKEYqAyl7U3UvInNKjckgnN9NuggRnE0C5Is0sBLbgmfL9rGuhHBrWN/QC2YFv
         eO+lI1P8jYnX0m/v8c4h1H+4ezM4lWfUnA9n3rLGUgBfWqQt8Wya8k0el9NwhkJ7kwSa
         WTm1xzXcVsEV8aqhADzVuFPa2Te686Il/kyxftn2JiAT1dF4asMR1R6bedGpClH07caG
         DKCiHqJhgw5wRRrOTnXt/LFGvzFWWR0OD0OPD/keY10epc5/sBWD4/HQSdAOmXIJQ5jo
         DQkwwEdp9D9xX740KiBJljSGLW+Hs44FC0ZW5hclIqO1fpK9195VfJb7c4HMtH30pltE
         FhYA==
X-Gm-Message-State: AOJu0YyawHQP2LxzZgKY4NjHFLtcPYad4OmiyLALH3dNzVkrNlxnR11j
        MKkLcJJg1iaXcbTMs57QP7VG3g==
X-Google-Smtp-Source: AGHT+IGFa9YKZO4oiDjaZUP80v8iJiJtJhGfjR7i2hR3cNCIzFJkq0PafdJnTHS7B5OWY8oZjd9SbA==
X-Received: by 2002:a17:902:a414:b0:1bd:b8c8:98f8 with SMTP id p20-20020a170902a41400b001bdb8c898f8mr14935310plq.4.1693002599319;
        Fri, 25 Aug 2023 15:29:59 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id ji18-20020a170903325200b001b9da8b4eb7sm2270966plb.35.2023.08.25.15.29.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Aug 2023 15:29:58 -0700 (PDT)
Date:   Fri, 25 Aug 2023 15:29:58 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Florent Revest <revest@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, catalin.marinas@arm.com,
        anshuman.khandual@arm.com, joey.gouly@arm.com, mhocko@suse.com,
        david@redhat.com, peterx@redhat.com, izbyshev@ispras.ru,
        broonie@kernel.org, szabolcs.nagy@arm.com, kpsingh@kernel.org,
        gthelen@google.com, toiwoton@gmail.com
Subject: Re: [PATCH v3 3/5] mm: Make PR_MDWE_REFUSE_EXEC_GAIN an unsigned long
Message-ID: <202308251529.43BB30B9A3@keescook>
References: <20230704153630.1591122-1-revest@chromium.org>
 <20230704153630.1591122-4-revest@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230704153630.1591122-4-revest@chromium.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 04, 2023 at 05:36:27PM +0200, Florent Revest wrote:
> Defining a prctl flag as an int is a footgun because on a 64 bit machine
> and with a variadic implementation of prctl (like in musl and glibc),
> when used directly as a prctl argument, it can get casted to long with
> garbage upper bits which would result in unexpected behaviors.
> 
> This patch changes the constant to an unsigned long to eliminate that
> possibilities. This does not break UAPI.
> 
> Fixes: b507808ebce2 ("mm: implement memory-deny-write-execute as a prctl")
> Cc: linux-stable@vger.kernel.org
> Signed-off-by: Florent Revest <revest@chromium.org>

Ah yes. I remember this pain with seccomp. :)

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
