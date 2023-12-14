Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A95A8812E46
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 12:13:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443961AbjLNLMw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 06:12:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443857AbjLNLMv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 06:12:51 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D927BCF
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 03:12:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1702552377;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=f72MJnuN1/cm/Dev/0mlmhtD0XSLJacZaVRiLhnCUic=;
        b=Vkwg+VamJtASEHBtQqC077cMbWngakDFVEIzRqAZUz/wuR8cNnyr8ew5eRkJncXK03G+q0
        t2/a4rfWWY4ioXOPt+np3NJZ5+0tt79YNIH0XR/I2ImxKfAyuvB8ZiKMQeZYb/NmArPQda
        tv7pQaGtI+Y+b+9SOn/jQODvFJKoVFY=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-575-iuwSl_1pOkunnRJmoYUZEQ-1; Thu, 14 Dec 2023 06:12:55 -0500
X-MC-Unique: iuwSl_1pOkunnRJmoYUZEQ-1
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-6ceb9596211so9565036b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 03:12:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702552374; x=1703157174;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f72MJnuN1/cm/Dev/0mlmhtD0XSLJacZaVRiLhnCUic=;
        b=BZp1/Nxc7KukjVu2dRIgM20MF82Jr81aVkDlYADw853HLEdtKnf4Y1QkdfjZvqtbPQ
         gu0mS9ht1T9BmFjgLYFzaAjp45h2pQrf78zJNCNq4C3BoNjAad5unV0fDYyWLsqqGDcO
         vKhwg2MUMjQxg/ONEe2IqvJVUjwWZlgEgjaaLfnWYaL1d2NbA65wCHlMueTJtJ448Ee9
         w/12XNnjo9au6dQE+6hiDJEmHlzH7vi76tnaPG9MfQyBPap60ri6j4Xubwcu0EKsZJZ4
         HUy6JlE4H4aj36K5OUcg+bqwGbq/7LgkDImeARGqHzbqtGJlOexFlIfAMBj/LWAYwKSl
         ULzw==
X-Gm-Message-State: AOJu0Ywbj5r1yqQTLboSZjBT35MLDbPuidBiIRK+j2E9IaG2sIZ+aHrX
        HyT6LWhiI42EH7O7VVGa0+xLvBcJ2olWwj1WIPIPHfN8Qy2ik0mXlPWhOGyWC4wckpsOZeeA3jP
        xK7VB+PjR8Qa1Q3AJroFfwLFfBXf7X8tGtr3qaIpd
X-Received: by 2002:a05:6a20:3d81:b0:190:c386:3eb6 with SMTP id s1-20020a056a203d8100b00190c3863eb6mr10338339pzi.101.1702552374620;
        Thu, 14 Dec 2023 03:12:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHA1c/CMcEeS+1zDL88vvudKMYHgJepRndOV9p8crSqiGJQ3oKpXOe7sIBEPnt0dv284xrC4mnCFqnGWX5ErSY=
X-Received: by 2002:a05:6a20:3d81:b0:190:c386:3eb6 with SMTP id
 s1-20020a056a203d8100b00190c3863eb6mr10338334pzi.101.1702552374325; Thu, 14
 Dec 2023 03:12:54 -0800 (PST)
MIME-Version: 1.0
References: <ZXrfBYLGiNXDKkJa@archie.me>
In-Reply-To: <ZXrfBYLGiNXDKkJa@archie.me>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Thu, 14 Dec 2023 12:12:43 +0100
Message-ID: <CAFqZXNvZVzBZhfOvquXDh_1i_ro05iXbEH+hZr3Ct1jDZ92P7A@mail.gmail.com>
Subject: Re: SELinux mprotect EACCES/execheap for memory segment directly
 adjacent to heap
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     SELinux Mailing List <selinux@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Paul Moore <paul@paul-moore.com>,
        David Hildenbrand <david@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Ilija Tovilo <ilija.tovilo@me.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 14, 2023 at 12:00=E2=80=AFPM Bagas Sanjaya <bagasdotme@gmail.co=
m> wrote:
>
> Hi all,
>
> I forward a Bugzilla report [1]. As you may know, many developers don't
> take a look on Bugzilla (especially linux-kernel@kernel-bugs.kernel.org
> as no one subscribes to the generic component).
>
> The original reporter (Ilija Tovilo) writes:
>
> > Hi! We're running into an issue with SELinux where mprotect will result=
 in a EACCES due to the execheap policy since Kernel 6.6. This happens when=
 the mmap-ed segment lies directly adjacent to the heap. I think this is ca=
used by the following patch:
> >
> > https://github.com/torvalds/linux/commit/68df1baf158fddc07b6f0333e4c81f=
e1ccecd6ff
<snip the details>

Hi,

this already has a fix pending in the mm tree:
https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git/commit/?h=3Dmm-=
hotfixes-stable&id=3Dd3bb89ea9c13e5a98d2b7a0ba8e50a77893132cb

More context:
https://lore.kernel.org/selinux/CAFqZXNv0SVT0fkOK6neP9AXbj3nxJ61JAY4+zJzvxq=
JaeuhbFw@mail.gmail.com/
https://lore.kernel.org/all/20231207152525.2607420-1-wangkefeng.wang@huawei=
.com/T/

--=20
Ondrej Mosnacek
Senior Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

