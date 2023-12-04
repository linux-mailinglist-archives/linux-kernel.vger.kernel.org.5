Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A5A4803715
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 15:39:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345226AbjLDOjK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 09:39:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233871AbjLDOjI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 09:39:08 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 803D7F0
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 06:39:14 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-6ce3935ffedso1839184b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 06:39:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701700754; x=1702305554; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0jLlSu3/GaVGbEpaSldOKV5ftevDhGsXDKnanlgCeDI=;
        b=izfQkdaj/z90zcSMjM/MxthXdpmN95lppXo3MvbHTfnMscN4Mvw9R2rhSiNb9KbfAC
         1UpsdW6cFHrwbVuFjrLnaxByg8k+2XOYF8bWYXqbvpb/DQAeQXHgLqsWnoq5gVRyMO8U
         a8nK99R9Puc4zf9PV3KKOr/Zlo4uc5SH4AzwijtXMTtg7g0sxYX5du6q8n+5xiEA0nhs
         Gu/mtiskAh4Xgzldh2q5f4Apzwgw/y2jIFdq2C35c32j0w9SYELIUaFtQCt6N77OdFKW
         orc5UG1jEguqyKuS4zc2e4vsGCFiWs7MDQgkoWmFt2oFZpzpmP+TkoEfwMH5/JVpVGup
         z/gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701700754; x=1702305554;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0jLlSu3/GaVGbEpaSldOKV5ftevDhGsXDKnanlgCeDI=;
        b=GI1FuH3Oj4Qbi2J1di4PSUv5dlj0TsEYzlXrHJLSHTCmK54KNA+DEfuDN+8IkWmNPw
         bKh5mBIxs8KaqaAt/KgUbO2yeGN7m0tewVkqmrcYgBr1bf7DfeFzTWrVi8wvFp3T0LW9
         v+31RZgIic2gzZOLVUHGKf0YeBFll3+jmVZxjYcCdCY3hAl5BCHWXlmmecSykMo0B4hz
         V8bGy096IUEgDXjKKMNM/9kKbW4fhhRI/eRw57YK23bIcE1mPdI3F8gy+BUurBwEIi6D
         QRLuQKaXhE293Hvzr/p2FRcks1HuRYv5Gq0EZVwWfj3Xwdut6h4kyDxBj5tW9WtItTSS
         IokQ==
X-Gm-Message-State: AOJu0Yxs53Fc7uRzShGYZA/hFVRfrG/GEBtVSR7nkCt20H1UpbyLs47y
        kkxsNY9QrTPs/SESpLjKO6EaLw==
X-Google-Smtp-Source: AGHT+IFOer8+VToEvlzAjqJ8WKjvLUnocdKB9fczASUXK2IJ5yrMKzucY9IvJFV773qLe0FZSKLgzg==
X-Received: by 2002:a05:6a20:3945:b0:18f:97c:8a35 with SMTP id r5-20020a056a20394500b0018f097c8a35mr5699397pzg.96.1701700753765;
        Mon, 04 Dec 2023 06:39:13 -0800 (PST)
Received: from google.com (170.102.105.34.bc.googleusercontent.com. [34.105.102.170])
        by smtp.gmail.com with ESMTPSA id s16-20020a056a00179000b006c0316485f9sm3449035pfg.64.2023.12.04.06.39.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 06:39:13 -0800 (PST)
Date:   Mon, 4 Dec 2023 14:39:10 +0000
From:   Carlos Llamas <cmllamas@google.com>
To:     Alice Ryhl <aliceryhl@google.com>
Cc:     arve@android.com, brauner@kernel.org, gregkh@linuxfoundation.org,
        joel@joelfernandes.org, kernel-team@android.com,
        linux-kernel@vger.kernel.org, maco@android.com, surenb@google.com,
        tkjos@android.com
Subject: Re: [PATCH v2 23/28] binder: document the final page calculation
Message-ID: <ZW3kjj6KC73zpnw4@google.com>
References: <20231201172212.1813387-24-cmllamas@google.com>
 <20231204115727.42370-1-aliceryhl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231204115727.42370-1-aliceryhl@google.com>
X-Spam-Status: No, score=-13.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,FSL_HELO_FAKE,RCVD_IN_DNSWL_NONE,SORTED_RECIPS,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 04, 2023 at 11:57:27AM +0000, Alice Ryhl wrote:
> > The code to determine the page range for binder_lru_freelist_del() is
> > quite obscure. It leverages the buffer_size calculated before doing an
> > oversized buffer split. This is used to figure out if the last page is
> > being shared with another active buffer. If so, the page gets trimmed
> > out of the range as it has been previously removed from the freelist.
> > 
> > This would be equivalent to getting the start page of the next in-use
> > buffer explicitly. However, the code for this is much larger as we can
> > see in binder_free_buf_locked() routine. Instead, lets settle on
> > documenting the tricky step and using better names for now.
> > 
> > I believe an ideal solution would be to count the binder_page->users to
> > determine when a page should be added or removed from the freelist.
> > However, this is a much bigger change than what I'm willing to risk at
> > this time.
> > 
> > Signed-off-by: Carlos Llamas <cmllamas@google.com>
> 
> Yes, this does help somewhat.
> 
> However, `curr_last_page` is actually not the last page. It's the last
> page plus one, since `binder_lru_freelist_del` is exclusive on this
> argument. Maybe rename it to `curr_after_last_page` or something like
> that? Or maybe even just `curr_last_page_plus_one`.

hmmm, I don't know. I think this could be more confusing, the plus-one
is only because of the way that binder_lru_freelist_del() processes the
final page. So you could interpret the name both ways. Do we _really_
need the extra comments to make it clear?

This solution is too complex anyway, it should really be replaced with a
binder_page->nr_users to determine when to add/remove from the lru.

--
Carlos Llamas
