Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FACC772CB0
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 19:21:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232206AbjHGRVg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 13:21:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232204AbjHGRVb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 13:21:31 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B314B1BDB
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 10:21:13 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691428871;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EGavXVkZHM+ciWEQ9GZ5bosY1IzlScV64OLDHKwGObs=;
        b=oaR+3yfRRkm28GpOnuBeWj0ivjistFqiLg5vIOSxiuYkp6riIPUk/xbhfES+lOl3Mu4FWg
        xHuLDo9yImGjiyTWl1N1PovKatfD+Ih3nej1JjqCoE6PA1RRBrMC55WvYx7/IHGaP/aTth
        hvVNCC4hS0fOlZYbn+6XemV3M6qLyIL+d0JGB943MQRudF4QJKxez/3sPeWXhzhfDqh+iP
        4x6CnxIpWm1DfS/LfboJlQw9p+BWTLvvcgwggIhI1gdNQZkye3C5HyLn1Rr//5/WtXsBvt
        v+PslSjRaPvsg/YQPKsH35DbDOsEFV+28siKlsgild3GaqCATw/ilwoBD1WAbw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691428871;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EGavXVkZHM+ciWEQ9GZ5bosY1IzlScV64OLDHKwGObs=;
        b=wnb++WmR/vjUKbzClexVP1ToMtCqbscGLMjxzf3UDaO4DtEwaCaPWuP+iLVYiQrjwXQBcj
        UXR4iu3utMlmEDBQ==
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Huang Rui <ray.huang@amd.com>, Juergen Gross <jgross@suse.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Sohil Mehta <sohil.mehta@intel.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Zhang Rui <rui.zhang@intel.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Feng Tang <feng.tang@intel.com>,
        Andy Shevchenko <andy@infradead.org>
Subject: Re: [patch 09/53] x86/mpparse: Rename default_find_smp_config()
In-Reply-To: <CAHp75VcR4KhhCidjjHG9d4Q65P4vbW3L-Mvkbr6Ar0FoJ=aQDQ@mail.gmail.com>
References: <20230807130108.853357011@linutronix.de>
 <20230807135026.906384570@linutronix.de>
 <CAHp75VcR4KhhCidjjHG9d4Q65P4vbW3L-Mvkbr6Ar0FoJ=aQDQ@mail.gmail.com>
Date:   Mon, 07 Aug 2023 19:21:10 +0200
Message-ID: <87wmy6u5tl.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 07 2023 at 19:03, Andy Shevchenko wrote:
> On Mon, Aug 7, 2023 at 4:52=E2=80=AFPM Thomas Gleixner <tglx@linutronix.d=
e> wrote:
>>
>> MPTABLE is not longer the default SMP configuration mechanism.
>
> not --> no
>
>> Rename it to mpparse_find_mptable() because that's what it does.
>
> ...
>
>> -#define enable_update_mptable 0
>
>> +#define enable_update_mptable  (0)
>
> Hmm.. What's the point of this change?

Good question. Definitely not intentional.
