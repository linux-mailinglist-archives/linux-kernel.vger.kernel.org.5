Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16C8D782D6E
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 17:41:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236424AbjHUPlj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 11:41:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230011AbjHUPli (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 11:41:38 -0400
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com [IPv6:2001:4860:4864:20::30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04596F1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 08:41:33 -0700 (PDT)
Received: by mail-oa1-x30.google.com with SMTP id 586e51a60fabf-1a1fa977667so2301759fac.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 08:41:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692632492; x=1693237292;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EeGfHwRGwwRYbXeeefh7iQ7yCYz7KLAfKCabKiv94CE=;
        b=BMezuwTASDt/+FL3cE7ffudvgMNTJuLkhTniMQXciQ0PmJ+wNKDp9r2xDdzsZhwrhW
         hfXEmDHtJYYWgS4VL4+Dx/UCmJtQ71B0oQGulzLkAu0UUDN7Fb14Xukc39yjwXQ6jT+S
         g3jkV60YJkXZaNGYvqg3z01CAbYt1L7VgpDQg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692632492; x=1693237292;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EeGfHwRGwwRYbXeeefh7iQ7yCYz7KLAfKCabKiv94CE=;
        b=XAE6olwFvvI4itC3IkkjIyIZkVm18bEyUH/dgyWybxMkcarDpeCYoShZTjYuYET50d
         U3k6ySc/+b6KfqxrteAP7V0Ju3zjk+SoCrHJgmrsDARhmcPvYJwQVU77pzd4RcTkoNSw
         LUdaGbmLZeoB+B7a2w75djfo0BxP2NMmLaNWuglbnN9AVVp2scxuHAJeUE1UdZCGJb9j
         qiT2cAGtI7ChF+s7GlIikmfolrMzMCvTnepsJ2GYnW+xK+iO1f6z70ENUoxTZOEFwbLN
         LpIwg60U9+u0f8+h1ps++reQ37KZA5uC2h/h2IHysBARo2jnx7XI7tFCcGJQ74Gn79bE
         gvUw==
X-Gm-Message-State: AOJu0Yz5hsD1tlMbl8z0f6lYBOv5ihRazWRzRZ7fMIyCBsQn/tPX7xWj
        i3STN1DRHSGssGOPUIEhtlbpi6xt+3u9Vle7akhjMw==
X-Google-Smtp-Source: AGHT+IH1Qszox9Yk+3f1AeTumdyeECq5APECIyqTkTxYrkNnnsDkCQqCztmHIwGTkcSKfC3RtYdz3wiDu3cledIoISw=
X-Received: by 2002:a05:6870:8594:b0:1bf:1a58:c4f with SMTP id
 f20-20020a056870859400b001bf1a580c4fmr9923689oal.55.1692632492370; Mon, 21
 Aug 2023 08:41:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230820111509.1470826-1-gongruiqi@huaweicloud.com>
In-Reply-To: <20230820111509.1470826-1-gongruiqi@huaweicloud.com>
From:   Florent Revest <revest@chromium.org>
Date:   Mon, 21 Aug 2023 17:41:21 +0200
Message-ID: <CABRcYmJkt3AYL1T57415JBLa7kT9LWuWx-oGZf5Lvn9nskyhSw@mail.gmail.com>
Subject: Re: [PATCH] samples: ftrace: replace bti assembly with hint for older compiler
To:     "GONG, Ruiqi" <gongruiqi@huaweicloud.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        gongruiqi1@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 20, 2023 at 1:10=E2=80=AFPM GONG, Ruiqi <gongruiqi@huaweicloud.=
com> wrote:
>
> When cross-building the arm64 kernel with allmodconfig using GCC 9.4,
> the following error occurs on multiple files under samples/ftrace/:
>
> /tmp/ccPC1ODs.s: Assembler messages:
> /tmp/ccPC1ODs.s:8: Error: selected processor does not support `bti c'
>
> Fix this issue by replacing `bti c` with `hint 34`, which is compatible
> for the older compiler.

I see this hint is already used in
tools/testing/selftests/arm64/fp/rdvl.S but I'm curious why it isn't
used in other parts of the kernel like
arch/arm64/kernel/entry-ftrace.S or
tools/testing/selftests/arm64/bti/syscall.S
