Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47FAA7BEA84
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 21:24:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378365AbjJITY1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 15:24:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378273AbjJITYZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 15:24:25 -0400
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 480F493;
        Mon,  9 Oct 2023 12:24:24 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id C2A9040E0187;
        Mon,  9 Oct 2023 19:24:21 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id wobydHsTtQ37; Mon,  9 Oct 2023 19:24:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1696879460; bh=Cd6dCjB9KpgPg5EGQuQfBli6ZN6vFlsaNEknGS0Y5vQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jRd92FFKqJ24BQhAqYhi1ge1OZoQTErHxAeTd2VX+bNLy6cDFnxknimkHQl+ZfZ9q
         HRoDFpE171t4hLuhItTPs5R4e3EjpG8Hx4pEdHjZv5/n3zXn5KQMydOWsYJHBJjZyC
         Ay2TVyhXPqbgXcxRD8YsL5XHkmycPIleq+CilajUQO4jyqmk7GewrcVpwoLUVunKdC
         cjaDLlxbau1lZsD0hqDgiPVAo8SudKsNcmGurFSrJ9ZahuHaYcaI3fZc7EL3NsVVKc
         I+Si6P0Caj8rGkrb/Xx0n7so3EPTe6+AoY+/jGtB488Wz69vWS2pPOcAjLx1MbOE2j
         DeI1lVwPlBB0MjMxozzUP0x1Jt8L6ZI8LJdAGizk9Jh4BbBzpqmAZyKIddrhfBEcAn
         7v+7/91Oikoz6LhgxfUQyc3SYxycDIuN5pDQvwKtZmyAtamjQetaL3DagqUmgY034l
         spDWnW9dFQUmNstrjVneWvN4KplVPYLroXCCYRljjE2Ij7pGNtPsdyc2OgpserDXjb
         Y9EZQvgtXwaxJvsY2Jkg/rt7tUkKseijYGQGfcm7uoDJXZytE0z/XuGXfBPsAZ6KT2
         A19qFGUKy6uJTueI7Q9WwDCRcRcP7O5YOgnhH7zkqjxv8fqjmQF4md7FFPykQbnrTt
         9+k18CT3Q4Z5WtDfOPrUDVFY=
Received: from zn.tnic (pd953036a.dip0.t-ipconnect.de [217.83.3.106])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 80A4040E0177;
        Mon,  9 Oct 2023 19:23:45 +0000 (UTC)
Date:   Mon, 9 Oct 2023 21:23:40 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Reinette Chatre <reinette.chatre@intel.com>
Cc:     Babu Moger <babu.moger@amd.com>, corbet@lwn.net,
        tglx@linutronix.de, mingo@redhat.com, fenghua.yu@intel.com,
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
Subject: Re: [PATCH v11 05/10] x86/resctrl: Unwind the errors inside
 rdt_enable_ctx()
Message-ID: <20231009192340.GEZSRTPE9b9hOtu0JJ@fat_crate.local>
References: <20231003235430.1231238-1-babu.moger@amd.com>
 <20231003235430.1231238-6-babu.moger@amd.com>
 <20231009172517.GRZSQ3fT05LGgpcW35@fat_crate.local>
 <51277249-2351-4933-98d5-2cb74a14c7dd@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <51277249-2351-4933-98d5-2cb74a14c7dd@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 09, 2023 at 10:59:27AM -0700, Reinette Chatre wrote:
> Is it the fourth paragraph (mentioning cdp_disable_all()) that is annoying? I
> can see that it is redundant. Would it be more palatable if the fourth paragraph
> is just dropped?

Yes, basically you don't want to explain what a patch does as that
should be obvious from the diff. Rather, it should talk about why
a change is being done. Sure, sometimes, you need to talk about the
change in case you want to highlight certain aspects of why the code is
being changed in the first place but explaining in text what is already
visible in the diff is not very useful.

I always give the example about git archeology here: put enough info in
the commit message so that any future reader of it can understand why
the change was done. The "what" of a patch doesn't belong to that text.

I hope that makes more sense.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
