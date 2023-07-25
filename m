Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96B90760C48
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 09:46:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232721AbjGYHq1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 03:46:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230428AbjGYHq0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 03:46:26 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 281AF97;
        Tue, 25 Jul 2023 00:46:25 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1690271183;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MwlQeCse0p+PDVAUpXy5OS86DdcWiW2W0yctq9JW4YU=;
        b=UV5iHfgs84Vzben7Ls/EN8AacDD4keKPQa6CkpOHdqYXxXKmW4QbOtGxhQ+RWU740YNYDm
        xoplp+6QwC/iwzLhLxxHFOsdr3Zs61Wcn6s3GQdBooOrQvRUMCIR0arURIqr8ykUoPyFuA
        2fdPYc9hFKn+I0B6tP9P/CAbyTOSEPsiXOJss88yFxmpeVfhF5yZZnJYq3Mr3UFw1zFt5d
        5qxL5SMeIdkjn5l6aQms8LF2buK+HKS+U8KrBMadgTrGH81vmYp7qmtXruuIuQzuzIsUza
        xgjtAx65WpTFajlfmqHTDGEZJ5ib+Xj5yOTxfiIfw7G66ZymwCFZQPJ16qVlkA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1690271183;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MwlQeCse0p+PDVAUpXy5OS86DdcWiW2W0yctq9JW4YU=;
        b=L6pYgAhSdpmx7S0bNGsgkCM3d/UYiFUS7u3Ilt+BnxOEVnP/BmE0LRZHRyAgKEOB1KWeqI
        9EXhBYcSVw8dV+Cg==
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Tom Lendacky <thomas.lendacky@amd.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>,
        James Smart <james.smart@broadcom.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-hwmon@vger.kernel.org,
        Jean Delvare <jdelvare@suse.com>,
        Huang Rui <ray.huang@amd.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Steve Wahl <steve.wahl@hpe.com>,
        Mike Travis <mike.travis@hpe.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Russ Anderson <russ.anderson@hpe.com>
Subject: Re: [patch 01/29] x86/cpu: Encapsulate topology information in
 cpuinfo_x86
In-Reply-To: <20230724172843.757723854@linutronix.de>
References: <20230724155329.474037902@linutronix.de>
 <20230724172843.757723854@linutronix.de>
Date:   Tue, 25 Jul 2023 09:46:23 +0200
Message-ID: <877cqotovk.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 24 2023 at 19:43, Thomas Gleixner wrote:
> +struct cpuinfo_topology {
> +	u16			apicid;
> +	u16			initial_apicid;

There was an offlist question whether these should be u32 because with
X2APIC the APIC ID is 32bit wide.

The answer is yes, no, maybe. Why?

In practice there are limitations, both on the hardware side and on the
kernel side.

The kernel limits the max. APIC ID to 32768 and the maximum number of
CPUs to 8192 right now. Increasing the maximum APIC ID is possible, but
that needs some deep thoughts as we have one array which is
MAX_LOCAL_APIC sized and a bitmap of that size too. Even the bitmap
would require (1 << 32)/8 = 5.36871e+08 B = 512MB of memory. With a limit
of 32768 it's a reasonable 4KB. :)

On the hardware side the topology information is in the APIC ID:

      [PKGID][DIEID]...[COREID][THREADID]

where everything below the PKGID is relative to the package. Right now
the vendors have that space packed, i.e. the number of bits below PKGID
is sized that its the next power of 2 which allows to fit the actual
number of logical processors.

There have been systems where the PKGID shift was larger than that which
caused us to do the logical package mapping because we ended up with
package ID gaps. That was caused by incorrect information in leaf
0xB/0x1F, i.e. the package shift enumerated was smaller than the actual
one.

So with an upper limit of 8192 CPUs the limitation to 32K APIC IDs
should be really sufficient. The largest package shift I've seen so far
is 8, i.e. 256 logical processors per package. That means 32 packages
max. That should be sufficient for a while, right? The HPE/UV people
might have a word to say here though.

So no, u16 is fine, but yes, we can make it u32 just for simplicity
sake, which still does not allow you to have an APIC ID >= 32k, but
makes it easy enough to expand that to e.g. 64K or 128K if the need ever
arises. Let me rework that accordingly.

Thanks,

        tglx
