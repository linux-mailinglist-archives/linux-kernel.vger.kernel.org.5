Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 740CF8126F8
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 06:35:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234264AbjLNF3K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 00:29:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbjLNF3I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 00:29:08 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CA09BD;
        Wed, 13 Dec 2023 21:29:15 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1d336760e72so25286385ad.3;
        Wed, 13 Dec 2023 21:29:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702531754; x=1703136554; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=d25UVzWoyIF+y1CCj67lRRjCwCFhalI/I5d7ruwEREs=;
        b=ddWrQ/s0VfcKRtXaAjwXLUGew3Gz/qfinC/phlMhwL6Eyv005kDSStqtppqOT1iD3T
         tN1qjsXNRpL6qhp8yLt5YS8snvwKejniasmEYotZrU+/AkbLGRPuXXfsX34oZddmQThw
         zAfa93ZnYJDEn/n1+rlwZ9+R4Bokgz16Dbu3YHxenLSqjSAq2LRzljlQr1pB515QI3WS
         Zz0bO0Lswt2HGkk2SS6Y/2b+cj/SELnw3e8JToR1EQq1vcnxZ/uDJUs4NF149IpfFsrl
         DwLEjaAMb8Wnj82P+L7/mdtJUtp4OHqDldbPm3poOLdsO2teerrC6kcB3yTRmvyvcwob
         oOuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702531754; x=1703136554;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d25UVzWoyIF+y1CCj67lRRjCwCFhalI/I5d7ruwEREs=;
        b=FcfLKHkCEUXMTB3t+rYJTVAHqKFJTvwvEQKHwvaFnj6V23nQGM+dAy9YOc/lTlUpkz
         AiYZJzDk+8227nTbdOwYACDWHpDUiZR1F5jXuQZNZjvqH4iPT0Od2EJt6Ie8ldYKHoe8
         Nx9tnSpqqD0od8nmegJKsKKcf+OMK0KQKC7FLt/50akyHaCbgY6kOcYnXncpMW2qTHS1
         /3N7TUy+ybIISM1U8qjtKoVAR7sK9odid87TthSRWG1OsCAoEKdU+HBYiYZlByT3MMjV
         Jw2Q8OUYW0LIk8/eIZ7C5kIV2kc+lC93NXUEecMGEdk1c2E7YVj3r/9YBlodKhlqGETF
         TgVA==
X-Gm-Message-State: AOJu0YzhkDfuuUu/FzCZFgJ+hcg9H2zu/MRvjvz00JUy5N9zgOUGQUs+
        ECEjU0qF50uPMeQaMWlu4RU=
X-Google-Smtp-Source: AGHT+IHi4W3EDjJd+bvaSDHh9IJhMG7RlDTvScw2niy1sEe/djEPsLlAqYIozqjuNk0f4QGUDXziqw==
X-Received: by 2002:a17:902:b706:b0:1d0:737d:2ae5 with SMTP id d6-20020a170902b70600b001d0737d2ae5mr8215953pls.87.1702531754118;
        Wed, 13 Dec 2023 21:29:14 -0800 (PST)
Received: from google.com ([2620:15c:9d:2:fcc:5ab4:9103:3ae2])
        by smtp.gmail.com with ESMTPSA id ik2-20020a170902ab0200b001c74df14e6fsm11761113plb.284.2023.12.13.21.29.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 21:29:13 -0800 (PST)
Date:   Wed, 13 Dec 2023 21:29:11 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: duplicate patch in the input tree
Message-ID: <ZXqSp_Fejj0XGuwX@google.com>
References: <20231214074546.453a926b@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231214074546.453a926b@canb.auug.org.au>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

On Thu, Dec 14, 2023 at 07:45:46AM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> The following commit is also in Linus Torvalds' tree as a different commit
> (but the same patch):
> 
>   877ee02cd962 ("dt-bindings: input: qcom,pm8921-keypad: convert to YAML format")
> 
> This is commit
> 
>   53ed3233e6b5 ("dt-bindings: input: qcom,pm8921-keypad: convert to YAML format")
> 
> in Linus' tree.

Thank you for letting me know, I dropped the commit from my tree.

-- 
Dmitry
