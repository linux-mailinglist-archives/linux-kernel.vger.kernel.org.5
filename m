Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 371C47DEBFF
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 05:46:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348510AbjKBEqe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 00:46:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348268AbjKBEqc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 00:46:32 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB7ECB7
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 21:46:29 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-9d2e6c8b542so71257566b.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 Nov 2023 21:46:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698900388; x=1699505188; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lly96fwYzj9dyrjYI20I++tfUGe2kjS+ATbpaoIUCkk=;
        b=eRzmB9kM585VDAX1TV/zfY38RLHFbM/WkAiTl5NBEXolZ7KZPZOqx2MjnRqzZBTEBy
         7AG8oDvmJTSsyWH2H9E0MFWPOoez89VncNlGGeutKQFFHBDW4+kccvlVlCsEDJ9AXKrb
         rUvmEPUBq89YDzlP7qnCIEdLdWCs9SjTVz3hLswfcYlwoPwusOcSH1HmUmHY4tZRjZA0
         5XBfmg4qfp1m+OXEYaXiPMHmgAWtmEff6iCoyl85waO1TnYpn6szi5NJ5utH+GFeCy55
         3/4OtYRhutZY26LfTQ9QbY81XhXVvaIeo5kcnkb+kMkkj7FWsioQgVkP45scTU+t/XUH
         /V5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698900388; x=1699505188;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lly96fwYzj9dyrjYI20I++tfUGe2kjS+ATbpaoIUCkk=;
        b=vGFOtHlaGIaCAluOXYZfbFGaNm2gLO1nTEGnaiZB+A+OpYWPKnrlIZkLA28xM4Ps1K
         Dpc1tKGydcIeSA3SAbJhId7oKe98Q1rmbAk3bD9Rg3qX9iE7iWyvUrGtiqdyxj2xGxt6
         br2J1tjAAun/sLQCBvG7el2hg4zO0iIoW/Nf0mCcyTweqLzOJVQcGHR3lmt0EG31/nTx
         SWHgYHWneaUcETrNTm7/bfW/1OPsRCZvvAiFTfhb0aZ9OFKmgBtugyKo4sD/nFn54HXl
         GtxGs6Dz1FIltDhUu7Q3IRtusXrgUOCrjgthbgNeHuvMtvtjyvNz7A5XlTSTRdhPjKOA
         4rHw==
X-Gm-Message-State: AOJu0Yx0GTqxnAKMTMawtAQb5oZruou21HJp/BTP4KN/usiCFm0faP9O
        MAwoj67ONj3/5mgWrZ4PYD/9AWGX4u4w4SPevlw=
X-Google-Smtp-Source: AGHT+IGkqWSf4mQmPFBoVK42WimmNA6rK9CryaOzWX4lpkZQZCXNKAihrrJ+s409aIvJ2HMwO4/hG56dmimdbmuyPs4=
X-Received: by 2002:a17:907:5c1:b0:9bf:b8f7:1fc4 with SMTP id
 wg1-20020a17090705c100b009bfb8f71fc4mr3467078ejb.43.1698900388120; Wed, 01
 Nov 2023 21:46:28 -0700 (PDT)
MIME-Version: 1.0
References: <20231101233113.8059-1-dakr@redhat.com> <20231101233113.8059-5-dakr@redhat.com>
In-Reply-To: <20231101233113.8059-5-dakr@redhat.com>
From:   Dave Airlie <airlied@gmail.com>
Date:   Thu, 2 Nov 2023 14:46:16 +1000
Message-ID: <CAPM=9tzRPMDMiJUpMS3Kw4VtXy_nfxEH5fa++fZD=fBm=Khp1Q@mail.gmail.com>
Subject: Re: [PATCH drm-misc-next v8 04/12] drm/nouveau: make use of drm_gpuvm_range_valid()
To:     Danilo Krummrich <dakr@redhat.com>
Cc:     daniel@ffwll.ch, matthew.brost@intel.com,
        thomas.hellstrom@linux.intel.com, sarah.walker@imgtec.com,
        donald.robson@imgtec.com, boris.brezillon@collabora.com,
        christian.koenig@amd.com, faith@gfxstrand.net,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Nov 2023 at 09:31, Danilo Krummrich <dakr@redhat.com> wrote:
>
> Use drm_gpuvm_range_valid() in order to validate userspace requests.
>
> Signed-off-by: Danilo Krummrich <dakr@redhat.com>

Reviewed-by: Dave Airlie <airlied@redhat.com>
