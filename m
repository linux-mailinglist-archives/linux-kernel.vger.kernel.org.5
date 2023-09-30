Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D4567B41E8
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Sep 2023 18:00:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234457AbjI3QAf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Sep 2023 12:00:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231715AbjI3QAd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Sep 2023 12:00:33 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0F56B9;
        Sat, 30 Sep 2023 09:00:31 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id 98e67ed59e1d1-279013f9875so4051104a91.2;
        Sat, 30 Sep 2023 09:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696089631; x=1696694431; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gILmhzCOvJo6YdBgmybUBBwY7d2ScLP58BDF9B/fF+Y=;
        b=fe0WXuPib0sEf5qUFQteyIARYW1Ps1XHtjdjBxfQo/txhQKozp3LpD+EkxTu42x0+G
         om2JeApQxOgpXHnyS/d49cNpheoT5kHzks2NplmY4Kbtff55C4vk/ko17wdfC2AaNBPI
         DirxdASYONuvI/TemcYirl/MitP5zHel+K/Sv1bNhodbzXTxiPCauRgPAf8mbCmY6pTa
         R6YyjihjEROceLDsrU3iaZm4mPnvqZ2GtlT2U5Boy3gJeiSYzmGZrFCZSIZsaiUC+POE
         5hXOgNtOTnwH23WCW0wGsdmRR1hXkcqbaVzp645MSVsTK0QflvUQRblWYqj4EdcoMOd5
         Zbng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696089631; x=1696694431;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gILmhzCOvJo6YdBgmybUBBwY7d2ScLP58BDF9B/fF+Y=;
        b=kgS8YSEj4ZPltWAVSfR016/oNKXHd+4dBE/5JykTDSTN+52D6o4hZAMBR8j0hsM8PU
         CRndURPo7Jo7IzwX2hMncy5O3EyfrStxNXaCQVeEd3NDHvVLlyh4aR5bTJQaRENeqGG6
         8xm/Z5t2cpWfygF9Gen9c6bdrWzEeV1RRE3s51zCQsv+hnaHxoKxyZNK4GNc3od2Ofy0
         U7EDs59GL0yHbxogdXre2DKP5PZmUesXYrwLdYmX3XHrb8nBPgpbGXz47SbGdU4BNJgd
         NpmR4BKy05VIr8SNa1B/8aPN6GINEN5HxTUCv3icuQgVoonE0+bRTjubAo96O/TnavXP
         qa6g==
X-Gm-Message-State: AOJu0YzOTbsUqgddb/PCwe3wp2TVx9qT/vZ1+WwxlP+TygFCxc6NMwxL
        Uk0WwUZJ9kQbsOrf6zBbJ6BcTM01NC9W5L2fHUg=
X-Google-Smtp-Source: AGHT+IFFEXIoF7kfOqEdM5wgbVRNXP9UlJONU8p47f9Q5/EZaebYx7vvZmq5aNqc0+fOqNUGQGn4aSfCCasDwnU85OI=
X-Received: by 2002:a17:90b:4f47:b0:273:441a:dae6 with SMTP id
 pj7-20020a17090b4f4700b00273441adae6mr6900713pjb.19.1696089631380; Sat, 30
 Sep 2023 09:00:31 -0700 (PDT)
MIME-Version: 1.0
From:   =?UTF-8?Q?Henrik_Lindstr=C3=B6m?= <lindstrom515@gmail.com>
Date:   Sat, 30 Sep 2023 18:00:20 +0200
Message-ID: <CAHkKap3sdN4wZm_euAZEyt3XB4bvr6cV-oAMGtrmrm5Z8biZ_Q@mail.gmail.com>
Subject: macvtap performs IP defragmentation, causing MTU problems for virtual machines
To:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

We are trying to receive fragmented multicast traffic on a qemu/kvm VM
using a macvtap NIC (e1000e model).
Even though the traffic is properly fragmented by the sender, it's
never received by the VM.

The reason seems to be that the macvlan driver performs IP
defragmentation for multicast traffic, causing e1001e to drop it for
being too big.
It works fine with a virtio NIC instead of e1000e, but that's not an
option for us.

I found this old thread describing why macvlan does this:
https://lore.kernel.org/netdev/4E8C89EE.3090600@candelatech.com/
Interestingly, the problem described in that thread seems to be more
general than macvlans, and i can still reproduce it by simply having
multiple physical interfaces.
So it looks like macvlans are being special-cased right now, as a
workaround for a more general defragmentation problem?

A fix for our issue is to simply remove the `ip_check_defrag` call
from `macvlan_handle_frame`, but that regresses the other issue..
I'm not sure what a proper fix would look like, but it feels a bit
unexpected that macvtaps would perform IP defragmentation.

Thanks,
Henrik
