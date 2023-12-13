Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A2F7810671
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 01:27:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232632AbjLMA1M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 19:27:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232505AbjLMA1L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 19:27:11 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A769192
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 16:27:17 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AF93C433C7;
        Wed, 13 Dec 2023 00:27:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702427237;
        bh=/H2khaMF8vfAJM4ApUDC7NOWw3ck3r3U1TwZFrVK9ms=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KcSt3eln+BKAmUyTk71p1Gk6qbrqaamO+PJwTOuVkOnIffWJDeE62pLLyzF5/FhUi
         fsutcvPuqwu5Hqg24mMh/3PIZYYx/IcaaIR860xHfY7BFU7mFYc7gybnZtfp2YbZ8M
         liIcHj/63BIVsyCESyZK0XofpkNuWXua+5mpfinuRr958yMdB312N89rNSABjwiTe7
         aHk3t5Rj8NmqYNVC102m/ereHCjTixuse6KsbFC4NXlCRTVBCqpAmKLuKhjmW29+qD
         6Uzdo4WaPrsBYUaLLgtUA49Rbm4bxhZMyB4G2NTjwu/0Dv6NfrW0w90wfYXCcb/NFP
         NdkHfVNSrK+yg==
Date:   Tue, 12 Dec 2023 16:27:15 -0800
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     Dimitri John Ledkov <dimitri.ledkov@canonical.com>
Cc:     Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] objtool: Make objtool check actually fatal upon fatal
 errors
Message-ID: <20231213002715.w5cqo5ataaevivop@treble>
References: <20231212185339.1562967-1-dimitri.ledkov@canonical.com>
 <20231212203031.uudk57xhegi5yziz@treble>
 <CADWks+aDuPcwmOCSmnQ4T-mKZ-N55-L+cS1ww2huEAXQnc_q8Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CADWks+aDuPcwmOCSmnQ4T-mKZ-N55-L+cS1ww2huEAXQnc_q8Q@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 12, 2023 at 08:39:30PM +0000, Dimitri John Ledkov wrote:
> Well, I'm hoping to add --error option next, and yeah, make warnings
> fatal. Or for example at least make the retpoline, sls, rethumb ones
> to be fatal - because i found myself in a very surprising situation
> where retpoline enabled build of kernel, had non-retpoline paths
> remaining and not otherwise silenced as safe.
> 
> Maybe I should finish that second patch and make it available as a
> config option.
> 
> At least right now, with Ubuntu Noble (development series) and
> v6.7-rc4 everything is squeaky clean to enable CONFIG_OBJTOOL_WERROR=y
> and make all warnings, fatal.
> 
> Also i think having it as a config option will result in various
> automation tools able to flip it on, and submit bug reports when
> something somewhere regresses.

Right, the warnings should never be ignored.

I agree we need CONFIG_OBJTOOL_WERROR.  Problem is, upstream supports a
lot more than just Ubuntu configs, and there are several outstanding
warnings, reported by both bots and humans.

Fixing them is on my TODO list, it's just that other things are taking
priority.

If we introduce CONFIG_OBJTOOL_WERROR now, build bots will start
reporting build failures and people will start complaining more loudly.
Without more help I'm lacking the bandwidth to stay on top of that.

-- 
Josh
