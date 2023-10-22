Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2BE07D22D1
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Oct 2023 13:12:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231773AbjJVLMG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Oct 2023 07:12:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjJVLMF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Oct 2023 07:12:05 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FC38E3
        for <linux-kernel@vger.kernel.org>; Sun, 22 Oct 2023 04:12:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=fypmIzyeNXIf0U3i1Yj27gKRGNQ1W+imAB6IJ7sDhWc=; b=i/6mmGhvTpO9SEmfHNoLWJdAqI
        KSsSe3mLZvuS0tFrlPGqm/npxWotcDKdM5z/67WSyFlXSL/fqY63H2KxMdDVHTllGVV6zfrts/vD/
        h7Y4T9rHuyYlockKweeMzAXN6yXeAZqiqTtEHlBbUB+bd5vxoQt5hnHlEuPUoIBYheQKsESBelU5M
        CL2Dk1BOxqi4fbSSITOVZpNAcArmxC4t7FAS8D3DKBQfCFn7J3l+7fc8SHoecxRbOr3St8d98Wj3n
        tBkyd9b5iM9W7WvNCYJX8dWAskvvAhvfvrO5eRlhxHZsbHkMT63DjZgbbAz9Qd+8w2H/tHidC9Jc0
        JCiOlbmg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1quWN7-003wW1-0E;
        Sun, 22 Oct 2023 11:11:53 +0000
Date:   Sun, 22 Oct 2023 12:11:53 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     David Laight <David.Laight@aculab.com>
Cc:     Eric Dumazet <edumazet@google.com>,
        gus Gusenleitner Klaus <gus@keba.com>,
        Al Viro <viro@ftp.linux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        "dsahern@kernel.org" <dsahern@kernel.org>,
        "kuba@kernel.org" <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Subject: Re: AW: [PATCH] amd64: Fix csum_partial_copy_generic()
Message-ID: <20231022111153.GB800259@ZenIV>
References: <20231018154205.GT800259@ZenIV>
 <VI1PR0702MB3840F2D594B9681BF2E0CD81D9D4A@VI1PR0702MB3840.eurprd07.prod.outlook.com>
 <20231019050250.GV800259@ZenIV>
 <20231019061427.GW800259@ZenIV>
 <20231019063925.GX800259@ZenIV>
 <CANn89iJre=VQ6J=UuD0d2J5t=kXr2b9Dk9b=SwzPX1CM+ph60A@mail.gmail.com>
 <20231019080615.GY800259@ZenIV>
 <20231021071525.GA789610@ZenIV>
 <20231021222203.GA800259@ZenIV>
 <5487af5c8c184ac896af2d0b32b3ff42@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5487af5c8c184ac896af2d0b32b3ff42@AcuMS.aculab.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 22, 2023 at 11:03:39AM +0000, David Laight wrote:

> > +			return -1;
> 
> If you are going to return -1 the return type should be signed.

It's a perfectly valid C to have return -1 in a function that
returns unsigned long long (or any other unsigned type, really)...
