Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AC7879E852
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 14:51:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240525AbjIMMvA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 08:51:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238125AbjIMMu6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 08:50:58 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4681119B1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 05:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=66j4LpC4FkxboVA4ELkFlwA3s9erD6zM+Bkl1ZbmvNs=; b=vzAIjuHVFwzSZ+jmF8W8PUR+jX
        h/0d3pu00H6MwztFn+DD9n5qhlrm4BdAwuTumla3TY/DvJAzCQY8e8jcJ5h8U4m0J5kqfMwdPqch3
        EqnpUxTjGNo96gntkkgtI9VGIVo7XfjvbXmb4Q3MxlE40M9FjzfcPV5kSjDosg3dP8YrD0QeWguor
        3LKNRtxReQz0aiMLYRMzLjRx+7536mnBHihJ8kd2ro19Qod9rQyhAM1jpD6OSmpmZic6QPA9RsPjL
        1VA7EVk5zrR5pLP63Vu5cMA4pGveJrkIL3ayrcdrR5TtZX2DFTJ7IEtOLcUuRDFkebvQIUxjZe4gs
        r7/78SiA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qgPK4-00DuuQ-BZ; Wed, 13 Sep 2023 12:50:24 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 08FCA300348; Wed, 13 Sep 2023 14:50:24 +0200 (CEST)
Date:   Wed, 13 Sep 2023 14:50:23 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@kernel.org>
Cc:     Nikolay Borisov <nik.borisov@suse.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Borislav Petkov <bp@alien8.de>,
        Babu Moger <babu.moger@amd.com>, David.Kaplan@amd.com,
        gregkh@linuxfoundation.org, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH RFC 4/4] x86/srso: Use CALL-based return thunks to reduce
 overhead
Message-ID: <20230913125023.GG692@noisy.programming.kicks-ass.net>
References: <20230821112723.3995187-1-andrew.cooper3@citrix.com>
 <20230821112723.3995187-5-andrew.cooper3@citrix.com>
 <20230821151636.onk2e6tlhmjg5yz5@treble>
 <810fa94b-9417-0076-1232-d263ef882027@citrix.com>
 <20230822022229.xlctyccmgdxiy6ic@treble>
 <9565380a-4654-f267-c8ac-a4d6ab81156a@suse.com>
 <20230822221828.htnwidmr22gtjhcd@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230822221828.htnwidmr22gtjhcd@treble>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 22, 2023 at 03:18:28PM -0700, Josh Poimboeuf wrote:

> The problem is the call-site, not the thunk.  Ideally we'd have an
> option which adds an INT3 after the 'JMP __x86_return_thunk'.

The -mharden-sls=all option *SHOULD* be extended to unconditionally emit
INT3 after everyt JMP instruction -- including the one used for
-mfunction-return=thunk-extern.

This is a known missing mitigation for an AMD SLS issue.

Due to the whole branch-type-confusion thing, AMD CPUs can predict the
JMP as 'not-a-branch' and continue to the next instruction.

I'm sure Andrew has the proper name and CVE stashed away somewhere. IIRC
he even has a GCC bugzilla entry for it.
