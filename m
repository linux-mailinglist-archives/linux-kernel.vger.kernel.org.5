Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 920DA7D5EE4
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 01:57:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344702AbjJXX5b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 19:57:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344663AbjJXX5a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 19:57:30 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50A1CDA
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 16:57:28 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-6b497c8575aso5039209b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 16:57:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1698191848; x=1698796648; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+jb2uj/CUvYCQb1nd+7JiDUO6KWcdpkh68n2gxqAFo4=;
        b=dFVTLNtvHQfbRipS98kn+yVzA+Agdcob15SjfGynY2TXh6lBmY5+yVtDG7YL0u2P3x
         boX3eatRc/mV8CPlTZ3o09QO45iBV1nKsGaA5wAplbcsD8bfPpMfFUPiYzHGqb2CoDJs
         N5hBnmo3GkAaB4reJF0hk0iIVBQA6fLl7MCfU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698191848; x=1698796648;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+jb2uj/CUvYCQb1nd+7JiDUO6KWcdpkh68n2gxqAFo4=;
        b=E+qhdxrvcaXsoiglFaib2VsGaxJgrFdt30qaayLHDDcfwWa9twh5rjtV3XRRuhP4Hu
         dzq3WJxQGsu3LfwFhDGTtc+EkgpdsWIyISoMyw3shqPB1lIopcy+2lscIrkr82G4ga5P
         Jb5MX440F66mcbkjpzKoc9iIz8vOHideX/7bi3VRwoZKDn2jse6SudGr8/qcsJnq9nKz
         f++93Ine3w6hlrtzO6IxlkbiUQU8AAgpRsaTnbSQdEihMut0FarbUaNn1RXo6CowVs3x
         RlB+2l1KO3kpmGpjdefXu3sX72Kqz6cySODFxjSbQPZBM6iu+4gJ23797mzTjH9IlZMJ
         fOlw==
X-Gm-Message-State: AOJu0YyfhOmkJrT1Mbem8aPIQh+RTcDX9UE30R0oogCwt90xcqh//Sy3
        YnDWS1BAIkQHpvcXRYbNoGVYZA==
X-Google-Smtp-Source: AGHT+IHiWgIbAS3C1mTQBzLM3/k+ba7tUzB32559w73G+RDb4OoKwzd9S25AXPmtWjJ4RMWsEs69UQ==
X-Received: by 2002:a05:6a00:10c4:b0:6b5:608d:64f6 with SMTP id d4-20020a056a0010c400b006b5608d64f6mr15661946pfu.20.1698191847785;
        Tue, 24 Oct 2023 16:57:27 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id v13-20020aa799cd000000b006933f657db3sm8127484pfi.21.2023.10.24.16.57.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Oct 2023 16:57:27 -0700 (PDT)
Date:   Tue, 24 Oct 2023 16:57:26 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Justin Stitt <justinstitt@google.com>
Cc:     Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] s390/sclp: replace deprecated strncpy with strtomem
Message-ID: <202310241652.0A3460C@keescook>
References: <20231023-strncpy-drivers-s390-char-sclp-c-v1-1-eaeef80522bb@google.com>
 <202310241645.62B11FE65@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202310241645.62B11FE65@keescook>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 24, 2023 at 04:46:04PM -0700, Kees Cook wrote:
> > Instead use strtomem() as `e.id` is already marked as nonstring:
> > |       char id[4] __nonstring;
> 
> I'm surprised the compiler didn't complain about this -- I thought that
> was the point of the __nonstring attribute: to diagnose when used with a
> string function. Hmpf.

Wow. GCC only warns if you call strlen() on it, but literally nothing
else... :(

-- 
Kees Cook
