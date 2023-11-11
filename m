Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FFF07E8987
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Nov 2023 07:32:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229983AbjKKGbY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Nov 2023 01:31:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbjKKGbX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Nov 2023 01:31:23 -0500
Received: from matoro.tk (unknown [IPv6:2600:1700:4b10:9d80::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0F452D55
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 22:31:02 -0800 (PST)
DKIM-Signature: a=rsa-sha256; bh=sxu1IVgQ+VBFrVH8VLRgdW/Gi26Ib4onxRrbpdknMAM=;
 c=relaxed/relaxed; d=matoro.tk;
 h=Subject:Subject:Sender:To:To:Cc:From:From:Date:Date:MIME-Version:MIME-Version:Content-Type:Content-Type:Content-Transfer-Encoding:Content-Transfer-Encoding:Reply-To:In-Reply-To:Message-Id:Message-Id:References:Autocrypt:Openpgp;
 i=@matoro.tk; s=20230917; t=1699684261; v=1; x=1700116261;
 b=JUFxI09wydSe3RlvkBcZVl9GEglVshTI+Qm/IjXvB6cyQ9hKyy2MQshDCFsvMlRT49xm/F/D
 E2b6bSPf50VM4XBguSYbt92R+nk2diTMkhhCWaAYJMJIiU1vobeQNR56XB63SCFvuNQ3p+FTozg
 QlVyeVFe4oW9PGUyTcpTlm2fHpDEjvT9efOiDghbGN4ISed/MCfM5ep+1J9WB3jzgqJqcJ3RM8S
 PWAl8ajO8k65g+AV0Z35/KadmopCS2+Sm7Gu+ghmovidZgOTF7q5Ihb4j5LiBWxKkFuw3HaTB1s
 M7biTcQUllnDcCh8k168soIhqQiysQaTK8o/Xl6HjVb+K2wfjv8PV8pjKvoC+hppwNyuXREoagS
 +O22vC8LBudJbBDdd5h0vZntKO9mfAxcljMByg0ZpF9AcIImFARxO2S31FJU7GfYAAM3+VmYmX8
 GeAT0I1tqdx6GjSgrMsvwHe50UM447HA0pmoOlvA2ju3z5gdl66AFuORxIlqi3fnGnd05xZD1PK
 MrkkQ0WerwMTaNxue15MaLkgBvd7ZZiH2tXY6ZuJV2AE7oc99K3Ou+GRgDp+U6AeWQPpYwaiBFM
 2z1eqn8AGtc8pELo7hvlpQ2ZZF3bDO/I4vdqaxdMJ+EEmfVdaWT1cpo/9wDUw2oZYF6ABOAnzoj
 hrV8PiCBfCA=
Received: by matoro.tk (envelope-sender
 <matoro_mailinglist_kernel@matoro.tk>) with ESMTPS id d1971dad; Sat, 11 Nov
 2023 01:31:01 -0500
MIME-Version: 1.0
Date:   Sat, 11 Nov 2023 01:31:01 -0500
From:   matoro <matoro_mailinglist_kernel@matoro.tk>
To:     linux-parisc@vger.kernel.org, deller@gmx.de,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sam James <sam@gentoo.org>
Subject: Bisected stability regression in 6.6
Message-ID: <75318812c588816e0c741b4cd094524f@matoro.tk>
X-Sender: matoro_mailinglist_kernel@matoro.tk
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Helge, I have bisected a regression in 6.6 which is causing userspace 
segfaults at a significantly increased rate in kernel 6.6.  There seems to be 
a pathological case triggered by the ninja build tool.  The test case I have 
been using is cmake with ninja backend to attempt to build the nghttp2 
package.  In 6.6, this segfaults, not at the same location every time, but 
with enough reliability that I was able to use it as a bisection regression 
case, including immediately after a reboot.  In the kernel log, these show up 
as "trap #15: Data TLB miss fault" messages.  Now these messages can and do 
show up in 6.5 causing segfaults, but never immediately after a reboot and 
infrequently enough that the system is stable.  With kernel 6.6 I am 
completely unable to build nghttp2 under any circumstances.

I have bisected this down to the following commit:

$ git bisect good
3033cd4307681c60db6d08f398a64484b36e0b0f is the first bad commit
commit 3033cd4307681c60db6d08f398a64484b36e0b0f
Author: Helge Deller <deller@gmx.de>
Date:   Sat Aug 19 00:53:28 2023 +0200

     parisc: Use generic mmap top-down layout and brk randomization

     parisc uses a top-down layout by default that exactly fits the generic
     functions, so get rid of arch specific code and use the generic version
     by selecting ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT.

     Note that on parisc the stack always grows up and a "unlimited stack"
     simply means that the value as defined in 
CONFIG_STACK_MAX_DEFAULT_SIZE_MB
     should be used. So RLIM_INFINITY is not an indicator to use the legacy
     memory layout.

     Signed-off-by: Helge Deller <deller@gmx.de>

  arch/parisc/Kconfig             | 17 +++++++++++++
  arch/parisc/kernel/process.c    | 14 -----------
  arch/parisc/kernel/sys_parisc.c | 54 
+----------------------------------------
  mm/util.c                       |  5 +++-
  4 files changed, 22 insertions(+), 68 deletions(-)

I have tried applying ad4aa06e1d92b06ed56c7240252927bd60632efe ("parisc: Add 
nop instructions after TLB inserts") on top of 6.6, but it does NOT fix the 
issue.

Let me know if there is anything I can answer on this.  I can provide full 
remote access with BMC if it would help.
