Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B7BF78DAFD
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 20:39:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235854AbjH3SiO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 14:38:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244173AbjH3MjJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 08:39:09 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48A2CD2
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 05:39:05 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1693399143;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=c/wZWIOJmrDA9CLDQ+WXGMtZeROrW/NzaX+Hro/OBsM=;
        b=j8NCxm9AJCqXq4X7czyaFi+3tWLNqEmvTgBIKPOh8W3eDtNB73kS0D7rY1tfRhCYIAoMtl
        6ZL3mzwU7tPNs9sTCXt/y38BeyBcpcJjwu78Y7Ryh3wg7GASvtgH5iwdLbQ7i3HWvmYfXn
        zbs2qj8EJH0HICFXFY7NFAPYsCHHkmSsNfK0gaIGa+0FV8GsbeCuVO6gB9tJVF5oFH5RYB
        Vqof+qm3f37ju84i7FCWPzYIeazUDRv6gubA1uvDkaTeEqVwZ5Ox9GUflsgVUjanylrpq0
        hm6VjEVO1wuMnujo3RUFMPspSU93ZAaDf+VISVwMb6fKI0QAiPw4NDuDO999cw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1693399143;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=c/wZWIOJmrDA9CLDQ+WXGMtZeROrW/NzaX+Hro/OBsM=;
        b=YnC9itHdH/GCmp67UvtbzV/jbcXTHe/FjcE3jAeq4eJbq0FHPvVZAZhYL86E9Y1tjBI+RK
        TExDHYKzXgRjFQCg==
To:     "Brown, Len" <len.brown@intel.com>,
        "Zhang, Rui" <rui.zhang@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     "Gross, Jurgen" <jgross@suse.com>,
        "mikelley@microsoft.com" <mikelley@microsoft.com>,
        "arjan@linux.intel.com" <arjan@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
        "ray.huang@amd.com" <ray.huang@amd.com>,
        "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
        "Sivanich, Dimitri" <dimitri.sivanich@hpe.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>
Subject: RE: [patch V3 27/40] x86/cpu: Provide a sane leaf 0xb/0x1f parser
In-Reply-To: <MN0PR11MB6010F1D501B9A2C0B7B3D1F6E0E6A@MN0PR11MB6010.namprd11.prod.outlook.com>
References: <20230802101635.459108805@linutronix.de>
 <20230802101934.258937135@linutronix.de>
 <8e5bbbc91ff9f74244efe916a4113999abc52213.camel@intel.com>
 <87350ogh7j.ffs@tglx> <87ttt3f0fu.ffs@tglx>
 <b8637c8c92751f791bf2eae7418977c0fd0c611d.camel@intel.com>
 <87il9hg67i.ffs@tglx>
 <MN0PR11MB6010CB72411BA723BEFC5565E017A@MN0PR11MB6010.namprd11.prod.outlook.com>
 <877cpxioua.ffs@tglx>
 <MN0PR11MB601007E7DAE4C5FC86E58DB0E014A@MN0PR11MB6010.namprd11.prod.outlook.com>
 <87fs4ighln.ffs@tglx>
 <MN0PR11MB6010D09FF7C20779B70A3B83E01BA@MN0PR11MB6010.namprd11.prod.outlook.com>
 <874jksher3.ffs@tglx>
 <MN0PR11MB6010F1D501B9A2C0B7B3D1F6E0E6A@MN0PR11MB6010.namprd11.prod.outlook.com>
Date:   Wed, 30 Aug 2023 14:39:02 +0200
Message-ID: <87r0nk66xl.ffs@tglx>
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

On Wed, Aug 30 2023 at 02:46, Len Brown wrote:
>>    and it's more than obvious that
>>    non-enumerated domain levels occupy _zero_ bits in the APIC ID
>>    partitioning and therefore end up being size _one_.
>
> By "size _one_", do you mean that a non-enumerated level gets a valid
> id, eg. id=0?
>
> That direction would be problematic.
>
> If CPUID.1F doesn't enumerate a module level, then there is NO module level.
> Conjuring up a valid module_id=0 in this scenario is a bug.
>
> For a module level to exist, it must occupy at least 1 bit in the APIC ID.
>
> This is what I failed to impress upon you about die_id erroneously
> following the example of package_id.  Package_id is special.  There is
> always an architectural package, and if no package bits are set in the
> APIC-id, we can still assume package_id=0.
>
> This is not true for the intermediate levels.  If they are not
> enumerated, they DO NOT EXIST.

Again. You are conflating an implementation detail with a conceptual
problem.

Conceptually _all_ levels exist, but the ones which occupy zero bits
have no meaning. Neither have the unknown levels if they should surface
at some point.

So as they _all_ exist the logical consequence is that even those which
occupy zero bits have an ID.

Code which is interested in information which depends on the enumeration
of the level must obviously do:

    if (level_exists(X))
    	analyse_level(X)

Whether you express that via an invalid level ID or via an explicit
check for the level is an implementation detail.

Other code paths can still utilize the resulting ID for comparisons
without checking whether the level exists or not. The validity of such a
comparision is not per se wrong. It depends on what you want to achieve
and in some cases the unconditional comparison just allows you to write
better code because there are enough cases where the only information
required is whether two IDs are matching or not. Such code neither cares
whether there are multiple instances of that level nor does it deduce
that there is level dependent information.

The problem of the current implementation is not that the die ID is
automatically assigned. The problem is at the usage sites which blindly
assume that there must be a meaning. That's a completely different issue
and has absolutely nothing to do with purely mathematical deduced ID
information at any given level.

See?

Thanks,

        tglx




