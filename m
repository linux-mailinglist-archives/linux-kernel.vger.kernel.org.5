Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DED775A7BD
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 09:24:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231573AbjGTHYp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 03:24:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231539AbjGTHYo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 03:24:44 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43E5419A4;
        Thu, 20 Jul 2023 00:24:43 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-3fbc77e76abso3357175e9.1;
        Thu, 20 Jul 2023 00:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689837882; x=1692429882;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yow1cHIuBGKmdbyc+Rx7EeiM5zCm8cLIDBivGD4mn/w=;
        b=jj6hKaOIAgZW1rQR3JUyzigKY+JAwiGnoHWTjGMqJgwaf+rJNGCeFQbKjutDxKcwlR
         UpbBG5A95iLXXbj+9PbsZdtPaLNI1iEEJZV6FWfjyORyJgheY79iYIhEpZMcgI9qQubr
         AbMn/9Gqu13XhOybvCUtf/3oPvsrAQgga/9tpxYtUJsjG8+ky7lTSPHDegM4ujUP1Cya
         u+GDEO3t0/eUqVqfNyYvd5RhZtoXsLkkf3CONH8RxmR3cQwYwRW0gjvmC/v2BAhnmhpw
         ek4jmTXM9yjJzkVNGZq7cPWaiN44D7ilvQE8/OJf1aMZeTlVwS4KmyhoxdWd7FOXwZmn
         1WXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689837882; x=1692429882;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yow1cHIuBGKmdbyc+Rx7EeiM5zCm8cLIDBivGD4mn/w=;
        b=YRlbo5VFZCdaVLWPMxt8tikjMVNVsMJ+QxRW6q1O14ZzhO35ITNhdCQ3rhHYSnNJCq
         J6Q8Br6TZGcrEYYTS5d3oK9sGHJuUowf5Rs2LNF+gbzDqUOfIlKZtu/pXZpYNx0VsYyI
         4MvegIbjigY2d4JGV8XUjo2fk5oIit1uTW0YViDTvOWs8F7+LF5221Rs1TJ63s+XhPka
         Cjv6xVpocp+tTuvr0sdze5frj2Niczr51pkbOcWB5JZJUlyjb9Wj7E5Wadhx8+zMdGSV
         41ZmVNOGCujoFXNoFI4gwBt34o9PNXUVrW767Uq9N2aWNyQ/N19IsDX3zWy4VPvqH2Fp
         Tnrw==
X-Gm-Message-State: ABy/qLawy0muZNSeNTx/cvMw2gl6tFIPKn129+97HqUr+xb9Ma7tPShN
        9I9NtAb22dGJLoeNtDCAxSU/KrkFAs9XuH7qBTs=
X-Google-Smtp-Source: APBJJlFORQ8QKCAJxuhFtSYsKHr+yW3ncGk/fZG8Z70QJ7Vb7bGUaSvEyXpnoxSlob/bHIINAKito6MDs2Yxfg7Q+4w=
X-Received: by 2002:a1c:4b11:0:b0:3fc:1a6:7764 with SMTP id
 y17-20020a1c4b11000000b003fc01a67764mr3240468wma.16.1689837881276; Thu, 20
 Jul 2023 00:24:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230628072840.28587-1-dg573847474@gmail.com> <20230719151817.GB4176673@hu-bjorande-lv.qualcomm.com>
In-Reply-To: <20230719151817.GB4176673@hu-bjorande-lv.qualcomm.com>
From:   Chengfeng Ye <dg573847474@gmail.com>
Date:   Thu, 20 Jul 2023 15:24:30 +0800
Message-ID: <CAAo+4rVA-1jq34K8Rk061fsH=bPbamB2uEemzJh6pj7RNdRt7g@mail.gmail.com>
Subject: Re: [PATCH] mfd: qcom-pm8xxx: Fix potential deadlock on &chip->pm_irq_lock
To:     Bjorn Andersson <quic_bjorande@quicinc.com>, lee@kernel.org,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 > You are correct, so please drop "I think", and change "should be" to
> "are generally"
>  I don't think this is a "tentative patch fix", it is the patch to fix
> the issue. I think you can omit this line, because you already described
> your problem, and the solution above.
The V2 patch was just sent to address the problem.

> Reviewed-by: Bjorn Andersson <quic_bjorande@quicinc.com>
Also thanks for your time in reviewing the patch :)

> No, I need you to resubmit it with more historical people on Cc please.
Thanks for the reminder, I Cc more people with large contributions to the
file in the V2 patch.

Best Regards,
Chengfeng
