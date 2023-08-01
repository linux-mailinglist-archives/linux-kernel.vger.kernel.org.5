Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A330276AA14
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 09:34:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231826AbjHAHee (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 03:34:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229874AbjHAHeb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 03:34:31 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87F621726;
        Tue,  1 Aug 2023 00:34:30 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1690875269;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=barXOaLcqK7APgvHwy35ku+WMnw5Wwq/VfYIfSWf/UY=;
        b=hEXIhvWX+SuOx+KXfj/eqYjjEpgeZC4/n4Fpc/+IPsWHJo3nZ6MKdzXczrybyV8tQBtooe
        VVaNN67MBFQCF0aiH6KQzuyQnp/lhhw9ZkSdf06j8tJZj2R7yLT+tPeb3Fwb9QbL/NzBgj
        YnD85mc3xW6FWzlUgi7eP9rMu6/TFbWK9VuFTfYpryPyysxPyWP7yG62gbAiBVJTgAhZdr
        CuKTEHkwhx+rx2ARNXZBpcL3ST26HbKV3DrALaFngofEqhvTY1FpRtE9P+F+2ed64fWwu1
        H14cm5T8BEl7nYJpOtRbmz1j7qXTT6XST7kB3zcIsI4VqKoKnD0t8pOs8qqdHA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1690875269;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=barXOaLcqK7APgvHwy35ku+WMnw5Wwq/VfYIfSWf/UY=;
        b=bBpIEnmh2rLafh4mQOd9MkQxRwNZaxEQ5WNI+LrjQHqzYeh3P+07vsAYLsfNrnGS0ptJVY
        Kafs3z+qoUp5LfDA==
To:     "Gautham R. Shenoy" <gautham.shenoy@amd.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>,
        James Smart <james.smart@broadcom.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        linux-hwmon@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        Huang Rui <ray.huang@amd.com>, Juergen Gross <jgross@suse.com>,
        Steve Wahl <steve.wahl@hpe.com>,
        Mike Travis <mike.travis@hpe.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Russ Anderson <russ.anderson@hpe.com>
Subject: Re: [patch v2 21/38] x86/cpu: Provide cpu_init/parse_topology()
In-Reply-To: <ZMiu1t8blYAdm2Br@BLR-5CG11610CF.amd.com>
References: <20230728105650.565799744@linutronix.de>
 <20230728120930.839913695@linutronix.de>
 <ZMiu1t8blYAdm2Br@BLR-5CG11610CF.amd.com>
Date:   Tue, 01 Aug 2023 09:34:28 +0200
Message-ID: <87leevkygr.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 01 2023 at 12:35, Gautham R. Shenoy wrote:
> On Fri, Jul 28, 2023 at 02:13:08PM +0200, Thomas Gleixner wrote:
>> +static void topo_set_ids(struct topo_scan *tscan)
>> +{
>> +	struct cpuinfo_x86 *c = tscan->c;
>> +	u32 apicid = c->topo.apicid;
>> +
>> +	c->topo.pkg_id = topo_shift_apicid(apicid, TOPO_ROOT_DOMAIN);
>
> Shouldn't this use TOPO_PKG_DOMAIN instead of TOPO_ROOT_DOMAIN ?

Yup. It does not make a difference in that case. That's why I didn't
notice, but let me fix this for conistency sake.

