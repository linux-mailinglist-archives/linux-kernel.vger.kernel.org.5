Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A335777EADC
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 22:40:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346198AbjHPUjs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 16:39:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346192AbjHPUjd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 16:39:33 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 009331BE6
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 13:39:32 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id 98e67ed59e1d1-2681223aaacso181116a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 13:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692218372; x=1692823172;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=M/VlrpLaLonWwvLdMHTbKBLWS+0ZwHTAviVzHTRR32g=;
        b=b8C7A3fSaauDeX1Uma32OORq+lCiJhxdLrG3qjzQPV4bzX8r9TZ+BlQLwV8DkRl7g8
         rOwidredzXHeJ/K7i7plM3yCqTPibNGdAO+aWx7ICPfAOm0vx/l2oGhIgC+QWVD9/mzy
         XPyTkIHMldPIr/2pJWGhBYBVOcf2ZxZCPFUV0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692218372; x=1692823172;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M/VlrpLaLonWwvLdMHTbKBLWS+0ZwHTAviVzHTRR32g=;
        b=Xz0V8ynD6KNoqHCp321h6vIz7bThCrSYgipJUJScPf2t0123S9o/itZkfvQlQ1HdU3
         5fXrTvqnMRQViLdF7jJ08rKqvm5rkHNS76d6kOQiY/cPjC+tzySkJcb65VRvlrj6kQck
         wRtdUr2BUmTGK3Q6XkBx8rKpXsJ2zvqXrOLadVBLRibMlfmnblNrQZJn0zuZoIQEwpmv
         N3fLYnlDEc1V1vO6qzan2GPTlX5Vp4jbCRt9DiE0jlCHgGPIheavW/fWcWSckUN9pM6a
         lP8oKQdbKUxBrPM4gCRBKbyetwv9LbS1PVOxSMeCSqLaA7HQpPatvMbRCraHq4IsbOg9
         G/3A==
X-Gm-Message-State: AOJu0YykIiJI8Up6uxeTjHJBhJy62RSxaxtQX23q4MuxOMJ5SxJ71b8y
        /NPoUaSWG1a1cKoYx1vV1tyWh/NCf67P+tKZnTM=
X-Google-Smtp-Source: AGHT+IFH3p8cu/k6sO/6dJ0jNC4lS5Gy9QpuuFjew2rQXbw+Jnrz4Trg8GNoh8Zj8AEI5qs6r8bbSg==
X-Received: by 2002:a17:90a:e7c1:b0:268:808:8e82 with SMTP id kb1-20020a17090ae7c100b0026808088e82mr863439pjb.1.1692218372471;
        Wed, 16 Aug 2023 13:39:32 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id a4-20020a17090acb8400b0025bd4db25f0sm142476pju.53.2023.08.16.13.39.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Aug 2023 13:39:32 -0700 (PDT)
Date:   Wed, 16 Aug 2023 13:39:31 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Anil Gurumurthy <anil.gurumurthy@qlogic.com>,
        Sudarsana Kalluru <sudarsana.kalluru@qlogic.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] scsi: bfa: Replace one-element array with
 flexible-array member in struct fc_rscn_pl_s
Message-ID: <202308161339.C68DC815C@keescook>
References: <ZN0VTpDBOSVHGayb@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZN0VTpDBOSVHGayb@work>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 16, 2023 at 12:28:30PM -0600, Gustavo A. R. Silva wrote:
> One-element and zero-length arrays are deprecated. So, replace
> one-element array in struct fc_rscn_pl_s with flexible-array member.
> 
> This results in no differences in binary output.
> 
> Link: https://github.com/KSPP/linux/issues/339
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
