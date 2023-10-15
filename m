Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AAC07C9822
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Oct 2023 08:20:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbjJOGUk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Oct 2023 02:20:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjJOGUj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Oct 2023 02:20:39 -0400
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com [209.85.167.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA76EDA
        for <linux-kernel@vger.kernel.org>; Sat, 14 Oct 2023 23:20:36 -0700 (PDT)
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-3af5b5d816aso5490579b6e.3
        for <linux-kernel@vger.kernel.org>; Sat, 14 Oct 2023 23:20:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697350836; x=1697955636;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JnnxlBZS3D2FK4g6Uy7ps+bfDovN+JjodCSC2jnZejQ=;
        b=H5Kz8W4JFKb+FShWtbGZdClCP+mXBBXH5usa2Evy4AKQ1fNvPwQBfwTRAMpLvgecvp
         bdHE7f6OTIsB0Xe2XvVSFphf/pS7NzsO+L0UYMiQROnII4jXaaUK4Nrb4H58pj0TqN5x
         DK1VBtdCLjD/vs4TWovUs2HpeY1vgcThjFCMFOocr+R+AlzxDrTPQPRMkzDDO+mzMC+L
         9jdJqB/gRYKxOvXbau52iXrlbDrDjenVAf1x4jXFKsmYVr0MivDr44bbIDkfbx6cySJH
         sRDKy56w2bLbXDqs6FbcZgrLxLMAKL+WwFxIVW6euNIxKvIUQkVJm4NxPkHdTTqgY3eh
         NPWg==
X-Gm-Message-State: AOJu0YwB0f7GTKQ190cx/5ahjnKmp08x9Cqi10O9Ftep1FTucLCOrrD0
        6ntd2Qp00H78x4IN9aJe36jA8faLD73iZW1pztSEWSY/28ie
X-Google-Smtp-Source: AGHT+IGdOmApbp1z+C4jkZhnMvLqnC6RfTusIF3Td3gW7xJSBZwQQZ2Gm5r1fGERsRs0BZ48WUtl4POS6SIIi2qUuNZw18KJEBSn
MIME-Version: 1.0
X-Received: by 2002:a05:6808:2118:b0:3a9:b964:820e with SMTP id
 r24-20020a056808211800b003a9b964820emr15443810oiw.3.1697350836276; Sat, 14
 Oct 2023 23:20:36 -0700 (PDT)
Date:   Sat, 14 Oct 2023 23:20:36 -0700
In-Reply-To: <000000000000d04ea90604a6efcc@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a7d2820607bb49c2@google.com>
Subject: Re: [syzbot] [kernel?] general protection fault in usb_hub_create_port_device
From:   syzbot <syzbot+c063a4e176681d2e0380@syzkaller.appspotmail.com>
To:     andriy.shevchenko@linux.intel.com, christophe.jaillet@wanadoo.fr,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, rafael@kernel.org, raychi@google.com,
        royluo@google.com, stern@rowland.harvard.edu,
        syzkaller-bugs@googlegroups.com, yuran.pereira@hotmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot suspects this issue was fixed by commit:

commit fd6f7ad2fd4d53fa14f4fd190f9b05d043973892
Author: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Date:   Mon Aug 28 14:58:24 2023 +0000

    driver core: return an error when dev_set_name() hasn't happened

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=148e8a9d680000
start commit:   7733171926cc Merge tag 'mailbox-v6.6' of git://git.linaro...
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=b273cdfbc13e9a4b
dashboard link: https://syzkaller.appspot.com/bug?extid=c063a4e176681d2e0380
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17a4ca00680000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13bed168680000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: driver core: return an error when dev_set_name() hasn't happened

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
