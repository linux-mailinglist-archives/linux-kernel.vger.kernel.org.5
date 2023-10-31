Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41A697DC55E
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 05:31:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236259AbjJaEal (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 00:30:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230100AbjJaEak (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 00:30:40 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB823D8
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 21:30:34 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-508126afb9bso7257355e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 21:30:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1698726633; x=1699331433; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/zl+WazKFc5HhMN50LZss0tyvIWhNvX+UxT2FffeptI=;
        b=UlrKCvg4SNog7i3djl+bZ1M2KZy4D/I8e00XF90nlvN+nHWxNhH6apfSPD057gimTF
         9nKXZ01W5wMNftC9Wz8oS141j9O579wVML6bdsTC4xY3oN5w+FNTcT0Z+IXvMwnpQUYM
         GWGe+apHKlVO2MzmzaLBFqjZCasgYWx6XRwr8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698726633; x=1699331433;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/zl+WazKFc5HhMN50LZss0tyvIWhNvX+UxT2FffeptI=;
        b=UekNV7ZsxcLJ+XGyD2RRiouWf5oY3R5hn4xs0deBzNbxxCFicit5GGqjQzoGFtoKLP
         ej2WdzG355aW3M1k+H5c9MWjrpTwQ8ielzpJ36ry0/2Kn90nbdAbhFAqGlvu+5o7ZHQ6
         KZh8KxMv5ZF8jTPgINnSmcItrLhLXB1n9e0tD4TqaAJNnnDcNNoufWtjitWZIQL1Rji0
         4f0ahqdrsAOxkmy8UR/Q6u+WpOLWGBeDgPTmoFPOgjVpuAWhlzA/Ehv5dY8IbmUL14hk
         sacB3jn2EzY54S2N8Mqe+KkIuRjikA4JVyWhEUMMkSqlNAKh18Xx3Q5keenzsSodNvAo
         zKyQ==
X-Gm-Message-State: AOJu0Yzx8KxrW15pfK1AAoldgi+LgtSibKuLdbVX7r/V3mCX+ACuXWLm
        xjKxovhpmuFrjt8jcdSaMOHgarj59/6FZH8wubPX2g==
X-Google-Smtp-Source: AGHT+IFkFMOcoKydhMu+wv2rhPuSAm4i0gRv+cc6pol6A8loPI1tW7TBI4rukvH4Ja1NFYXKJiMdHv7K9smM18sVk1M=
X-Received: by 2002:a05:6512:48c6:b0:507:9fa0:e247 with SMTP id
 er6-20020a05651248c600b005079fa0e247mr8045647lfb.32.1698726632783; Mon, 30
 Oct 2023 21:30:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230911021637.1941096-1-stevensd@google.com>
In-Reply-To: <20230911021637.1941096-1-stevensd@google.com>
From:   David Stevens <stevensd@chromium.org>
Date:   Tue, 31 Oct 2023 13:30:21 +0900
Message-ID: <CAD=HUj5733eL9momi=V53njm85BQv_QkVrX92xReiq0_9JhqxQ@mail.gmail.com>
Subject: Re: [PATCH v9 0/6] KVM: allow mapping non-refcounted pages
To:     Sean Christopherson <seanjc@google.com>
Cc:     kvmarm@lists.linux.dev, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sean, have you been waiting for a new patch series with responses to
Maxim's comments? I'm not really familiar with kernel contribution
etiquette, but I was hoping to get your feedback before spending the
time to put together another patch series.

-David
