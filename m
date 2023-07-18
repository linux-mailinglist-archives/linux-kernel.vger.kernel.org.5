Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FA11757605
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 09:59:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231550AbjGRH7y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 03:59:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231855AbjGRH7L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 03:59:11 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FD1D1FC1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 00:58:25 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-316f4abb1e1so2750904f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 00:58:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689667093; x=1692259093;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CrCUDL1/u3mCyL3fGovIg+T0/y0vvq0Eia4n2zK2lnk=;
        b=exYwYXqaYt69rAA551GUkajdfbeIDYFt1zJnYYdvTH/EysTtyCpgW8PAp/OtbPy4QB
         1XGy8+Y7I8Y0NadiAOJSVhTh3RyeVmKuCd3J6ORLnaZiSmWaneBYDQxYSUkWPQ59YJmf
         D9E59hMqxACT/ooaaKHzvwuo1BHIqz3xwui0xbwoMwlIFHUW+P8ZD6zHgOmKIK0CEI9o
         qT8nDH55g1RkkIiHMzg7PgBn/sJA1jicoR26AZ4cUzX2QQnOiudCjtomKMAXRXqgO8jD
         E4IunYpPgjIvHxIJsGbw6BZCfL+qTIsp8xRcIOSyXSJ2TN77NL770F8alqxdok2F4+vr
         6Tgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689667093; x=1692259093;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CrCUDL1/u3mCyL3fGovIg+T0/y0vvq0Eia4n2zK2lnk=;
        b=Lm8vc8zw1I8lNoj9P0tIfGFveL6Hdv6hDS1CcRsM4xnOm6f7xp+lG6/mzJn4PVa/em
         2qZ9Kw9Q3Gy/u0uaDANCr2CMNz8NiSUd8c/v14CDz3HTcW3wK9+hGlgliR7iTc2zqFPn
         I7ZLGAx1Sk9DOrk82PQyVbva/0etzz22aAhYE47/ZiQsoBjQ+2TccDRExdHUZyfpPpD7
         4FXZzkOpsLdsrNbQ+DI14qTv2vybLwQXn5lI9jIEb90WvDLNKfLB6Pm9scDJcPOhAYJ/
         CcGBW7wDhK0P+6xA84sLhiE+F8XWhT3ffad0BsHnBjYFWD9AgpZIz+so3+6uE8bjLRyC
         XAwg==
X-Gm-Message-State: ABy/qLYl+vFVtsjmfRyd5jtnGnAJqvuMfkNoVjQasyghkXxcFDh9mjrp
        niy/mCmVEYEwcVtkYoMfVY9/VXYo/c44PZKWPtg=
X-Google-Smtp-Source: APBJJlFJmMXy4bAucMJyJ/9PSS30kzUaf+Q/jNb7PnNEMPBk/kznzHcHYBJdeql30kykr0WI5Wj2xS3b3rzfd33hKKg=
X-Received: by 2002:a5d:6d4b:0:b0:30f:be04:5b5e with SMTP id
 k11-20020a5d6d4b000000b0030fbe045b5emr11551750wri.37.1689667093092; Tue, 18
 Jul 2023 00:58:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230627062831.16553-1-dg573847474@gmail.com>
In-Reply-To: <20230627062831.16553-1-dg573847474@gmail.com>
From:   Chengfeng Ye <dg573847474@gmail.com>
Date:   Tue, 18 Jul 2023 15:58:01 +0800
Message-ID: <CAAo+4rUPKp932aBN0mTdy2gMf1NA+mE=B9QztU5GP4-GWErk_A@mail.gmail.com>
Subject: Re: [PATCH] fs: ocfs: fix potential deadlock on &qs->qs_lock
To:     mark@fasheh.com, jlbec@evilplan.org, joseph.qi@linux.alibaba.com
Cc:     ocfs2-devel@oss.oracle.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Maintainers,

I hope this message finds you well.

The patch was submitted during last merged windows and
I think maybe it is buried under other patches. If you've had
a chance to look at it and have any feedback, I would be
very appreciative.

Best regards,
Chengfeng
