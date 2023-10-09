Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A406F7BEAEA
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 21:52:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378505AbjJITwj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 15:52:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378488AbjJITwh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 15:52:37 -0400
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5DF0D6;
        Mon,  9 Oct 2023 12:52:34 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 1723640E01A5;
        Mon,  9 Oct 2023 19:52:32 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 48amw1-2Wmql; Mon,  9 Oct 2023 19:52:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1696881150; bh=Y59MA/tIFAYhXTrbuM/NErWaLdzcC9gYjWL78eHvdYA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZFjQdihRCNUZROAw9sjNCRHG48o9vGPZV1KjjReOhO1vBiL2rQ20hnX6Jm1L6Epjz
         FpFGKQl0+AZwbH6bE+Fo7RqcIX2EgHLdfxPW9/JiWogIsklcrRba3FakyZ+aoZJOpR
         3/VhAt8XLp6XyHkWW1M15gs1IFtpi8plfuWETDKcZtNSaEYjBKlZzUpbY66lCPK9ew
         jwAFacMVp9REyxMXzByoV/SmPyMDGMK5wVcXWdsMKEIs+TP/FJspC0xmUGVEpoE6kZ
         VFJ8EYoRO7Zpv/pmyX7fqnEDBzeZuwA9nNfvtIsc9y4CfM/kZBTWHJYGst1WTIXAZZ
         ptQcIj2fE4G3/pesrOnzZkazj+j8Pw/z8hFgQnbn3gJGehzJxQ3QrKb1uVRsWOKcKY
         uogOOISnk/tNxULz6aX2CIC1B9MQjjDqLRX+s/o+jdVIRAQlZFM/5+SkryjM4GRaqB
         ahvXW9/+bpozuR+2GGqTz68G0ONcTAEehfB5aVJ4nuLObkonRIjmuNlg5BBeUfCcnv
         jFepZrjgtvn79PgkZWufiPByz6HjfilJr75sS6Zc0k8Wrv8zcu6wlQ0BbvRXt8MIOs
         +B4f3T5oFwTrCYpS/aS8BPYPyg3Ay3dmYvzZc6jznrfk4iicLQNNnNpljtfBsgrhui
         sj7qvE5/1edQxoA3Lw5r5iKE=
Received: from zn.tnic (pd953036a.dip0.t-ipconnect.de [217.83.3.106])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id EDEEC40E01AA;
        Mon,  9 Oct 2023 19:51:55 +0000 (UTC)
Date:   Mon, 9 Oct 2023 21:51:50 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Moger, Babu" <babu.moger@amd.com>
Cc:     corbet@lwn.net, reinette.chatre@intel.com, tglx@linutronix.de,
        mingo@redhat.com, fenghua.yu@intel.com,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        paulmck@kernel.org, akpm@linux-foundation.org,
        quic_neeraju@quicinc.com, rdunlap@infradead.org,
        damien.lemoal@opensource.wdc.com, songmuchun@bytedance.com,
        peterz@infradead.org, jpoimboe@kernel.org, pbonzini@redhat.com,
        chang.seok.bae@intel.com, pawan.kumar.gupta@linux.intel.com,
        jmattson@google.com, daniel.sneddon@linux.intel.com,
        sandipan.das@amd.com, tony.luck@intel.com, james.morse@arm.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        bagasdotme@gmail.com, eranian@google.com,
        christophe.leroy@csgroup.eu, jarkko@kernel.org,
        adrian.hunter@intel.com, quic_jiles@quicinc.com,
        peternewman@google.com
Subject: Re: [PATCH v11 04/10] x86/resctrl: Add comments on RFTYPE flags
 hierarchy
Message-ID: <20231009195150.GFZSRZ1pl+KFBao/lK@fat_crate.local>
References: <20231003235430.1231238-1-babu.moger@amd.com>
 <20231003235430.1231238-5-babu.moger@amd.com>
 <20231009172207.GQZSQ2vyKLm660U5o6@fat_crate.local>
 <c794d06d-1954-470d-bd3f-b8c73a32dce0@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c794d06d-1954-470d-bd3f-b8c73a32dce0@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 09, 2023 at 02:39:30PM -0500, Moger, Babu wrote:
> User visible files are already documented in resctrl.rst file.
> 
> Understanding of these flags are mostly required for programmers. Users
> don't need to know all these internal flags. That is why it is listed in here.

You can have a section in resctrl.rst called "Implementation notes" or
so. This way you have it all in one file instead of having programmers
grep the whole tree for info.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
