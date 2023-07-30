Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81A41768438
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jul 2023 09:41:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbjG3HlJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jul 2023 03:41:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjG3HlI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jul 2023 03:41:08 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D0FF198E;
        Sun, 30 Jul 2023 00:41:06 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1690702863;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=W6ewvr0FuRcnzy1sYvOX0rJHbQtOdV3pD/pLGGyIiQY=;
        b=YMgAsJVkeAQ/k4TtYhgWOi9bkYvqOMQ+kYKzry7qopWRF4X47YXCC7Qy6gJ6Lw0qoS1qr2
        4ZgqlN0+3jV60xACrqVd7D8ISrN4s1o2/TjPYF3qDzybxyh61e2rknWIitqwwFi5JUTKzo
        etAcnlyPnyKDp0xgb+QbTITj+PtUIhmNrNKxxviN/GHNGadMn16gv4u7rQMeNHRJ5GBKTu
        3w87BOkmCCGlqAd0RzEKMbVmpWYGrZ5vgOkPruSUW+So8+IFl0W8LHZB6P20xc/rRct+eK
        bWKmGXVuOod52Jdpfg/v7jZ+2uviCEzcKY6NVZFta2xwo4swF7N+rCfzzrw0Mg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1690702863;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=W6ewvr0FuRcnzy1sYvOX0rJHbQtOdV3pD/pLGGyIiQY=;
        b=2+vO3fk74NOeBRY7+OMw/Co/dCVcOzO9c5JkJ7gmQmOGWOF+quzu0L5xhEPS0Z7Bnwsh8L
        bYMtr2WZS8qgvYBQ==
To:     "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     "x86@kernel.org" <x86@kernel.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>,
        James Smart <james.smart@broadcom.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        Jean Delvare <jdelvare@suse.com>,
        Huang Rui <ray.huang@amd.com>, Juergen Gross <jgross@suse.com>,
        Steve Wahl <steve.wahl@hpe.com>,
        Mike Travis <mike.travis@hpe.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Russ Anderson <russ.anderson@hpe.com>
Subject: RE: [patch v2 28/38] x86/cpu: Provide an AMD/HYGON specific
 topology parser
In-Reply-To: <BYAPR21MB16882172252C0C013A0E3B5ED704A@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <20230728105650.565799744@linutronix.de>
 <20230728120931.226185847@linutronix.de>
 <BYAPR21MB16882172252C0C013A0E3B5ED704A@BYAPR21MB1688.namprd21.prod.outlook.com>
Date:   Sun, 30 Jul 2023 09:41:02 +0200
Message-ID: <874jllq229.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 30 2023 at 05:20, Michael Kelley wrote:
> From: Thomas Gleixner <tglx@linutronix.de> Sent: Friday, July 28, 2023 5:13 AM
>> +	/*
>> +	 * If leaf 0xb is available, then SMT shift is set already. If not
>> +	 * take it from ecx.threads_per_cpu and use topo_update_dom() as
>
> "take it from ebx.threads_per_cu and use topology_update_dom() as"
>
>> +	 * topology_set_dom() would propagate and overwrite the already
>> +	 * propagated CORE level.
>> +	 */
>> +	if (!has_0xb) {
>> +		topology_update_dom(tscan, TOPO_SMT_DOMAIN, get_count_order(leaf.threads_per_cu),
>> +				    leaf.threads_per_cu);
>
> leaf.threads_per_cu needs to be (leaf.threads_per_cu + 1) above.  If
> the core has two hyper-threads, the value of the threads_per_cu
> field returned by CPUID is "1".
>
> All my Hyper-V VMs on AMD processors were coming up with only
> one thread per core.   The change fixes the problem.

You are right. Thanks for tracking that down!

    tglx
