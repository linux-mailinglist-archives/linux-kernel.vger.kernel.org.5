Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C50DF7E0098
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 11:30:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345867AbjKCHQN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 03:16:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344008AbjKCHQK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 03:16:10 -0400
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com [209.85.160.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C83BC191
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 00:16:03 -0700 (PDT)
Received: by mail-oa1-f72.google.com with SMTP id 586e51a60fabf-1e990f0629cso2441118fac.2
        for <linux-kernel@vger.kernel.org>; Fri, 03 Nov 2023 00:16:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698995763; x=1699600563;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KTF8g/fG8S64+yMV067G0wOy0IAP8ddv8VHzg03eh8U=;
        b=SUcxWt9VI40HO51fOO9JEcuHABYQWsQAEkxXRVYcKJdJmRg1K4o11lVhrl/RbHgzvN
         bIi78raU35Sv4RAkY3OFeFaON7csqg8ndS2TJmi2W1EZNxD1kpcnwxxmoTtAqGznRuHM
         5cXeFKcu/s8ztQ1mlsJhbaad+iVoIjquAnIiNjqWUDG3AbZ9huzaDqvoihKw5Qs/cOr0
         k5RusRjk9cyqwTLOhiMoncfW54W4mRvjOPRlZPYGjo3N4/Zxd4ssNyKRZrpITm2/gH4n
         SPwuEBXeyOSb6Bds1Aa1lxjf8T6SCm82rDPMYFkSFk3ydqBCtli+Q3+tM2Td84+wPE44
         GVoA==
X-Gm-Message-State: AOJu0YzZTIHGPGofVuetrnCaqhWQwQljp97eKa0ED3alsFWOFyHnlRDa
        4WgjKCwzeILu2byAsc+60gJI2ryqZs/y1Z3GjsbiKbpeSh0S6rU=
X-Google-Smtp-Source: AGHT+IHlBAe+RnDf1RY1UJ/msju+ttyhwiZ6dfF+uDjt1wI7kS+odB8CVnAGGM3nIu/zaxny2UdHYBn3gvO6SaEKABJgbRx78qqA
MIME-Version: 1.0
X-Received: by 2002:a05:6870:b4a6:b0:1ef:9f4a:9a10 with SMTP id
 y38-20020a056870b4a600b001ef9f4a9a10mr8424967oap.3.1698995763221; Fri, 03 Nov
 2023 00:16:03 -0700 (PDT)
Date:   Fri, 03 Nov 2023 00:16:03 -0700
In-Reply-To: <20231103070938.2846226-1-lizhi.xu@windriver.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f1198606093a46ae@google.com>
Subject: Re: [syzbot] [iommu?] KASAN: slab-use-after-free Read in iommufd_vfio_ioas
From:   syzbot <syzbot+d31adfb277377ef8fcba@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, lizhi.xu@windriver.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

./include/linux/stddef.h:8:14: error: incompatible types when assigning to type 'struct iommufd_object' from type 'void *'


Tested on:

commit:         2af9b20d Merge tag 'x86-urgent-2023-10-28' of git://gi..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
kernel config:  https://syzkaller.appspot.com/x/.config?x=cb98fe061049a6e4
dashboard link: https://syzkaller.appspot.com/bug?extid=d31adfb277377ef8fcba
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=13c8c53d680000

