Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E5AF77BEAC
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 19:12:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbjHNRMP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 13:12:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230112AbjHNRMJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 13:12:09 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CB0D10F
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 10:12:08 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1692033126;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IPu7inolqtI1q6OEIIr6rwE4HWAEJRXOPK5OU87TuH0=;
        b=vNoQmix+jy8t7rV+ogQjlqECUPQIQe/eMMaYIESht6USUlj8dork2QOvYV5eKKswec4m7x
        kchYvd1uhrfO4ZlxAD6vJACjhbigyBML4MyItnQDsfn49i0z2MWRFnpWCbrflL4XXEs/DH
        zPS+eRXYiLE3kKIwTj4M03PsFTryTRVfeKzXB6k4iulQemu2535rgByguSqJFzfXPHM5i6
        8rqCwRjZPQbIY5J1q5w9MAEE0cN9gq++3oKj0gUHGBdblC6cMq/usUOp5i2Bu8K1sPimBj
        3s8oFqnoG4JtAk0z/AaHhbYyXUhS+lkB5Az2BWTguDv3YM1lYtj38ns+mwGqGA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1692033126;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IPu7inolqtI1q6OEIIr6rwE4HWAEJRXOPK5OU87TuH0=;
        b=Gh5mZ/m2IhCqY/48cFEvl4dxCCkXeRVwfYzB3PDtC2Oj2YnAh0WZb+VnGyk4MYyeQbPZlT
        iHelpYukn9IIL9Ag==
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
In-Reply-To: <265f4f8a3eceebd1acef4c8a9ff99a6d78a0126d.camel@intel.com>
References: <20230802101635.459108805@linutronix.de>
 <20230802101934.258937135@linutronix.de>
 <8e5bbbc91ff9f74244efe916a4113999abc52213.camel@intel.com>
 <87350ogh7j.ffs@tglx> <87ttt3f0fu.ffs@tglx>
 <b8637c8c92751f791bf2eae7418977c0fd0c611d.camel@intel.com>
 <87il9hg67i.ffs@tglx>
 <265f4f8a3eceebd1acef4c8a9ff99a6d78a0126d.camel@intel.com>
Date:   Mon, 14 Aug 2023 19:12:05 +0200
Message-ID: <874jl1im56.ffs@tglx>
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

On Mon, Aug 14 2023 at 15:28, Rui Zhang wrote:
> On Mon, 2023-08-14 at 14:26 +0200, Thomas Gleixner wrote:
>> What's the problem you are trying to solve? Some real world issue or
>> some academic though experiment which might never become a real
>> problem?
>> 
> Maybe I was misleading previously, IMO, I totally agree with your
> points, and "using optional die/tile/module" is what I propose to
> address these concerns.

That's exactly what's implemented. If module, tile, die are not
advertised, then you end up with:

        N   threads
        N/2 cores
        1   module
        1   tile
        1   die

in a package because the bits occupied by module, tile and die are
exactly 0.

But from a conceptual and consistency point of view they exist, no?

Thanks,

        tglx


