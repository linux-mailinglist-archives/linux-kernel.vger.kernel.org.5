Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8C43787229
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 16:48:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241792AbjHXOsS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 10:48:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241901AbjHXOsG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 10:48:06 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C30F31FF2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 07:47:45 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-5232ce75e26so11304a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 07:47:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692888460; x=1693493260;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=szLdS5RHFFJmIl7dIQZZUJMa64tgdaaz20ssbXi59gY=;
        b=kmKIEqvd24XXY6uu+5/LT7T+U5p41NS37rhYUrrrSZsW7XLuehJAgWg1GGZHH97atJ
         KJU25Sz93DlgTj3MsZdq8FpAKs8fDP4iLLa7lOL9CCRza67xhRkTB7UogfAfYWqbNHGB
         V4BurqsDsqVimyNEFpqwNraJrKFNCF7ZgAn+TT/BPlF3o83+aAx8BGbzWPPkr/QO6N94
         o/48f/GMXt3gJInH9CUGLE7Ap1UoPXWQQdsFs7QavWE2b90O9EJ+ofZgSZKR1Yyzf1V9
         1qy/LEm8fkvY6xPNJPXdP/y9V98VH/dChtloet0qkpoMLZjIWzBM71YHWGskb8womw9l
         WhRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692888460; x=1693493260;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=szLdS5RHFFJmIl7dIQZZUJMa64tgdaaz20ssbXi59gY=;
        b=O97jwSyC4Whog9Luk4VJ7wR7MRhmRkZuphi/kQv2kdxw22nq2DtMcpDXgq+Z6JPlzZ
         EBbMU1SnvjWlt3v0FupIldRby1adbUVa2t97vKhWhDhHN5+xkltA9QVR9YICgYO1JV5g
         h/xCTsnFa3pgLdXwSYCirfjojwghd+r+Mlq/9HTUZZQr3Kr7sUhfFhlpiOLy0aEV6zQ8
         WXoTjq9TIbk1RAabWFq+yDPCtpCGJtf7aVzrQ6v+ith+E0Rmrxpndq82iunvqUv2v19d
         xKRodp7Hasp1AW/118CRl7912q7GnlPA3KBN2+b2yHTpMVwU+OshxPkE9pC+fG80VE2H
         qt8w==
X-Gm-Message-State: AOJu0YyDjwKVJOOI+Fww9KBnLK5a+ncDjUZSIqiSaVD1OTKD/66emVBH
        R9j/bW2YeXAmwTsudJUqlk6M0H9gX327UGdrxoG51w==
X-Google-Smtp-Source: AGHT+IE0Pu693JS2IW8sE0A491+67g8cNurIxmbz+9zZJGDLJtooGOIT0OlxBA2MbO5JKk6Jxvz7ZZz+XUFT5pfSiqc=
X-Received: by 2002:a50:9b1e:0:b0:523:193b:5587 with SMTP id
 o30-20020a509b1e000000b00523193b5587mr430490edi.6.1692888460224; Thu, 24 Aug
 2023 07:47:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230821234844.699818-1-zokeefe@google.com> <37c2b525-5c2c-d400-552c-9ccb91f4d7bf@redhat.com>
 <CAAa6QmSHF6-9aFa68WDcb+WATh2Yz=wXyp8VBLDNv6yPp2SS5Q@mail.gmail.com> <3e08d48b-7b70-cc7f-0ec1-12ad9b1a33db@redhat.com>
In-Reply-To: <3e08d48b-7b70-cc7f-0ec1-12ad9b1a33db@redhat.com>
From:   "Zach O'Keefe" <zokeefe@google.com>
Date:   Thu, 24 Aug 2023 07:47:03 -0700
Message-ID: <CAAa6QmSNvx7wbZzfhFOyhODTMoBbf6PimnOf2xeAw5NkD1eXVg@mail.gmail.com>
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
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 24, 2023 at 7:05=E2=80=AFAM David Hildenbrand <david@redhat.com=
> wrote:
>
> On 24.08.23 15:59, Zach O'Keefe wrote:
> > On Thu, Aug 24, 2023 at 12:39=E2=80=AFAM David Hildenbrand <david@redha=
t.com> wrote:
> >>
> >> On 22.08.23 01:48, Zach O'Keefe wrote:
> >>> The 6.0 commits:
> >>>
> >>> commit 9fec51689ff6 ("mm: thp: kill transparent_hugepage_active()")
> >>> commit 7da4e2cb8b1f ("mm: thp: kill __transhuge_page_enabled()")
> >>>
> >>> merged "can we have THPs in this VMA?" logic that was previously done
> >>> separately by fault-path, khugepaged, and smaps "THPeligible" checks.
> >>>
> >>> During the process, the semantics of the fault path check changed in =
two
> >>> ways:
> >>>
> >>> 1) A VM_NO_KHUGEPAGED check was introduced (also added to smaps path)=
.
> >>> 2) We no longer checked if non-anonymous memory had a vm_ops->huge_fa=
ult
> >>>      handler that could satisfy the fault.  Previously, this check ha=
d been
> >>>      done in create_huge_pud() and create_huge_pmd() routines, but af=
ter
> >>>      the changes, we never reach those routines.
> >>>
> >>> During the review of the above commits, it was determined that in-tre=
e
> >>> users weren't affected by the change; most notably, since the only re=
levant
> >>> user (in terms of THP) of VM_MIXEDMAP or ->huge_fault is DAX, which i=
s
> >>> explicitly approved early in approval logic.  However, there is at le=
ast
> >>> one occurrence where an out-of-tree driver that used
> >>> VM_HUGEPAGE|VM_MIXEDMAP with a vm_ops->huge_fault handler, was broken=
.
> >>
> >> ... so all we did is break an arbitrary out-of-tree driver? Sorry to
> >> say, but why should we care?
> >>
> >> Is there any in-tree code affected and needs a "Fixes:" ?
> >
> > The in-tree code was taken care of during the rework .. but I didn't
> > know about the possibility of a driver hooking in here.
>
> And that's the problem of the driver, no? It's not the job of the kernel
> developers to be aware of each out-of-tree driver to not accidentally
> break something in there.
>
> >
> > I don't know what the normal policy / stance here is, but I figured
> > the change was simple enough that it was worth helping out.
>
> If you decide to be out-of-tree, then you have be prepared to only
> support tested kernels and fix your driver when something changes
> upstream -- like upstream developers would do for you when it would be
> in-tree.
>
> So why can't the out-of-tree driver be fixed, similarly to how we would
> have fixed it if it would be in-tree?

I don't know much about driver development, but perhaps they are /
need to use a pristine upstream kernel, with their driver as a
loadable kernel module. Saurabh can comment on this, I don't know.

But your point is very valid otherwise.


> --
> Cheers,
>
> David / dhildenb
>
