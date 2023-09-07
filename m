Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 145D9796F89
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 06:14:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240800AbjIGEOZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 00:14:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240908AbjIGEON (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 00:14:13 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED8A9199F
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 21:14:09 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id af79cd13be357-770819c1db6so33750285a.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Sep 2023 21:14:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1694060049; x=1694664849; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7OBl7ZlktdOAZo2mwTBARGf7BsHYYco425PFnGBZf2g=;
        b=owqt/MvAF3P9sM+ThjQ3zjUpqleOJ/ftw1B0jgRxf3HM5StK1n5zbjswo73lmt5nQd
         vZygj45dU8r2r+jsMsUE00oPS2K31DjO0aJt22tFxbJDUaVW/Sd8gT23nQoMlLVMTImZ
         KKriysifMEyuCsXmbOCNQYoX2ukyd91NoaqjMWxwulleag7M0EwnkKzPSB6V6a36MXdk
         Q9FYVxI0FH0xbosv2ngMqilJp4CnuaLTRu7EZLQnKoJXfIUqhrLXgggKwVsUZtCIIMEW
         A0/kogd97tcNLeXtJld1c+RPyUM1u+3ZB5WLHBMZW01cLU6aG+LeBKBPWcSWpHIQH1vw
         YX1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694060049; x=1694664849;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7OBl7ZlktdOAZo2mwTBARGf7BsHYYco425PFnGBZf2g=;
        b=c4qHXlQIwr1ziFtKwimg2aPpXZWX+OCNjU+ehCLsr1zWqTm4b3HW1ZolKCEea/tQWD
         5BPUMQRxbm52KAj3PtsabnXnljOnhYfViT7M8jy9VqTm75MFjuLkqVgXjsxGtdZio62g
         MS/VFvMgYx65haNNyFJfAbR2eiS1EByh2O9iIz2PsGi3CPHIdQLW6t/D9gD3XM+SWv0O
         T2lLl5SrbNNtsaQ890WYhfIx3hGzNza5VwS4AlNI8yaDqS5Jbw9/SNmxda+yQEPxVEGU
         YJr49meIRYTW+JTv+TVOKNhebPSDNE9JriL333fYAbhbsHf6UjyBWRAY6LfSkqCx8qU/
         TG2g==
X-Gm-Message-State: AOJu0Yw3jT+ObYnRazhXHfrr4ma7YGRJ766VkpYjyE1sbIkOm3gdYhEl
        2sA9mR88iv7Gj3MijAUt/xWsJB45zNlp7ketYm71xAJHP1x/0/zNQhLZRA==
X-Google-Smtp-Source: AGHT+IFzOiXrrbUT9c5ylYR8Rxg9I6ORxvfn4SsLGZ9bl2VgBJKQMQ/mWQ4Djr9rAqKU1eqaorRwHZyWQArlgRPZ0AM=
X-Received: by 2002:a05:620a:1356:b0:767:8373:a890 with SMTP id
 c22-20020a05620a135600b007678373a890mr14552712qkl.45.1694060048796; Wed, 06
 Sep 2023 21:14:08 -0700 (PDT)
MIME-Version: 1.0
References: <20230906173904.475722-1-catalin.marinas@arm.com>
In-Reply-To: <20230906173904.475722-1-catalin.marinas@arm.com>
From:   Sandeep Dhavale <dhavale@google.com>
Date:   Wed, 6 Sep 2023 21:13:57 -0700
Message-ID: <CAB=BE-QYXHNzq3Hw6m12A7=EdwBeVvJBgpDk5CV_2RZ8MwWExw@mail.gmail.com>
Subject: Re: [PATCH] workqueue: Remove duplicate worqueue attributes allocation
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     tj@kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
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

Thank you Catalin for following up!

Reviewed-by: Sandeep Dhavale <dhavale@google.com>

Thanks,
Sandeep.
