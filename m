Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20F9277A251
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 22:06:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231221AbjHLUGs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Aug 2023 16:06:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231226AbjHLUGn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Aug 2023 16:06:43 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C73812706
        for <linux-kernel@vger.kernel.org>; Sat, 12 Aug 2023 13:06:19 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691870689;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Wtvo571d87Q4UWnlp7I5H5p2cbtWMUbQPMH/PnPfg5Q=;
        b=RBVtPzjEiRA5J7HWVZYdE7mHLJHJAwZ93VUjc28qfOUOTwb9rUl9VY7xl4pl/zUYlydBWF
        rxyk57fQ7xnJ7CjHLuk7Mazy3g/9Cju+leyIWrJSaftpf7SNAYkLBX3JzLqUyYqkX3EAKX
        GNeGMWlneaRctlCL9SipmOxGDrDPrjgmO/oEUri4UNiFNQWKuK6rv6SDsy1Rmjdk0SdBy2
        VO5GyDj/EYy8dngraf9GhIeEepuet6YfWn9xfkcCOPngM2lu7fLlI9Fe6fFswMU6aF+jM+
        25oFhM6v2p+LB7i0ZV7LPlv8ZffaaHrfI6aVio4w0BQ0mN4QHQQoXdpmo99wMQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691870689;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Wtvo571d87Q4UWnlp7I5H5p2cbtWMUbQPMH/PnPfg5Q=;
        b=VuZU88itT/IYNqsGPgRsNZCxCurCX2I3Sb2zcAqul6bt1hiLKMFog5Acc/XMQ7T+npqG0m
        XEiDE+H8Jeo/BBCQ==
To:     "Zhang, Rui" <rui.zhang@intel.com>,
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
Subject: Re: [patch V3 27/40] x86/cpu: Provide a sane leaf 0xb/0x1f parser
In-Reply-To: <8e5bbbc91ff9f74244efe916a4113999abc52213.camel@intel.com>
References: <20230802101635.459108805@linutronix.de>
 <20230802101934.258937135@linutronix.de>
 <8e5bbbc91ff9f74244efe916a4113999abc52213.camel@intel.com>
Date:   Sat, 12 Aug 2023 22:04:48 +0200
Message-ID: <87350ogh7j.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 12 2023 at 08:21, Rui Zhang wrote:
> On Wed, 2023-08-02 at 12:21 +0200, Thomas Gleixner wrote:
>> +
>> +/*
>> + * Use a lookup table for the case that there are future types > 6
>> which
>> + * describe an intermediate domain level which does not exist today.
>> + *
>> + * A table will also be handy to parse the new AMD 0x80000026 leaf
>> which
>> + * has defined different domain types, but otherwise uses the same
>> layout
>> + * with some of the reserved bits used for new information.
>> + */
>> +static const unsigned int topo_domain_map[MAX_TYPE] =3D {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0[SMT_TYPE]=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=3D TOPO_SMT_DOMAIN,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0[CORE_TYPE]=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=3D TOPO_CORE_DOMAIN,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0[MODULE_TYPE]=C2=A0=C2=A0=C2=
=A0=3D TOPO_MODULE_DOMAIN,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0[TILE_TYPE]=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=3D TOPO_TILE_DOMAIN,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0[DIE_TYPE]=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=3D TOPO_DIE_DOMAIN,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0[DIEGRP_TYPE]=C2=A0=C2=A0=C2=
=A0=3D TOPO_PKG_DOMAIN,
>
> May I know why DIEGRP_TYPE is mapped to TOPO_PKG_DOMAIN?

Where else should it go? It's the topmost, no? But diegrp is a
terminoligy which is not used in the kernel

>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (sl.type >=3D maxtype) {
>
> It is still legal to have sparse type value in the future, and then
> this check will break.
> IMO, it is better to use a function to convert type to domain, and
> check for unknown domain here, say, something like

Why? If somewhere in the future Intel decides to add UBER_TILE_TYPE,
then this will be a type larger than DIEGRP_TYPE. maxtype will then
cover the whole thing and the table will map it to the right place.

Even if in their infinite wisdom the HW folks decide to make a gap, then
the table can handle it simply by putting an invalid value into the gap
and checking for that.

Serioulsy we don't need a switch case for that.
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0/*
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 * As the subleafs are ordered in domain level order,
>> this
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 * could be recovered in theory by propagating the
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 * information at the last parsed level.
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 *
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 * But if the infinite wisdom of hardware folks
>> decides to
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 * create a new domain type between CORE and MODULE
>> or DIE
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 * and DIEGRP, then that would overwrite the CORE or
>> DIE
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 * information.
>
> Sorry that I'm confused here.
>
> Say, we have CORE, FOO, MODULE, then the subleave of FOO must be higher
> than CORE but lower than MODULE.
> so we parse CORE first and propagates the info to FOO/MODULE, and then
> parse FOO and propagate to MODULE, and parse MODULE in the end.
> How could we overwrite the info of a lower level?

We don't know about this new thing yet. So where should we propagate to?
We could say, last was core so we stick the new thing into module, but
do we know that's correct? Do we know there is a module actually. Let me
rephrase that comment.
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 *
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 * Refuse to implement monstrosity, emit an error and =
try
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 * to survive.
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 */
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0pr_err_once("Topology: leaf 0x%x:%d Unknown domain typ=
e %u\n",
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 leaf, subleaf, sl.type);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0return true;
>
> Don't want to be TLDR, I can think of a couple cases that breaks Linux
> in different ways if we ignore the cpu topology info of an unknown
> level.

Come on. If Intel manages it to create a new level then it's not rocket
science to integrate support for that a long time before actual silicon
ships. So what will break? The machines of people who use ancient
kernels on modern hardware? They can keep the pieces.

> So I just want to understand the strategy here, does this mean that
> we're not looking for a future proof solution, and instead we are
> planning to take future updates (patch enum topo_types/enum
> x86_topology_domains/topo_domain_map) whenever a new level is
> invented?

You need that anyway, no?=20

> With this, we can guarantee that all the available topology information
> are always valid, even when running on future platforms.

I know that it can be made work, but is it worth the extra effort? I
don't think so.

Thanks,

        tglx


