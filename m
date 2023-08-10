Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 379397772E8
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 10:30:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234195AbjHJIao (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 04:30:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234159AbjHJIam (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 04:30:42 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DB1DDC
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 01:30:37 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 0238A1F38D;
        Thu, 10 Aug 2023 08:30:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1691656236; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4d3gomxYT1ofllTPcuCL5wAFLP4dHrlKfTQkkM4UoSo=;
        b=CFfrlaRrwFYH55gobDW59FO9zFem56DMOsW1c2+8bFAwqwIzwReIzZaHdNjyJltqAecC33
        c1ll0noLNld3YY7z4knnxr321ZK4fwqEuol35t+4tCCNBPqz6M4tYzy7ifY8QQlX42gP1Q
        1YB+LssHWsKw/kHrXVDsGOkV+Vn/Ut8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1691656236;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4d3gomxYT1ofllTPcuCL5wAFLP4dHrlKfTQkkM4UoSo=;
        b=Jjm8j1DeiffXz3bDNzS0qqR57eBdMif8asgSlM/AkiMje3jw1VCs0ObPGzZYQcn4ZcWDjI
        9qNCBtq5lEoOBpAw==
Received: from suse.de (mgorman.tcp.ovpn2.nue.suse.de [10.163.32.246])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id CFA742C142;
        Thu, 10 Aug 2023 08:30:33 +0000 (UTC)
Date:   Thu, 10 Aug 2023 09:30:28 +0100
From:   Mel Gorman <mgorman@suse.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Cyril Hrubis <chrubis@suse.cz>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org, ltp@lists.linux.it
Subject: Re: [PATCH 0/2 RESEND] Two fixes for sysctl_sched_rr_timeslice
Message-ID: <20230810083028.l2ov4wpffhv3zw3h@suse.de>
References: <20230802151906.25258-1-chrubis@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20230802151906.25258-1-chrubis@suse.cz>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 02, 2023 at 05:19:04PM +0200, Cyril Hrubis wrote:
> - Fixes rounding error for initial value with CONFIG_HZ_300
> 
> - Fixes read from the file after reset to default (by writing val <= 0)
> 

Hi Peter,

Any chance this can be picked up in tip please? It might have helped if
the leader mentioned the main problem covered in patch 1 -- some HZ
values can fail LTP tests due to a simple rounding error at compile
time.

-- 
Mel Gorman
SUSE Labs
