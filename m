Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 465F376472F
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 08:48:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231585AbjG0Gsq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 02:48:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbjG0Gsn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 02:48:43 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE00ACE;
        Wed, 26 Jul 2023 23:48:42 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-3fbd33a57dcso6759825e9.0;
        Wed, 26 Jul 2023 23:48:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690440521; x=1691045321;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=VpfPqnSyEJn3uInpTbdcbPzujiKIYnv2c5CfOl1W9m8=;
        b=bvzN2iELZoGqcpdFmv3xv1K8CB6XXmxsm++CEktsT6U+5/rvC0p+3j1hAagAgOXnr3
         z+QbDFs8qu4O4mN/soO+nPfoTBdsL14whspTuhG3/a73iTN95FZqQkTVvzM4/C3Zo2WG
         tWSu2I1QsqGIan398lA3vJeKErM4+ooCRzFzNStEcIrYGDxu488offXMPziZh/IjmZrR
         Q9IA7jfrcknIABMIu2vTTJd+Nx/H3+cxaYEzR6tTM0ur/12TGxaT5d3e/n7Hfm62imn1
         cbKR6hYro5TrvBbF89ZklVI/3regLYNfnR9GEGr5+uxMi/toAM6A83C70S3n8InpnWR6
         JCsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690440521; x=1691045321;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VpfPqnSyEJn3uInpTbdcbPzujiKIYnv2c5CfOl1W9m8=;
        b=c4S3+cS6/05ukgaLUD+G7QD86Ju8mV2LxlMBIWLIZAxZ1keGfcWzb2VRRxY+u4jXNF
         1S0Fs6GTroeluUy+AHavB4FhmlCAeVQM/yOqu2o/diQQJCCPKik5ybK5/jw25Tl+a/IG
         6V7av0AKj5gjmgRP+NY6cenX2PgkdhVF2zFBCGdMf0IRjzVNDXQ3YaIlXXWSX/meCz13
         X1VozJi7px3dTCcLe3l8jlJvU6+txI5NFiyWaKx1huKJbfjOJc025g4S7nx8qGvd7358
         73JDthU9fQCrVyIha36nbq0tXlGFSxpzBuZ9F05HW6ekSE58FtGe3Y8SuyRfQ9M4XOLm
         PHQQ==
X-Gm-Message-State: ABy/qLZKXvIIO2iLLutoTnlDcd60xL7HIjFM4JMt9MpEDsuHJGqeVLfr
        BcdVFjc2bnHHcZJn+5xvhyA=
X-Google-Smtp-Source: APBJJlGD4ik5Orku7Q7ERVPnysIHnUBtbq19uMOJ8XclPyzSWQrJaxDlib/mBtMTb7Z1Lw7jL0ocoQ==
X-Received: by 2002:a7b:c010:0:b0:3fb:b1fd:4183 with SMTP id c16-20020a7bc010000000b003fbb1fd4183mr889838wmb.12.1690440521048;
        Wed, 26 Jul 2023 23:48:41 -0700 (PDT)
Received: from Red ([2a01:cb1d:3d5:a100:4a02:2aff:fe07:1efc])
        by smtp.googlemail.com with ESMTPSA id r18-20020adfce92000000b0031272fced4dsm1057201wrn.52.2023.07.26.23.48.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 23:48:40 -0700 (PDT)
Date:   Thu, 27 Jul 2023 08:48:38 +0200
From:   Corentin Labbe <clabbe.montjoie@gmail.com>
To:     LeoLiu-oc <LeoLiu-oc@zhaoxin.com>
Cc:     olivia@selenic.com, herbert@gondor.apana.org.au,
        jiajie.ho@starfivetech.com, conor.dooley@microchip.com,
        martin@kaiser.cx, mmyangfl@gmail.com, jenny.zhang@starfivetech.com,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        leoliu@zhaoxin.com, CobeChen@zhaoxin.com, YunShen@zhaoxin.com,
        TonyWWang@zhaoxin.com
Subject: Re: [PATCH] hwrng: add Zhaoxin HW RNG driver
Message-ID: <ZMITRjPOQAZ8qaZL@Red>
References: <20230726113553.1965627-1-LeoLiu-oc@zhaoxin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230726113553.1965627-1-LeoLiu-oc@zhaoxin.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le Wed, Jul 26, 2023 at 07:35:53PM +0800, LeoLiu-oc a écrit :
> From: leoliu-oc <leoliu-oc@zhaoxin.com>
> 
> Add support for Zhaoxin HW RNG.
> 
> Signed-off-by: leoliu-oc <leoliu-oc@zhaoxin.com>
> ---
>  drivers/char/hw_random/Kconfig       |  13 +++
>  drivers/char/hw_random/Makefile      |   1 +
>  drivers/char/hw_random/via-rng.c     |  17 ++--

Hello

You are doing changes in via-rng without stating why.
If changes are needed in via-rng, you should do this in a separate patch.

Regards
