Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FF5F78D125
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 02:33:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241404AbjH3Acw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 20:32:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239118AbjH3AcV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 20:32:21 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D58EB107
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 17:32:18 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-31c73c21113so4450895f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 17:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1693355537; x=1693960337; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Gzg4UEp9aD0VDjzsHgbVhYzgvlS+KiuyM3pgV5dY23Q=;
        b=I71ugWh8HmgN/6dQmBXYKc6S5YQ388t958bJeXOn1lptPqNfBlFUBp2+/5UndDp0sS
         I2qCKPQ7ScAESVhtNU5svFD0RLaMhGxclfd8MiYS3Zxn6YU9OZw5OIrHZw0yrGrEJQ6V
         ex3fwcW5ySPA0qXNsOcH42S3kRKqBz/4oSdVU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693355537; x=1693960337;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Gzg4UEp9aD0VDjzsHgbVhYzgvlS+KiuyM3pgV5dY23Q=;
        b=ZNtNE+KVSL8bnTpPAdkrItrFKLGqrCG7qlq2G7OgaSVGN7we2kMA8f9ZA/uzKrIDdA
         ljLOhxlCBJ0OTA5SwGuoUCgu+//8UroGMMwptNjhgnUBcYICon/ISxt0qMoDLx0NsfEe
         h4trklyUf8iC1xVB03Ue7N58XaEF1bj4XaVMLZzqYV4+7dDHJZ5+U6tbHzCj5n5tRDzU
         v/lb786cYW8zk0jALwF1LYYALjoMSaX1WW29PhPdrJsdnqFEG0nvawUYqlH8yK0aJ5Zx
         cIbVPHd4S1k2ozo9exUq85uJ8LJQD3NEj16OV9dQ4QsDEaQOMqt/Kb3I+uDRqyXCxO5O
         B+cA==
X-Gm-Message-State: AOJu0YxJ9MM1xummS4xbSx+XNUNSVADQgoUCxHjGenaPdnc4l+87G+P5
        t4xaJsdOzyuQUMzaXrxr7upQ3NWcXEts8NIf3zjinV/w
X-Google-Smtp-Source: AGHT+IF8OmH9LeKECwy+9qDtxdVweOJELuhC+rtHfN0y/pfKhUW9Y10V3ppa2JkGAQDBtmJgSzp9YQ==
X-Received: by 2002:adf:fed1:0:b0:319:71be:9248 with SMTP id q17-20020adffed1000000b0031971be9248mr491740wrs.19.1693355537106;
        Tue, 29 Aug 2023 17:32:17 -0700 (PDT)
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com. [209.85.218.45])
        by smtp.gmail.com with ESMTPSA id mh3-20020a170906eb8300b0099bcdfff7cbsm6480300ejb.160.2023.08.29.17.32.16
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Aug 2023 17:32:16 -0700 (PDT)
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-99bcf2de59cso663759666b.0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 17:32:16 -0700 (PDT)
X-Received: by 2002:a17:906:2092:b0:9a1:b5fc:8c56 with SMTP id
 18-20020a170906209200b009a1b5fc8c56mr412325ejq.55.1693355535843; Tue, 29 Aug
 2023 17:32:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230829213441.310655-1-ulf.hansson@linaro.org> <CAHk-=wg0gc4Cc90OL29Vr5gDtd4mnsKD+TxtoNtQbAryaWHkZQ@mail.gmail.com>
In-Reply-To: <CAHk-=wg0gc4Cc90OL29Vr5gDtd4mnsKD+TxtoNtQbAryaWHkZQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 29 Aug 2023 17:31:59 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjLO=Jsdk2prq0piznMMCk+V0_fRaFRHEPuaALpF8J=hw@mail.gmail.com>
Message-ID: <CAHk-=wjLO=Jsdk2prq0piznMMCk+V0_fRaFRHEPuaALpF8J=hw@mail.gmail.com>
Subject: Re: [GIT PULL] ARM: SoC/genpd driver updates for v6.6
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        soc@kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Aug 2023 at 17:18, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Please don't use random letter combinations that have absolutely
> no meaning to anybody else, and that aren't even explained.

Side note: at least to me, 'gen' is short for 'generate'. Looking at
existing kernel naming, that's how we've used it (lots of examples of
that from different areas).

Do we also have "generic"? Yes. And because 'gen' does not mean
'generic' to anybody, we've typically spelled it out - as in
asm-generic, but also 'sound/soc/generic', or in fact a _lot_ of other
examples.

Because we really aren't that close to running out of letters.

As to the 'pd' part, it actually has a fairly widely used meaning in
the industry, but it tends to be 'power delivery', in the USB-C sense.

So I really find that short-hand actively misleading,

I realize that the SoC code has used that shorthand internally, but
once you expose it like this, I really think you should do a much
better job at naming.

                 Linus
