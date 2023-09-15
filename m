Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 384FA7A2AC3
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Sep 2023 00:52:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237315AbjIOWwO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 18:52:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237996AbjIOWvw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 18:51:52 -0400
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com [IPv6:2607:f8b0:4864:20::c29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A938270A;
        Fri, 15 Sep 2023 15:51:40 -0700 (PDT)
Received: by mail-oo1-xc29.google.com with SMTP id 006d021491bc7-573249e73f8so1588379eaf.1;
        Fri, 15 Sep 2023 15:51:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694818299; x=1695423099; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NpTJGCY4idVrSrL74E2EoToGTamv1+IwJk0/AcYqzBQ=;
        b=fbxo1J/GOf7AIPchmuuUYCh6ILq5nto/DOJVIyeLTMsBvuc1HLcsZmA6dGAAfZ9IRN
         BjqBPks5UW6TZtL2I9iHBR6ICCdFQhAPNd9qP5B2j+NdaYlGvyHTBPr8GQStuwnaT97U
         y8ChllDy+8C8sqqquAzTwkZrM+p0LSnEgI7rAfKWxVfoPp5mcyIGPTXTBS/K0X5BFnOL
         MDgyxQIymWkywjsJ83DpwDATOyB3+yg4azd3icULWgcta0o4BSJtJWyGAxN9rwSK+saW
         fxvS3U++00dsXo2nlySlHqnyr1NL7TCnySggBrfbzeAjStiiZbprFnleD0a1SM+il8ez
         rCoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694818299; x=1695423099;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NpTJGCY4idVrSrL74E2EoToGTamv1+IwJk0/AcYqzBQ=;
        b=ilFsQ32iigdSbB+BA0AijZZ1KPJVqNeFWKL5Z7CPLkAqcOdGvxr8MEdiSRIGK0VEum
         7VROqCrA3frm8fpoquuWUh4kY9xidBLnW4brZOKZJOQvm8gW9ZNK2Uj2a+FoK9Ph6B0m
         9a3UQUgHbHPkbD5uknrlFBpgrgt8iUm3p8asjEolvksjfQkvi2x5T2WUrSmVu49KzqF8
         +crs150lNPu2a+Q97a7/sr3P00FGcf+zxTE7UCuDrVoSyfSyj13HcjBYCR4qiyJSg+/7
         Fyyhcf6ThEQgURzCcuXwyeRZk+h789OTna3+rI1AZbN5s8+ROr579PWUNavX7HeWfgET
         nG9Q==
X-Gm-Message-State: AOJu0YzvKddSGvm7q+/Z6V2SY8vBXzUFqq5AHHjYuLnqa/rfTyVkAfIr
        PqmbZPfyWlhWgSy9ugS6+ko=
X-Google-Smtp-Source: AGHT+IFLllA773HYArepv3qkPOI/RwoA4dr30Gl+hsXVwgACBDLV2DMbXmFufjn1g5+FmJuXUqOIEA==
X-Received: by 2002:a05:6871:686:b0:1b0:89e0:114f with SMTP id l6-20020a056871068600b001b089e0114fmr2906473oao.31.1694818299258;
        Fri, 15 Sep 2023 15:51:39 -0700 (PDT)
Received: from [192.168.54.90] (static.220.238.itcsa.net. [190.15.220.238])
        by smtp.gmail.com with ESMTPSA id h22-20020a056870a3d600b001ccab369c09sm2356461oak.42.2023.09.15.15.51.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Sep 2023 15:51:38 -0700 (PDT)
Message-ID: <50dcf114-e7f7-4e6f-8d30-4166f5f3848d@gmail.com>
Date:   Fri, 15 Sep 2023 19:51:22 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rust: Respect HOSTCC when linking for host
To:     Matthew Maurer <mmaurer@google.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Masahiro Yamada <masahiroy@kernel.org>
Cc:     Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        Alice Ryhl <aliceryhl@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kbuild@vger.kernel.org
References: <20230915172900.3784163-1-mmaurer@google.com>
Content-Language: en-US
From:   Martin Rodriguez Reboredo <yakoyoku@gmail.com>
In-Reply-To: <20230915172900.3784163-1-mmaurer@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/15/23 14:28, Matthew Maurer wrote:
> Currently, rustc defaults to invoking `cc`, even if `HOSTCC` is defined,
> resulting in build failures in hermetic environments where `cc` does not
> exist. This includes both hostprogs and proc-macros.
> 
> Since we are setting the linker to `HOSTCC`, we set the linker flavor to
> `gcc` explicitly.
> 
> Signed-off-by: Matthew Maurer <mmaurer@google.com>
> ---
> [...]

Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
