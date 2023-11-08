Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62AAA7E581A
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 14:46:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232401AbjKHNqb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 08:46:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230467AbjKHNqa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 08:46:30 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFBFE1BEC
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 05:46:27 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCB72C433C7;
        Wed,  8 Nov 2023 13:46:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699451187;
        bh=9piwSVb+iOfZNKJlZd2BLlMYfsPN89K6I354wLk+mtw=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=BEHY5O5x4R554f6C6AzJfaEzT5qyRhY5HA/d3lr89kWErjSri0MuiufM5ECKCTf9E
         96DlStXktOOmaYrwhyZqDvAUR/XQchMrEy0GCBOS7ljv0zY0Qgi98Dj7cKO/Sb25HQ
         FDSaC4sXUoj4pLpLeuysmtk79mDUuW8cLx9ksVtkPlm+fm5IT1/KBLd2bbNyue4/CY
         HokkiufhYVUOzwxdRdpv3xaZP3iI4F5TpfAUHZAuofByHA1DHJTsd+fdnpsqLe+De+
         kRYSvPejKQHjc0RhZLV5tMvXXvRQ6L4a/d9Qshmg+0bge3r5ViTbvJqZHZsIZhfz7V
         m3sH/tNvA1pRg==
Message-ID: <599225f2-9a51-4a95-bbe8-58a5febfe80b@kernel.org>
Date:   Wed, 8 Nov 2023 14:46:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 6/7] sched/deadline: Deferrable dl server
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Daniel Bristot de Oliveira <bristot@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org,
        Luca Abeni <luca.abeni@santannapisa.it>,
        Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vineeth Pillai <vineeth@bitbyteword.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Phil Auld <pauld@redhat.com>
References: <cover.1699095159.git.bristot@kernel.org>
 <c7b706d30d6316c52853ca056db5beb82ba72863.1699095159.git.bristot@kernel.org>
 <CAEXW_YS=PrWDx+YGVR7bmq0_SoKNztzGrreApCd9qk1yBLA5bA@mail.gmail.com>
 <CAEXW_YQ8kv3tXQJexLSguPuWi0bXiReKDyYNo9+A-Hgp=Zo1vA@mail.gmail.com>
 <CAEXW_YSjsZSrJK_RbGmbLNy4UrLCgu+7NPZjg-wiLuNbGOGr+w@mail.gmail.com>
 <20231107114732.5dd350ec@gandalf.local.home>
 <7d1ea71b-5218-4ee0-bc89-f02ee6bd5154@redhat.com>
 <3e58fad7-7f66-4e48-adcc-0fda9e9d0d07@kernel.org>
 <20231108124401.GQ8262@noisy.programming.kicks-ass.net>
Content-Language: en-US, pt-BR, it-IT
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
In-Reply-To: <20231108124401.GQ8262@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/8/23 13:44, Peter Zijlstra wrote:
> Because the above also causes period drift, which we do not want.

The period drift is not a problem when we do not have DL tasks because
... we do not have dl tasks. The task will run for runtime.

But not doing the period drift is bad if we have DL tasks because we
break the (current u <= U) rule... which breaks CBS/EDF.

