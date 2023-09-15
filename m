Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF4C57A26DE
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 21:03:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236932AbjIOTDb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 15:03:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237101AbjIOTDR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 15:03:17 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F7E630DA
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 12:02:09 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1694804527;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Dt9kJ6Ff6Lpaj1GdR7agEr2M8M442ofH0gFpnzYx1Q4=;
        b=kYyrEUNn5FUKON/qwXOiT/XoKbtG+jKjkilvHjaY8AeFJzgeFolghkNGS+tN6gPS4uC17a
        /hybAwsz9Na9adxJb8LsDN19ilNLRhHdoSnE6GqAAp76RLhtEFF75210mUbcw8V84ozBTu
        lxpBDmxP93RQ58JJ/wiGesR3HpXVtwJFt4/hr8w+KUklk/TBwvBHEf7QSLOUy/aUYr3j6c
        236Av+M8G+Wg5RU7ldk+qudSWzuE5CDpxGfhe6SBlmCSh+Jl5sWLWUCnaiQcBkIsBGkAsg
        WKdxUCQWUL2PPbt4Q+sQ3wBZrE+wNzbdTyVjTtM3Lt04tVG2j5DgwcjCyTueIw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1694804527;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Dt9kJ6Ff6Lpaj1GdR7agEr2M8M442ofH0gFpnzYx1Q4=;
        b=ZY8z338kN+7HXOmuhzBOvGcDKzQtvVQJmELKTEFl4hfEeVdTACOYozlhaNlbacAntd+xnU
        hosLSt3CEEtsqhBg==
To:     Peter Hilber <peter.hilber@opensynergy.com>,
        linux-kernel@vger.kernel.org
Cc:     John Stultz <jstultz@google.com>, Stephen Boyd <sboyd@kernel.org>,
        "Christopher S. Hall" <christopher.s.hall@intel.com>
Subject: Re: [RFC PATCH v2 2/6] timekeeping: Fix cross-timestamp
 interpolation corner case decision
In-Reply-To: <36b2f11b-9dfd-b721-c97e-478eabceb4cf@opensynergy.com>
References: <20230818012014.212155-1-peter.hilber@opensynergy.com>
 <20230818012014.212155-3-peter.hilber@opensynergy.com>
 <87a5tn1kp6.ffs@tglx>
 <36b2f11b-9dfd-b721-c97e-478eabceb4cf@opensynergy.com>
Date:   Fri, 15 Sep 2023 21:02:07 +0200
Message-ID: <874jjv1cr4.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 15 2023 at 19:30, Peter Hilber wrote:
> On 15.09.23 18:10, Thomas Gleixner wrote:
>> So the explanation in the changelog makes some sense, but this code
>> without any further explanation just makes my brain explode.
>> 
>> This whole thing screams for a change to cycle_between() so it becomes:
>> 
>>      timestamp_in_interval(start, end, ts)
>> 
>> and make start inclusive and not exclusive, no?
>
> I tried like this in v1 (having 'end' inclusive as well), but didn't like
> the effect at the second usage site.
>
>> 
>> That's actually correct for both usage sites because for interpolation
>> the logic is the same. history_begin->cycles is a valid timestamp, no?
>
> AFAIU, with the timestamp_in_interval() change, history_begin->cycles would
> become a valid timestamp. To me it looks like
> adjust_historical_crosststamp() should then work unmodified for now. But
> one would have to be careful with the additional corner case in the future.
>
> So, document the current one-line change, or switch to
> timestamp_in_interval()?

I really prefer the consistent function which treats the start as
inclusive as that makes the most sense and is self explanatory.

Thanks,

        tglx
