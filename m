Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B80EA7E12D8
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Nov 2023 10:40:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbjKEJkM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Nov 2023 04:40:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjKEJkL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Nov 2023 04:40:11 -0500
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E292DB7;
        Sun,  5 Nov 2023 01:40:06 -0800 (PST)
Received: from [192.168.1.123] (ip5b4280bd.dynamic.kabel-deutschland.de [91.66.128.189])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: buczek)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 0A99461E5FE03;
        Sun,  5 Nov 2023 10:40:03 +0100 (CET)
Message-ID: <77184fcc-46ab-4d69-b163-368264fa49f7@molgen.mpg.de>
Date:   Sun, 5 Nov 2023 10:40:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From:   Donald Buczek <buczek@molgen.mpg.de>
Subject: Heisenbug: I/O freeze can be resolved by cat $task/cmdline of
 unrelated process
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, experts,

we have a strange new problem on a backup server (high metadata I/O 24/7, xfs -> mdraid). The system worked for years and with v5.15.86 for 8 month. Then we've updated to 6.1.52 and after a few hours it froze: No more I/O activity to one of its filesystems, processes trying to access it blocked until we reboot.

Of course, at first we blamed the kernel as this happened after an upgrade. But after several experiments with different kernel versions, we've returned to the v5.15.86 kernel we used before, but still experienced the problem. Then we suspected, that a microcode update (for AMD EPYC 7261), which happened as a side effect of the first reboot, might be the culprit and removed it. That didn't fix it either. For all I can say, all software is back to the state which worked before.

Now the strange part: What we usually do, when we have a situation like this, is that we run a script which takes several procfs and sysfs information which happened to be useful in the past. It was soon discovered, that just running this script unblocks the system. I/O continues as if nothing ever happened. Then we singled-stepped the operations of the script to find out, what action exactly gets the system to resume. It is this part:

     for task in /proc/*/task/*; do
         echo  "# # $task: $(cat $task/comm) : $(cat $task/cmdline | xargs -0 echo)"
         cmd cat $task/stack
     done

which can further be reduced to

     for task in /proc/*/task/*; do echo $task $(cat $task/cmdline | xargs -0 echo); done

This is absolutely reproducible. Above line unblocks the system reliably.

Another remarkable thing: We've modified above code to do the processes slowly one by one and checking after each step if I/O resumed. And each time we've tested that, it was one of the 64 nfsd processes (but not the very first one tried). While the systems exports filesystems, we have absolutely no reason to assume, that any client actually tries to access this nfs server. Additionally, when the full script is run, the stack traces show all nfsd tasks in their normal idle state ( [<0>] svc_recv+0x7bd/0x8d0 [sunrpc] ).

Does anybody have an idea, how a `cat /proc/PID/cmdline` on a specific assumed-to-be-idle nfsd thread could have such an "healing" effect?

I'm well aware, that, for example, a hardware problem might result in just anything and that the question might not be answerable at all. If so: please excuse the noise.

Thanks
Donald
-- 
Donald Buczek
buczek@molgen.mpg.de
Tel: +49 30 8413 1433
