Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C7FE8053B2
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 13:00:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345175AbjLEMAf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 07:00:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345161AbjLEMAc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 07:00:32 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F34AA98
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 04:00:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Message-ID:In-Reply-To:Subject:CC:To:From:Date:Sender:Reply-To:
        Content-ID:Content-Description:References;
        bh=/eKJhgPMTMMY5RfTR6X1AJ44Ndjq/J/8VLPyF0xruWU=; b=QfDoArJdhDbZztII3tMJ1ynhkK
        1XX3+6r4Oh3Yi54ykyfQQShKvX5us7FdMniDsEg3taV/89OoASvWIonKDHGg/lrnK01unE/OWpQk0
        YXGEtcB9jNYnhnRfZoCWYSIG2eZ7E651BZOT4C5ho16w9Fpk3JgYERmNqCCu4UUooevXV16xC3BYO
        MU1ZTQH7xB2ZHPQvdt34iAo3U/+1E8ay9o/71IXKV07vw85D8BHsdjYRJdX1MjR9iWWMu4E4CX94m
        wYKbWsioCa6AyM+N8hBDnIpWEslkqgekQbtZDtrxghZkgQVFWfq2FSQ5P+Ov1Em4pPGi2kRN01+wt
        NTj6oz3w==;
Received: from [46.18.216.58] (helo=[127.0.0.1])
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1rAU5s-001py0-VY; Tue, 05 Dec 2023 12:00:05 +0000
Date:   Tue, 05 Dec 2023 12:00:04 +0000
From:   David Woodhouse <dwmw2@infradead.org>
To:     pdurrant@amazon.co.uk
CC:     bp@alien8.de, dave.hansen@intel.com, dave.hansen@linux.intel.com,
        hdegoede@redhat.com, hpa@zytor.com, jalliste@amazon.co.uk,
        juew@amazon.com, len.brown@intel.com, linux-kernel@vger.kernel.org,
        mingo@redhat.com, peterz@infradead.org, rafael.j.wysocki@intel.com,
        rafael@kernel.org, tglx@linutronix.de, usama.arif@bytedance.com,
        x86@kernel.org
Subject: =?US-ASCII?Q?RE=3A_=5BPATCH=5D_x86=3A_intel=5Fepb=3A_Add_earlyp?= =?US-ASCII?Q?aram_option_to_keep_bias_at_performance?=
User-Agent: K-9 Mail for Android
In-Reply-To: <53bce76c5c60463eba1372df426a64b9@amazon.co.uk>
Message-ID: <1D71D218-5EB6-47DE-A01B-3A66F9F4C74E@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Paul writes:
> The problem is that this will take effect even on a kexec and hence it i=
s throttling
> a system that set ENERGY_PERF_BIAS_PERFORMANCE prior to the kexec=2E  We=
 use kexec to
> live update the host kernel of our systems whilst leaving virtual machin=
es running=2E
> This resetting of the perf bias is having a very detrimental effect on t=
he downtime
> of our systems across the live update - about a 7 fold increase=2E

It isn't just about kexec, is it? Even in a clean boot why wouldn't we wan=
t to stay in performance mode until the kernel has *finished* booting? It's=
 literally adding seconds to the startup time in some cases=2E

And yes, we *particularly* care in the kexec case because guests experienc=
e it as excessive steal time=2E But it ain't great in the general case eith=
er, surely?
