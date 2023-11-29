Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CABA87FD6A4
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 13:22:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233492AbjK2MVv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 07:21:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233324AbjK2MVl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 07:21:41 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FB2710C3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 04:21:47 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1cfd76c5f03so186775ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 04:21:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701260507; x=1701865307; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o56Www3Q+AtcE90gXDvz5NG1arQEXkGu3aDX+2U5OVg=;
        b=bdOxlM7RAmZg1OpHSkxKL864stOnjSKxyFqjmE/WlnPxNyFC7g42HGDP4cMHYkLffb
         0k4QxcxvxbTlEzyGKHtnI+7gZJ5wLKDoXq8yp0ULCcvGL47hz56N3MfVhE8eB3xGeKJD
         qYy2dYDFb5y3Eusd1ekO/5foZ6rK0zLcJ0I+7K7beTdw66aCpcHpLMYXZq3eOAg1Oh7C
         fhzemgMWrOYv/k+80Zd4SciI6Rm+zPCRjNFhTbkNRJqbigzsBta1OE8JsV4pyZhXimEa
         sOUpFpflN/YTWIj7K0w35aD3lYXPlVvSjFKPuy+l2NnHOIX40CJ1OEut/F+ImBS0aqjl
         n7qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701260507; x=1701865307;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o56Www3Q+AtcE90gXDvz5NG1arQEXkGu3aDX+2U5OVg=;
        b=OV/SFOTG5Yl/K2FemiBGPf/oMwPS8IzfDRdRnF9nwBDHzbSr4v8OwYfFB8BVmd7ik2
         IFIYybOi2bmcD/hJkqf7bPzxQXr7y09vLt8NwprpBSOwRtHbtQWf647es3gHjnfMqI0X
         wxbpecqzK+wpPgyGH7EjYb3xv5ONcPFxeSWzAgCTYb6wPo90O1RoTs8WH+P83d3RFX48
         qEFUvx4vXg4JEGkwKZQm3yG84Nc0uYuE0gBjN7SjBiYQeE3pCqXHTFCgbWZAkszy9R3F
         QtVvrQUY5gYmFN8KBcFt5Rtq22Sif7d+F5Kw7vh2IKv75sC/BeDsRe18af4RVCJn6M2L
         FVyw==
X-Gm-Message-State: AOJu0YwBtnfaAOALCT3cgVHekX9jINzQyIiff6QU1/KdHJXPFq0KAkFr
        kIFlnHLM392FRzyO5fKtjbG92cAAUu5Xml38WlY7xA==
X-Google-Smtp-Source: AGHT+IGijv2oaXJrsz4eOoB3TmX4ovkG0ibEUz+P5TLts7xACNH5qB3XKWndGchQRopwNv8LdczoZIB5sx6elgIxlsM=
X-Received: by 2002:a17:902:fc44:b0:1d0:220b:f254 with SMTP id
 me4-20020a170902fc4400b001d0220bf254mr21736plb.14.1701260506633; Wed, 29 Nov
 2023 04:21:46 -0800 (PST)
MIME-Version: 1.0
References: <000000000000d9483d060901f460@google.com> <0000000000006547d3060b498385@google.com>
In-Reply-To: <0000000000006547d3060b498385@google.com>
From:   Aleksandr Nogikh <nogikh@google.com>
Date:   Wed, 29 Nov 2023 13:21:35 +0100
Message-ID: <CANp29Y4NLk4jd8zhN-VjXWtrDSWbS=Y-ADGxrmboKU+KH2hMPw@mail.gmail.com>
Subject: Re: [syzbot] [perf?] general protection fault in inherit_task_group
To:     syzbot <syzbot+756fe9affda890e892ae@syzkaller.appspotmail.com>
Cc:     acme@kernel.org, adrian.hunter@intel.com,
        alexander.shishkin@linux.intel.com, bpf@vger.kernel.org,
        irogers@google.com, jolsa@kernel.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, mark.rutland@arm.com,
        mingo@kernel.org, mingo@redhat.com, namhyung@kernel.org,
        netdev@vger.kernel.org, peterz@infradead.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-15.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SORTED_RECIPS,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 29, 2023 at 1:17=E2=80=AFPM syzbot
<syzbot+756fe9affda890e892ae@syzkaller.appspotmail.com> wrote:
>
> syzbot suspects this issue was fixed by commit:
>
> commit a71ef31485bb51b846e8db8b3a35e432cc15afb5
> Author: Peter Zijlstra <peterz@infradead.org>
> Date:   Tue Oct 24 09:42:21 2023 +0000
>
>     perf/core: Fix potential NULL deref
>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=3D17172162e8=
0000
> start commit:   6808918343a8 net: bridge: fill in MODULE_DESCRIPTION()
> git tree:       bpf-next
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D429fa76d04cf3=
93c
> dashboard link: https://syzkaller.appspot.com/bug?extid=3D756fe9affda890e=
892ae
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D12db572b680=
000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D10839a1b68000=
0
>
> If the result looks correct, please mark the issue as fixed by replying w=
ith:
>
> #syz fix: perf/core: Fix potential NULL deref

#syz fix: perf/core: Fix potential NULL deref

>
> For information about bisection process see: https://goo.gl/tpsmEJ#bisect=
ion
>
> --
