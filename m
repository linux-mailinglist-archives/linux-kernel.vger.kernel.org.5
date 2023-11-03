Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB9487E0182
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 11:31:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233599AbjKCHLO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 03:11:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232885AbjKCHLL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 03:11:11 -0400
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com [209.85.160.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EBB6186
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 00:11:05 -0700 (PDT)
Received: by mail-oa1-f70.google.com with SMTP id 586e51a60fabf-1ef4782ef93so2136348fac.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 Nov 2023 00:11:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698995464; x=1699600264;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9bBiTuQmzhIrhENOLLOz6/vc6vZ9QR5v4pDSsvtAk5Y=;
        b=jO0hhXwysM5Neawuf8h3f1W2XBarTptlelWdaS8Qb4ugCfvJ3FxTl/XG2FOpWF9yei
         Eymv/UUIGBtu7Q98cqXRcNAYy930etZ9YuPaRJxROnCjS1rFBT7jy4REHDwcVrq4OmNf
         IoqSwSxi2rq3EOH24fKBoB5P4OFjeNPnx5F4C0TTe7A3+cPN2FMkdfyeBwsRWQozipH6
         qAw4G8Wc9/L8YsIZp5/kENgGT9BUXTu6larV65p91gEwtBAFy8NvJKUnimEOAVpVauXn
         Y3eDGDKvN+863K3Hs2QtSX1iJ7QfRzzqPfTOg/ISAjnmx79GLcWdD05lQIjLYj7cf392
         U21A==
X-Gm-Message-State: AOJu0YxETNEawTVUtpzX+h8MSt+E24JIcp/h0OTFxuKA3/A8RH9ANFgO
        xBzswLidD7vclMeuMvccPT76IDLCzjmDnnNCKoGWl+bv16/q2BM=
X-Google-Smtp-Source: AGHT+IER6fWsqtYpy/2KhQMl2rgnrVKhhl4jIu/vvItUCA3F6vemUhnRRBkQYAv8ckNqlY0cjM8tvPpvKOO23GmS+FCnWdEJrMXZ
MIME-Version: 1.0
X-Received: by 2002:a05:6870:a919:b0:1ef:afd3:813f with SMTP id
 eq25-20020a056870a91900b001efafd3813fmr802244oab.5.1698995464580; Fri, 03 Nov
 2023 00:11:04 -0700 (PDT)
Date:   Fri, 03 Nov 2023 00:11:04 -0700
In-Reply-To: <20231103070111.2610655-1-lizhi.xu@windriver.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000024358306093a35be@google.com>
Subject: Re: [syzbot] [bluetooth?] KASAN: slab-use-after-free Write in
 hci_conn_drop (2)
From:   syzbot <syzbot+1683f76f1b20b826de67@syzkaller.appspotmail.com>
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

net/bluetooth/sco.c:81:26: error: static assertion failed due to requirement '__builtin_types_compatible_p(struct hci_conn, struct hci_conn *) || __builtin_types_compatible_p(struct hci_conn, void)': pointer type mismatch in container_of()
net/bluetooth/sco.c:82:7: error: no member named 'hci_conn' in 'struct sco_conn'


Tested on:

commit:         8de1e7af Merge branch 'for-next/core' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git
kernel config:  https://syzkaller.appspot.com/x/.config?x=3e6feaeda5dcbc27
dashboard link: https://syzkaller.appspot.com/bug?extid=1683f76f1b20b826de67
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64
patch:          https://syzkaller.appspot.com/x/patch.diff?x=155280d7680000

