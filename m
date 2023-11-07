Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5D057E373D
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 10:09:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233938AbjKGJJb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 04:09:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233851AbjKGJI7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 04:08:59 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D557B10FF
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 01:08:38 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-da0c6d62ec8so6348653276.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Nov 2023 01:08:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699348118; x=1699952918; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=+eUGHj56X84oOehB7OsmFu7+AC/IamVLcx65fDwIjUA=;
        b=uL1tl+4NOq02Zk8oQMpEFZj/U7IKzD4d4dgx3ATqWxaKqu8lHhNdmBknmw/cG2QLYX
         RAxGuTAoPklitqOYWQAiqByFPXukMWF8owKx+EOc918Bw325Bg9g4YiKDdnogVfIfvCv
         wKxYWRaq5MRf6r2GSvpeZBlWEPcgHSN+GarvgzZ8skk0SIhQCDHug+HqlDXzhy6jXex8
         7dcYgy+Pp+OMpW/2xpIQ1vigQNsmgvZPOpAAaXVcQsQ0UVIJdrHo6IjWC6jeBJbGdEzX
         74j0R7h4fvvUngboxdq9rE4Ni7V/YVRkeLIMfqSvKUqiPYCdvgYKV/UwbxACSUxIQrQb
         qmzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699348118; x=1699952918;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+eUGHj56X84oOehB7OsmFu7+AC/IamVLcx65fDwIjUA=;
        b=rly7yfuasQjpp8k3t2lCQLPl1QvQiL4g0F0s9JEUFJjWg9W59HsI+NJtxsMGOywbuY
         Dve5TRSD9qOlG+1I1iKLUJl6tUQ/vFQGAlfelCt6kgAiuBWPHNQ/0/iDvFDDY0R9mnCH
         4DToSymi54FClVlnJ5L8SH+RGmPFM9Yrcfc6/jSwiAWOQ0flMVDdKub2ese7SBZ0xLRu
         QYNPAQQKl2ZbhlEUc7wqXZq+tJg8gvzIJ7QNDksHKvC78UZy3lmxeq1aJ2R7uI/jc5Ie
         nX6mutw5ZieQPhj46MZTgzBa5sR3iDSTo1znMh839+JLhBvUYCx/YYwJjN/RVo8PS14f
         w0ww==
X-Gm-Message-State: AOJu0YxE4ZQ5y1oZ1ZeLxW/YwLsb89JGD9fK6+Lz6iuPHtZew5W2TSk/
        qiyYvoRFaDTLIDgXMO2iYTy6kgC8hreumbc=
X-Google-Smtp-Source: AGHT+IH5t8iOsN0KtWLmoijdLE1j9S5kYcygeklX7ppktVhEzgE9KfoGFDafRAO6GIpCIrwZ0VAhLTM1NzwHEVM=
X-Received: from aliceryhl2.c.googlers.com ([fda3:e722:ac3:cc00:68:949d:c0a8:572])
 (user=aliceryhl job=sendgmr) by 2002:a05:6902:1083:b0:da0:567d:f819 with SMTP
 id v3-20020a056902108300b00da0567df819mr744427ybu.10.1699348117913; Tue, 07
 Nov 2023 01:08:37 -0800 (PST)
Date:   Tue,  7 Nov 2023 09:08:35 +0000
In-Reply-To: <20231102185934.773885-17-cmllamas@google.com>
Mime-Version: 1.0
References: <20231102185934.773885-17-cmllamas@google.com>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
Message-ID: <20231107090835.260342-1-aliceryhl@google.com>
Subject: Re: [PATCH 16/21] binder: refactor page range allocation
From:   Alice Ryhl <aliceryhl@google.com>
To:     Carlos Llamas <cmllamas@google.com>
Cc:     "=?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?=" <arve@android.com>,
        Christian Brauner <brauner@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        kernel-team@android.com, linux-kernel@vger.kernel.org,
        Martijn Coenen <maco@android.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Todd Kjos <tkjos@android.com>
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Carlos Llamas <cmllamas@google.com> writes:
> Instead of looping through the page range twice to first determine if
> the mmap lock is required, simply do it per-page as needed. Split out
> all this logic into a separate binder_get_user_page_remote() function.
>
> Signed-off-by: Carlos Llamas <cmllamas@google.com>

One nit, otherwise looks okay to me.
Reviewed-by: Alice Ryhl <aliceryhl@google.com>

Carlos Llamas <cmllamas@google.com> writes:
> +		unsigned long index;
> -		size_t index;

You're changing the type of index to unsigned long here, but it seems to
me that size_t is the correct type.

Alice
