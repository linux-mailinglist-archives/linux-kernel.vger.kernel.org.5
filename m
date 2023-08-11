Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A3617795E6
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 19:11:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235926AbjHKRLx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 13:11:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235464AbjHKRLv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 13:11:51 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D49FE19F;
        Fri, 11 Aug 2023 10:11:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1691773907; x=1692378707; i=deller@gmx.de;
 bh=DTvpu55SnrHRDHc9jkNUw++IZViS9L+vW27eRjzRv3Y=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject;
 b=DkOqj9wIEc4UoMBNLrJaRCLSnEP9hUdAx0p0e6/vxxsftXEib1fTHyc3nK+3M4zQqXtJsC8
 0jXOiMJLWVn10CC3qP7LGd4gBfipA9nVQOUJHBAVcjMdIuKCwxb7kYMVaLB/1LARbPMd7p4mo
 2mksPuaJ868WHRj0MV1+9xUYRu+QhJVpU5b8XVeOr2v6+iR00z8o8fk0+KIvDPl8mPcvtkvw4
 GqcBZm1gondfCaVn3Clll1aabirp5Uqi94L1eUmlPbSo8JsQFfZ4nNbUC3pCeq/WpSiL9PXMS
 wiO5EJxC6cVMCKTwe+pdONyhL45WA8PL5vMOw3lkLDQcvuOWqY8w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from p100 ([94.134.154.87]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mg6Zq-1prbsz2frq-00hah5; Fri, 11
 Aug 2023 19:11:47 +0200
Date:   Fri, 11 Aug 2023 19:11:46 +0200
From:   Helge Deller <deller@gmx.de>
To:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Petr Mladek <pmladek@suse.com>
Cc:     linux-parisc@vger.kernel.org
Subject: [PATCH] watchdog: Fix lockdep warning
Message-ID: <ZNZr0mPsIuqKzb5u@p100>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Provags-ID: V03:K1:6lJNnMqR+HtTA3+h9xFX3VvmWhCWQ5tSmahp9ChlB8pyFPiRg4J
 G/PDINIVK7YXKZJal1xhQsETfOKUCF67gf9KRnmRB/SM6G/5KAz7O1cEc7bN8hq8NEn7/HB
 hv/201yF2aUUOEdJBgO7X116vSNgN90Lp80DUBPAX9k4mYDMIoOreRm3iZ1nj5AwS8P/fw3
 dPUYq42DhER3PGmAruCxw==
UI-OutboundReport: notjunk:1;M01:P0:zAPdIIOqjk4=;a1ZkRJ9KR74ZnLdSpmIVeKnkmcw
 FwpuO/LpCXaoYVWIwV834fOllmYwWSnh+CvTBZ7aZZZ9hnN+U+lmHE0FtNFnWferU24T9w3Y/
 jo6TsFMR01i3drLtTBlAwB4XpEAAXXLLrPmIRVLKgWcAw4xThO6vlqLjqUgpuqUKUJ0fmB9Qh
 YyeecdYS8yofwxrf9rrV/3yYGaCfrrAyxwBqcIKhN19D9QkpkjR0GFPZ/P4nmf36ddQ+IXqqX
 zghRcQUuIi9UbKroBAgbKWGXbolpXwrTEU3CPk/GIwDde2N5DZ/Jaw3E30MRK6mOWlxdFHgxe
 fQAEVPYsQQkJAa1Sd3lYU/wV+l4daz6556MqRMYL58zOEE+PajOkyusykByWb/N8CGsjjxcra
 9y5z6x0Q474MruZSLCINoRvgPVKc+nhVGokdoytdwmZa/r4fNFeCe/AVlF7MT/pCXCNjXINLW
 GCof3tjFgW82r1rZvrLMXup6TGlr51TGRYZTKi1lNcsiQIVGbVdLLBxjGDh9xD+qwOJk5JtnN
 nCvAnQDEXKHk+EIkSpDjUUqoxHiEHj+is2nCVYIDxGbp7k3/JQ1X/R8SpND+Z+Px//QeRfc2u
 f3oIqGJKc0924llDt9Yii2o5fMmYBbznb4YllZJoYICt0XoWbzE2gDqeDvR3TKOv3lCe0oG1f
 WuU+9IqUHcrjZeEck09SWc3+MhysyEmrLYiXStZeqy7Hzn2FrrdQT8fS7If6IcIFiNbTCSiIY
 OYb5aR5We4SPMOhdp+vtnBuqgzI7dgiuwprSiS1ZgQHSAQ/o1WgJ8NjL32SjjJ1iF5RyROOWq
 nv+5c28+MvWibtbqI+mulLNZj6fZFn69v30Twa9+nUaJzLmOBGcxJTCbMnE7k5ZcwGxn3TpmZ
 Pflu1q+5T1lso5OQ7v09A/Ygd67ssBeIi645xax0LsJh5ZM86iIjlw45sMgdzkRPr4Nh9UbrC
 +J/BxG8ZAaHEGFtvhnHv6ya65jo=
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fully initialize detector_work work struct to avoid this kernel warning
when lockdep is enabled:

 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
 WARNING: bad unlock balance detected!
 6.5.0-rc5+ #687 Not tainted
 -------------------------------------
 swapper/0/1 is trying to release lock (detector_work) at:
 [<000000004037e554>] __flush_work+0x60/0x658
 but there are no more locks to release!

 other info that might help us debug this:
 no locks held by swapper/0/1.

 stack backtrace:
 CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.5.0-rc5+ #687
 Hardware name: 9000/785/C3700
 Backtrace:
  [<0000000041455d5c>] print_unlock_imbalance_bug.part.0+0x20c/0x230
  [<000000004040d5e8>] lock_release+0x2e8/0x3f8
  [<000000004037e5cc>] __flush_work+0xd8/0x658
  [<000000004037eb7c>] flush_work+0x30/0x60
  [<000000004011f140>] lockup_detector_check+0x54/0x128
  [<0000000040306430>] do_one_initcall+0x9c/0x408
  [<0000000040102d44>] kernel_init_freeable+0x688/0x7f0
  [<000000004146df68>] kernel_init+0x64/0x3a8
  [<0000000040302020>] ret_from_kernel_thread+0x20/0x28

Signed-off-by: Helge Deller <deller@gmx.de>

=2D--

diff --git a/kernel/watchdog.c b/kernel/watchdog.c
index be38276a365f..eab0dfcfa3f9 100644
=2D-- a/kernel/watchdog.c
+++ b/kernel/watchdog.c
@@ -1022,5 +1022,6 @@ void __init lockup_detector_init(void)
 	else
 		allow_lockup_detector_init_retry =3D true;

+	INIT_WORK(&detector_work, lockup_detector_delay_init);
 	lockup_detector_setup();
 }
