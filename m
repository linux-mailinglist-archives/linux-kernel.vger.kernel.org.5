Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBF287ADE5A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 20:04:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229735AbjIYSEr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 14:04:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231853AbjIYSEl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 14:04:41 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7A6A103
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 11:04:34 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id 3f1490d57ef6-d865854ef96so5300803276.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 11:04:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695665074; x=1696269874; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XftFOjpvnqBOvm+GyG7dS3QneDyHgJbjgRAoI+rP2Vc=;
        b=hR7fPoA9GHElMqHoCR+hCqcwl2hviY1cJs0/p9nCUFs0yEqkiUApK5fs84WUphxHuA
         3aRBZCaEeIn03MsA8ev3tuaBgLG5GPGQmLGgbnT4XnJbPcBxz0KqPCzXlFF2sIX94x96
         N/GfDflSXS3ODCqdCmMuzXPTr9WPBuk8Z51rY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695665074; x=1696269874;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XftFOjpvnqBOvm+GyG7dS3QneDyHgJbjgRAoI+rP2Vc=;
        b=tsypWc0QrhnktxnmwaSXD/NeL1XeS2ZbLqt0wKris9QB5j2gQUDPt1H1+rRa9irKnD
         5NlL2AbKnp97qqJ2jrWtVtSKOK8ks+mWl63qG4TsmAFNExFiaWyVjQd6Qk16SIUrsy3D
         p9QXNbA4zoB6RcmrMSdrjjjpwvenvdkMfYwOluS300uX+Jd0ZJDplEw5l6kNh9x8jBC0
         PoU+QJx87Va67QVgNJj12qI1uJD5TU/jM49C0yJPjAxP91CSyvto81Px0I8+3EzdFYqv
         q15P8XkNEc9Gd6r5GYF4KROoPqRvwLuuujpuQy7WK6nD5yr9XN8MZ8767UDySvYUV1Wj
         Y6yQ==
X-Gm-Message-State: AOJu0YxHRNddnynuljDd7BykoqlrqjR7ooXWI78xWnwNImomjmKoAlx1
        10lFTYGFcwVYuNzvKtsvmR5r7w==
X-Google-Smtp-Source: AGHT+IHLxOCMidSuiT5VuJdY2s//GNKCUPI3HgEunXnWS6HNGof+bL6k1SeyWqZzqivG9gVlZPGyJQ==
X-Received: by 2002:a25:838e:0:b0:d7f:e578:58d5 with SMTP id t14-20020a25838e000000b00d7fe57858d5mr6401728ybk.41.1695665073996;
        Mon, 25 Sep 2023 11:04:33 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id j19-20020a633c13000000b00565009a97f0sm8168514pga.17.2023.09.25.11.04.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Sep 2023 11:04:33 -0700 (PDT)
Date:   Mon, 25 Sep 2023 11:04:32 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Justin Stitt <justinstitt@google.com>
Cc:     Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>, dm-devel@redhat.com,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] dm crypt: replace open-coded kmemdup_nul
Message-ID: <202309251104.2039A045E@keescook>
References: <20230925-strncpy-drivers-md-dm-crypt-c-v1-1-eef875e4f9b2@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230925-strncpy-drivers-md-dm-crypt-c-v1-1-eef875e4f9b2@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 25, 2023 at 06:35:54AM +0000, Justin Stitt wrote:
> kzalloc() followed by strncpy() on an expected NUL-terminated string is
> just kmemdup_nul(). Let's simplify this code (while also dropping a
> deprecated strncpy() call [1]).
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Cc: Kees Cook <keescook@chromium.org>
> Signed-off-by: Justin Stitt <justinstitt@google.com>

This looks correct to me. Thanks!

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
