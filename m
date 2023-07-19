Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0C007598DD
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 16:54:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230164AbjGSOyc convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 19 Jul 2023 10:54:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231342AbjGSOyD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 10:54:03 -0400
Received: from 6.mo575.mail-out.ovh.net (6.mo575.mail-out.ovh.net [46.105.63.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92AFF1722
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 07:54:01 -0700 (PDT)
Received: from director8.ghost.mail-out.ovh.net (unknown [10.108.1.240])
        by mo575.mail-out.ovh.net (Postfix) with ESMTP id 3EBA92701E
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 14:46:00 +0000 (UTC)
Received: from ghost-submission-6684bf9d7b-vmrfz (unknown [10.110.171.117])
        by director8.ghost.mail-out.ovh.net (Postfix) with ESMTPS id 12A6A1FD18;
        Wed, 19 Jul 2023 14:45:58 +0000 (UTC)
Received: from courmont.net ([37.59.142.106])
        by ghost-submission-6684bf9d7b-vmrfz with ESMTPSA
        id hQaDOib3t2TqZgAAVw4Xwg
        (envelope-from <remi@remlab.net>); Wed, 19 Jul 2023 14:45:58 +0000
Authentication-Results: garm.ovh; auth=pass (GARM-106R006f1f5ee59-9d59-4f77-aa40-2a724a7ea83b,
                    EAC8E2D8683B439879DFB44EAE753B92CD951686) smtp.auth=postmaster@courmont.net
X-OVh-ClientIp: 87.92.194.88
From:   =?ISO-8859-1?Q?R=E9mi?= Denis-Courmont <remi@remlab.net>
To:     Atish Patra <atishp@atishpatra.org>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Aurelien Jarno <aurelien@aurel32.net>,
        Mathieu Malaterre <malat@debian.org>,
        Jan Newger <jannewger@google.com>
Subject: Re: [PATCH v4 00/10] riscv: Allow userspace to directly access perf counters
Date:   Wed, 19 Jul 2023 17:45:57 +0300
Message-ID: <5951331.lOV4Wx5bFT@basile.remlab.net>
Organization: Remlab
In-Reply-To: <CAOnJCU+W9u+HnMfjU_y9W7331Zx07eQs9R1twV0=KsBAeSMSjw@mail.gmail.com>
References: <20230703124647.215952-1-alexghiti@rivosinc.com>
 <8756384.Zvl9fuB8X0@basile.remlab.net>
 <CAOnJCU+W9u+HnMfjU_y9W7331Zx07eQs9R1twV0=KsBAeSMSjw@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="UTF-8"
X-Ovh-Tracer-Id: 17809484729600317882
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedviedrgeekgdeigecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfhojghfggfgtgesthhqredttddtjeenucfhrhhomheptformhhiucffvghnihhsqdevohhurhhmohhnthcuoehrvghmihesrhgvmhhlrggsrdhnvghtqeenucggtffrrghtthgvrhhnpeeuhfegfeefvdefueetleefffduuedvjeefheduueekieeltdetueetueeugfevffenucffohhmrghinheprhgvmhhlrggsrdhnvghtnecukfhppeduvdejrddtrddtrddupdekjedrledvrdduleegrdekkedpfeejrdehledrudegvddruddtieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduvdejrddtrddtrddupdhmrghilhhfrhhomhepoehrvghmihesrhgvmhhlrggsrdhnvghtqedpnhgspghrtghpthhtohepuddprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdpoffvtefjohhsthepmhhoheejhedpmhhouggvpehsmhhtphhouhht
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le keskiviikkona 19. heinäkuuta 2023, 1.48.49 EEST Atish Patra a écrit :
> > Isn't RDTIM susceptible to interference from power management and CPU
> > frequency scaling? I suppose that RDCYCLE may behave differently depending
> > on PM in *some* designs, but that would still be way better than RDTIME
> > for the purpose.
> 
> Yes. But that's what it is probably using for other ISAs ?

At least on AArch64, it is using either Linux perf cycle counter, or if that 
is disabled at build time, the raw PMU cycle counter - which obviously leads 
to SIGILL on Linux, just like this MR would do with RDCYCLE.

Again, I do not *personally* have objections to disabling RDCYCLE for 
userspace (somebody else does, but that's neither my nor your problem). I do 
have objections to the wording of some of the commit messages though.

> My point was it should just do whatever it does for other ISA. RISC-V is no
> special in that regard.

Sure. My point is that RDTIME may be great for, so to say, system-level 
benchmarks. For FFmpeg that could something like how long it takes to 
transcode a video. But it doesn't seem to make much sense for 
microbenchmarking of single threaded tightly optimised loops, as opposed to 
RDCYCLE (or a wrapper for RDCYCLE).

-- 
Rémi Denis-Courmont
http://www.remlab.net/



