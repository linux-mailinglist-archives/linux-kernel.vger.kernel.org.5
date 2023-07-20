Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F331F75AF7E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 15:17:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231750AbjGTNRA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 09:17:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231635AbjGTNQ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 09:16:56 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16DA526BA
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 06:16:53 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-57704af0e64so7479197b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 06:16:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689859012; x=1690463812;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=jZDyfQVqAO0bnYa7VYw9MMaKrL6NuobnBPEQu7nAapA=;
        b=b6DzRutOpRlchzhGc+vWqutvZPPlCW3TQf+U9eOy+pcYyCjPEjS83wJDT+mdAcH9WS
         ZKa2pOq77PfNzKjFJeVwBMyLfacxlFfOUdD20e/AOBtvomkN6yOFjVc5/eYRgrx+3l7d
         3ejGayJL4s3SMDgZFhcQ5GwPji6pqyjsIW+1b1tC53n1xDH2P9QNV7otpXOyxZGO772D
         ZxbDafbsKOn49/SC3si7WnXYIu6/Ki7S83+EjdnudP/wTEGox6vKP7+EvdIQDScKBWgw
         x1Ugue/ctvM4GE26AaDdqJwsK3jh18x1OFYNbPkBImnt09s7m3hTGf2grI49QkwZ5XV5
         6pmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689859012; x=1690463812;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jZDyfQVqAO0bnYa7VYw9MMaKrL6NuobnBPEQu7nAapA=;
        b=GkRVUWYp+tc0AlXYocU+axaD6wTKVunTRhzBovwF18xyss/jBkZRlOIX6I3A1rbO9z
         u3YI29LOcQwphk/XJfIniyiIlPq7+RjPKuyfif/iNTcoLnsdSO0if/9vIr2ygwCD4QFT
         bg/UsisBf4HZIxNyByhFamnXiZOklQ0G8cC5cyaUGg1TuNMx/K/4z9fxiIaW4gObhlN0
         E3ep58RqO+22pKYigmoWSU+WkkwXZoNXRNsIcPpcm8ruziy+gA+MqKPkAoUk0mLy2mdK
         ZgQTbgjqEQ87VTOtQECrz9Omqx2uEcJ9Pe6xV9iW11+vTgsa3mfwPC2PNJBYrdgnPlLK
         EibA==
X-Gm-Message-State: ABy/qLaACIaIt/nIrgfeoT3YOvxfPEWuBda0G9PmfqTZbtbb834CHyTh
        x0px+DFkV7K6S282VNIiFmEzP+xrQy3knvs=
X-Google-Smtp-Source: APBJJlFilV9dSuhKU7Af7K+uRVO6k7U92+nHUAIyOw7PsPz2kKbD7kCT1zItva0bW5jPFRiobB7cXYXHGmnRxgY=
X-Received: from aliceryhl.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:6c8])
 (user=aliceryhl job=sendgmr) by 2002:a81:b70d:0:b0:581:7b58:5e70 with SMTP id
 v13-20020a81b70d000000b005817b585e70mr59224ywh.5.1689859012266; Thu, 20 Jul
 2023 06:16:52 -0700 (PDT)
Date:   Thu, 20 Jul 2023 13:16:48 +0000
In-Reply-To: <20230719141918.543938-4-benno.lossin@proton.me>
Mime-Version: 1.0
References: <20230719141918.543938-4-benno.lossin@proton.me>
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
Message-ID: <20230720131648.3542031-1-aliceryhl@google.com>
Subject: Re: [PATCH v2 03/12] rust: init: make guards in the init macros hygienic
From:   Alice Ryhl <aliceryhl@google.com>
To:     benno.lossin@proton.me
Cc:     alex.gaynor@gmail.com, aliceryhl@google.com,
        bjorn3_gh@protonmail.com, boqun.feng@gmail.com, gary@garyguo.net,
        lina@asahilina.net, linux-kernel@vger.kernel.org, nmi@metaspace.dk,
        ojeda@kernel.org, rust-for-linux@vger.kernel.org,
        wedsonaf@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Benno Lossin <benno.lossin@proton.me> writes:
> Use hygienic identifiers for the guards instead of the field names. This
> makes the init macros feel more like normal struct initializers, since
> assigning identifiers with the name of a field does not create
> conflicts.
> Also change the internals of the guards, no need to make the `forget`
> function `unsafe`, since users cannot access the guards anyways. Now the
> guards are carried directly on the stack and have no extra `Cell<bool>`
> field that marks if they have been forgotten or not, instead they are
> just forgotten via `mem::forget`.
> 
> Suggested-by: Asahi Lina <lina@asahilina.net>
> Signed-off-by: Benno Lossin <benno.lossin@proton.me>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
