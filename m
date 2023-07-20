Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D546875B902
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 22:57:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbjGTU5s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 16:57:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbjGTU5r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 16:57:47 -0400
Received: from icts-p-cavuit-3.kulnet.kuleuven.be (icts-p-cavuit-3.kulnet.kuleuven.be [134.58.240.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EEF319A6;
        Thu, 20 Jul 2023 13:57:44 -0700 (PDT)
X-KULeuven-Envelope-From: jo.vanbulck@cs.kuleuven.be
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-KULeuven-Scanned: Found to be clean
X-KULeuven-ID: 277772016B.A90BB
X-KULeuven-Information: Katholieke Universiteit Leuven
Received: from icts-p-ceifnet-smtps-0.kuleuven.be (icts-p-ceifnet-smtps.service.icts.svcd [IPv6:2a02:2c40:0:51:143:242:ac11:20])
        by icts-p-cavuit-3.kulnet.kuleuven.be (Postfix) with ESMTP id 277772016B;
        Thu, 20 Jul 2023 22:57:42 +0200 (CEST)
BCmilterd-Mark-Subject: no
BCmilterd-Errors: 
BCmilterd-Report: SA-HVU#DKIM_VALID_AU#0.00,SA-HVU#DKIM_SIGNED#0.00,SA-HVU#DKIM_VALID#0.00
X-CAV-Cluster: smtps
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cs.kuleuven.be;
        s=cav; t=1689886662;
        bh=JK6gBvlZETluNpz/AU2Nfh84PH0YEjTmg3P3IF9GaLA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=Wsfxk4St7q2jIPpQNz6aWaTxHc2GNfDFSxUng0x2nuc7h3VKM6JC/bagMxQcckTrJ
         XTJq4XZNn7GP30+1W7NFNuuTJ9UpvbRYK6R9igG8zop3dm8HcNbk6EHMWqyvooSbXj
         pQDqEQ+YKHK7nCzvgVx/+aI8gytw0ikO3l5VKdlk=
Received: from [IPV6:2a02:1210:6c17:f000:af2b:c1b5:c15b:acda] (unknown [IPv6:2a02:1210:6c17:f000:af2b:c1b5:c15b:acda])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by icts-p-ceifnet-smtps-0.kuleuven.be (Postfix) with ESMTPSA id C0FB6D4EB1016;
        Thu, 20 Jul 2023 22:57:41 +0200 (CEST)
Message-ID: <a51dde86-b2e5-569a-81ce-78db66986302@cs.kuleuven.be>
Date:   Thu, 20 Jul 2023 22:57:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 0/4] selftests/sgx: Harden test enclave
Content-Language: en-US
To:     Dave Hansen <dave.hansen@intel.com>,
        Jarkko Sakkinen <jarkko@kernel.org>, linux-sgx@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     dave.hansen@linux.intel.com
References: <20230719142500.13623-1-jo.vanbulck@cs.kuleuven.be>
 <CU76BC9V7H3Z.TQ3L8AZY1WD@suppilovahvero>
 <a6e26927-acb0-c967-10c4-90a41d9a8cad@cs.kuleuven.be>
 <715e3263-02a8-9d0e-8b34-e79adc0595a0@intel.com>
X-Kuleuven: This mail passed the K.U.Leuven mailcluster
From:   Jo Van Bulck <jo.vanbulck@cs.kuleuven.be>
In-Reply-To: <715e3263-02a8-9d0e-8b34-e79adc0595a0@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20.07.23 21:56, Dave Hansen wrote:
> On the other hand, if we don't leave glaring, known "security"
> vulnerabilities in it, even more people will be fooled into trying to
> use our example code for something that needs actual security.

I see the reasoning, but I'm afraid it's generally hard to stop people 
from copying good examples as templates for their own projects..

I do believe in the value of clean, minimal open-source example enclave 
code. In this respect, I personally (and others on the past mailing list 
as well, it seems) really like the minimal self-contained Linux selftest 
enclave! I think, with the fixes in this patch series, the Linux 
selftest enclave can continue to bring value to the community and help 
in further diversifying the open-source SGX ecosystem.

FWIW, I'd not call these "glaring" security holes, but rather subtle 
oversights that I think most people who would copy the code today may 
well not be aware of and inherit unknowingly (e.g., reference [2] from 
my original message did a wide-scale study of the open-source SGX 
ecosystem as of 2019 and showed exactly these kinds of ABI/API 
vulnerabilities were widespread and re-occurring in several SGX 
production projects).

> I personally don't know the first thing about writing a secure enclave.
> I just know it's _really_ hard and I honestly don't expect someone to do
> it without the help of the SDK.

Agreed, it _is_ hard indeed. And it has been a moving target over the 
years, especially with software/compiler defenses for different waves of 
microarchitectural vulnerabilities (Spectre, LVI, etc.). That being 
said, I do think that we learned a lot as a community and we have a much 
better grasp on how to write (reasonably) secure enclave software these 
days. Sanitizing the ABI and API remains a core enclave software 
responsibility (whereas microarchitectural attacks can arguably be 
mostly mitigated through hardware silicon/ucode patches and/or automatic 
compiler mitigations).

I do agree that sane end users should use a shielding runtime to 
abstract away most of these concerns, where the Intel SGX SDK is just 
one of many in a growing open-source SGX ecosystem (see for instance 
earlier references [2,3] for an overview).

But there may be good reasons to want to do things from scratch when 
building your own SGX shielding runtime, e.g., support for custom 
languages (Rust, Go) or library OSs. I think the Linux selftest enclave 
helps in further diversifying the open-source SGX ecosystem and can 
provide an excellent starting point (with the fixes in this patch series).

Best,
Jo
