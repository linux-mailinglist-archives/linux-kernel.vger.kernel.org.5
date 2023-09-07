Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37A44797402
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 17:35:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344219AbjIGPcm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 11:32:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343699AbjIGPax (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 11:30:53 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6B1619B4
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 08:30:27 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id d75a77b69052e-412091b9035so7619331cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Sep 2023 08:30:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694100581; x=1694705381; darn=vger.kernel.org;
        h=cc:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=J4f41YsSBkx4jVRvXl4Nds903quY9STr5t2ZITBPCIU=;
        b=HNQQQaBSTzzoQ8XwYUAV0D+JnfGTu0QX8gSp5UE0uo2vwW0yr2truVl29K9fX+nZYn
         HDM87GoXQRgw8aymukebwajJqDWECm57O7QefJHGs3VgSqn87ofYva9bJx68jmPiYFU4
         XZsb4tJwFGp2rvXKhb6ASV/315xLs/uI9UuJIDA8TP4/6JS7e7h17C1sOfePt3FMMjfQ
         Z9kS3uD4hZqi0gPtJH2RMgPMUFNaY+JyeGD+mhpiIZ9XFZDRBBVuxJNGADvPV9Ala61H
         1fSkXDrJyOXFtSCCSPnPsloE2yKKxBn/5hEwV6RQKao2o0ykUCbzNNPcbFPB2feA5ZyU
         WefA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694100581; x=1694705381;
        h=cc:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J4f41YsSBkx4jVRvXl4Nds903quY9STr5t2ZITBPCIU=;
        b=D4ncqh4w5cz7dTnIvsXzc5xiNDDoQXy0U5gmptNUWdFpnF9onPBXWELP8299DQwdbw
         WlZcPAbYh2ZBmha7xy1UaTZUhyeF4o3gD3WPE26c8fPJaCkvwzIKtXYotiS8KXUAyoc/
         e7iBn+VhT8IzcW6NhnuuxZozJsOTRpS5S9i/Q1/Kwlb97jnDWUbwvLm0PPGMFeOm7nRp
         GLLTyx2uq/cbf6TMyCf4eRMhX46C52LZF7Q9LcamfPdrDCezoFg5QyoSKixAKTZBNkgV
         bkyCm8mlOH3LO4fcw26MChKc2sh6dQsrDFAPcYsWDescH9b8w90e2CD1hTxr/8U5bBbD
         XXFw==
X-Gm-Message-State: AOJu0YznaQ4gvYzPcGvR4doIPXv6fLJ55yYOEyxnLJVL4TVJA2G2tdOO
        HHVzvRHvwCcyZ8K7HKthRN9Xu+xXeL+bxQgALdHgcMZPdo3wiA==
X-Received: by 2002:a05:622a:110d:b0:411:7212:bd66 with SMTP id
 e13-20020a05622a110d00b004117212bd66mt28124185qty.66.1694096172656; Thu, 07
 Sep 2023 07:16:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230822134849.3352329-1-alessandro.carminati@gmail.com>
In-Reply-To: <20230822134849.3352329-1-alessandro.carminati@gmail.com>
From:   Alessandro Carminati <alessandro.carminati@gmail.com>
Date:   Thu, 7 Sep 2023 16:15:36 +0200
Message-ID: <CAPp5cGTshQJ3aLeLqv=CbaVeg9GnK_k9nsoaWrBKs1dcXzNZow@mail.gmail.com>
Subject: Re: [PATCH] Sanitize possible_parent_show to Handle Return Value of of_clk_get_parent_name
Cc:     Philip Daly <pdaly@redhat.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,MISSING_HEADERS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

this is a gentle ping

thank you
Alessandro Carminati

Il giorno mar 22 ago 2023 alle ore 15:49 Alessandro Carminati
<alessandro.carminati@gmail.com> ha scritto:
>
> In the possible_parent_show function, ensure proper handling of the return
> value from of_clk_get_parent_name to prevent potential issues arising from
> a NULL return.
> The current implementation invokes seq_puts directly on the result of
> of_clk_get_parent_name without verifying the return value, which can lead
> to kernel panic if the function returns NULL.
>
> This patch addresses the concern by introducing a check on the return
> value of of_clk_get_parent_name. If the return value is not NULL, the
> function proceeds to call seq_puts, providing the returned value as
> argument.
> However, if of_clk_get_parent_name returns NULL, the function provides a
> static string as argument, avoiding the panic.
>
> Reported-by: Philip Daly <pdaly@redhat.com>
> Signed-off-by: Alessandro Carminati (Red Hat) <alessandro.carminati@gmail.com>
> ---
>  drivers/clk/clk.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> index c249f9791ae8..ab999644e185 100644
> --- a/drivers/clk/clk.c
> +++ b/drivers/clk/clk.c
> @@ -3416,6 +3416,7 @@ static void possible_parent_show(struct seq_file *s, struct clk_core *core,
>                                  unsigned int i, char terminator)
>  {
>         struct clk_core *parent;
> +       const char *tmp;
>
>         /*
>          * Go through the following options to fetch a parent's name.
> @@ -3436,12 +3437,12 @@ static void possible_parent_show(struct seq_file *s, struct clk_core *core,
>                 seq_puts(s, core->parents[i].name);
>         else if (core->parents[i].fw_name)
>                 seq_printf(s, "<%s>(fw)", core->parents[i].fw_name);
> -       else if (core->parents[i].index >= 0)
> -               seq_puts(s,
> -                        of_clk_get_parent_name(core->of_node,
> -                                               core->parents[i].index));
> -       else
> +       else if (core->parents[i].index >= 0) {
> +               tmp = of_clk_get_parent_name(core->of_node, core->parents[i].index);
> +               seq_puts(s, tmp ? tmp : "(none)");
> +       } else {
>                 seq_puts(s, "(missing)");
> +       }
>
>         seq_putc(s, terminator);
>  }
> --
> 2.34.1
>
