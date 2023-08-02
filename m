Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27A9776CF53
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 15:58:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234557AbjHBN6E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 09:58:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234520AbjHBN6A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 09:58:00 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E5592114;
        Wed,  2 Aug 2023 06:57:59 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id B71B31F889;
        Wed,  2 Aug 2023 13:57:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1690984677; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pP0tjlFxJUsves+h5UQpQ/VI40XUAuXUc434UuEEXzc=;
        b=NtGW65uvX6z0QRtIpaJS3fbOrIy1GC3KFNBwZSkKfQOFwc1WuAdCHvCyPSkJCGq5jQw5gc
        rzhAf0nf/XTUTH95rnazWrTic1AtT4u1JXQyQhtFdAXKBxYyx+ypNQ9vhSFP9OrQaIpEiw
        PmunLT76CVUK7sE5r8JcaK05copYLW8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1690984677;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pP0tjlFxJUsves+h5UQpQ/VI40XUAuXUc434UuEEXzc=;
        b=2jdaxtNuejtl2acEEY38pHvyeNX4cPPR+7rnIAiMWimubsHwfCPac1nvkCUSFtOdk8eO+2
        Rpt6IEJmGhpXAvAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BF7EC13909;
        Wed,  2 Aug 2023 13:57:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id PZk9LORgymSRfQAAMHmgww
        (envelope-from <rhopkins@suse.de>); Wed, 02 Aug 2023 13:57:56 +0000
Message-ID: <4f18d78411a5477690640a168e0e5d9f28d1c015.camel@suse.de>
Subject: Re: scheduler problems in -next (was: Re: [PATCH 6.4 000/227]
 6.4.7-rc1 review)
From:   Roy Hopkins <rhopkins@suse.de>
To:     paulmck@kernel.org, Guenter Roeck <linux@roeck-us.net>
Cc:     Peter Zijlstra <peterz@infradead.org>,
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
Date:   Wed, 02 Aug 2023 14:57:56 +0100
In-Reply-To: <8215f037-63e9-4e92-8403-c5431ada9cc9@paulmck-laptop>
References: <3da81a5c-700b-8e21-1bde-27dd3a0b8945@roeck-us.net>
         <20230731141934.GK29590@hirez.programming.kicks-ass.net>
         <20230731143954.GB37820@hirez.programming.kicks-ass.net>
         <f5a18aa3-9db7-6ad2-33d5-3335a18e4e2f@roeck-us.net>
         <20230731145232.GM29590@hirez.programming.kicks-ass.net>
         <7ff2a2393d78275b14ff867f3af902b5d4b93ea2.camel@suse.de>
         <20230731161452.GA40850@hirez.programming.kicks-ass.net>
         <baa58a8e-54f0-2309-b34e-d62999a452a1@roeck-us.net>
         <20230731211517.GA51835@hirez.programming.kicks-ass.net>
         <a05743a3-4dec-6af7-302f-d1d2a0db7d3e@roeck-us.net>
         <8215f037-63e9-4e92-8403-c5431ada9cc9@paulmck-laptop>
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

T24gVHVlLCAyMDIzLTA4LTAxIGF0IDEyOjExIC0wNzAwLCBQYXVsIEUuIE1jS2VubmV5IHdyb3Rl
Ogo+IE9uIFR1ZSwgQXVnIDAxLCAyMDIzIGF0IDEwOjMyOjQ1QU0gLTA3MDAsIEd1ZW50ZXIgUm9l
Y2sgd3JvdGU6Cj4gCj4gCj4gUGxlYXNlIHNlZSBiZWxvdyBmb3IgbXkgcHJlZmVycmVkIGZpeC7C
oCBEb2VzIHRoaXMgd29yayBmb3IgeW91IGd1eXM/Cj4gCj4gQmFjayB0byBmaWd1cmluZyBvdXQg
d2h5IHJlY2VudCBrZXJuZWxzIG9jY2FzaW9uYWxseSB0byBibG93IHVwIGFsbAo+IHJjdXRvcnR1
cmUgZ3Vlc3QgT1Nlcy4uLgo+IAo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqBUaGFueCwgUGF1bAo+IAo+IC0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQo+IAo+
IGRpZmYgLS1naXQgYS9rZXJuZWwvcmN1L3Rhc2tzLmggYi9rZXJuZWwvcmN1L3Rhc2tzLmgKPiBp
bmRleCA3Mjk0YmU2MjcyN2IuLjJkNWI4Mzg1YzM1NyAxMDA2NDQKPiAtLS0gYS9rZXJuZWwvcmN1
L3Rhc2tzLmgKPiArKysgYi9rZXJuZWwvcmN1L3Rhc2tzLmgKPiBAQCAtNTcwLDEwICs1NzAsMTIg
QEAgc3RhdGljIHZvaWQgcmN1X3Rhc2tzX29uZV9ncChzdHJ1Y3QgcmN1X3Rhc2tzICpydHAsIGJv
b2wgbWlkYm9vdCkKPiDCoMKgwqDCoMKgwqDCoMKgaWYgKHVubGlrZWx5KG1pZGJvb3QpKSB7Cj4g
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBuZWVkZ3BjYiA9IDB4MjsKPiDCoMKgwqDC
oMKgwqDCoMKgfSBlbHNlIHsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgbXV0ZXhf
dW5sb2NrKCZydHAtPnRhc2tzX2dwX211dGV4KTsKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoHNldF90YXNrc19ncF9zdGF0ZShydHAsIFJUR1NfV0FJVF9DQlMpOwo+IMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcmN1d2FpdF93YWl0X2V2ZW50KCZydHAtPmNic193YWl0
LAo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIChuZWVkZ3BjYiA9IHJjdV90YXNrc19uZWVkX2dwY2IocnRwKSksCj4g
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgVEFTS19JRExFKTsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
bXV0ZXhfbG9jaygmcnRwLT50YXNrc19ncF9tdXRleCk7Cj4gwqDCoMKgwqDCoMKgwqDCoH0KPiDC
oAo+IMKgwqDCoMKgwqDCoMKgwqBpZiAobmVlZGdwY2IgJiAweDIpIHsKCllvdXIgcHJlZmVycmVk
IGZpeCBsb29rcyBnb29kIHRvIG1lLgoKV2l0aCB0aGUgb3JpZ2luYWwgY29kZSBJIGNhbiBxdWl0
ZSBlYXNpbHkgcmVwcm9kdWNlIHRoZSBwcm9ibGVtIG9uIG15wqAKc3lzdGVtIGV2ZXJ5IDEwIHJl
Ym9vdHMgb3Igc28uIFdpdGggeW91ciBmaXggaW4gcGxhY2UgdGhlIHByb2JsZW0gbm8KbG9uZ2Vy
IG9jY3Vycy4KCgo=

