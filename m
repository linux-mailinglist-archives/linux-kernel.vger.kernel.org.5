Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF0EB774829
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 21:27:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233927AbjHHT1s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 15:27:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233284AbjHHT1d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 15:27:33 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC33A6968E
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 11:55:53 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691520952;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NB5qZGpXRGcSb+6tiRNnG9E39TwT1cI9hCXxzJHa6XY=;
        b=o+DwbdteHjion+dhZM9uhBd7MpPgvAL9b8vmyVoPQVh2G8YZ5l1R2Do9ICQMGB0k1rnb2+
        66l8/GpLMVEe5vVx8mYyQQvoLAy9094AqXbcepZUWeeobywlIrcIiIF/o1JD87pOAkWAX6
        7AY9JwDkDJAc7dIehRDcQLbVnccqzx2n3J8yPnzzYMmdHdK9ry7F6xWqxJfAhitey9WriC
        btNcq3SKk7nUobP8WDzSHaIU8bjy1vCzPWsSm7CDutCXTqpt6Rs3rih99NeFdExW0IOu3Y
        Jt0fX3L7+DEUgBaTtix1jxpoG2bdgaSpMA2T9Nc1W7UyIyC7hQ1Mg4eV/npWRQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691520952;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NB5qZGpXRGcSb+6tiRNnG9E39TwT1cI9hCXxzJHa6XY=;
        b=PsVIuA126MCf+/qlCoUnDHutTJ7iwySHlww3JenOYZ/dhUgScPgmovdTgwYXIgWa5NQpHb
        0Wb79xid6wsUnCCw==
To:     Andrew Cooper <andrew.cooper3@citrix.com>,
        Juergen Gross <jgross@suse.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Tom Lendacky <thomas.lendacky@amd.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Huang Rui <ray.huang@amd.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Sohil Mehta <sohil.mehta@intel.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Zhang Rui <rui.zhang@intel.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Feng Tang <feng.tang@intel.com>,
        Andy Shevchenko <andy@infradead.org>
Subject: Re: [patch 00/53] x86/topology: The final installment
In-Reply-To: <a08e9457-cb8f-6b57-8f4d-4a1f856ce60e@citrix.com>
References: <20230807130108.853357011@linutronix.de>
 <8d650d5c-e7b8-99c3-e561-3d177e6189bd@suse.com>
 <a08e9457-cb8f-6b57-8f4d-4a1f856ce60e@citrix.com>
Date:   Tue, 08 Aug 2023 20:55:52 +0200
Message-ID: <87jzu5l5xj.ffs@tglx>
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

On Tue, Aug 08 2023 at 12:20, Andrew Cooper wrote:
> On 08/08/2023 8:40 am, Juergen Gross wrote:
>> Tested on an Intel system with Xen:
>>
>> - PV dom0 is working fine. I couldn't test physical cpu hotplug, but
>> removing
>> =C2=A0 and then re-adding vcpus to dom0 worked.
>
> It turns out that physical CPU hotplug with XenPV is broken in at least
> two ways.
>
> It's dom0 (not Xen) that gets the hot-unplug event, after which the Xen
> code in Linux succumbs to a preempt-check failure while trying to
> offline the vCPU that aliases the pCPU wanting to go offline.

That should be gone by now :)
