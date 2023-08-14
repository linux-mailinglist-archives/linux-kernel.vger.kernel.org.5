Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B49577B89A
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 14:27:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230009AbjHNM12 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 08:27:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229880AbjHNM1A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 08:27:00 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABF8E106
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 05:26:59 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1692016017;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jfreRQ522pdV/rOivYbUvBnEZFjhWY0KAvCKUzm4bRE=;
        b=yT8z+UOWTvXxNdMnSeOfO6B4L/zkbwump1+rHXCuMfOA1i8oB3hu8b5Ll8LpluRPG/T8c7
        fhMNyQposcG9rqNxFu45TI8mmO4HPYwmaUH7WFv6O3nlKAH/vazJwjyZF0f6Sb+t2fMrcS
        w1T7DUSWOgu9vaI7TmtN5iEdxSQtbVVVhOLrrOdv1AFKIHiW0xAX8716vAxfX5ORca9BY7
        B+jH13kDlLBYN4Uli3VfRGTpPlYfmUb3TSbQnunGP5qXLVaeRofbgqvXefBAcWbT0A9d8L
        eWj3Q+yxSZald11oA4Jzc8pQnV5766zMRh3orV72tt+2tkN2fhnxkKuL3bpYOA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1692016017;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jfreRQ522pdV/rOivYbUvBnEZFjhWY0KAvCKUzm4bRE=;
        b=69kpX8iuKD3F5oK/ym9OmOTvJjixFH0nwaVa1lvmr2y7RC3FVMjxsUPa0MabqdS8RjrdG8
        0w8Z2hxADunW0YAA==
To:     "Zhang, Rui" <rui.zhang@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     "Brown, Len" <len.brown@intel.com>,
        "Gross, Jurgen" <jgross@suse.com>,
        "mikelley@microsoft.com" <mikelley@microsoft.com>,
        "arjan@linux.intel.com" <arjan@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
        "ray.huang@amd.com" <ray.huang@amd.com>,
        "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
        "Sivanich, Dimitri" <dimitri.sivanich@hpe.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>
Subject: Re: [patch V3 27/40] x86/cpu: Provide a sane leaf 0xb/0x1f parser
In-Reply-To: <b8637c8c92751f791bf2eae7418977c0fd0c611d.camel@intel.com>
References: <20230802101635.459108805@linutronix.de>
 <20230802101934.258937135@linutronix.de>
 <8e5bbbc91ff9f74244efe916a4113999abc52213.camel@intel.com>
 <87350ogh7j.ffs@tglx> <87ttt3f0fu.ffs@tglx>
 <b8637c8c92751f791bf2eae7418977c0fd0c611d.camel@intel.com>
Date:   Mon, 14 Aug 2023 14:26:57 +0200
Message-ID: <87il9hg67i.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Sun, 2023-08-13 at 17:04 +0200, Thomas Gleixner wrote:
>
> With this, we set dom_offset[DIE] to 7 first when parsing TILE, and
> then overwrite it to 8 when parsing UBER_TILE, and set
> dom_offset[PACKAGE] to 9 when parsinig DIE.
>
> lossing TILE.eax.shifts is okay, because it is for UBER_TILE id.

No. That's just wrong. TILE is defined and potentially used in the
kernel. How can you rightfully assume that UBER TILE is a valid
substitution? You can't.

> Currently, die topology information is mandatory in Linux, we cannot
> make it right without patching enum topo_types/enum
> x86_topology_domains/topo_domain_map (which in fact tells the
> relationship between DIE and FOO).

You cannot just nilly willy assume at which domain level FOO sits. Look
at your example:

> Say, we have new level FOO, and the CPUID is like this
> level	type		eax.shifts
> 0	SMT		1
> 1	CORE		5
> 2	FOO		8

FOO can be anything between CORE and PKG, so you cannot tell what it
means.

Simply heuristics _cannot_ be correct by definition. So why trying to
come up with them just because?

What's the problem you are trying to solve? Some real world issue or
some academic though experiment which might never become a real problem?

Thanks,

        tglx



