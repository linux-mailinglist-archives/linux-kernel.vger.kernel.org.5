Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F46A7A5A06
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 08:37:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229791AbjISGhI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 02:37:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbjISGhG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 02:37:06 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB5C4119;
        Mon, 18 Sep 2023 23:37:00 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2128C433C8;
        Tue, 19 Sep 2023 06:36:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695105420;
        bh=fEmXkRf1BlO1aq/3eAd0nY8VtZl1PlGZ/UWAiyLWBro=;
        h=References:From:To:Cc:Subject:Date:In-reply-to:From;
        b=Qx3HP3frbS/kXweUYyGCFVJD7mZpTD2UVn6XZsXrerjWiRjyRnzalul/+ToeiMrr2
         Jx3j5seVRpfHj88dx9Ufl4FCXDZQ3P+3nBA2iLtXAAL12zJ7j5hJHyf1CNLabIb7cb
         YhZVkpfKi0NWfBxvyI5mvQU+OJVzSeXT7EdLv/x/r9X/NX7MLd5l6rDrVabKeKVNbN
         2EMmz4buEqwbWsHxwJma+z9dv3csHp7IC2aZUJxZZOyo2XPI3MECUMajvEClaFaWLN
         iFqugf2UZJd/8Vx8atexK9KAXpiRQuGEfK7bcUC/ABdOYyqzAmzbAKo2b14hpf7tgD
         hkLha342dA0VQ==
References: <63b3742c-0efe-c096-c737-a0e0419480bd@outlook.com>
 <59dd15dd-5b35-871d-6d3a-ec779975b089@outlook.com>
 <0a72f462-8b8e-4dec-6ce4-f52e33423957@outlook.com>
 <CY8PR05MB9378441D3F6430D1A414142BCDFAA@CY8PR05MB9378.namprd05.prod.outlook.com>
 <20230919032138.GC348037@frogsfrogsfrogs>
User-agent: mu4e 1.8.10; emacs 27.1
From:   Chandan Babu R <chandanbabu@kernel.org>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Wang Jianchao <jianchwa@outlook.com>,
        Chandan Babu R <chandanrlinux@gmail.com>,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3] xfs: use roundup_pow_of_two instead of ffs during
 xlog_find_tail
Date:   Tue, 19 Sep 2023 12:04:44 +0530
In-reply-to: <20230919032138.GC348037@frogsfrogsfrogs>
Message-ID: <874jjqk6t2.fsf@debian-BULLSEYE-live-builder-AMD64>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 18, 2023 at 08:21:38 PM -0700, Darrick J. Wong wrote:
> On Tue, Sep 19, 2023 at 10:06:56AM +0800, Wang Jianchao wrote:
>> Ping ? Do I need other update on this patch ?
>
> Nope, I think this is ok...
>
>> Thanks
>> Jianchao
>> 
>> On 2023/9/13 09:38, Wang Jianchao wrote:
>> > 
>> > In our production environment, we find that mounting a 500M /boot
>> > which is umount cleanly needs ~6s. One cause is that ffs() is
>> > used by xlog_write_log_records() to decide the buffer size. It
>> > can cause a lot of small IO easily when xlog_clear_stale_blocks()
>> > needs to wrap around the end of log area and log head block is
>> > not power of two. Things are similar in xlog_find_verify_cycle().
>> > 
>> > The code is able to handed bigger buffer very well, we can use
>> > roundup_pow_of_two() to replace ffs() directly to avoid small
>> > and sychronous IOs.
>> > 
>> > Reviewed-by: Dave Chinner <dchinner@redhat.com>
>> > Signed-off-by: Wang Jianchao <wangjc136@midea.com>
>
> ...so let's see if the release manager will take this patch.
>
> Chandan?  Could you pull in the various one-off patches floating around
> on the list that have passed review?  ;)

I had picked this patch along with others sometime last week.

I have pushed the new set of commits to official xfs-linux git repository and
sent the announcement mail around 30 mins ago.

>
> Reviewed-by: Darrick J. Wong <djwong@kernel.org>
>
> PS: If you'd like to send a pull request to push things along, please do
>

-- 
Chandan
