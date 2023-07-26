Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B644B763A0D
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 17:04:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234781AbjGZPEX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 11:04:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234737AbjGZPD7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 11:03:59 -0400
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com [209.85.167.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7CD62D5B
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 08:03:31 -0700 (PDT)
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-39cdf9f9d10so11083700b6e.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 08:03:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690383811; x=1690988611;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8wyKibTr8k/NSeubFc4y5q8h8vNK9/oynyCVrZ6x5+Q=;
        b=h1FgE9kXB5Mz8OddP39YEa4dDRuqbt9wm1OsuYRw9s076Xe8tOSlw+3HedhTd7YYQZ
         88vGJO2wV290xZcd+A3dZhmp+DyGaRlDAVOKQbBb2AVrbDNwniGk0xeZFXYTDQyyRgkQ
         q0KMKknpooGzo/KxzXuOE9pxWt/KKmidebdxgfUpjYlwOcJKENJac4REuUm+CuJ3M7sK
         j6/fcNzEnAHovEDpFmQJbPPUz6U4x3wsRSf2nmM4gHTNK7ixatyi1Bh726XmS/PTK2Ma
         Yvnh9xv+hEEfj2yqwLK0dUibhXwu02el+nNhAZBpoCwZMvGTCiPkKv302Xd5ZyEMeHo9
         0RqQ==
X-Gm-Message-State: ABy/qLZhTHuq2quglmA4UVAmL57fnVKdZfJhVbwZPix7TrF9eH6TMUSH
        LkZQl1yJVuCEPtmAnfNcT/Ygt66Th0nVOTJVmt6tMgtK8OhS
X-Google-Smtp-Source: APBJJlHVqSyLEBclB3tQD4vr9mZJ9hegiZ1FlT2olGWiMvQebgqSxbAMmWl0J/vYqeFidm1ZBu0jFydr0CDmwU8Z1xWGp11AFQAU
MIME-Version: 1.0
X-Received: by 2002:a05:6808:1206:b0:3a4:8115:5e7 with SMTP id
 a6-20020a056808120600b003a4811505e7mr5403236oil.10.1690383810972; Wed, 26 Jul
 2023 08:03:30 -0700 (PDT)
Date:   Wed, 26 Jul 2023 08:03:30 -0700
In-Reply-To: <0000000000002b5e2405f14e860f@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009655cc060165265f@google.com>
Subject: Re: [syzbot] [gfs2?] KASAN: use-after-free Read in qd_unlock (2)
From:   syzbot <syzbot+3f6a670108ce43356017@syzkaller.appspotmail.com>
To:     agruenba@redhat.com, andersson@kernel.org,
        cluster-devel@redhat.com, dmitry.baryshkov@linaro.org,
        eadavis@sina.com, konrad.dybcio@linaro.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        rpeterso@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot suspects this issue was fixed by commit:

commit 41a37d157a613444c97e8f71a5fb2a21116b70d7
Author: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Mon Dec 26 04:21:51 2022 +0000

    arm64: dts: qcom: qcs404: use symbol names for PCIe resets

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17b48111a80000
start commit:   [unknown] 
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=fe56f7d193926860
dashboard link: https://syzkaller.appspot.com/bug?extid=3f6a670108ce43356017
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1209f878c80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=111a48ab480000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: arm64: dts: qcom: qcs404: use symbol names for PCIe resets

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
