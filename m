Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A03C577B17D
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 08:22:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231376AbjHNGWJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 02:22:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233799AbjHNGVn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 02:21:43 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0DEC1BD0
        for <linux-kernel@vger.kernel.org>; Sun, 13 Aug 2023 23:21:25 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691994037;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fpJF9hBfBomBJr5TfbyVCxXC5GKehatxHj9wTSwthAg=;
        b=rlEkzr37Iw0fym1t7Ikyjh4LJKnUD8PyxzAElr4h6OHnJ7WCSNXl1/nZANWFFauBcJcl2u
        3ed3ZsU+HZKPM4KhztXCs9zJ9/A/SMQBNZHc3G5quT5Xa2459ewb42Np/k9kIcqadI7QBF
        TG+c8isx7NpPK+6l0uLGQIr93dtYbuCd0iEQhCwo0GjMZ6OO28m7n2r0Pcb1OKJkhkOCU6
        Yb2WdAxSyIpjakUzOrJw3kJk5k/f4zR+wgxhEW0ozCsArQnvEZRgDsSmApLGlO7+zf81Xk
        hOP6lYBBuOxqZNjewYiCCTn2b0HuoXHOw9eOOsHMIGrcA1PWQdL9/3lcm+k4Gg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691994037;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fpJF9hBfBomBJr5TfbyVCxXC5GKehatxHj9wTSwthAg=;
        b=1Elg3o/HIQGZuFZHKXYS7OVqv+LRzufYn9rBE2lQtx4rTfUQK1qcqUl8dCtHYIv90R4gRW
        od43rsf0m1FFPGBA==
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
In-Reply-To: <87wmxzf1q7.ffs@tglx>
References: <20230802101635.459108805@linutronix.de>
 <20230802101934.026097251@linutronix.de>
 <e46c345503a6d0827d3198f699258274e22cb9e3.camel@intel.com>
 <33b628a02f190481c42a2dfd31b5ed1b2b50b37f.camel@intel.com>
 <87wmxzf1q7.ffs@tglx>
Date:   Mon, 14 Aug 2023 08:20:37 +0200
Message-ID: <87r0o6f8lm.ffs@tglx>
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

On Sun, Aug 13 2023 at 16:36, Thomas Gleixner wrote:
> On Sun, Aug 13 2023 at 13:30, Rui Zhang wrote:
>>> My understanding is that, to ensure a package scope unique core_id,
>>> rather than Module/Tile scope unique, what is really needed here is
>>> something like,
>>>>
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0apicid >>=3D x86_topo_s=
ystem.dom_shifts[SMT];
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0c->topo.core_id =3D api=
cid & (x86_topo_system.dom_size[PACKAGE]
>>> - 1);

Actually it needs to be:

         apicid &=3D (1U << x86_topo_system.dom_shifts[TOPO_PKG_DOMAIN]) - =
1;
         c->topo.core_id =3D apicid >> x86_topo_system.dom_shifts[TOPO_SMT_=
DOMAIN];

because otherwise you shift the lowest package ID bit into the result.
