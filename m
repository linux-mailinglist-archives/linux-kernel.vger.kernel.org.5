Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A622777D437
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 22:36:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238293AbjHOUfl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 16:35:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238328AbjHOUff (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 16:35:35 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED039F7;
        Tue, 15 Aug 2023 13:35:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=75R46oKMXGij9WjDuFRcdkMZQJztFv+MgWLiP5Z+wmA=; b=HXM125bORhCV4ax8Na19Xg+n8F
        qUDPfxv5z5BG59BiS5GrOzIBFT+rykYfaVfA0vxT6jJXyBIvAEbnIWzCNFBfcS9E7+lB8Tdhg2rtd
        NBvWegeQKrIsT2X8BAu40iqrHwZmSO7d+mqB3+Li5FXQSG+WXm8LdNGH8A5VY5THCscRKJwMAjzk4
        KgDGfOKWSi9ifyo80vqNkjxtaOm2a/Vpk5flQr0kDDlj/F9j5Ex2ShRwN6O48a5ZMsA3CUAGT05Rp
        XDbLqyqOiMrQsPWTTbful4WTY0jlyj9V3GgBLvZroT6qSNOm8OktHApKP8h8LxJKVQxBb7ODIK4FU
        o3C18w5g==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qW0lE-00AISb-0a; Tue, 15 Aug 2023 20:35:28 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 96028300222;
        Tue, 15 Aug 2023 22:35:27 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 52D992B57699C; Tue, 15 Aug 2023 22:35:27 +0200 (CEST)
Date:   Tue, 15 Aug 2023 22:35:27 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     James Clark <james.clark@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        catalin.marinas@arm.com, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Suzuki Poulose <suzuki.poulose@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH V13 - RESEND 02/10] arm64/perf: Add BRBE registers and
 fields
Message-ID: <20230815203527.GB971582@hirez.programming.kicks-ass.net>
References: <20230711082455.215983-1-anshuman.khandual@arm.com>
 <20230711082455.215983-3-anshuman.khandual@arm.com>
 <20230728162011.GA22050@willie-the-truck>
 <89ce4bc4-00c5-a763-3179-e1d3e9f198b7@arm.com>
 <937468a1-b325-7d05-8daf-765f911c9240@arm.com>
 <ZMd5gCOHqnGRc0Ja@FVFF77S0Q05N>
 <f5437bfc-e458-bc23-bc31-a308aa412463@arm.com>
 <ZNt3mQeGbql4oi55@FVFF77S0Q05N>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZNt3mQeGbql4oi55@FVFF77S0Q05N>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 15, 2023 at 02:05:36PM +0100, Mark Rutland wrote:

> From a quick dig, it's supposed to be like that: the GNU assembler uses a
> different operator precedence to C, and clang's assembler does the same for
> compatibility. What a great.

GNU assembler doesn't even have a consistent true value for boolean
expressions. The comparisons use -1/~0 as true value while the logical
ops use 1.

It's as if they purposefully want to mess you up :-(

  https://sourceware.org/binutils/docs-2.38/as.html#Infix-Ops
