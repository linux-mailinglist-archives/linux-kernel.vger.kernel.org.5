Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5BE0770E23
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Aug 2023 08:36:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbjHEGgA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Aug 2023 02:36:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjHEGfz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Aug 2023 02:35:55 -0400
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A89F1BE;
        Fri,  4 Aug 2023 23:35:55 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-583b3939521so32733557b3.0;
        Fri, 04 Aug 2023 23:35:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691217354; x=1691822154;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=izJldXkK49lbGL0XLPukfeIEvUvsLq+UDkHmXV6tSds=;
        b=A707mbbrKfoL1HkqQ9fJGcWngC04eUzbvLyMt49WGL8RFVv8VVbIZrDybCgkWbyF3Z
         vBWBrqUXwI/5LR1HQvVi4keHlv535aZBqE4e/Dh3PSZ8liVnM3jGsUxBJya6dEnt46pm
         kUKIDrb+hlSRduhrPrL8dHw4HqoWOQcCe2gbXLoiQhroTv7kn9YzXEgY9nHwVBseDeXT
         PVUJUU4wde1bkvk6TsY0r3Hnjqwwhbtkd1uUhjdwnS8DvcTDcQPuTWvM2CAxHW/AJGV4
         UwlCEAtthV3zhWmSjt8Z4wfFxaTBk9UynuGfZjMU9XrEaUsC2gwLOOSdl24JTRFx4l3y
         ZMXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691217354; x=1691822154;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=izJldXkK49lbGL0XLPukfeIEvUvsLq+UDkHmXV6tSds=;
        b=TtntCX+eoihEOto2szE1SocVXsVnwCNo2z5ICd8QVtXv9Q5TUCpbhRnj0a/9dcnpjs
         vgPCv122J+nrW6q9OsZuopTKt2F6oyfTeoAd22/LsX/QDo2PeFkEpOI893OlyNIUy/Dx
         6DgZ6yw63pfxrNdYf9PQpYZvjB85T9jwbDlm+9LCdamImSHdF5RWBKopq0Bgg4rAxFJf
         FcF/5uEUjlS0GGuKi3spXzABV5lTe8WyCszXExMRZI4HxKxSIjfTGgBaLrGkJ+/hys1d
         Mo1GzjPZuF4ZrzL8Y4DhDBKNdEjGxRg4ESmsZw3juSyDXQ6mYDs6C7TFPK1PsSnkvytV
         Lzig==
X-Gm-Message-State: AOJu0Ywc2H/Tc5FECEZOJ3VFFuG7HTf4U9eEjpLgufPm16T/mfRk/ejg
        1ogMIQ2mV0ziAn6M3/MMfqyDldqgQqOjbeRQjv5QWc9zqbg=
X-Google-Smtp-Source: AGHT+IET4oIjgzL1wCDATiUpvfpr5nw9EkbuCymAifTyabQIhU5etbcc4G7i4IZn4+mmPn7hXwN8W06nR+L21IOYu7k=
X-Received: by 2002:a81:73c1:0:b0:584:3140:fcae with SMTP id
 o184-20020a8173c1000000b005843140fcaemr4139723ywc.26.1691217354314; Fri, 04
 Aug 2023 23:35:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230804090621.400-1-elver@google.com>
In-Reply-To: <20230804090621.400-1-elver@google.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Sat, 5 Aug 2023 08:35:43 +0200
Message-ID: <CANiq72=-o49qkW+mPW45P_+jbS2jO=5_qks14HOtzVOukb0Mpw@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] compiler_types: Introduce the Clang
 __preserve_most function attribute
To:     Marco Elver <elver@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, Miguel Ojeda <ojeda@kernel.org>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        kasan-dev@googlegroups.com, linux-toolchains@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 4, 2023 at 11:06=E2=80=AFAM Marco Elver <elver@google.com> wrot=
e:
>
> will imply notrace. It is recommended to restrict use of the attribute
> to functions that should or already disable tracing.

Should the last sentence here be added into the code comment?

Apart from that this looks fine from a `compiler_attributes.h`
perspective (even if we are not there anymore):

Reviewed-by: Miguel Ojeda <ojeda@kernel.org>

Cheers,
Miguel
