Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F409D77B549
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 11:21:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232482AbjHNJUi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 05:20:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230394AbjHNJUJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 05:20:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 634B2D7;
        Mon, 14 Aug 2023 02:20:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F0D516486A;
        Mon, 14 Aug 2023 09:20:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36761C433C9;
        Mon, 14 Aug 2023 09:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692004807;
        bh=Ty8NGGo3JXqkLqy19/JnXSoN8dOjRRuIxGNMQ/ei/yg=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=ayL/D07sybSSXx91QRT+sfjHSv1xt9+FnHggMXSIPVjQT2ONqxYFnfhkSj+mN8IPU
         R4//m+/pU5sy1y2IV7G6+LMCzADqp/cycW5oNhocoZEtl0Q8hz7vOqM8tbqQDRSGc1
         NEmLROUfR8L/bUzwgOIX/9t8hk2A9NEGvvPRLQj9EjLRYqm3Ur3+4wGXRRFL/Z1euw
         ThLemRoiWudA0feoOVM4bnZE/VgfdnjrRRhVMf8uLBWWBg6ct3Dl+JseG1u9AmPZ2t
         hHOs7Z4N4rFHGiDVqM5Rs+lDfNb9U05yK/VmnUfuIP+SN+mJMNOKzmROfX9o6Kn5UJ
         RopzdLqrfyCrw==
Date:   Mon, 14 Aug 2023 11:20:04 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Illia Ostapyshyn <ostapyshyn@sra.uni-hannover.de>
cc:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nils Fuhler <nils@nilsfuhler.de>
Subject: Re: [PATCH RESEND] HID: input: Support devices sending Eraser without
 Invert
In-Reply-To: <20230613152559.108594-1-ostapyshyn@sra.uni-hannover.de>
Message-ID: <nycvar.YFH.7.76.2308141119290.14207@cbobk.fhfr.pm>
References: <20230613152559.108594-1-ostapyshyn@sra.uni-hannover.de>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Jun 2023, Illia Ostapyshyn wrote:

> Some digitizers (notably XP-Pen Artist 24) do not report the Invert
> usage when erasing.  This causes the device to be permanently stuck with
> the BTN_TOOL_RUBBER tool after sending Eraser, as Invert is the only
> usage that can release the tool.  In this state, Touch and Inrange are
> no longer reported to userspace, rendering the pen unusable.
> 
> Prior to commit 87562fcd1342 ("HID: input: remove the need for
> HID_QUIRK_INVERT"), BTN_TOOL_RUBBER was never set and Eraser events were
> simply translated into BTN_TOUCH without causing an inconsistent state.
> 
> Introduce HID_QUIRK_NOINVERT for such digitizers and detect them during
> hidinput_configure_usage().  This quirk causes the tool to be released
> as soon as Eraser is reported as not set.  Set BTN_TOOL_RUBBER in
> input->keybit when mapping Eraser.
> 
> Fixes: 87562fcd1342 ("HID: input: remove the need for HID_QUIRK_INVERT")
> Co-developed-by: Nils Fuhler <nils@nilsfuhler.de>
> Signed-off-by: Nils Fuhler <nils@nilsfuhler.de>
> Signed-off-by: Illia Ostapyshyn <ostapyshyn@sra.uni-hannover.de>

Applied, thanks.

> ---
> We were wondering about the reason to keep quirk bits reserved for
> backward compatibility.  Is it because of dynamic quirks at module load
> time?  

Yes, that is indeed the case.

Thanks,

-- 
Jiri Kosina
SUSE Labs

