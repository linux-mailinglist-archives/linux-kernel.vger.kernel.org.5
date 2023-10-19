Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C8C67D04E9
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 00:35:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346666AbjJSWfR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 18:35:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235549AbjJSWfP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 18:35:15 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE441124
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 15:35:13 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-53e84912038so189359a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 15:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1697754912; x=1698359712; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6L6sBoVhtv+gisMW9vrcDKOjCxepeY7VRUU0FAAL42c=;
        b=EhCfFpyEpKRg9lDWjoX55C9LCtMdInS280r1So6+Owc2vxXYpxOYNTT9egQA3sqz/C
         EIeA2nFS25MKMJfaG33Qk2W2NSurFXUrgr9cQCj37SBeNdGnUDB5pZbNICa0yka1FF/o
         V8sBJuZ7UBcNzs55L34D5T+7KP4314RJQoyhcfqmJib5d3gPjPOGNIMGDFEtlRRT9bSC
         4+Dd3IBVUC+5QQwCWju8A6IEkQJa9PWjM5PoWGxtkmna6uCUKiM7P35+ILf9A3COnzfN
         nGnBbMpaQ06ecEW0nZI1112tGCtGXRlWImr9zVNmcQ3ahrGwnOsCI5UOrBf5qubtuab+
         EkSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697754912; x=1698359712;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6L6sBoVhtv+gisMW9vrcDKOjCxepeY7VRUU0FAAL42c=;
        b=J9FnW4PAmTtpX610/pB8xm5P2DF85amJpGlZJ1Ci/Yb3qpsDeRJroGfoA6am3ErANN
         vfMHe3NHL3rhQ2zK2fdHebclF1oQXF3NCTagU5LH/Zq94RhbedmHRtS7MxbhMDqi0tr0
         DhOMsE03j0TvsXaEh7FbeQp7PogqgN/TD8dQ3ZN7oFREemznv31UnfmmzE1Qho7Me88e
         3kQz4wF6uMuOuhrLnTfXLTlN+tUa0Cl2ijhhCHNG99IxyAvPtahKqUDecG/zLHd4a6Vb
         5+RYZbCLKi16Gmre95DiP6Si8QZgFHM93ThS9cAcq7fCYTnxjedcojdLxm0pGoQYT0E/
         JnhA==
X-Gm-Message-State: AOJu0Ywk335F/rXeKp+rKbqTitzLOGGaMwPb7E9JP4eT4+8Oap7KEvn/
        DYBg4IxUTQaXe/Tltozjlta+fKHOQ80bl3CL3ZXM4Q==
X-Google-Smtp-Source: AGHT+IEdZWTAYH0vwqrtaMnk4W8FAL+z9O+h9gExED1hdEcOGaiC47Rzcdn3qAXdh6CsA0N91h0Rwho1lcLBdMf9jvs=
X-Received: by 2002:a50:cd1b:0:b0:530:a186:f8a8 with SMTP id
 z27-20020a50cd1b000000b00530a186f8a8mr190751edi.37.1697754912395; Thu, 19 Oct
 2023 15:35:12 -0700 (PDT)
MIME-Version: 1.0
From:   Ivan Babrou <ivan@cloudflare.com>
Date:   Thu, 19 Oct 2023 15:35:01 -0700
Message-ID: <CABWYdi1kiu1g1mAq6DpQWczg78tMzaVFnytNMemZATFHqYSqYw@mail.gmail.com>
Subject: wait_for_unix_gc can cause CPU overload for well behaved programs
To:     Linux Kernel Network Developers <netdev@vger.kernel.org>
Cc:     kernel-team <kernel-team@cloudflare.com>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

We have observed this issue twice (2019 and 2023): a well behaved
service that doesn't pass any file descriptors around starts to spend
a ton of CPU time in wait_for_unix_gc.

The cause of this is that the unix send path unconditionally calls
wait_for_unix_gc, which is a global garbage collection. If any
misbehaved program exists on a system, it can force extra work for
well behaved programs.

This behavior is not new: 9915672d4127 ("af_unix: limit
unix_tot_inflight") is from 2010.

I managed to come up with a repro for this behavior:

* https://gist.github.com/bobrik/82e5722261920c9f23d9402b88a0bb27

It also includes a flamegraph illustrating the issue. It's all in one
program for convenience, but in reality the offender not picking up
SCM_RIGHTS messages and the suffering program just minding its own
business are separate.

It is also non-trivial to find the offender when this happens as it
can be completely idle while wrecking havoc for the rest of the
system.

I don't think it's fair to penalize every unix_stream_sendmsg like
this. The 16k threshold also doesn't feel very flexible, surely
computers are bigger these days and can handle more.
