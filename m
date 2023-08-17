Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC65B77F2D1
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 11:11:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349331AbjHQJLX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 05:11:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349351AbjHQJLH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 05:11:07 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C41BA1FE9
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 02:11:06 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1692263465;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=os458OxaSYH49+EBiXmjDb0zuYUogsN9dNYy7PIE6+E=;
        b=xHVamROk3miyQPPRSASCJVQLpTfuIBhoOLfyAuID5l5951SFTnN1xfDplePmBj6stw8TIl
        vp0/7opABlffGcs4s3zH+NNuK67eXd+veUvSyzktuuJiWcrMu/OnAKyCqGyw8VHCW0CroR
        bSCN/LtiVLFnz4CXE/SezwTeEyT5b7M27Cw48d9MZUKfx+CVZpAmEzUyQeP6lvI6kpXPDT
        Ag0ZXEwXfiQsjwERYw+ETp2os/jcLbMVFHiRJZ+lpPck2KEwx5fQ7AFZSL1UAmKHn6sz+o
        zZADRqweqdbmgHUViaUrYc8OY5uOKyYwNACHVSnUqUEJnqYyUnoVhwXP0eVP3g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1692263465;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=os458OxaSYH49+EBiXmjDb0zuYUogsN9dNYy7PIE6+E=;
        b=0g/owWUCXH6DNMvAU+TGLmfa72gXtxbxQBva3t6T49nMp8TlT4pGp+tZTth1WUui23ONtc
        14NXgv3uxqHRUsBg==
To:     "Zhang, Rui" <rui.zhang@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>,
        "Gross, Jurgen" <jgross@suse.com>,
        "mikelley@microsoft.com" <mikelley@microsoft.com>,
        "arjan@linux.intel.com" <arjan@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
        "ray.huang@amd.com" <ray.huang@amd.com>,
        "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
        "Sivanich, Dimitri" <dimitri.sivanich@hpe.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        "puwen@hygon.cn" <puwen@hygon.cn>,
        "Mehta, Sohil" <sohil.mehta@intel.com>
Subject: Re: [patch V4 28/41] x86/cpu: Provide a sane leaf 0xb/0x1f parser
In-Reply-To: <9cc313b7fdad7c26d561fe390c7e797b81e0323c.camel@intel.com>
References: <20230814085006.593997112@linutronix.de>
 <20230814085113.705691574@linutronix.de>
 <9cc313b7fdad7c26d561fe390c7e797b81e0323c.camel@intel.com>
Date:   Thu, 17 Aug 2023 11:11:05 +0200
Message-ID: <87cyzmghjq.ffs@tglx>
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

On Wed, Aug 16 2023 at 12:09, Rui Zhang wrote:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0} else if (tscan->c->topo.ini=
tial_apicid !=3D sl.x2apic_id) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0pr_warn_once(FW_BUG "CPUID leaf 0x%x subleaf %d APIC
>> ID mismatch %x !=3D %x\n",
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 leaf, subleaf, tscan->c-
>> >topo.initial_apicid, sl.x2apic_id);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
>> +
>
> Maybe worth a warning somewhere if sl.x2apic_shift !=3D
> x86_topo_system.dom_shifts[dom], because invariant x2apic_shift (for
> the same level) among different CPUs is critical for this patch series.
> And I do see variant x2apic_shift on an Intel AlderLake NUC, which has
> been identified to be a microcode bug later.

Yes, we can do that.
