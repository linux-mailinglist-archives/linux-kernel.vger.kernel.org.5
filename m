Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2EFA7A9791
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 19:25:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229669AbjIURZl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 13:25:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbjIURZJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 13:25:09 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABBCC40666
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 10:13:15 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id d75a77b69052e-4132c2cee1dso7433401cf.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 10:13:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695316391; x=1695921191; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dcy4s/y9QrO7HyaGbG5mBXkJxd9gLjLKZbDI7oXicRU=;
        b=SXEwamodmmxtQYKjF3iTAy5NpAN6thYsN2+QTK/mdDG1bJarxGnQX7ybpWV77sEILC
         kXIuHLWPD8LRiAy6tqGVeQOTdH2ZlBJNI9r0xC2K5DtbC0lz1JloaX+GMUK5utBZa+Ck
         84WQLBIENt9IHgixyQjOuW+bd1Cfgn2SmAbyQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695316391; x=1695921191;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dcy4s/y9QrO7HyaGbG5mBXkJxd9gLjLKZbDI7oXicRU=;
        b=cexvpMmpohzksIbE17Cm8kRNctswJxqgHlW5fVHd3eouX7ladkm9HGvwUnVt0RSBdL
         /0cB0fWiHRj5nfIbI3b8RfFAqJYn0H7TuJJ//uRid/a2uoGaO4waO7WJyuBIRMtZrvBW
         L7k76KE2PmhS/UBZPEKD0/SQX1SPq7U9iUEbq8nFF+GLETOgT7XpV9QMD90HTDTXSoQN
         4Ov/7bIhjo56zCbaX6IleHn+BDzurf16gBKJ0u2+TeWHw5729oxXKYaCz2evGLIIFdMt
         r66yIekcRhilsX0rWEpKtuzOAWHBIhKMIrPl5Rf/9vfTQJQbOZZ1svcUY38od4tjJL1V
         ZuNg==
X-Gm-Message-State: AOJu0Yx12Kwbkxi75mH2BPuhXjDCJRytkUguSloXYf/l0vr2oiFGV+db
        BbxH7USVMO8OLbffScFzGlxg2KmNWrjY0tE+YOszVkqBM+jAiMgO
X-Google-Smtp-Source: AGHT+IENHY2NWzp2t7oTLLYtLJAusFJoXLC4LiTtWC/n27+ddm0+GulmSKnIh4apJN5/NUozS6cXcoxavCqIAMRMCSA=
X-Received: by 2002:a17:90a:5305:b0:276:c6b8:eaae with SMTP id
 x5-20020a17090a530500b00276c6b8eaaemr3846719pjh.7.1695290273607; Thu, 21 Sep
 2023 02:57:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230828150858.393570-1-revest@chromium.org> <CABRcYm+u1AHMrXbYrfkxW-2vrjdq-1cx13FsX_DFo=wwWB8rbA@mail.gmail.com>
 <ZQwSas2aA/TCLTOf@arm.com>
In-Reply-To: <ZQwSas2aA/TCLTOf@arm.com>
From:   Florent Revest <revest@chromium.org>
Date:   Thu, 21 Sep 2023 11:57:42 +0200
Message-ID: <CABRcYmJ92F-y_q8NEDg_jy6aJf4nLseTWbWum6SzqRvy8LTfEw@mail.gmail.com>
Subject: Re: [PATCH v4 0/6] MDWE without inheritance
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, anshuman.khandual@arm.com,
        joey.gouly@arm.com, mhocko@suse.com, keescook@chromium.org,
        david@redhat.com, peterx@redhat.com, izbyshev@ispras.ru,
        broonie@kernel.org, szabolcs.nagy@arm.com, kpsingh@kernel.org,
        gthelen@google.com, toiwoton@gmail.com, ayush.jain3@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 21, 2023 at 11:52=E2=80=AFAM Catalin Marinas
<catalin.marinas@arm.com> wrote:
>
> On Wed, Sep 20, 2023 at 09:56:08PM +0200, Florent Revest wrote:
> > It looks like this series got quite a few Reviewed-by now. What should
> > be the next steps to have it merged ?
>
> Does it still apply on top of 6.6-rc2? Maybe Andrew can pick it up
> through the mm tree?

Luckily, yes, it still applies! :)
