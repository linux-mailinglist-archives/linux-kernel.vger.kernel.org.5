Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 926AB7E04FC
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 15:50:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231631AbjKCOud (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 10:50:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbjKCOub (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 10:50:31 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 79F9D13E
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 07:50:28 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0AEB22F4;
        Fri,  3 Nov 2023 07:51:11 -0700 (PDT)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 97ADF3F64C;
        Fri,  3 Nov 2023 07:50:26 -0700 (PDT)
Message-ID: <ea74c4f0-5881-41c5-932e-3ee297b83728@arm.com>
Date:   Fri, 3 Nov 2023 15:50:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 6/6] sched/uclamp: Simplify uclamp_eff_value()
Content-Language: en-US
To:     Hongyan Xia <Hongyan.Xia2@arm.com>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>
Cc:     Qais Yousef <qyousef@layalina.io>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Christian Loehle <christian.loehle@arm.com>,
        linux-kernel@vger.kernel.org
References: <cover.1696345700.git.Hongyan.Xia2@arm.com>
 <6006f27e2cae8c5f8b00987aa04ee29317aabcc1.1696345700.git.Hongyan.Xia2@arm.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <6006f27e2cae8c5f8b00987aa04ee29317aabcc1.1696345700.git.Hongyan.Xia2@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/10/2023 11:04, Hongyan Xia wrote:
> From: Hongyan Xia <hongyan.xia2@arm.com>
> 
> The commit
> 
> sched: Remove all uclamp bucket logic
> 
> removes uclamp_{inc/dec}() functions, so now p->uclamp contains the

s/uclamp_{inc/dec}/uclamp_rq_{inc/dec}

> correct values all the time after a update_uclamp_active() call, and

s/update_uclamp_active()/uclamp_update_active()

> there's no need to toggle the boolean `active` after an update. As a
> result, this function is fairly simple now and can live as a static
> inline function.

[...]

> -unsigned long uclamp_eff_value(struct task_struct *p, enum uclamp_id clamp_id)
> -{
> -	if (!uclamp_is_used() || !p->uclamp[clamp_id].active)
> -		return uclamp_none(clamp_id);
> -
> -	return p->uclamp[clamp_id].value;
> -}
> -

Is there still a need for p->uclamp[clamp_id].active ? Does
uclamp_eff_value() ever get called with !active ?

And why do we have to set uclamp default values in case (!used ||
!active)? Shouldn't they be set already in this situation?

[...]
