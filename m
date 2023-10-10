Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA6587BFB1D
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 14:20:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231734AbjJJMUK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 08:20:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231714AbjJJMUH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 08:20:07 -0400
Received: from 1.mo560.mail-out.ovh.net (1.mo560.mail-out.ovh.net [46.105.63.121])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C90859D
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 05:20:05 -0700 (PDT)
Received: from director6.ghost.mail-out.ovh.net (unknown [10.108.20.96])
        by mo560.mail-out.ovh.net (Postfix) with ESMTP id B15B128910
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 12:20:03 +0000 (UTC)
Received: from ghost-submission-6684bf9d7b-nrnbc (unknown [10.110.103.46])
        by director6.ghost.mail-out.ovh.net (Postfix) with ESMTPS id BE0761FEC1;
        Tue, 10 Oct 2023 12:20:02 +0000 (UTC)
Received: from RCM-web10.webmail.mail.ovh.net ([151.80.29.18])
        by ghost-submission-6684bf9d7b-nrnbc with ESMTPSA
        id OdwFLHJBJWXSDQAAjjGCXQ
        (envelope-from <jose.pekkarinen@foxhound.fi>); Tue, 10 Oct 2023 12:20:02 +0000
MIME-Version: 1.0
Date:   Tue, 10 Oct 2023 15:20:02 +0300
From:   =?UTF-8?Q?Jos=C3=A9_Pekkarinen?= <jose.pekkarinen@foxhound.fi>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>, seanjc@google.com,
        skhan@linuxfoundation.org, dave.hansen@linux.intel.com,
        kvm@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com, bp@alien8.de, hpa@zytor.com, tglx@linutronix.de,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH] kvm/sev: make SEV/SEV-ES asids configurable
In-Reply-To: <5c19c422-41ad-430b-664c-15f3e2087922@redhat.com>
References: <20231010100441.30950-1-jose.pekkarinen@foxhound.fi>
 <2023101050-scuff-overstay-9b43@gregkh>
 <5c19c422-41ad-430b-664c-15f3e2087922@redhat.com>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <0c73f3ee77afe22879fbbed8a34f838f@foxhound.fi>
X-Sender: jose.pekkarinen@foxhound.fi
Organization: Foxhound Ltd.
X-Originating-IP: 192.42.116.173
X-Webmail-UserID: jose.pekkarinen@foxhound.fi
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 4716113239035455142
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvkedrheehgdeglecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeggfffhvfevufgjfhgfkfigohhitgfgsehtkehjtddtreejnecuhfhrohhmpeflohhsrocurfgvkhhkrghrihhnvghnuceojhhoshgvrdhpvghkkhgrrhhinhgvnhesfhhogihhohhunhgurdhfiheqnecuggftrfgrthhtvghrnhepkefhgeduudefgedvleegtddvffeghedvtdekveekjeevvdegiedtfeelhedtiedtnecukfhppeduvdejrddtrddtrddupdduledvrdegvddrudduiedrudejfedpudehuddrkedtrddvledrudeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepuddvjedrtddrtddruddpmhgrihhlfhhrohhmpeeojhhoshgvrdhpvghkkhgrrhhinhgvnhesfhhogihhohhunhgurdhfiheqpdhnsggprhgtphhtthhopedupdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdfovfetjfhoshhtpehmohehiedtpdhmohguvgepshhmthhpohhuth
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-10-10 14:40, Paolo Bonzini wrote:
> On 10/10/23 13:35, Greg KH wrote:
>> On Tue, Oct 10, 2023 at 01:04:39PM +0300, José Pekkarinen wrote:
>>> There are bioses that doesn't allow to configure the
>>> number of asids allocated for SEV/SEV-ES, for those
>>> cases, the default behaviour allocates all the asids
>>> for SEV, leaving no room for SEV-ES to have some fun.
> 
> In addition to what Greg pointed out (and there are many more cases
> that have to be checked for errors, including possible overflows), why
> is it correct to just ignore what's in CPUID?

     I'll check if I can use cpuid info to improve this
for v2, I just noticed my cpu advertises sev_es but
the kernel doesn't activate it despite of the kvm_amd
parameter being set, so I tried to fix it this way, but
any comments or ideas for improvement are welcomed.

     Thanks!

     José.
