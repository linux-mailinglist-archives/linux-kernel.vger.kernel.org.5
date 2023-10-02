Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 617737B4CDA
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 09:52:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235792AbjJBHwO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 03:52:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbjJBHwN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 03:52:13 -0400
Received: from mail-vk1-xa2e.google.com (mail-vk1-xa2e.google.com [IPv6:2607:f8b0:4864:20::a2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19CC8BD
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 00:52:11 -0700 (PDT)
Received: by mail-vk1-xa2e.google.com with SMTP id 71dfb90a1353d-49040dc5cedso6085333e0c.3
        for <linux-kernel@vger.kernel.org>; Mon, 02 Oct 2023 00:52:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696233130; x=1696837930; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0eB1JHsdEJVi5+OIbOyuQwr2jpiM2fDRqI2qLCnxqC4=;
        b=lOawnfVvwurlGTERAfCT4nN4sN8YNb//Rhno00eUkh/EMlMMBwsZc/C52164FgYi2B
         ElQmNb4QFVQ7toDcsHFYfwca6DRTb57AWxnA/SXCpeW+f7Vh7p6Dlqbfcy3alYaEK261
         AuLjMZI5UP2MiSnOKtNctfDWty4A4LVl8biAEa3fPyoST2PdIU0AqDK3xX0yeDZq0/yU
         3pyqTzYyxzSTqH3Z6mLYiukRqzw/o2qyAI3PfiSzPZL0ScLVBrCCYwQYZ0S0sx3prehL
         r1FsrQYD1y/6NUZXGa4vGeULZtvWmk6w7l7Nh9muHRhvjP5grRz7ZXkvJKcZpJnPIeAZ
         ApDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696233130; x=1696837930;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0eB1JHsdEJVi5+OIbOyuQwr2jpiM2fDRqI2qLCnxqC4=;
        b=ZjYD3kcUWZsG0gG1tw/ZJbCkwEWbqdAqtrcZILP1Y/lCMXBUkClshHjWZyTFK1tuly
         LWeeYCYDmg0RNBlE1ZsVgkUFbzUKnzcYmC9uaJlCpxRbcZn8/rElpCqK02fzl2a7oUly
         g1Kw2bebbwPpDc2jdcSHp9uL3M320/BbzRlWlpWCW9MRe4+Mjuy8RhptfMOcfKWIdbCw
         fz0s69qaih1flxhrRh/QL+sY/u7zVEusNB1xRGb7FgvvVzKIMGJjyW90QoqIsT9730KE
         EwkylJpPMlDIkw7/fA8v2RbO3v++fHlCqH0YXSMlI6kJB77SzemafiuWvhDXSyMTjHY5
         SNhg==
X-Gm-Message-State: AOJu0YzpPJ3VDq0Jq0Xl8zXttYjBgyiMvf4xTQ2jVyOivOMr7q7VJeoI
        0cRKWMIp991oo69OSlEo5dy0ayX2rRBgSS325rAhnA==
X-Google-Smtp-Source: AGHT+IHZB51YF7QTx3t7DDgFWlsKziT1a7v9b77HG6jtZQj1Bi+P05ewtbDn3c7BD6d6mOHABX16dzqMmdw4k+2s4SQ=
X-Received: by 2002:a1f:c8c4:0:b0:499:dec9:e1a7 with SMTP id
 y187-20020a1fc8c4000000b00499dec9e1a7mr5746398vkf.10.1696233129914; Mon, 02
 Oct 2023 00:52:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230928201421.2296518-1-mmaurer@google.com>
In-Reply-To: <20230928201421.2296518-1-mmaurer@google.com>
From:   Alice Ryhl <aliceryhl@google.com>
Date:   Mon, 2 Oct 2023 09:51:59 +0200
Message-ID: <CAH5fLgjmPkfokku190dab9JVqk3_uTABNWqOZ-xKOEqQJoX+9g@mail.gmail.com>
Subject: Re: [PATCH] rust: Use grep -Ev rather than relying on GNU grep
To:     Matthew Maurer <mmaurer@google.com>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 28, 2023 at 10:14=E2=80=AFPM Matthew Maurer <mmaurer@google.com=
> wrote:
>
> While GNU grep supports '\|' when in basic regular expression mode, not
> all grep implementations do (notably toybox grep, used to build the
> Android kernel, does not). Switching to grep -Ev enables extended
> regular expresions which includes support for the '|' operator.
>
> Signed-off-by: Matthew Maurer <mmaurer@google.com>

LGTM. I tested this in my Android build.

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Tested-by: Alice Ryhl <aliceryhl@google.com>
