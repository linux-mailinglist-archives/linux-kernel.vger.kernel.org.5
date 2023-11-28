Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF2557FB0A0
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 04:37:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234575AbjK1D14 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 22:27:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbjK1D1z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 22:27:55 -0500
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC516CE
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 19:27:58 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1701142077;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ia5FEieqmPFOskYCTTUZA+gPEFuSUkjlm/7c2IG4/g8=;
        b=ru/a1ZFY8Bo3mvKKHLO28+D/W+sXLCDuOyha4vYpgUqppJEAJaj9npBy5qXa+vQOAE2wcW
        lQ67AtqX73AoNgjFSyP9hAo/Ht/TmAH+sHFoXKk9Iu0S8+DK0UjnNN/rRu6Wf/71UnCqxc
        MRyjfuwF2xANgfnaKRF/MdgRZKf/J+8=
Mime-Version: 1.0
Subject: Re: [PATCH 2/7] mm: shrinker: Add a .to_text() method for shrinkers
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20231125003009.tbaxuquny43uwei3@moria.home.lan>
Date:   Tue, 28 Nov 2023 11:27:11 +0800
Cc:     Qi Zheng <zhengqi.arch@bytedance.com>,
        Linux-MM <linux-mm@kvack.org>, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Dave Chinner <david@fromorbit.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <76A1EE85-B62C-49B3-889C-80F9A2A88040@linux.dev>
References: <20231122232515.177833-1-kent.overstreet@linux.dev>
 <20231122232515.177833-3-kent.overstreet@linux.dev>
 <deed9bb1-02b9-4e89-895b-38a84e5a9408@gmail.com>
 <20231123212411.s6r5ekvkklvhwfra@moria.home.lan>
 <4caadff7-1df0-45cc-9d43-e616f9e4ddb3@bytedance.com>
 <20231125003009.tbaxuquny43uwei3@moria.home.lan>
To:     Kent Overstreet <kent.overstreet@linux.dev>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Nov 25, 2023, at 08:30, Kent Overstreet <kent.overstreet@linux.dev> =
wrote:
>=20
> On Fri, Nov 24, 2023 at 11:08:11AM +0800, Qi Zheng wrote:
>> Hi Kent,
>>=20
>> On 2023/11/24 05:24, Kent Overstreet wrote:
>>> On Thu, Nov 23, 2023 at 11:32:59AM +0800, Qi Zheng wrote:
>>>>> + void (*to_text)(struct seq_buf *, struct shrinker *);
>>>>=20
>>>> The "to_text" looks a little strange, how about naming it
>>>> "stat_objects"?
>>>=20
>>> The convention I've been using heavily in bcachefs is
>>> typename_to_text(), or type.to_text(), for debug reports. The
>>=20
>> OK.
>>=20
>>> consistency is nice.
>>=20
>> However, this is inconsistent with the name style of other
>> shrinker callbacks. Please use the "objects" suffix. As for
>> bcachefs's own callback function, you can use typename_to_text()
>> to ensure consistency.
>=20
> That would be inconsistent with introducing a convention to the wider
> kernel.
>=20

I don not think .to_text is a good name. I really do not know what it =
means
when I first look at this name. I knew you want to report the objects of
shrinks, so why not use .report_objects or stat_objects proposed by Qi.
Although .to_text is only used by bcachefs now, shrinker is a general =
module
which is not only serving the bcachefs itself. I think it should be =
better
to use a more straightforward name.

Muchun,
Thanks.=
