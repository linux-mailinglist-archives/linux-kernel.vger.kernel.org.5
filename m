Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 253487B9949
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 02:36:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233633AbjJEAgA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 20:36:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233173AbjJEAf7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 20:35:59 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12CD7AD
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 17:35:55 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-40662119cd0so17455e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Oct 2023 17:35:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696466153; x=1697070953; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=891ROwzeVMGLL79Q7/ilOZGIERwi77Fn8nbYvewlZdY=;
        b=sx/WotIDUHvvVXhaEkKPwvjFbllRhaSNBtiIAB7XURiIRI1zG7QvsbvoqD7HnwzqnC
         HcvjnGDu7T1VxWxdK11jBJc/3bvn35Tr6ztiZCtH4a9lSTXvqTUIChBs9VRPHDtrqFZ2
         7FUv6b3kNHq4H51QnYQ0s00z4ZpW2bcOvHwNuyD2OUKV/JKSv4DOvKOq7bd1e9jW1zXz
         43OF1jsKMVIIHl6h0Qpwbss4eBI/3fg9v82raoic/LI1thpnOvZWkiSq0pyOoRskdxJX
         alaGe2FgV9sk/Y3iXFYv7D76h9vLb9/KRlyBU3iM1zA6SWTiquva2dHBqxpXyJ50HSgt
         hzoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696466153; x=1697070953;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=891ROwzeVMGLL79Q7/ilOZGIERwi77Fn8nbYvewlZdY=;
        b=Tqko3N1YcpVfmdTgK+bp6m22ddhwgZI3BZUXqTaviAYojdj1igFkpgU/AjLPZexpSJ
         d29/Usi+q/RuLyv4WDnj0h5ipcuI8pW6uNBlJy6GrXCZvRwl9EhFBmbA82fdHV2coJMF
         uhUZX2dS3UPGzcu/7t3boWcGgwsymS7iANrK6NLffb3Am7vcRc9ddMMZYR4PG2NyMv3Z
         6O631FXEPJ0BZrSrbqTpOK29kA2tKk9e1Ow5NXduQGsQ3xSq4pXEAU71DC+sDPI6TRcr
         g5fcmnltgpyEYWRO4CrnDo0zkFQjaJABynePJqjJ7E2/AH2tf0XpADN/pDcZd38p6S5z
         4bjQ==
X-Gm-Message-State: AOJu0YzDkQ5vi3nHNkO3O9CdBlEnv/QTGcQC8sDgNNSG5NWbuMPOIari
        t9EMbbsaxZklmI+la1MLnevQKJScPzSpJ5Yu8FKaRA==
X-Google-Smtp-Source: AGHT+IEi3YtWX+NJjBDdIeGM/BFonF8YLAMdDpxuuRw2lp4O/hWRzW60AsvY2Q9hZbgVZB7QO5qNM3fDEA51beFgFsc=
X-Received: by 2002:a05:600c:130f:b0:405:320a:44f9 with SMTP id
 j15-20020a05600c130f00b00405320a44f9mr25353wmf.5.1696466153330; Wed, 04 Oct
 2023 17:35:53 -0700 (PDT)
MIME-Version: 1.0
References: <20231004005729.3943515-1-jefferymiller@google.com> <2023100418-clapping-driven-bc09@gregkh>
In-Reply-To: <2023100418-clapping-driven-bc09@gregkh>
From:   Jeffery Miller <jefferymiller@google.com>
Date:   Wed, 4 Oct 2023 19:35:42 -0500
Message-ID: <CAAzPG9NBi78mqdLRNCoye6uBaYWa8pM5UX6Jhxi0Vpgi3Ry-KQ@mail.gmail.com>
Subject: Re: [PATCH] Input: elantech - fix fast_reconnect callback in ps2 mode
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        regressions@lists.linux.dev, benjamin.tissoires@redhat.com,
        linux@leemhuis.info, Andrew Duggan <aduggan@synaptics.com>,
        Andrew Duggan <andrew@duggan.us>, loic.poulain@linaro.org,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Wed, Oct 4, 2023 at 1:19=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> What commit id does this fix?  Should it also have a cc: stable tag?
>
A crash was observed after commit 92e24e0e57f7 ("Input: psmouse - add
delay when deactivating for SMBus mode") which
is not in stable.
I don't think so. The underlying issue was introduced in commit
8eb92e5c9133 ("Input: psmouse - add support for SMBus companions") but
wasn't causing a noticed problem.
