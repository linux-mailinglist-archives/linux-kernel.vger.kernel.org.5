Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F00176A219
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 22:41:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229880AbjGaUlc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 16:41:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjGaUla (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 16:41:30 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FC55E75;
        Mon, 31 Jul 2023 13:41:29 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1690836088;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BTxPMB3V133cgzwz17m6DmWwRtesGt+jhqpdIH5ALoQ=;
        b=0G8BQSRxV7478DeJ/esCuK54evV9NQCPC4ID96ymAA03ofm8kvZ4nsCn+DSgeW8XJsJY8W
        zq+UbN2szW1PdZUdeqsbf36Zf7VLeoc4xsqb8PJ+iBS2a0D0IbQO+j1XWWCQrDosRG3Ryi
        IQW4zSl88x4G+daZbw5QVfdTPYrwM9RWEOqrIvQh0cWhcVTsMVZ0lUlJGeNE/chKw4FY9p
        g65UGbWCbjfotggxaInr71hJBvC1Ny43kpiio468+BQwCCC4rTesKnIlouhjuqAFlcP693
        QrvjJtK35uy1mUdxLSDHT3KtzKBMe8hU8Iys9QYd+yqqXpbtMgNCHmo2/8DKCQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1690836088;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BTxPMB3V133cgzwz17m6DmWwRtesGt+jhqpdIH5ALoQ=;
        b=/FhSHnIwquFqCkm7XmxX3HCzSElSAB8dpvKfGEw71LcWF5A9ynlFHoO5mKwt/pnm9jEBod
        QbfR97sGl4l9hnAg==
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
Subject: RE: [patch v2 21/38] x86/cpu: Provide cpu_init/parse_topology()
In-Reply-To: <BYAPR21MB168857E160C70BC76665FE6FD705A@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <20230728105650.565799744@linutronix.de>
 <20230728120930.839913695@linutronix.de>
 <BYAPR21MB16889FD224344B1B28BE22A1D705A@BYAPR21MB1688.namprd21.prod.outlook.com>
 <871qgop8dc.ffs@tglx>
 <BYAPR21MB168857E160C70BC76665FE6FD705A@BYAPR21MB1688.namprd21.prod.outlook.com>
Date:   Mon, 31 Jul 2023 22:41:27 +0200
Message-ID: <87jzufn79k.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 31 2023 at 16:25, Michael Kelley wrote:
> From: Thomas Gleixner <tglx@linutronix.de> Sent: Monday, July 31, 2023 5:35 AM
>> Define bogus. MADT is the primary source of information because that's
>> how we know how many CPUs (APICs) are there and what their APIC ID is
>> which we can use to wake them up. So there is a reasonable expectation
>> that this information is consistent with the rest of the system.
>
> Commit d49597fd3bc7 "x86/cpu: Deal with broken firmware (VMWare/Xen)"
> mentions VMware and XEN implementations that violate the spec.  The
> commit is from late 2016.  Have these bad systems aged out and no longer
> need accommodation?

They do, but this commit explicitely uses the MADT/real APIC ID value:

     c->initial_apicid = apicid;

So the new mechanics are accomodating for those, right?

Thanks,

        tglx
