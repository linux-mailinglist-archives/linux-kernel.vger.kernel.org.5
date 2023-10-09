Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13B9E7BE378
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 16:49:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344535AbjJIOtD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 10:49:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234545AbjJIOtB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 10:49:01 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF4F7AC;
        Mon,  9 Oct 2023 07:48:58 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1696862937;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XGxzYbViuLT+KjbnCIr8b+GOy6d8U/BxcG6sWQXRcpQ=;
        b=hJ6zUXy9y3Uy8vXAPRTUbYIcxL4U8ppbEpeNWPjl/+fBMBbSyUldQoPVHkYlwznvj2f7aL
        Ci6aVT88LzPEsKicU3iZgPrjFBaW7+7yoEFF6eeNVWb6/CZD9230Z1EzMZ+zryQB+Z4DgO
        EeVZZ4x4D6clgFM3KSE53eV3DDe6huKwaz+rTQLb0Uvz+CriLRDtGeF/SV+jaE3jU4NXS/
        KHJBZXHPh8wleE7+dVDnx5MZZ2uJoU9yXU+oAW7wP/xAbTPed+c1QIs9Ht8uhGK9B/TYjG
        iSkxpWJoTcJbHrYJIi0f09Jkby0RWby80jYgM81QKjs1amBaUGYBSnKlEVtbbQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1696862937;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XGxzYbViuLT+KjbnCIr8b+GOy6d8U/BxcG6sWQXRcpQ=;
        b=1wVwgSzenBvoDOxvUMkRgbpNWU3QEC6JIfSpqjbdJQtHEeR1FobUXAvZnWAXFHgNzOVdcA
        1TNcijX6xKzK4AAw==
To:     Richard Cochran <richardcochran@gmail.com>,
        John Stultz <jstultz@google.com>
Cc:     =?utf-8?B?TWFoZXNoIEJhbmRld2FyICAgICAgICAgKOCkruCkueClh+CktiDgpKzgpII=?=
         =?utf-8?B?4KSh4KWH4KS14KS+?= <maheshb@google.com>,
        Netdev <netdev@vger.kernel.org>,
        Linux <linux-kernel@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Don Hatchett <hatch@google.com>,
        Yuliang Li <yuliangli@google.com>,
        Mahesh Bandewar <mahesh@bandewar.net>,
        Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH 1/4] time: add ktime_get_cycles64() api
In-Reply-To: <ZRiP9mgFjLpKHj8N@hoboy.vegasvil.org>
References: <20230929023737.1610865-1-maheshb@google.com>
 <CANDhNCqb5JzEDOdAnocanR2KFbokrpMOL=iNwY3fTxcn_ftuZQ@mail.gmail.com>
 <CAF2d9jgeGLCzbFZhptGzpUnmMgLaRysyzBmpZ+dK4sxWdmR5ZQ@mail.gmail.com>
 <CANDhNCro+AQum3eSmKK5OTNik2E0cFxV_reCQg0+_uTubHaDsA@mail.gmail.com>
 <CANDhNCryn8TjJZRdCvVUj88pakHSUvtyN53byjmAcyowKj5mcA@mail.gmail.com>
 <ZRiP9mgFjLpKHj8N@hoboy.vegasvil.org>
Date:   Mon, 09 Oct 2023 16:48:56 +0200
Message-ID: <87o7h7q2av.ffs@tglx>
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

On Sat, Sep 30 2023 at 14:15, Richard Cochran wrote:
> On Fri, Sep 29, 2023 at 12:06:46AM -0700, John Stultz wrote:
>> But I still think we should avoid exporting the raw cycle values
>> unless there is some extremely strong argument for it
>
> Looks like the argument was based on a misunderstanding of what
> CLOCK_MONOTONIC_RAW actually is.  So, please, let's not expose the raw
> cycle counter value.

Correct. Exposing the raw counter value is broken if the counter wraps
around on a regular base.

Thanks,

        tglx

