Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CED077FD33
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 19:48:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354083AbjHQRr3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 13:47:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354103AbjHQRrI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 13:47:08 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AAF430F5
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 10:47:07 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id 41be03b00d2f7-563f8e8a53dso67272a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 10:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692294426; x=1692899226;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TJUEN3/MzB2Leff/dyiCqwmONnMWLUZ1CWSo2+nWXtI=;
        b=sfQibF0xOiKOYawtTfuu+kZdEG97V60HlcJNSZQDL1LcqOjTBae5UEmGIBcIdfzOw0
         0IQyP9VOV6Xj1r7oZyukZ85JM/ELoL+zjpla7FoUQUYaoTG/9xJp1TFf0IGpOYyJCr1X
         remZvGHZ7JWTTRxiVbz+OjKRFlW0+jER1+ATKD4A8NbIgEWc+NAJEye99wDBtWLmOVDH
         pfFF9vxB1frwdZRc7YCbP31eDyolle/hs543IyffdieuoZyCCZcgUaq30Bx2qsi/E8DA
         N/L/24xiQBj71SqTMyilTB12hTqHtQYTX/86tQvHXeHmFpUTe5IjhIumOi7Dt2vm392H
         wyiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692294426; x=1692899226;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TJUEN3/MzB2Leff/dyiCqwmONnMWLUZ1CWSo2+nWXtI=;
        b=HorIleU/1nxUD9tP+5B3M7dooFMtmRySEZ8+X/qe1OO/WVxxRkK4h63A4SgoeIMjbb
         Rj4odWw1S/lZRPmLBOhxJb9k0sA/5iHVosvip9r6C7bri+S0oK+xIH5jia8iZ5ovQKH2
         V5tcw0GXOQAd1aajcBFmh+K6aY+e1viOHSOKMfoTdaOCaHfifB9tuMXwvAQrjBnuopAc
         0Pn0WyIt2roNOO0RssHsKpX/NWYCKfWmf4d/63fWtdWsBEbdpVp/McqmIHijoc7WZYlP
         7oaMdZ8YuGNlUDSYrYb6iPeuWsuVDiKvw0q5fepc3rnh1g6xxFhyj9IrXXm87b77f0wl
         KI/Q==
X-Gm-Message-State: AOJu0Yx1Cil2+fI2BEGBEdAzxDcm8S9hjeEMRuzYtYcSdMiQAgT8UEwq
        WiNei8GJ3MGceClvxXzIM1woDDgDGxJkG4Q+EP4=
X-Google-Smtp-Source: AGHT+IHhoEkfZu+PvEzuaZxH9Qimc/cllC1ac7hKrtni4oIMC9XA4BdYVJPG66Or18T75ZkFpZzx36QmSyvKv3fzxhs=
X-Received: by 2002:a17:90a:8c18:b0:26c:f769:829 with SMTP id
 a24-20020a17090a8c1800b0026cf7690829mr93202pjo.28.1692294426422; Thu, 17 Aug
 2023 10:47:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230812210053.2325091-1-zokeefe@google.com> <PUZP153MB06358FF02518EF3B279F5DD4BE16A@PUZP153MB0635.APCP153.PROD.OUTLOOK.COM>
 <CAAa6QmSrwe2m4MjS9mGO+DeGNGSv=B2uZ72EAxnZk2jsDh39rQ@mail.gmail.com>
 <ZNp7JDaPhT3Se4de@casper.infradead.org> <CAAa6QmSN4NhaDL0DQsRd-F8HTnCCjq1ULRNk88LAA9gVbDXE4g@mail.gmail.com>
 <ZNrh6w9ICu4rMrhV@casper.infradead.org> <PUZP153MB063529C4869A7A666C275B23BE15A@PUZP153MB0635.APCP153.PROD.OUTLOOK.COM>
 <CAAa6QmRrnRHEEQMMYe20GLXj7g+LVVHVRAKUdSLy=jUW=khb2A@mail.gmail.com>
In-Reply-To: <CAAa6QmRrnRHEEQMMYe20GLXj7g+LVVHVRAKUdSLy=jUW=khb2A@mail.gmail.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Thu, 17 Aug 2023 10:46:54 -0700
Message-ID: <CAHbLzko_xLiqkNgjA7DhVFBSW6qJdAwgfk557YKV+ZpwS2x16w@mail.gmail.com>
Subject: Re: [EXTERNAL] [PATCH] mm/thp: fix "mm: thp: kill __transhuge_page_enabled()"
To:     "Zach O'Keefe" <zokeefe@google.com>
Cc:     Saurabh Singh Sengar <ssengar@microsoft.com>,
        Matthew Wilcox <willy@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 16, 2023 at 2:48=E2=80=AFPM Zach O'Keefe <zokeefe@google.com> w=
rote:
>
> > We have a out of tree driver that maps huge pages through a file handle=
 and
> > relies on -> huge_fault. It used to work in 5.19 kernels but 6.1 change=
d this
> > behaviour.
> >
> > I don=E2=80=99t think reverting the earlier behaviour of fault_path for=
 huge pages should
> > impact kernel negatively.
> >
> > Do you think we can restore this earlier behaviour of kernel to allow p=
age fault
> > for huge pages via ->huge_fault.
>
> That seems reasonable to me. I think using the existence of a
> ->huge_fault() handler as a predicate to return "true" makes sense to
> me. The "normal" flow for file-backed memory along fault path still
> needs to return "false", so that we correctly fallback to ->fault()
> handler. Unless there are objections, I can do that in a v2.

Sorry for chiming in late. I'm just back from vacation and trying to catch =
up...

IIUC the out-of-tree driver tries to allocate huge page and install
PMD mapping via huge_fault() handler, but the cleanup of
hugepage_vma_check() prevents this due to the check to
VM_NO_KHUGEPAGED?

So you would like to check whether a huge_fault() handler existed
instead of vma_is_dax()?
