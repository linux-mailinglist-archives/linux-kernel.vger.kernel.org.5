Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5372788FEF
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 22:40:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231219AbjHYUkY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 16:40:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjHYUju (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 16:39:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E00CC2129
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 13:39:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 59F0363AC4
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 20:39:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6131C43391
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 20:39:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692995987;
        bh=XJFKgDIg8He98yCrYb1AV3cLbEHPt+Vb3mnSreYOibY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=I5yBgf/sqyYepdC03Wv79Vv019xhi2jIbrTKfXiOKOCvUGh/MUHQezTcAWHLLE6yj
         qaWzqbENa7qSH2DcQBZCkVuyvOTtir0maNQvskq/J5Xdxf2R+lcNvVV1msXIVTBNPr
         0HriScfgM6vNYwdLO0q32JJWE4KuSOsHL6Zb6bnh0PmNZMc5xHQVZzIctPk/8ypqGN
         ajbi6rG0MfZp3Znry87gcePK3XkhZ46b3izF/U56P1Jc3f8DTrhvXPWqlpxj5o7haL
         ON02Sv5DA0UrLlOShjvPQ+k65cd4fpyac7lwZGwpFy2Rj7nity3SNV5DBFq2QDyrZM
         3u9EpFtrpW5Lw==
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5008faf4456so2019871e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 13:39:47 -0700 (PDT)
X-Gm-Message-State: AOJu0Yy+jU5jhao7/mb1lByS/5yC8L9AV845CisM5nrF9bcgy4+lADv5
        0Pg0kK0Tv4j7g90AV8KU7tRo5yCetE34qANQj8k=
X-Google-Smtp-Source: AGHT+IGAH82i+2aRelwSVgwLMyDN2t8G6fNGkLSuAWf/AJR0IfoZFaBtK4gUazRk30qSGYXei53cUiuPlK58JNsAKXU=
X-Received: by 2002:a05:6512:32cf:b0:4fb:821e:2241 with SMTP id
 f15-20020a05651232cf00b004fb821e2241mr15138323lfg.23.1692995985616; Fri, 25
 Aug 2023 13:39:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230825202036.441212-1-yonghong.song@linux.dev>
In-Reply-To: <20230825202036.441212-1-yonghong.song@linux.dev>
From:   Song Liu <song@kernel.org>
Date:   Fri, 25 Aug 2023 13:39:33 -0700
X-Gmail-Original-Message-ID: <CAPhsuW5SYmD1Rx=9VCG9E8m8CQCcy4x67qo=mX3Y+Ho3tQcHBg@mail.gmail.com>
Message-ID: <CAPhsuW5SYmD1Rx=9VCG9E8m8CQCcy4x67qo=mX3Y+Ho3tQcHBg@mail.gmail.com>
Subject: Re: [PATCH] kallsyms: Change func signature for cleanup_symbol_name()
To:     Yonghong Song <yonghong.song@linux.dev>
Cc:     Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Fangrui Song <maskray@google.com>, kernel-team@fb.com,
        Leizhen <thunder.leizhen@huawei.com>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 25, 2023 at 1:21=E2=80=AFPM Yonghong Song <yonghong.song@linux.=
dev> wrote:
>
> All users of cleanup_symbol_name() do not use the return value.
> So let us change the return value of cleanup_symbol_name() to
> 'void' to reflect its usage pattern.
>
> Suggested-by: Nick Desaulniers <ndesaulniers@google.com>
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>

Reviewed-by: Song Liu <song@kernel.org>
