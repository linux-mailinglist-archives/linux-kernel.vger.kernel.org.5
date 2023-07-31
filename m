Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F03976979A
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 15:28:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232693AbjGaN20 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 09:28:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233000AbjGaN2D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 09:28:03 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5FD4171F;
        Mon, 31 Jul 2023 06:27:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=z3FGDGVTFrElSVM7fG1oVI/2ZdLRjgqGQNhHfwty3ro=; b=gT1/elGv8pRKZcUAdG87anzivd
        bQYyicftn/s4ecFExe79VFyXXKm4PsJXltInnPUVRyGqMwTQ5IqeaWlri5k9m69YCNyncH6jcww5b
        0pavFKpPHmrYlleE9z4EDEBH1CsBhFD2t1pneT8PYLnICc5sGq3LnOjG3uuDRBK159PCKsg/vkBMo
        68hYTVV+3ZXkOGHemrthHSfQXmpNG93pwA+tsAQi7uJFAZYtmhkOvyJXYxZy7BRyewjSXTSmcUf4N
        F4yFzoc4Ag4BpxLQW3b4n+w+OMxW0RbfqdbNTXOoWnagtjDMHfTiPS9aoJz8QFwzVk/tA8rR+s4Xo
        3f+UcpXg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qQSvb-00CjRi-2p;
        Mon, 31 Jul 2023 13:27:16 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id CD30C3001DD;
        Mon, 31 Jul 2023 15:27:14 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id BB3622058B54B; Mon, 31 Jul 2023 15:27:14 +0200 (CEST)
Date:   Mon, 31 Jul 2023 15:27:14 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
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
Subject: Re: [patch v2 21/38] x86/cpu: Provide cpu_init/parse_topology()
Message-ID: <20230731132714.GH29590@hirez.programming.kicks-ass.net>
References: <20230728105650.565799744@linutronix.de>
 <20230728120930.839913695@linutronix.de>
 <BYAPR21MB16889FD224344B1B28BE22A1D705A@BYAPR21MB1688.namprd21.prod.outlook.com>
 <871qgop8dc.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <871qgop8dc.ffs@tglx>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 31, 2023 at 02:34:39PM +0200, Thomas Gleixner wrote:

> This collides massively with the other work I'm doing, which uses the
> MADT provided information to actually evaluate various topology related
> things upfront and later during bringup. Thats badly needed because lots
> of todays infrastructure is based on heuristics and guesswork.
> 
> But it seems I wasted a month on reworking all of this just to be
> stopped cold in the tracks by completely undocumented and unnecessary
> hyper-v abuse.
> 
> So if Hyper-V insists on abusing the initial APIC ID as read from CPUID
> for topology information related to L3, then hyper-v should override the
> cache topology mechanism and not impose this insanity on the basic
> topology evaluation infrastructure.

So I'm very tempted to suggest you continue with the topology rewrite
and let Hyper-V keep the pieces. They're very clearly violating the SDM.

Thing as they stand are untenable, the whole topology thing as it exists
today is an untenable shitshow.

Michael, is there anything you can do early (as in MADT parse early) to
fix up the APIC-IDs?
