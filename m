Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 668047FF29D
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 15:40:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346071AbjK3Okj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 09:40:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346038AbjK3Oki (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 09:40:38 -0500
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B46BE93;
        Thu, 30 Nov 2023 06:40:44 -0800 (PST)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 308F540E0030;
        Thu, 30 Nov 2023 14:40:42 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id zijeYWMRN7vv; Thu, 30 Nov 2023 14:40:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1701355240; bh=h0qwow19NdKO2+/XrBUXodPBR9R3/3gl99cArdMrp3w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GWzzjqgrfLnSQPKE0qba0s7RZ54I13eojfslwg0fAcYdiA12TK8XDBQkvoWks8ifV
         I/yj7qWWWt/1cAXrL47wvl7R8T+q92wFeUxThqrGyBhZR/nOY+C4kOdocjFX8QDPW9
         5pMzCLDVv0Eo4mV2tmNgKzmW4FS3wVIJY/N9UFnqGkBC+jGDUr4zOdTcIjf3gdkvY6
         jwwLd9C8220jj6W2G2Or6BPmSgHfieZDFr3c1ty9L5wT8DQGy7Zx3QzMrGG4L2AXTq
         nhPgnFKeBSmw07LAqri0Nb1tVmz61+BFWIzv7cJdR+hMneNc0P4mLwnpa4UHUCt/Iw
         MuyOazyjjadjifxvdSTZh8eoneG99HjiXzyKutoeeJbx3QAGmbmwhpN3vIXekbloO6
         BlgMN+uq7i5R/MspJgGDqd3kiZef3NPj+AsB3belkSCDi9JCWZDFjsPf2V3sibVtsL
         GZ7VzV0khKEj8Hv9onSX8M/mxE5V5JBLDG2bmVsrftboqiwmJ4Poz8G6nHCRFwGHhe
         IRhefBSFLNt0Gi07+wz3ZUdQZGbPzhi7AMQSBrstDjHh6AL+qdkQAKzBBAST3zvqSb
         F/9pY96ebjtRJNzPjBLqh+C8bNUgF03g7PFxxytDL6OYAEc6gaiU7pq/ubtpmHMs4D
         1ueM1ZNR66s0O69R14YftBV4=
Received: from zn.tnic (pd95304da.dip0.t-ipconnect.de [217.83.4.218])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 9862640E0239;
        Thu, 30 Nov 2023 14:40:05 +0000 (UTC)
Date:   Thu, 30 Nov 2023 15:40:01 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Shuai Xue <xueshuai@linux.alibaba.com>
Cc:     james.morse@arm.com, rafael@kernel.org, wangkefeng.wang@huawei.com,
        tanxiaofei@huawei.com, mawupeng1@huawei.com, tony.luck@intel.com,
        linmiaohe@huawei.com, naoya.horiguchi@nec.com,
        gregkh@linuxfoundation.org, will@kernel.org, jarkko@kernel.org,
        linux-acpi@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        linux-edac@vger.kernel.org, acpica-devel@lists.linuxfoundation.org,
        stable@vger.kernel.org, x86@kernel.org, justin.he@arm.com,
        ardb@kernel.org, ying.huang@intel.com, ashish.kalra@amd.com,
        baolin.wang@linux.alibaba.com, tglx@linutronix.de,
        mingo@redhat.com, dave.hansen@linux.intel.com, lenb@kernel.org,
        hpa@zytor.com, robert.moore@intel.com, lvying6@huawei.com,
        xiexiuqi@huawei.com, zhuo.song@linux.alibaba.com
Subject: Re: [PATCH v9 0/2] ACPI: APEI: handle synchronous errors in task
 work with proper si_code
Message-ID: <20231130144001.GGZWiewYtvMSJir62f@fat_crate.local>
References: <20221027042445.60108-1-xueshuai@linux.alibaba.com>
 <20231007072818.58951-1-xueshuai@linux.alibaba.com>
 <20231123150710.GEZV9qnkWMBWrggGc1@fat_crate.local>
 <9e92e600-86a4-4456-9de4-b597854b107c@linux.alibaba.com>
 <20231125121059.GAZWHkU27odMLns7TZ@fat_crate.local>
 <1048123e-b608-4db1-8d5f-456dd113d06f@linux.alibaba.com>
 <20231129185406.GBZWeIzqwgRQe7XDo/@fat_crate.local>
 <a3cd9b79-4be5-4f77-b32a-51a624a65ec0@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a3cd9b79-4be5-4f77-b32a-51a624a65ec0@linux.alibaba.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

FTR, this is starting to make sense, thanks for explaining.

Replying only to this one for now:

On Thu, Nov 30, 2023 at 10:58:53AM +0800, Shuai Xue wrote:
> To reproduce this problem:
> 
> 	# STEP1: enable early kill mode
> 	#sysctl -w vm.memory_failure_early_kill=1
> 	vm.memory_failure_early_kill = 1
> 
> 	# STEP2: inject an UCE error and consume it to trigger a synchronous error

So this is for ARM folks to deal with, BUT:

A consumed uncorrectable error on x86 means panic. On some hw like on
AMD, that error doesn't even get seen by the OS but the hw does
something called syncflood to prevent further error propagation. So
there's no any action required - the hw does that.

But I'd like to hear from ARM folks whether consuming an uncorrectable
error even lets software run. Dunno.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
