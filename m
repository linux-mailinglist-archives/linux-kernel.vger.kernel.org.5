Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B120576D1FB
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 17:32:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234092AbjHBPcK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 11:32:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234121AbjHBPbw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 11:31:52 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 574C130ED;
        Wed,  2 Aug 2023 08:31:16 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 8995121A0F;
        Wed,  2 Aug 2023 15:31:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1690990274; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PJ1ozCIxCoCOh6j1//RRkt4MpdElTDbfhOayXF9q86o=;
        b=E66j+uoP3FBwS1b6Pwwk3exJFzee3+7rqhTIC6a+Q5Oxa2TFuqTLwqgX1lsp43kLZl9XUE
        GYLlykVWbXyDzvDvFXmIVJLrbjy5HXMhznIcer5aJvpvR4SCIBLN0zN0RHj6vF7e2W2BQw
        kWeweb3pRkSXYL1/tjJ3gmqJDw3NzzY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1690990274;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PJ1ozCIxCoCOh6j1//RRkt4MpdElTDbfhOayXF9q86o=;
        b=jgU0HALcsE/eSXNKzIi1/gOVT0UEyXkzupdQRK3VWTGV4iTHP8um7lFXgCIrc7dvZTzNpd
        0tB1PZsCxjYF28Dg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8173313919;
        Wed,  2 Aug 2023 15:31:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id +9Y9HcF2ymRmLwAAMHmgww
        (envelope-from <rhopkins@suse.de>); Wed, 02 Aug 2023 15:31:13 +0000
Message-ID: <10f9d5152389e3e76f200f737f11ec721a8e148f.camel@suse.de>
Subject: Re: scheduler problems in -next (was: Re: [PATCH 6.4 000/227]
 6.4.7-rc1 review)
From:   Roy Hopkins <rhopkins@suse.de>
To:     paulmck@kernel.org
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Pavel Machek <pavel@denx.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
        rcu@vger.kernel.org, Ingo Molnar <mingo@kernel.org>
Date:   Wed, 02 Aug 2023 16:31:12 +0100
In-Reply-To: <063a2eba-6b5e-40bc-afd4-7d26f12762e4@paulmck-laptop>
References: <20230731143954.GB37820@hirez.programming.kicks-ass.net>
         <f5a18aa3-9db7-6ad2-33d5-3335a18e4e2f@roeck-us.net>
         <20230731145232.GM29590@hirez.programming.kicks-ass.net>
         <7ff2a2393d78275b14ff867f3af902b5d4b93ea2.camel@suse.de>
         <20230731161452.GA40850@hirez.programming.kicks-ass.net>
         <baa58a8e-54f0-2309-b34e-d62999a452a1@roeck-us.net>
         <20230731211517.GA51835@hirez.programming.kicks-ass.net>
         <a05743a3-4dec-6af7-302f-d1d2a0db7d3e@roeck-us.net>
         <8215f037-63e9-4e92-8403-c5431ada9cc9@paulmck-laptop>
         <4f18d78411a5477690640a168e0e5d9f28d1c015.camel@suse.de>
         <063a2eba-6b5e-40bc-afd4-7d26f12762e4@paulmck-laptop>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.46.4 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIzLTA4LTAyIGF0IDA4OjA1IC0wNzAwLCBQYXVsIEUuIE1jS2VubmV5IHdyb3Rl
