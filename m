Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3782A7897CC
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Aug 2023 17:46:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229950AbjHZPp3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Aug 2023 11:45:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231255AbjHZPpX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Aug 2023 11:45:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 846E919AE
        for <linux-kernel@vger.kernel.org>; Sat, 26 Aug 2023 08:45:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 21BC3627D5
        for <linux-kernel@vger.kernel.org>; Sat, 26 Aug 2023 15:45:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1485AC433C8;
        Sat, 26 Aug 2023 15:45:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693064720;
        bh=nA+MA1XZYDPu6nvn+EVt9YkyGx7UTRtZ6bKzI2prtgo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DzGF2Xt7CHGesJs4av4ISSW1PqvLtL+sK2Z5yZMjjjHeo4t6DvDIexC1E4+LuNUpD
         ZSOYpR6ey7j2CvAP07HUxBsZfq+CciGzXOx0hlMz9e590OigA1H74tX14v/fpm5guH
         hTAtZBC7WQw5va00xbHH6HBVXHZ6c0LcbNGqcjteK82fKBNH01qE/cBDNmC7EncpKM
         ZAREwWBlryeWUuks/hU4Aj2QUoddqAL2sNzMCEmVk+WF4gGsHVCU2sv+tBCELywu+J
         4aXlWJ3s6FVmHBw8ieW/aVH2LKHdtEFgeZk0s4XjxdFeqMlH+TUAct3Z/o1oDhNGRV
         nBHo2R5hr33HA==
Date:   Sat, 26 Aug 2023 08:45:18 -0700
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     Nikolay Borisov <nik.borisov@suse.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Babu Moger <babu.moger@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>, David.Kaplan@amd.com,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        gregkh@linuxfoundation.org, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 15/23] x86/srso: Remove 'pred_cmd' label
Message-ID: <20230826154518.rwu5wyerqhefmhon@treble>
References: <cover.1692919072.git.jpoimboe@kernel.org>
 <ec18b04787fc21874303f29746a49847751eddd6.1692919072.git.jpoimboe@kernel.org>
 <ef77446f-0b9b-ea5e-61b4-da6b747f9892@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ef77446f-0b9b-ea5e-61b4-da6b747f9892@suse.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 25, 2023 at 10:51:04PM +0300, Nikolay Borisov wrote:
> 
> 
> On 25.08.23 г. 10:01 ч., Josh Poimboeuf wrote:
> > SBPB is only enabled in two distinct cases:
> > 
> > 1) when SRSO has been disabled with srso=off
> > 
> > 2) when SRSO has been fixed (in future HW)
> > 
> > Simplify the control flow by getting rid of the 'pred_cmd' label and
> > moving the SBPB enablement check to the two corresponding code sites.
> > This makes it more clear when exactly SBPB gets enabled.
> > 
> > Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
> 
> 
> I think it never was explained why SBPB should be used when SRSO is off/hw
> is not affected? There's nothing in AMD's whitepape and there's nothing in
> the original patch introducing SRSO_NO. This patch deals with the "when",
> but what about the "Why" ? Can you put this in the changelog (if I'm the
> only one missing this detail)?

This patch was merged, but the "why" is that on Zen3/4, the new
microcode adds branch type flushing to IBPB, making IBPB slower.  SBPB
is the "old" IBPB, without branch type flushing.  So if you don't need
the branch type flushing (i.e., to mitigate SRSO) then you can just use
the old IBPB (aka SBPB).

-- 
Josh
