Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CF90765982
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 19:05:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232021AbjG0RFn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 13:05:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232287AbjG0RFf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 13:05:35 -0400
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C720730D6
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 10:05:32 -0700 (PDT)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout01.posteo.de (Postfix) with ESMTPS id 6E6FD240027
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 19:05:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1690477531; bh=qaQROcTztgDRo5sZ8BJWrWwgKHfZqQrdq/uRSJEyT7A=;
        h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:
         Content-Transfer-Encoding:From;
        b=WF6HvPGK6XdEH+dialYIJhpR043AC7A6fLb7j0dqDAt3fkSRpysAkesJdG8naYiGY
         lN6aYYH5M/0NmU1JuyLcshMARYWrgXeZAYVEIL2VXC2MTBDAd3q7m3UW9ZtxQI8LxC
         /5OXac3aV56XWqHFVByYBmRVG9Wu+taczXqbNLSnoC9gCNNQtt9aCleVcl/wdXINIk
         y8c84xpMq5qwmXYUEC188ghNNr0sywEH7hr3q3nNFlmykJPQER5mU1Vvgr4C3WVMcz
         smABoVhB0hZScm6wLNSpJm9ue1fJzjuf76jGURYiM187FWb92owy6tJzezUFLXWbH3
         VoyGAm2Uhsr2Q==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4RBcbG1C2nz6ty1;
        Thu, 27 Jul 2023 19:05:30 +0200 (CEST)
Date:   Thu, 27 Jul 2023 17:05:27 +0000
From:   Daniil Stas <daniil.stas@posteo.net>
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     James.Bottomley@hansenpartnership.com, Jason@zx2c4.com,
        jarkko@kernel.org, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, regressions@leemhuis.info,
        stable@vger.kernel.org, torvalds@linux-foundation.org
Subject: Re: [PATCH 1/1] tpm: disable hwrng for fTPM on some AMD designs
Message-ID: <20230727200527.4080c595@g14>
In-Reply-To: <67eefe98-e6df-e152-3169-44329e22478d@amd.com>
References: <20230727183805.69c36d6e@g14>
        <b1dd27df-744b-3977-0a86-f5dde8e24288@amd.com>
        <20230727193949.55c18805@g14>
        <65a1c307-826d-4ca3-0336-07a185684e5d@amd.com>
        <20230727195019.41abb48d@g14>
        <67eefe98-e6df-e152-3169-44329e22478d@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Jul 2023 11:51:21 -0500
Mario Limonciello <mario.limonciello@amd.com> wrote:

> On 7/27/2023 11:50, Daniil Stas wrote:
> > On Thu, 27 Jul 2023 11:41:55 -0500
> > Mario Limonciello <mario.limonciello@amd.com> wrote:
> >   
> >> On 7/27/2023 11:39, Daniil Stas wrote:  
>  [...]  
>  [...]  
> >>   [...]  
>  [...]  
>  [...]  
> >>
> >> drivers/other is fine.  If there is a better category we can move
> >> it later.  
> > 
> > I see there are already several bug reports similar to mine. This
> > one for example: https://bugzilla.kernel.org/show_bug.cgi?id=217212
> > Should I still make a new one?  
> 
> Yes; please make a separate one.  If we decide it's the same we can 
> always mark as a duplicate.

Here is the bug report I created:
https://bugzilla.kernel.org/show_bug.cgi?id=217719
