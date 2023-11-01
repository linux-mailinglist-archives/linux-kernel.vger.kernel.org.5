Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E6307DE621
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 19:47:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344483AbjKASj5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 14:39:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231908AbjKASj4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 14:39:56 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48D0FA6
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 11:39:54 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-6c311ca94b4so145589b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 01 Nov 2023 11:39:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698863994; x=1699468794; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Mg/KOVePNmARti1sogxRuGEfS088YfXRvhg4XGoDqCQ=;
        b=QEg9AbsdoCDwu751NWaz2ExNNwm+QN5DoqzDwWLGSr/HPHEJ8zSFMIO4Zlk26+UT6X
         kz62Uz34LUj8O7hoBaNunajFvCVTWEd/3NDuxU7hG44A/hhO6r981+ICtH0lAWc6iDbK
         RFt/3iquQYaHNNMWxccauawpa5IqCjCtqjJZ/sej6zBuH1PhmElmkx4kCvAQAVWXEN3O
         Hbu5cxm+CVTd+JaEJU+hiM8/zERccg9xGp4DpS6pjQoWFXw5H2QqXvC20ppOqwAmFiuh
         CccXG0vp9SKSkI8Up4WA8i9y3NdRgeTPR6JxB8lZRTfD1OLByuR5X6xmzV/l1Zu0BBYu
         aLtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698863994; x=1699468794;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mg/KOVePNmARti1sogxRuGEfS088YfXRvhg4XGoDqCQ=;
        b=Rl8id1rRfNNT/97TZuUh207GkluJz/M361bb7MeEh1m4s074ktr9SsQ+FnzTzUzi3Q
         av20UYfLrjITu/OiL3A+WtHeDRoR7EQ8O5INCYoTzWOqBF9oqKxZyBNSVRrtIpA9TsOT
         09DJGRXQUiAL17yQaVvwKExp1uuRpKkTknU9lOSB6pbs2r8kgHGg+gSS/OKVgEU/takI
         Xq9WSbVOh/mKiUwEr+avJEy30a+SkxjvxE6gTqjsdvPZILw1oFGym4JTs2cAHV2TObJi
         5vQyWNZozmWaGPkhWT8AwX7wZp26q1jnKjrGeuYwdq7lebe/34cfx+Z/ycQEZCRZaq4w
         VJbg==
X-Gm-Message-State: AOJu0YyAhH1zJN2ub5Q+Zidsyp1wtnKSx7GzSjbovoUJHzFwabZxjlXh
        Pj07VIj5OvK1wsetK7cjuaXMvw==
X-Google-Smtp-Source: AGHT+IGX9dGN/qHysgy7FuH2Yx3/QSCyXb1D8xpssIcNpGbPZzlCSbMBfIQrHf7OX0XWBa1fP+cLiA==
X-Received: by 2002:a05:6a00:2356:b0:6bd:ca1d:c51e with SMTP id j22-20020a056a00235600b006bdca1dc51emr18008629pfj.16.1698863993632;
        Wed, 01 Nov 2023 11:39:53 -0700 (PDT)
Received: from google.com (209.148.168.34.bc.googleusercontent.com. [34.168.148.209])
        by smtp.gmail.com with ESMTPSA id ka14-20020a056a00938e00b0068bbd43a6e2sm1612983pfb.10.2023.11.01.11.39.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Nov 2023 11:39:53 -0700 (PDT)
Date:   Wed, 1 Nov 2023 18:39:49 +0000
From:   Carlos Llamas <cmllamas@google.com>
To:     Alice Ryhl <aliceryhl@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <brauner@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        Matt Gilbride <mattgilbride@google.com>,
        Jeffrey Vander Stoep <jeffv@google.com>,
        Matthew Maurer <mmaurer@google.com>
Subject: Re: [PATCH RFC 20/20] binder: delete the C implementation
Message-ID: <ZUKbdaBsfg0DyIMu@google.com>
References: <20231101-rust-binder-v1-0-08ba9197f637@google.com>
 <20231101-rust-binder-v1-20-08ba9197f637@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231101-rust-binder-v1-20-08ba9197f637@google.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 01, 2023 at 06:01:50PM +0000, Alice Ryhl wrote:
> The ultimate goal of this project is to replace the C implementation.
> 
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>

Nice, great work Alice!

As far as logistics I think it would be nice to make the transition
right after an LTS branch off. This should give the Rust binder more
time to mature before landing on the subsequent LTS release.

Acked-by: Carlos Llamas <cmllamas@google.com>

--
Carlos Llamas
