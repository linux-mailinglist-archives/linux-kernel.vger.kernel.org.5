Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D67476FC1B
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 10:39:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229551AbjHDIj3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 04:39:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjHDIj1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 04:39:27 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42F9730F3
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 01:39:24 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id 5614622812f47-3a741f46fadso1427370b6e.0
        for <linux-kernel@vger.kernel.org>; Fri, 04 Aug 2023 01:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1691138363; x=1691743163;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=uOolvxWBO1oZnrFCsNd9LkuoHUEh7+0m5vzVuKW91eE=;
        b=E8tgotaOPMlZLWEneDezVkJ0ELNCraviaCDhpHdi6SiEn6x8ATG4dW3YomJI6954qC
         rivrS2SjBNPxU3VzBM+09BjmbCYnws4ZvcVBSEsO8RVP8rsEoWRzk5B5NJMsWOv8RB+X
         lan1aBokc23m6qlX+sU7sRC61dTyMP+bwhqaU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691138363; x=1691743163;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uOolvxWBO1oZnrFCsNd9LkuoHUEh7+0m5vzVuKW91eE=;
        b=XPjZQVCKGiQNIFGUFXb4rNspKz8Ku/CYJ/U8oPa+/o8qVScwZBxeABuxsgLsQD/qDZ
         AbpJglguFWAEWMfpQ5WJAPsv10omrbikW0dbg7G2ixtTPp8J5YPXYhwqrAj4lgwN0E3A
         vRowxwy+rYjBYaWU5lkg/B5GZUfEr4z06g9pSopYwnMRpr2WifK/iIieqimGY1KGO98V
         JhKcHS8qEqNPdm9zXzrnPbOZg6Y7FuEyzhgYhatIyNY5kGzkJGsLhflgZwBDMj5G0BOx
         CzI2PLCpJIiVLk7VsSqFaNvAiQaasiqoe/YQUpG/js5uwOIYRFJwgLVsg1VqNzaVNPt+
         dYZQ==
X-Gm-Message-State: AOJu0YytWkiCuw0tidB+u1kuBQbE+oIcpr9RYn8aETn0dwoI641lVyGk
        ve73c4lJPj4PCnF6e18qkFea+Q==
X-Google-Smtp-Source: AGHT+IGboEqf5SjHYIHFEbKK7aOryM+lxbAIAmKQkDmh2W79MfEWWt3tPOCGC3QF2ePwbQQYN8a7dQ==
X-Received: by 2002:a05:6808:24e:b0:3a7:25c6:7b80 with SMTP id m14-20020a056808024e00b003a725c67b80mr1578467oie.34.1691138363619;
        Fri, 04 Aug 2023 01:39:23 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id jv14-20020a17090b31ce00b00263e4dc33aasm3705436pjb.11.2023.08.04.01.39.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Aug 2023 01:39:22 -0700 (PDT)
Date:   Fri, 4 Aug 2023 01:39:22 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, John Stultz <jstultz@google.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Christian Brauner (Microsoft)" <brauner@kernel.org>,
        Mike Christie <michael.christie@oracle.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Zqiang <qiang1.zhang@intel.com>,
        Prathu Baronia <quic_pbaronia@quicinc.com>,
        Sami Tolvanen <samitolvanen@google.com>
Subject: Re: [PATCH] kthread: unexport __kthread_should_park()
Message-ID: <202308040138.46EC412@keescook>
References: <2023080450-handcuff-stump-1d6e@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2023080450-handcuff-stump-1d6e@gregkh>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 04, 2023 at 08:41:51AM +0200, Greg Kroah-Hartman wrote:
> There are no in-kernel users of __kthread_should_park() so mark it as
> static and do not export it.
> 
> Cc: John Stultz <jstultz@google.com>
> Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>
> Cc: "Arve Hjønnevåg" <arve@android.com>
> Cc: Valentin Schneider <vschneid@redhat.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: "Christian Brauner (Microsoft)" <brauner@kernel.org>
> Cc: Mike Christie <michael.christie@oracle.com>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Nicholas Piggin <npiggin@gmail.com>
> Cc: Zqiang <qiang1.zhang@intel.com>
> Cc: Prathu Baronia <quic_pbaronia@quicinc.com>
> Cc: Sami Tolvanen <samitolvanen@google.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Yeah. Seems like it got an EXPORT because it was duplicating the
neighboring functions?

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
