Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ED577E3738
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 10:09:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233961AbjKGJJI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 04:09:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233960AbjKGJIk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 04:08:40 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AF671B2
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 01:08:30 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5ae5b12227fso74914257b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Nov 2023 01:08:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699348109; x=1699952909; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=7X3syWBaPUh0blKE5Mh+DYBdLiEDNmkcRuOfR+8nfh8=;
        b=u+RavW/xU4eiChcvS41wEfM2xdCvIchHq3eFsPtO9HIBjqxa7C9QZwuTiZG8xfHFyp
         gCC4IXsDHsKUMKiu8MenfQWy3LCJDZ3DfRMxj3ZvAmoKZJBT3e50NCOPDXU7QlqlxqrA
         u1TMxdqpM3v97F5H/XtPkVJ2LIqA2CzEDtuANt9Q57dCqVb+IN2bRd8M0KaapZU7eDAv
         drqm3R3ReZPN0aUe3JOeL4ExnHAvST8cLhleKf1RgJVjXXyWG+T5ZFDHxqkaoIiuYH3v
         SfWBRXD8G9D9lW3VhLa/9EM2PzApWY69GPNcrO858qwaxrcriU6RuZ1KL7DMxz3e6n27
         A3jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699348109; x=1699952909;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7X3syWBaPUh0blKE5Mh+DYBdLiEDNmkcRuOfR+8nfh8=;
        b=O7uM5CeniHMF3vw9zieZDpIzpCr2ATVUEdzX1ADcwZKPaIwWGtT2OK82/B2ZGDABgL
         IVBFuM0vLplYEbiD0oGmg/CAWhx2pSncmx8WFhmymyOGEWL+FqksUiqeBET+dVse9yei
         X+Xsr6x1PIyjcO25IhlEw68kOKOhII4CeTVcHjhUwlyOMhzYddx7yZkgbmP+kFgdJMcW
         w87rCqx0OB6B/GAPmBVccH9TUm2X+UopOBtk3Loyg8z56RI1vvFDVOROpUIXoUod/WwG
         TS+aJV5rPNBpxagujNj/MSX/1SDFkhMKz5a2Yc5bl1zzakIv0EQAqlRlgst/lhlE6xfI
         eBYw==
X-Gm-Message-State: AOJu0YyMYrwMrVRpTAixVl6Im62yYfvS/28U5HcswxTl6rxVjxngW3gf
        O5LnXrP7volQb9PducbffSzGp68ZDhmS9AE=
X-Google-Smtp-Source: AGHT+IEW9Bw+WyLY0seD7hkQ7dtMkpw3UBGweSobA0M2+82Gk3Hh2medzpOBFcL+zD5XYuJglrRZDjyx6xwt7cE=
X-Received: from aliceryhl2.c.googlers.com ([fda3:e722:ac3:cc00:68:949d:c0a8:572])
 (user=aliceryhl job=sendgmr) by 2002:a81:4855:0:b0:592:83d2:1f86 with SMTP id
 v82-20020a814855000000b0059283d21f86mr244866ywa.4.1699348109495; Tue, 07 Nov
 2023 01:08:29 -0800 (PST)
Date:   Tue,  7 Nov 2023 09:08:26 +0000
In-Reply-To: <20231102185934.773885-14-cmllamas@google.com>
Mime-Version: 1.0
References: <20231102185934.773885-14-cmllamas@google.com>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
Message-ID: <20231107090826.259454-1-aliceryhl@google.com>
Subject: Re: [PATCH 13/21] binder: relocate low space calculation
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
> Move the low async space calculation to debug_low_async_space_locked().
> This logic not only fits better here but also offloads some of the many
> tasks currently done in binder_alloc_new_buf_locked().
> 
> No functional change in this patch.
> 
> Signed-off-by: Carlos Llamas <cmllamas@google.com>

One suggestion below, but I'm fine either way.

Reviewed-by: Alice Ryhl <aliceryhl@google.com>


Carlos Llamas <cmllamas@google.com> writes:
> +		if (debug_low_async_space_locked(alloc))
> +			buffer->oneway_spam_suspect = true;

You could avoid a branch here like this:

buffer->oneway_spam_suspect = debug_low_async_space_locked(alloc);

Alice
