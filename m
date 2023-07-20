Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBFB475B79F
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 21:12:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230246AbjGTTMg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 15:12:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbjGTTMa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 15:12:30 -0400
Received: from icts-p-cavuit-4.kulnet.kuleuven.be (icts-p-cavuit-4.kulnet.kuleuven.be [134.58.240.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 417ED1996;
        Thu, 20 Jul 2023 12:12:22 -0700 (PDT)
X-KULeuven-Envelope-From: jo.vanbulck@cs.kuleuven.be
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-KULeuven-Scanned: Found to be clean
X-KULeuven-ID: 306023E.A9684
X-KULeuven-Information: Katholieke Universiteit Leuven
Received: from icts-p-ceifnet-smtps-0.kuleuven.be (icts-p-ceifnet-smtps.service.icts.svcd [IPv6:2a02:2c40:0:51:143:242:ac11:20])
        by icts-p-cavuit-4.kulnet.kuleuven.be (Postfix) with ESMTP id 306023E;
        Thu, 20 Jul 2023 21:12:19 +0200 (CEST)
BCmilterd-Mark-Subject: no
BCmilterd-Errors: 
BCmilterd-Report: SA-HVU#DKIM_VALID_AU#0.00,SA-HVU#DKIM_SIGNED#0.00,SA-HVU#DKIM_VALID#0.00
X-CAV-Cluster: smtps
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cs.kuleuven.be;
        s=cav; t=1689880339;
        bh=xNUxqK1R5VTNPAGLqFndyY2LGO0x/eTnGj2ufVA0aAA=;
        h=Date:From:Subject:To:Cc:References:In-Reply-To;
        b=M9s7zLgu4zO9gWWlBmzHztoRxHakiIk8n2mpwAv3WaOVBNCd0vqymZ8EztVoT72Tg
         NTxH8JpFON9ezN0XO7vG0Y6wHbW058y7dxCEYAxZs8XtKu92IuFlHMytsp8trHJmr/
         uKaMej0M/Mp2bH4DHDHIptb5yhT90XA80ilJU1jk=
Received: from [IPV6:2a02:1210:6c17:f000:af2b:c1b5:c15b:acda] (unknown [IPv6:2a02:1210:6c17:f000:af2b:c1b5:c15b:acda])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by icts-p-ceifnet-smtps-0.kuleuven.be (Postfix) with ESMTPSA id DA920D4E6B1DB;
        Thu, 20 Jul 2023 21:12:18 +0200 (CEST)
Message-ID: <a6e26927-acb0-c967-10c4-90a41d9a8cad@cs.kuleuven.be>
Date:   Thu, 20 Jul 2023 21:12:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
X-Kuleuven: This mail passed the K.U.Leuven mailcluster
From:   Jo Van Bulck <jo.vanbulck@cs.kuleuven.be>
Subject: Re: [PATCH 0/4] selftests/sgx: Harden test enclave
To:     Jarkko Sakkinen <jarkko@kernel.org>, linux-sgx@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     dave.hansen@linux.intel.com
References: <20230719142500.13623-1-jo.vanbulck@cs.kuleuven.be>
 <CU76BC9V7H3Z.TQ3L8AZY1WD@suppilovahvero>
Content-Language: en-US
In-Reply-To: <CU76BC9V7H3Z.TQ3L8AZY1WD@suppilovahvero>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20.07.23 19:25, Jarkko Sakkinen wrote:
> There's a lot of source code in kselftest, which probably has at least
> some security issues.
> 
> I'm not sure, at least based on this motivation, why would we care?

I'd argue that, in general, code examples are often used as templates 
and may thus inherit any vulnerabilities therein. This may be especially 
relevant here as your selftest enclave is in my knowledge the only 
available truly minimal SGX enclave that can be built and extended while 
only relying on standard tools and no heavy frameworks like the Intel 
SGX SDK. Thus, as noted before on this mailing list, it may be an 
attractive start for people who want to build things from scratch.

IMHO the example enclave should do a best effort to reasonably follow 
SGX coding best practices and not have _known_ security vulnerabilities 
in it. Note that these are not advanced microarchitectural attacks with 
ugly LFENCE defenses, but plain, architectural memory-safety exploit 
preventions with minimal sanitization checks, not unlike the existing 
protections against buffer overflow where best practices are followed 
for op->type.

Apart from that, the added checks only enforce correct behavior in the 
test framework, only validating that things are sane and as expected. 
Thus, to some extent, the added checks may even increase resilience of 
the test framework.

Best,
Jo

