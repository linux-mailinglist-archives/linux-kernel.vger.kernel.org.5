Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6A3D7D0DD5
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 12:45:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377114AbjJTKpe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 06:45:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377195AbjJTKpU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 06:45:20 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B3051994
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 03:44:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1697798659;
        bh=BOQy2S+gkRQ6GqEG1l3wx7Pc1XFdYna8OiPHPqKzES4=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=ifl/oYvh+TRsSqRgEPMixGOqr4MoU0N6idL02NbzyNh9SF3hMbCT+41P1QDWt9mVo
         r0TnbRSCGpHxnFA9gfGRPjgqC0x+mJUC+G5G3bjzrS2ECDmKQriQsQBsa5eSkJrlLT
         nIqcKEqedWmBVS5HNXbL1uOSBHiHHvVSm1LE7Kg0f1/pSXNmJVbpWAnvbch0WWD0+u
         Z0dVWmEId377e1yEOsZALaWYmd8CxmAeINvjgQIdioHEWLBHybz/2wsXn2p1O86dEd
         SGlFy6Qr3r8lxy7s+ZxRnYq6QqQnhT34XhJPgr0BVQ0hdxxZZmMskpbccxYulBee/c
         Cwb6zW0meP0UQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4SBh6B6KH4z4xdP;
        Fri, 20 Oct 2023 21:44:18 +1100 (AEDT)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Cc:     linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Nicholas Piggin <npiggin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Rohan McLure <rmclure@linux.ibm.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Ajay Kaher <akaher@vmware.com>,
        Alexey Makhalov <amakhalov@vmware.com>,
        VMware PV-Drivers Reviewers <pv-drivers@vmware.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        virtualization@lists.linux-foundation.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/6] powerpc/smp: Move shared_processor static key to
 smp.h
In-Reply-To: <20231019130843.GI2194132@linux.vnet.ibm.com>
References: <20231018163751.2423181-1-srikar@linux.vnet.ibm.com>
 <20231018163751.2423181-4-srikar@linux.vnet.ibm.com>
 <87sf675im3.fsf@mail.lhotse> <20231019130843.GI2194132@linux.vnet.ibm.com>
Date:   Fri, 20 Oct 2023 21:44:14 +1100
Message-ID: <877cnh60ap.fsf@mail.lhotse>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Srikar Dronamraju <srikar@linux.vnet.ibm.com> writes:
> * Michael Ellerman <mpe@ellerman.id.au> [2023-10-19 15:41:40]:
>
>> Srikar Dronamraju <srikar@linux.vnet.ibm.com> writes:
>> > The ability to detect if the system is running in a shared processor
>> > mode is helpful in few more generic cases not just in
>> > paravirtualization.
>> > For example: At boot time, different scheduler/ topology flags may be
>> > set based on the processor mode. Hence move it to a more generic file.
>> 
>> I'd rather you just included paravirt.h in the few files where you need it.
>
> I thought, detecting if a Processor was shared or not was more a
> smp/processor related than a paravirt related.

It's both really :)

It's definitely paravirt related though, because if we weren't
*para*virt then we wouldn't know there was a hypervisor at all :)

But having smaller more focused headers is preferable in general just
for mechanical reasons.

cheers
