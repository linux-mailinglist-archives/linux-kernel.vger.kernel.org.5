Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AEF57B7558
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 01:42:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237859AbjJCXl5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 19:41:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237581AbjJCXl4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 19:41:56 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DDA5AC
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 16:41:52 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id 98e67ed59e1d1-27760c31056so997029a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 Oct 2023 16:41:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696376512; x=1696981312; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WhYcyR6Fe80biMSdh0fvQHW+o+cY1bEtG/iTTN+PcWg=;
        b=IHpUi4Ksr7Sxs+EbzIhbDtk+ViKhlKz9Km5JnR4HJs/OQ0KTliyWo//MOgxoddb8T7
         6ZlU3Y6KL2eWRewgAHgcBZqEnllPNwEtbaj+u4xJv6SyKhH8YxJDAgYIgrP28fXuE0WL
         tJRReKVlRVi8HOoqzeZeiR4+VmGIPjVhplyEY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696376512; x=1696981312;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WhYcyR6Fe80biMSdh0fvQHW+o+cY1bEtG/iTTN+PcWg=;
        b=e+Gm/0LRC2fRXfpJdSebmLKp6vNm64rOt3u/6n6q4MWlHkT2vOL19jyNjje5UPkli3
         LvlTjWA/ny/h7HcK6mmdBcfkNJECJh5lOP5lVddEbEXw1AKPU8MiC6l9CTVwIX3qPdHE
         0/OGkYGRrArShn9zubPf9O3JMcyHb9Bj/UJKcJXIe3e81jZWw0S6ccYxYAQhYBqNE9g+
         3vI8lXdMduke0xO/9UXPxuyz1IZZ6XINiWb9uPyP18QKiwtURGtsBfKvo0BwYoLURvjK
         XrIQ0tlKqVIQFnPoVeY4re+ce2LKnQDfm8EGRRJ/PB7th5MRNoKHzPn7tzfBgrlStC4D
         LDBw==
X-Gm-Message-State: AOJu0Yz7pxuTvFS+K9OekhwShEjTBY1ewLWrlMc5M+gBHoAjkXYVyQ9F
        O5RFEpyzqB3Ps4pYZnwdXsS+iA==
X-Google-Smtp-Source: AGHT+IEn0DmTvbVbBFxNdq3OKXXpFw4I9foZJK6ZxmUa8EteSnTE9RTr4xVQgT2VKg+fsVzgi2nZeA==
X-Received: by 2002:a17:90a:bf13:b0:277:5652:cb00 with SMTP id c19-20020a17090abf1300b002775652cb00mr674622pjs.24.1696376511915;
        Tue, 03 Oct 2023 16:41:51 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id 6-20020a17090a1a0600b00263dfe9b972sm188454pjk.0.2023.10.03.16.41.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 16:41:51 -0700 (PDT)
Date:   Tue, 3 Oct 2023 16:41:50 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Justin Stitt <justinstitt@google.com>
Cc:     David Rheinsberg <david@readahead.eu>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] HID: uhid: replace deprecated strncpy with strscpy
Message-ID: <202310031641.53DE6178@keescook>
References: <20231003-strncpy-drivers-hid-uhid-c-v2-1-6a501402581e@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231003-strncpy-drivers-hid-uhid-c-v2-1-6a501402581e@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 03, 2023 at 09:01:58PM +0000, Justin Stitt wrote:
> `strncpy` is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> A suitable replacement is `strscpy` [2] due to the fact that it
> guarantees NUL-termination on the destination buffer without
> unnecessarily NUL-padding.
> 
> Furthermore, let's make sure `hid->xyz` and `ev->u.create2.xyz` are the
> same size at compile time to prevent silent truncation.
> 
> With these changes, it is abundantly clear what the intent and behavior
> of the code is -- We are getting a string to string copy with
> NUL-termination and no truncation.
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Cc: Kees Cook <keescook@chromium.org>
> Signed-off-by: Justin Stitt <justinstitt@google.com>

Great! This looks much simpler to me. Thanks for adjusting it.

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
