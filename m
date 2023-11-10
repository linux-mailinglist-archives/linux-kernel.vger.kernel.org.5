Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58A757E8282
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 20:32:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346369AbjKJTXh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 14:23:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236178AbjKJTXT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 14:23:19 -0500
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 101C115E2F
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 11:20:39 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id d2e1a72fcca58-6c337ce11ceso2467779b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 11:20:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699644038; x=1700248838; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=CmDqdAWs76Z38wbCXMVzmK7UmSAVaiZdksg9Nozpdp8=;
        b=A4pfe43eMhEXQmBZBUhJX0Po1sv9EUnsEEVkX+znz+Ar0nct3KkqceJzmaE1W32K6Q
         h8FYXWYzIh/EykJUt5graVnWbC7TLIYm94dpl7ATz4kOHJHhrs934tgv4G0WrgPhQZEf
         1h8ryRBWIYVnwLC45DAjoqPNUHg2xGTNTNOuU1fIeSQo0Sm5qRi//D3tF2hB2h8nqs1F
         2EVOmIZed5xf1Db/vVqEz7dcWK/wrUd1KUOPZakkVCr/BrI698406fj6hVZY1cxfzwaT
         +bPQwBCktwHniqGAXCWu42rvTcR02wzJxi+8niHuksz/RFBXS0KRQut/xZTimksxCDLc
         0yuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699644038; x=1700248838;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CmDqdAWs76Z38wbCXMVzmK7UmSAVaiZdksg9Nozpdp8=;
        b=ZhqpGS6UI80qPsBcE6VZkViznpPseSU0iQCZJxfDzwvatIZUNZX33bC9DqwzafMt5D
         QjU1R+mGJ8N8wAsAoEIFrhfVhFVSJFZ9kCYRR5izJJ+7pCDBkG83DnR9O9qzutVwKmAL
         Yk+c2l2G0o5KR/qC28Fsf6Ba/d8FVKPiatOZJ3dXC0nD80hj+cyYd7cmNRIrF+GKOzAP
         +i40NeX4WlO6nEB+NND9Tbfi2ANLjpCwiFpoO+TXeA6oVG5Q84NWS1oVheqr6iQgh7P0
         iAF4LMbBJCNNyiBLvUfeM4dBcuaXVTq9jKphf6qNGXPllPcYGmsK8o0sMya45Q4A5C/m
         BKPA==
X-Gm-Message-State: AOJu0Ywez4jocBxpPUYiXmYLv8VM0wcwVG017hn0oyVc0tUzvgifSABH
        dFacGUfDI21QykMZlk2yv+kHT60=
X-Google-Smtp-Source: AGHT+IGjQZYceFZlkLGm/EfIF1Vis4zESpzioSQUieFa3Kg8E3dOt0VspAX2UHxfpbxz1G8loZjCJa0=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a05:6a00:3212:b0:68f:cb69:8e76 with SMTP id
 bm18-20020a056a00321200b0068fcb698e76mr1374197pfb.2.1699644038285; Fri, 10
 Nov 2023 11:20:38 -0800 (PST)
Date:   Fri, 10 Nov 2023 11:20:36 -0800
In-Reply-To: <20231110111223.692adbd7@kernel.org>
Mime-Version: 1.0
References: <20231110084425.2123-1-kdipendra88@gmail.com> <20231110111823.2775-1-kdipendra88@gmail.com>
 <20231110111223.692adbd7@kernel.org>
Message-ID: <ZU6ChFruBvEnA0V0@google.com>
Subject: Re: [PATCH v2] Fixes the null pointer deferences in nsim_bpf
From:   Stanislav Fomichev <sdf@google.com>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Dipendra Khadka <kdipendra88@gmail.com>, davem@davemloft.net,
        edumazet@google.com, pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        syzbot+44c2416196b7c607f226@syzkaller.appspotmail.com,
        Stanislav Fomichev <sdf@fomichev.me>
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/10, Jakub Kicinski wrote:
> On Fri, 10 Nov 2023 11:18:23 +0000 Dipendra Khadka wrote:
> > Syzkaller found a null pointer dereference in nsim_bpf
> > originating from the lack of a null check for state.
> > 
> > This patch fixes the issue by adding a check for state
> > in two functions nsim_prog_set_loaded() and nsim_setup_prog_hw_checks()
> > 
> > Reported-by: syzbot+44c2416196b7c607f226@syzkaller.appspotmail.com
> > Closes: https://syzkaller.appspot.com./bug?extid=44c2416196b7c607f226
> > Fixes: 31d3ad832948 ("netdevsim: add bpf offload support")
> 
> Don't think so. It's probably due to Stan's extensions / reuse of 
> the offload infra.
> 
> Please put more effort into figuring out when and why this started
> happening. Describe your findings in the commit message.
> 
> Current patch looks too much like a bandaid.
> 
> Before you repost read:
> https://www.kernel.org/doc/html/next/process/maintainer-netdev.html

I agree, I have a similar suspicion for the same report on the bpf list [0].

0: https://lore.kernel.org/bpf/ZU13dQb2z66CJlYi@google.com/
