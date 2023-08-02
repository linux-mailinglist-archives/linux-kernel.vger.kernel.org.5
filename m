Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0390176D81F
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 21:46:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230456AbjHBTqI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 15:46:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229795AbjHBTqG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 15:46:06 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6956410F0
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 12:46:03 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691005561;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LqRS2EoJDS/Y5wZ3dMpBQqJAz+N+iM1he8g2Rl97x6E=;
        b=eGPgzloOBUjeCaGEElOtd9yk9JUGpn9qjd3HOOBPgW6UBxTozgXWN2NN5OypjZKweW893E
        6zWFchwgR86qRdDlVf9v6ZOk2+r70dXbntbHedL5dRjote3GnlEtW4o1MAVM+qM5t4mf42
        ENfpV5v/DXL0OzUMsbQRRxUkI/SzN2hPkySeqxvhud4d8G5lohhN6131FzJRwMHKKGCJ1K
        aM8X835PJDwsYNsCybdph3Md16Riyg+IcpH2/k0Y+5ascy+QzA+rbXlK1GmpzslxMzsp+P
        ruBWVQfX4L2rXQtFt2rasTSZpGa5oCv5ip6DgPo7oS0p6pp1H/cMZrcZXlOvgA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691005561;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LqRS2EoJDS/Y5wZ3dMpBQqJAz+N+iM1he8g2Rl97x6E=;
        b=17RQAuzBXu319hmSm+0O57NQLnJdAtm6ImqKo7rAyIxsyvv5cefU/39nEcsO7dixAiAFv0
        06/UjgZrk+O95RBw==
To:     "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     "x86@kernel.org" <x86@kernel.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Huang Rui <ray.huang@amd.com>, Juergen Gross <jgross@suse.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Wei Liu <wei.liu@kernel.org>
Subject: RE: [patch V3 30/40] x86/cpu: Provide an AMD/HYGON specific
 topology parser
In-Reply-To: <BYAPR21MB1688C2B1723ADDA1640F956AD70BA@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <20230802101635.459108805@linutronix.de>
 <20230802101934.418143974@linutronix.de>
 <BYAPR21MB1688C2B1723ADDA1640F956AD70BA@BYAPR21MB1688.namprd21.prod.outlook.com>
Date:   Wed, 02 Aug 2023 21:46:00 +0200
Message-ID: <87leetjkhz.ffs@tglx>
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

On Wed, Aug 02 2023 at 19:28, Michael Kelley (LINUX) wrote:
> From: Thomas Gleixner <tglx@linutronix.de> Sent: Wednesday, August 2, 2023 3:22 AM
>> +	/*
>> +	 * If leaf 0xb is available, then SMT shift is set already. If not
>> +	 * take it from ecx.threads_per_cu and use topo_update_dom() -
>> +	 * topology_set_dom() would propagate and overwrite the already
>> +	 * propagated CORE level.
>> +	 */
>> +	if (!has_0xb) {
>> +		topology_update_dom(tscan, TOPO_SMT_DOMAIN, get_count_order(leaf.threads_per_cu),
>> +				    leaf.threads_per_cu + 1);
>
> Isn't the +1 also needed on the argument to get_count_order()?
> I haven't actually run the config, but if hyper-threading is disabled,
> presumably threads_per_cu is 0, and get_count_order returns -1.

Bah. I'm sure that I wanted to do that. No idea how I forgot about it
again.

