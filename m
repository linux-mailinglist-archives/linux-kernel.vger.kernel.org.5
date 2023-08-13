Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AF1377A6FC
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Aug 2023 16:37:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230059AbjHMOgu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Aug 2023 10:36:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbjHMOgt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Aug 2023 10:36:49 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C182E65
        for <linux-kernel@vger.kernel.org>; Sun, 13 Aug 2023 07:36:51 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691937409;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QM4pjIcdbqHv0LrFm5NoqZw0vY749GJ1cLEpQduONgQ=;
        b=XdOvSgIP7gZxz3ML4TsCr5R44CHHi27O2gnLt//C+aoigSzSXmckAP5VjVaN4kwwJsUY8v
        TOM79YcqIYVwKY+Zasir5cGBUQRqZz95X2p84v6XQWooAju+rYORjgbdX+dgrNTVs0Yqbe
        489FE7/64mpAYucE1cwlehjvX795vaJqaUHO80v3K941CCO+qOb6SAoi52bTlphnzNDvUv
        SYPJONvOcAxqkDV6BzED00IXi9Fh8NN6kCRibLlEsehui9nm9B99UuETIyTSfqNb/xqL4i
        agoAvQczDdAV0Y7nsWLtpDQIvI2gUhnJByu8wKhfko9oBWmdEl4n+JEuFl6YJw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691937409;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QM4pjIcdbqHv0LrFm5NoqZw0vY749GJ1cLEpQduONgQ=;
        b=Nn0H6rUVX1eRZgKT6gdUqteItraHY5AhFrT/E/sTNHamDCFb8OItHOE6UjFS2Yk42y+vDw
        D/qkb6sbR9BELNBA==
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
Subject: Re: [patch V3 23/40] x86/cpu: Provide cpu_init/parse_topology()
In-Reply-To: <33b628a02f190481c42a2dfd31b5ed1b2b50b37f.camel@intel.com>
References: <20230802101635.459108805@linutronix.de>
 <20230802101934.026097251@linutronix.de>
 <e46c345503a6d0827d3198f699258274e22cb9e3.camel@intel.com>
 <33b628a02f190481c42a2dfd31b5ed1b2b50b37f.camel@intel.com>
Date:   Sun, 13 Aug 2023 16:36:48 +0200
Message-ID: <87wmxzf1q7.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 13 2023 at 13:30, Rui Zhang wrote:
> On Sat, 2023-08-12 at 06:41 +0000, Zhang, Rui wrote:
>> > +static inline u32 topo_relative_domain_id(u32 apicid, enum
>> > x86_topology_domains dom)
>> > +{
>> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (dom !=3D TOPO_SMT_DOMAI=
N)
>> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0apicid >>=3D x86_topo_system.dom_shifts[dom - 1];
>> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return apicid & (x86_topo_s=
ystem.dom_size[dom] - 1);
>> > +}
>>=20
>> relative_domain_id() is used to get a unique id value within its next
>> higher level.

Correct.
=20
>> > +static void topo_set_ids(struct topo_scan *tscan)
>> > +{
>> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct cpuinfo_x86 *c =3D t=
scan->c;
>> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0u32 apicid =3D c->topo.apic=
id;
>> > +
>> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0c->topo.pkg_id =3D topo_shi=
ft_apicid(apicid,
>> > TOPO_PKG_DOMAIN);
>> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0c->topo.die_id =3D topo_shi=
ft_apicid(apicid,
>> > TOPO_DIE_DOMAIN);
>> > +
>> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/* Relative core ID */
>> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0c->topo.core_id =3D topo_re=
lative_domain_id(apicid,
>> > TOPO_CORE_DOMAIN);
>>=20
>> My understanding is that, to ensure a package scope unique core_id,
>> rather than Module/Tile scope unique, what is really needed here is
>> something like,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0apicid >>=3D x86_topo_sy=
stem.dom_shifts[SMT];
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0c->topo.core_id =3D apic=
id & (x86_topo_system.dom_size[PACKAGE]
>> - 1);

Indeed.

> This is all good, however,
>
> # grep . /sys/devices/system/cpu/cpu*/topology/c*_id
> /sys/devices/system/cpu/cpu0/topology/cluster_id:0
> /sys/devices/system/cpu/cpu0/topology/core_id:0
> /sys/devices/system/cpu/cpu1/topology/cluster_id:0
> /sys/devices/system/cpu/cpu1/topology/core_id:1
> /sys/devices/system/cpu/cpu2/topology/cluster_id:0
> /sys/devices/system/cpu/cpu2/topology/core_id:2
> /sys/devices/system/cpu/cpu3/topology/cluster_id:0
> /sys/devices/system/cpu/cpu3/topology/core_id:3
> /sys/devices/system/cpu/cpu4/topology/cluster_id:8
> /sys/devices/system/cpu/cpu4/topology/core_id:0
> /sys/devices/system/cpu/cpu5/topology/cluster_id:8
> /sys/devices/system/cpu/cpu5/topology/core_id:1
> /sys/devices/system/cpu/cpu6/topology/cluster_id:8
> /sys/devices/system/cpu/cpu6/topology/core_id:2
> /sys/devices/system/cpu/cpu7/topology/cluster_id:8
> /sys/devices/system/cpu/cpu7/topology/core_id:3
>
> The core_id is broken as it is Module scope unique only. To get package
> scope unique core id, it should contain all bits up to package id bits.

Right. Let me correct that.

But aside of that we need to have a discussion urgently how we look at
these things. If relative, then relative to what.

Right now its how it happened to be, but there is not really a plan
behind all that.

Thanks,

        tglx