Ogo+IE9uIFdlZCwgQXVnIDAyLCAyMDIzIGF0IDAyOjU3OjU2UE0gKzAxMDAsIFJveSBIb3BraW5z
IHdyb3RlOgo+ID4gT24gVHVlLCAyMDIzLTA4LTAxIGF0IDEyOjExIC0wNzAwLCBQYXVsIEUuIE1j
S2VubmV5IHdyb3RlOgo+ID4gPiBPbiBUdWUsIEF1ZyAwMSwgMjAyMyBhdCAxMDozMjo0NUFNIC0w
NzAwLCBHdWVudGVyIFJvZWNrIHdyb3RlOgo+ID4gPiAKPiA+ID4gCj4gPiA+IFBsZWFzZSBzZWUg
YmVsb3cgZm9yIG15IHByZWZlcnJlZCBmaXguwqAgRG9lcyB0aGlzIHdvcmsgZm9yIHlvdSBndXlz
Pwo+ID4gPiAKPiA+ID4gQmFjayB0byBmaWd1cmluZyBvdXQgd2h5IHJlY2VudCBrZXJuZWxzIG9j
Y2FzaW9uYWxseSB0byBibG93IHVwIGFsbAo+ID4gPiByY3V0b3J0dXJlIGd1ZXN0IE9TZXMuLi4K
PiA+ID4gCj4gPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqBUaGFueCwgUGF1bAo+ID4gPiAKPiA+ID4gLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCj4gPiA+
IAo+ID4gPiBkaWZmIC0tZ2l0IGEva2VybmVsL3JjdS90YXNrcy5oIGIva2VybmVsL3JjdS90YXNr
cy5oCj4gPiA+IGluZGV4IDcyOTRiZTYyNzI3Yi4uMmQ1YjgzODVjMzU3IDEwMDY0NAo+ID4gPiAt
LS0gYS9rZXJuZWwvcmN1L3Rhc2tzLmgKPiA+ID4gKysrIGIva2VybmVsL3JjdS90YXNrcy5oCj4g
PiA+IEBAIC01NzAsMTAgKzU3MCwxMiBAQCBzdGF0aWMgdm9pZCByY3VfdGFza3Nfb25lX2dwKHN0
cnVjdCByY3VfdGFza3MgKnJ0cCwKPiA+ID4gYm9vbCBtaWRib290KQo+ID4gPiDCoMKgwqDCoMKg
wqDCoMKgaWYgKHVubGlrZWx5KG1pZGJvb3QpKSB7Cj4gPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgbmVlZGdwY2IgPSAweDI7Cj4gPiA+IMKgwqDCoMKgwqDCoMKgwqB9IGVsc2Ug
ewo+ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgbXV0ZXhfdW5sb2NrKCZydHAt
PnRhc2tzX2dwX211dGV4KTsKPiA+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBz
ZXRfdGFza3NfZ3Bfc3RhdGUocnRwLCBSVEdTX1dBSVRfQ0JTKTsKPiA+ID4gwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqByY3V3YWl0X3dhaXRfZXZlbnQoJnJ0cC0+Y2JzX3dhaXQsCj4g
PiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIChuZWVkZ3BjYiA9IHJjdV90YXNrc19uZWVkX2dwY2IocnRwKSksCj4g
PiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIFRBU0tfSURMRSk7Cj4gPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqBtdXRleF9sb2NrKCZydHAtPnRhc2tzX2dwX211dGV4KTsKPiA+ID4gwqDCoMKgwqDC
oMKgwqDCoH0KPiA+ID4gwqAKPiA+ID4gwqDCoMKgwqDCoMKgwqDCoGlmIChuZWVkZ3BjYiAmIDB4
Mikgewo+ID4gCj4gPiBZb3VyIHByZWZlcnJlZCBmaXggbG9va3MgZ29vZCB0byBtZS4KPiA+IAo+
ID4gV2l0aCB0aGUgb3JpZ2luYWwgY29kZSBJIGNhbiBxdWl0ZSBlYXNpbHkgcmVwcm9kdWNlIHRo
ZSBwcm9ibGVtIG9uIG15wqAKPiA+IHN5c3RlbSBldmVyeSAxMCByZWJvb3RzIG9yIHNvLiBXaXRo
IHlvdXIgZml4IGluIHBsYWNlIHRoZSBwcm9ibGVtIG5vCj4gPiBsb25nZXIgb2NjdXJzLgo+IAo+
IFZlcnkgZ29vZCwgdGhhbmsgeW91IcKgIE1heSBJIGFkZCB5b3VyIFRlc3RlZC1ieT8KPiAKPiDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgVGhh
bngsIFBhdWwKWWVzLCBwbGVhc2UgZG8uCg==

