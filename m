Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F20697689F8
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 04:25:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229669AbjGaCZX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jul 2023 22:25:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjGaCZW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jul 2023 22:25:22 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B030319C
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jul 2023 19:24:59 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id 98e67ed59e1d1-2685bcd046eso2193129a91.3
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jul 2023 19:24:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1690770299; x=1691375099;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2WJGbTzBWWyLthYKvFHYFfDGIjVylpKt1feyDxG3xoY=;
        b=JZM+YnxhF57V3REfJ6Q/phNRJvycZOWrLWuMsmptcUSrCEPjSweMC7uEC+ywDAtrfl
         PDF8Hz92PvsHUwdwED7I/shUd9wzE1IVDfo/OejXYkuVTBmgoQUgP4dXKjJLkyKXVWNz
         3PRGEMdAJfTI5F4129d2cFvj+yAjts1Kgpk+aBnXWWW7idT0BjfbHfqDdS5o+wJpheDz
         YliKkxuP2WdVOo+nC/ijKbaN1PJb4hMTOMMv/6Myqq1kQPIYnbBSjiNPtKXhqgCdb8Qx
         TzWvTIMX3+TvdsI/yNUUQg1MZzegFgAZk71OG3n1ijx2ZpFnhK0a4Lzh2appZehDaITk
         4veA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690770299; x=1691375099;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2WJGbTzBWWyLthYKvFHYFfDGIjVylpKt1feyDxG3xoY=;
        b=L2Az1fQuO5dbDlW3oZHp7MRPXHKAQqYwpQwlQL+NAyf+u3Z7qnRFe6sFKGe0SuXkjN
         ON3Ec956CuLofE+HtKDt57igHL9MGomkON/d0u1081Q/UXGin1vhp1ii0XfUi+we+u8C
         t86pC8cVS8deHQrEO3hzFNXqIc1b+3LvPfMR8leq/OSIUrsu2P+1GYBg56ZNoJPeVRQl
         W+kesXcavPRSshvKECTuroRfrYssj+F5fs+5xTuB6dav900DJMrz/SWedLPIzElMIkEG
         4gQu/SyPPeKQStWElQ0+a4UtNTP880R8b8QpkjDwJEWHsBiuYJGfsV5zsnh44c1rTiuA
         psng==
X-Gm-Message-State: ABy/qLZBGgq6zejzqz7TWK9lee8zWX/IQDgD9KMkW+NO/FSZEUM0pk/t
        OUxzI4/Cf9xJEv45tMjNyA1gQ6RSJHqt2Y477TNk
X-Google-Smtp-Source: APBJJlEJ65CGI2+MsoymADeLmpN7lv9jLT77xSzuwL8zvJnrlqrMOy2zRhM179uVohKj3PjVe5q6QspU/YR0YoUXmWs=
X-Received: by 2002:a17:90a:74cc:b0:268:3b8b:140d with SMTP id
 p12-20020a17090a74cc00b002683b8b140dmr6635192pjl.35.1690770299166; Sun, 30
 Jul 2023 19:24:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230705114505.63274-1-maxime.coquelin@redhat.com>
In-Reply-To: <20230705114505.63274-1-maxime.coquelin@redhat.com>
From:   Yongji Xie <xieyongji@bytedance.com>
Date:   Mon, 31 Jul 2023 10:24:47 +0800
Message-ID: <CACycT3tVOKVvhTab7cbjFJsVk3vnWwqyaZ6pGvKmxO8jADj65Q@mail.gmail.com>
Subject: Re: [PATCH] vduse: Use proper spinlock for IRQ injection
To:     Maxime Coquelin <maxime.coquelin@redhat.com>
Cc:     Jason Wang <jasowang@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        David Marchand <david.marchand@redhat.com>,
        Cindy Lu <lulu@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        virtualization <virtualization@lists.linux-foundation.org>,
        Netdev <netdev@vger.kernel.org>, xuanzhuo@linux.alibaba.com,
        Eugenio Perez Martin <eperezma@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 5, 2023 at 7:45=E2=80=AFPM Maxime Coquelin
<maxime.coquelin@redhat.com> wrote:
>
> The IRQ injection work used spin_lock_irq() to protect the
> scheduling of the softirq, but spin_lock_bh() should be
> used.
>
> With spin_lock_irq(), we noticed delay of more than 6
> seconds between the time a NAPI polling work is scheduled
> and the time it is executed.
>
> Fixes: c8a6153b6c59 ("vduse: Introduce VDUSE - vDPA Device in Userspace")
> Cc: xieyongji@bytedance.com
>
> Suggested-by: Jason Wang <jasowang@redhat.com>
> Signed-off-by: Maxime Coquelin <maxime.coquelin@redhat.com>

Reviewed-by: Xie Yongji <xieyongji@bytedance.com>

Thanks,
Yongji
