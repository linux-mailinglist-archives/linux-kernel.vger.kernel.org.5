Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BF1C7870FA
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 16:01:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241092AbjHXOAi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 10:00:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237974AbjHXOAK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 10:00:10 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2835419BA
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 07:00:08 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-521e046f6c7so10608a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 07:00:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692885606; x=1693490406;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WkV40uqGUGl5dpsyEnO1MhpakKM+GSDF+knK2yDE5VM=;
        b=0xtfVAIt9X3PBZ7W+ieKFzpRgHm2ts6Ik89s7fWIYlrCDWnDnRBqUzXVq6ytDPs4qA
         cetr4u8d4bY7ogbBFfWaneL23yrKj0lZQjzHPIvEwZVfGpcuHRgC3nY0obM1F1W4LXQf
         qxPj8IJGj5pQjl606QYsA5+08zlmzqMYVNcNL7+BZPTtOMRP5fHtbQPQJsSQ08OucM5u
         jC7IEhIY3PGP0e4b0o+BFdXMocst/XA4u2bODDwbCj+F2bNGTy5XE6LVyWeYYZQwTeet
         5LHCnJY1/la3897lADLmZE5Pw43r0yVBx1+m7Qr7g912nAj+9Oo62xsUVDwejsu2+bWw
         TzOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692885606; x=1693490406;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WkV40uqGUGl5dpsyEnO1MhpakKM+GSDF+knK2yDE5VM=;
        b=ETI8TxTCU3kuJ11fnztfLO/nyNJIFu6mM9cr/hUfdPnTKJH5XNiTHnJrwej3HFn5f1
         B/CyTQFMXdck/h1mYLX3xU16VKtJ1ozvjHHJtridFytTe4j8sq72GSac1l5fSoqLtBVj
         4ZmEf0idWAjcVPQIexxWmpFnF+QCMsPJsdHOCzTcByJ9lgZ6wWO+WfrJ8r58MMNFLjMP
         /4dy/82VtE96vGIW0ge76oNjukxW8gqCki9/lqSPDhginCVwmJlu/pA9sPI68VGKpdvG
         o4vT3ZZ7FgrJEM2DUnxyHnC5+8qwr+xV6qQSSLuGZ4u51lQJQaXkop7jyK3TtIwWQQhg
         MDFg==
X-Gm-Message-State: AOJu0YzkqrlDVKOP/MgBVfVj9TDHBMboobh53Pgss+7JWmm7jBLB//PQ
        S3UeXzh1mSDQWcczXHFql9sat2IWQ38W0F2bhHWPVQ==
X-Google-Smtp-Source: AGHT+IHiiz5QrZnui68a1y/y8CWM+QocPYRyCNwuKkv+7h/M2kvsuIqgu/ctnn4/w+ncpxK+M+ilBLBwHcyXyqKykRM=
X-Received: by 2002:a50:8d16:0:b0:523:caae:d6ee with SMTP id
 s22-20020a508d16000000b00523caaed6eemr461390eds.2.1692885606420; Thu, 24 Aug
 2023 07:00:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230821234844.699818-1-zokeefe@google.com> <37c2b525-5c2c-d400-552c-9ccb91f4d7bf@redhat.com>
In-Reply-To: <37c2b525-5c2c-d400-552c-9ccb91f4d7bf@redhat.com>
From:   "Zach O'Keefe" <zokeefe@google.com>
Date:   Thu, 24 Aug 2023 06:59:26 -0700
Message-ID: <CAAa6QmSHF6-9aFa68WDcb+WATh2Yz=wXyp8VBLDNv6yPp2SS5Q@mail.gmail.com>
Subject: Re: [PATCH v3] mm/thp: fix "mm: thp: kill __transhuge_page_enabled()"
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-mm@kvack.org, Yang Shi <shy828301@gmail.com>,
        linux-kernel@vger.kernel.org,
        Saurabh Singh Sengar <ssengar@microsoft.com>,
        Greg KH <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 24, 2023 at 12:39=E2=80=AFAM David Hildenbrand <david@redhat.co=
m> wrote:
>
> On 22.08.23 01:48, Zach O'Keefe wrote:
> > The 6.0 commits:
> >
> > commit 9fec51689ff6 ("mm: thp: kill transparent_hugepage_active()")
> > commit 7da4e2cb8b1f ("mm: thp: kill __transhuge_page_enabled()")
> >
> > merged "can we have THPs in this VMA?" logic that was previously done
> > separately by fault-path, khugepaged, and smaps "THPeligible" checks.
> >
> > During the process, the semantics of the fault path check changed in tw=
o
> > ways:
> >
> > 1) A VM_NO_KHUGEPAGED check was introduced (also added to smaps path).
> > 2) We no longer checked if non-anonymous memory had a vm_ops->huge_faul=
t
> >     handler that could satisfy the fault.  Previously, this check had b=
een
> >     done in create_huge_pud() and create_huge_pmd() routines, but after
> >     the changes, we never reach those routines.
> >
> > During the review of the above commits, it was determined that in-tree
> > users weren't affected by the change; most notably, since the only rele=
vant
> > user (in terms of THP) of VM_MIXEDMAP or ->huge_fault is DAX, which is
> > explicitly approved early in approval logic.  However, there is at leas=
t
> > one occurrence where an out-of-tree driver that used
> > VM_HUGEPAGE|VM_MIXEDMAP with a vm_ops->huge_fault handler, was broken.
>
> ... so all we did is break an arbitrary out-of-tree driver? Sorry to
> say, but why should we care?
>
> Is there any in-tree code affected and needs a "Fixes:" ?

The in-tree code was taken care of during the rework .. but I didn't
know about the possibility of a driver hooking in here.

I don't know what the normal policy / stance here is, but I figured
the change was simple enough that it was worth helping out.

For both VM_MIXEDMAP and !DAX ->huge_fault, there is some argument to
be made that they are unnecessarily restrictive anyways.

> --
> Cheers,
>
> David / dhildenb
>
