Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15D1D7C8E59
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 22:28:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232041AbjJMU2E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 16:28:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232021AbjJMU2C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 16:28:02 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C655BDA
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 13:27:37 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-323168869daso2344277f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 13:27:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697228856; x=1697833656; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iaZqQEuB1EDABln979ILtGuG4qYa8Us/Meb6pDFY+K0=;
        b=1d9nFnwspgu2gyqkAw0fEABg69M5MW8BldPoifAEiWLhdqiO5iQhblciAacrXH2WAP
         4Tncte0GkC6v5OdxD2YsLAVC8SiJjbDQxOT8ZgbEGTb6/57cNDobdHIIX5sRrlW0Ke6+
         QuhWnvEuAElx6TcA0mlQdoLaA2zdTPJ6UoKScCWO6QH9L/yDOfafcZEQTERAzT7RHkDV
         ISuld2FhzPMFmuPlvw7BhuWAu0twW7otehwMDzGfFFOCGi6fY4MSJsv1dfQQC9uwEM9T
         t7xl/2O8ywk0XDISzRrOULNGIpCOfH+6hE7e48xLv/EtT85TfP7WBFs1DWcBidnVQkxo
         JJfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697228856; x=1697833656;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iaZqQEuB1EDABln979ILtGuG4qYa8Us/Meb6pDFY+K0=;
        b=dUqPz7MlL95muXqrDpDu0UHJSPQLwMRAelgb/N3NEmpfRXWSn+XbPOkwoMdUrLWvfI
         J7chq/ew/V9ZcEHXijAl7yNP2wcif0fcsAoDA4IoCG+hk/RQ+mK3Abx/CuPVCi5GliBq
         10GZvFiqjG5UeQOfmvAKjOaTTbVUa0HHzsx6zGKXAqgZ4w7HCrRiKuU2lRLTVof/YGkP
         9fjpnc5JvE2M+jFRe2b00YFgaW2a6z/0/NdeWDOPmh28rhsC3tSt0rV3Dg4YLmYrfHke
         zsNokT9+0e5KZs5JMOB79YhtwRzKk/W1h/x6GQLtKwz81Ntj55Gd3pcbyQHVO51+3iD5
         5VoA==
X-Gm-Message-State: AOJu0YzBHlRHQfzj1O89TeebA1lXb5olgLr01tWkdronL8LGpklHAgxf
        YQndMvVXLwUbSsty9tWDiVHaxjkyJYDiYyyyG4zTiw==
X-Google-Smtp-Source: AGHT+IHyQ9WTKrqS9x4alRXVbV12ByhlwpjEm1bFgi8CEeRhxufkl/22GsI4pbDr13iCTKmG38QO7rUDUdW8/CNuoj8=
X-Received: by 2002:a5d:5303:0:b0:32d:a29c:7321 with SMTP id
 e3-20020a5d5303000000b0032da29c7321mr1018120wrv.67.1697228855931; Fri, 13 Oct
 2023 13:27:35 -0700 (PDT)
MIME-Version: 1.0
References: <20231013132832.165768-1-2023002089@link.tyut.edu.cn>
In-Reply-To: <20231013132832.165768-1-2023002089@link.tyut.edu.cn>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 13 Oct 2023 13:27:24 -0700
Message-ID: <CAKwvOdneBDDCeg-GzKMpWmvqQCC53KcaV_GAF1JioCJdCtBkxw@mail.gmail.com>
Subject: Re: [PATCH] scripts/show_delta: add __main__ judgement before main code
To:     Hu Haowen <2023002089@link.tyut.edu.cn>
Cc:     gregkh@linuxfoundation.org, masahiroy@kernel.org,
        akpm@linux-foundation.org, n.schier@avm.de, ojeda@kernel.org,
        linux-kernel@vger.kernel.org
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

On Fri, Oct 13, 2023 at 6:29=E2=80=AFAM Hu Haowen <2023002089@link.tyut.edu=
.cn> wrote:
>
> When doing Python programming it is a nice convention to insert the if
> statement `if __name__ =3D=3D "__main__":` before any main code that does
> actual functionalities to ensure the code will be executed only as a
> script rather than as an imported module. Hence attach the missing
> judgement to show_delta.
>
> Signed-off-by: Hu Haowen <2023002089@link.tyut.edu.cn>

Thanks for the patch!
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
>  scripts/show_delta | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/scripts/show_delta b/scripts/show_delta
> index 28e67e178194..291ad65e3089 100755
> --- a/scripts/show_delta
> +++ b/scripts/show_delta
> @@ -125,4 +125,5 @@ def main():
>         for line in lines:
>                 print (convert_line(line, base_time),)
>
> -main()
> +if __name__ =3D=3D "__main__":
> +       main()
> --
> 2.34.1
>


--=20
Thanks,
~Nick Desaulniers
