Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E063769529
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 13:47:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231483AbjGaLrD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 07:47:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbjGaLrC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 07:47:02 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FEBDA1;
        Mon, 31 Jul 2023 04:47:01 -0700 (PDT)
Date:   Mon, 31 Jul 2023 13:46:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1690804019;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dRJre5mijQGPG8yCbq1nPfKCkyH0e+oZJUYJftEZTyM=;
        b=RvZlbBTpCHl6pbFoRgu5ODzjCFOC4veU9UqgBKvMmxpGPWFW2NjD1rGzNVIgOT5eS27qJy
        CuFE8ZivIO1ThRMcn9KXBtXMK/3ixoVZxXd03x8i79qnt7w7mgerkYTD6oOk28shkmO+ap
        QygLY8NhVzdtX4EAZCd2Q/3seIHFXFcbnY1TKFk94I9+nLSoeymx+5yuGVnQil2tJS/1Sd
        r7PnnPTJZ1RkMYklDbg1KRNfEtIIwlKfo1LOzGRsKGlhdVrmFjH6OKK29kMj9Yi7PydI6n
        zkoosT3jqBlvePHVbT/nJMIQCKToxIuHM5JlGHPbU1QtTCd04lkwvHHHVNB3Mw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1690804019;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dRJre5mijQGPG8yCbq1nPfKCkyH0e+oZJUYJftEZTyM=;
        b=ANssRL00KjhRF2jaDv9jRsj6cBMGNlzYciO6YlifTUdYuTyIjmZG4aqEGirEdCmnSuPlXl
        T7wB1uRt835tmCAw==
From:   Anna-Maria Behnsen <anna-maria@linutronix.de>
To:     Peter Zijlstra <peterz@infradead.org>
cc:     rafael@kernel.org, tglx@linutronix.de, frederic@kernel.org,
        gautham.shenoy@amd.com, linux-kernel@vger.kernel.org,
        daniel.lezcano@linaro.org, linux-pm@vger.kernel.org,
        mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com
Subject: Re: [RFC][PATCH 0/3] cpuidle,teo: Improve TEO tick decisions
In-Reply-To: <20230728145515.990749537@infradead.org>
Message-ID: <8b6b73a7-aff4-21e-5c55-294fcf67934e@linutronix.de>
References: <20230728145515.990749537@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 28 Jul 2023, Peter Zijlstra wrote:

> Hi,
> 
> Wanted to send this yesterday, but my home server died and took everything
> down :/
> 
> These patches are lightly tested but appear to behave as expected.
> 
> 

As I was asked to see if the patches of Raphael improve the behavior, I
rerun the tests with Raphaels v2 as well as with Peters RFC patchset. Here
are the results (compared to upstream):

			upstream		raphael v2		peter RFC

Idle Total		2533	100.00%		1183	100.00%		5563	100.00%
x >= 4ms		1458	57.56%		1151	97.30%		3385	60.85%
4ms> x >= 2ms		91	3.59%		12	1.01%		133	2.39%
2ms > x >= 1ms		56	2.21%		3	0.25%		80	1.44%
1ms > x >= 500us	64	2.53%		1	0.08%		98	1.76%
500us > x >= 250us	73	2.88%		0	0.00%		113	2.03%
250us > x >=100us	76	3.00%		2	0.17%		106	1.91%
100us > x >= 50us	33	1.30%		4	0.34%		75	1.35%
50us > x >= 25us	39	1.54%		4	0.34%		152	2.73%
25us > x >= 10us	199	7.86%		4	0.34%		404	7.26%
10us > x > 5us		156	6.16%		0	0.00%		477	8.57%
5us > x			288	11.37%		2	0.17%		540	9.71%

tick_nohz_next_event()
count			8839790			6142079			36623


Raphaels Approach still does the tick_nohz_get_sleep_length() execution
unconditional. It executes ~5000 times more tick_nohz_next_event() as the
tick is stopped. This relation improved massively in Peters approach
(factor is ~7).

Thanks,

	Anna-Maria

