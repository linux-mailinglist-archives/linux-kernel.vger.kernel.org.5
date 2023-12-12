Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B39780EDF4
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 14:47:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376284AbjLLNq4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 08:46:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346662AbjLLNqz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 08:46:55 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9137A1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 05:47:01 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D18DC433C7;
        Tue, 12 Dec 2023 13:47:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702388821;
        bh=mqxh9zunvpb036JZEOLxMSrfLM8AML7StjISr8/NUDE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UPDizaqpMsgAC2wnSd8hWh+uF/U5C1z1oKAH5P9f6P0IJXDjXBHa0BJJF6i2tfiNf
         keSo51yS8RBVKsLDWYkEpWFsCCdadst98HelLd695zkEMwY1C3gDAvLtopVA/ECXrf
         uwTfxOnAkA+Pps0AKRTPrc2kB5MuacVnNE8xYlHdVjOlYFoqL6MTZvnSOlr1DY+Eov
         279NiCHsiGwme2XmVmu7HB0YSqUSmy6GBYMY1/3a6sQVzBpgi0xjvDo4eyRqWsmWNp
         CU/zAbXQznnX3/dj2e48O5Xp2boLbHWjdN1e69iGTs5k0krjDe/WMWotoLZW8Frv/M
         BASwnQ0dHZRuA==
Date:   Tue, 12 Dec 2023 14:46:58 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Cooper <Andrew.Cooper3@citrix.com>,
        linux-tip-commits@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>, x86@kernel.org
Subject: Re: [tip: x86/core] x86: Fix CPUIDLE_FLAG_IRQ_ENABLE leaking timer
 reprogram
Message-ID: <ZXhkUshO49ldjBio@lothringen>
References: <20231115151325.6262-3-frederic@kernel.org>
 <170126975511.398.12493947150541739641.tip-bot2@tip-bot2>
 <20231130111519.GA20153@noisy.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231130111519.GA20153@noisy.programming.kicks-ass.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 30, 2023 at 12:15:19PM +0100, Peter Zijlstra wrote:
> This is so, because all mwait users should be in __cpuidle section,
> which itself is part of the noinstr section and as such
> kprobes/hw-breakpoints etc.. are disallowed.
> 
> Notable vmlinux.lds.h has:
> 
> #define NOINSTR_TEXT							\
> 		ALIGN_FUNCTION();					\
> 		__noinstr_text_start = .;				\
> 		*(.noinstr.text)					\
> 		__cpuidle_text_start = .;				\
> 		*(.cpuidle.text)					\
> 		__cpuidle_text_end = .;					\
> 		__noinstr_text_end = .;

So #DB aren't supposed to happen then, right? Or you noticed an mwait
user that doesn't have __cpuidle?

Thanks.
