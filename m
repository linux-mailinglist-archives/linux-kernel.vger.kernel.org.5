Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6029807B9F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 23:44:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377642AbjLFWoC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 17:44:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbjLFWoB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 17:44:01 -0500
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24D8ED5B;
        Wed,  6 Dec 2023 14:44:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=To9ucKTvN543g4EQHIcIczpJa6wUxMMz7xk5pdznqwo=; b=d7JS3LFBmBt2LemFl6aJnf7yrF
        pktEdrm6H+yEfe9JcinFzn2+knQltLAeCaA+mlRWiBCntnBj1n6YexrKopAcaIm7/wBwzlptDJfjg
        lQcKyE45QDLdcJHeY50G+k/QkMfNYiuJV9uB51Jf3EF8ZecSwBh3AKgKZGINkhCSOT6v3fRcgbNVV
        dRD9F667VjY15hhfGY2eXLoh3nusDt3R1U4sP9tTYX9qCv9rkVunAt0zmmuQCOcR12J/t0/Rijk5G
        5QsQX7NfkvItf5GJoUy8sNbDLuEMTli4wF3kZ/zaknTxGzIlvCyWsggLgXndvhWj+AtfXb2VR7xqj
        atGi9E0g==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1rB0ca-007y6e-06;
        Wed, 06 Dec 2023 22:44:00 +0000
Date:   Wed, 6 Dec 2023 22:43:59 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     David Laight <David.Laight@aculab.com>
Cc:     "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
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
        Paolo Abeni <pabeni@redhat.com>,
        Eric Dumazet <edumazet@google.com>
Subject: Re: [RFC][PATCHES v2] checksum stuff
Message-ID: <20231206224359.GR1674809@ZenIV>
References: <20231019050250.GV800259@ZenIV>
 <20231019061427.GW800259@ZenIV>
 <20231019063925.GX800259@ZenIV>
 <CANn89iJre=VQ6J=UuD0d2J5t=kXr2b9Dk9b=SwzPX1CM+ph60A@mail.gmail.com>
 <20231019080615.GY800259@ZenIV>
 <20231021071525.GA789610@ZenIV>
 <20231021222203.GA800259@ZenIV>
 <20231022194020.GA972254@ZenIV>
 <20231205022100.GB1674809@ZenIV>
 <602ab11ffa2c4cc49bb9ecae2f0540b0@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <602ab11ffa2c4cc49bb9ecae2f0540b0@AcuMS.aculab.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 06, 2023 at 11:10:45AM +0000, David Laight wrote:

> Do we?
> I've not seen any justification for this at all.
> IIRC the ICMPv4 reply code needs the checksum function return 0xffff
> for all-zero input.
> 
> So the correct and simple fix is to initialise the sum to 0xffff
> in the checksum function.

You do realize that ICMPv4 reply code is not the only user of those,
right?  Sure, we can special-case it there.  And audit the entire
call tree, proving that no other call chains need the same.

Care to post the analysis?  I have the beginnings of that and it's already
long and convoluted and touches far too many places, all of which will
have to be watched indefinitely, so that changes in there don't introduce
new breakage.

I could be wrong.  About many things, including the depth of your
aversion to RTFS.  But frankly, until that analysis shows up somewhere,
I'm going to ignore your usual handwaving.
