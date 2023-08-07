Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01FE5771A11
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 08:15:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231167AbjHGGPO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 02:15:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbjHGGPM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 02:15:12 -0400
Received: from icts-p-cavuit-3.kulnet.kuleuven.be (icts-p-cavuit-3.kulnet.kuleuven.be [IPv6:2a02:2c40:0:c0::25:133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F3BF10F9;
        Sun,  6 Aug 2023 23:15:10 -0700 (PDT)
X-KULeuven-Envelope-From: jo.vanbulck@cs.kuleuven.be
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-KULeuven-Scanned: Found to be clean
X-KULeuven-ID: A24E920034.A757A
X-KULeuven-Information: Katholieke Universiteit Leuven
Received: from icts-p-ceifnet-smtps-0.kuleuven.be (icts-p-ceifnet-smtps.service.icts.svcd [IPv6:2a02:2c40:0:51:144:242:ac11:2f])
        by icts-p-cavuit-3.kulnet.kuleuven.be (Postfix) with ESMTP id A24E920034;
        Mon,  7 Aug 2023 08:15:08 +0200 (CEST)
BCmilterd-Mark-Subject: no
BCmilterd-Errors: 
BCmilterd-Report: SA-HVU#DKIM_SIGNED#0.00,SA-HVU#DKIM_VALID_AU#0.00,SA-HVU#DKIM_VALID#0.00
X-CAV-Cluster: smtps
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cs.kuleuven.be;
        s=cav; t=1691388908;
        bh=qAEAuBjTzzHoMZUbH6JcPJmQOPkCDfo6qe+8I9+R/JI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=oSIIR/Pi4qcCt0t0k9uWUubT5wM6uElHLxs4rE67CRC0Ac9AwJj1PwHrnHc1oxgZ3
         rxmLZWK83UvVJF/8q57jYt/ZAUAOOqzL33WO0owAI6g0v6e6PZeXb5TLw8Zj6/TBxh
         HQBFaQYK9dslFJFVtVHou2bo8Z9J3a9vO06wYWsM=
Received: from [10.101.1.242] (ip-185-104-137-32.ptr.icomera.net [185.104.137.32])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by icts-p-ceifnet-smtps-0.kuleuven.be (Postfix) with ESMTPSA id D3818D4F79126;
        Mon,  7 Aug 2023 08:15:07 +0200 (CEST)
Message-ID: <88eb26eb-b3a8-40e7-5c47-f832b3b0a627@cs.kuleuven.be>
Date:   Mon, 7 Aug 2023 08:15:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 1/5] selftests/sgx: Fix uninitialized pointer dereference
 in error path.
Content-Language: en-US
To:     "Huang, Kai" <kai.huang@intel.com>,
        "linux-sgx@vger.kernel.org" <linux-sgx@vger.kernel.org>,
        "jarkko@kernel.org" <jarkko@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
References: <20230724165832.15797-1-jo.vanbulck@cs.kuleuven.be>
 <20230724165832.15797-2-jo.vanbulck@cs.kuleuven.be>
 <30cdc29283a6ed6ece205d9a91f44b44b2b3a73c.camel@intel.com>
X-Kuleuven: This mail passed the K.U.Leuven mailcluster
From:   Jo Van Bulck <jo.vanbulck@cs.kuleuven.be>
In-Reply-To: <30cdc29283a6ed6ece205d9a91f44b44b2b3a73c.camel@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03.08.23 05:51, Huang, Kai wrote:
> Is it safe to assume EVP_MD_CTX_destroy() can always handle a NULL ctx?
> 
> The manpage says:
> 
> EVP_MD_CTX_destroy() cleans up digest context ctx and frees up the space
> allocated to it, it should be called only on a context created using
> EVP_MD_CTX_create().

Thank you for pointing this out. Afais the implementations I've seen can 
handle NULL, and similar error-handling paths exists where 
EVP_MD_CTX_destroy() is called with a NULL pointer exist in several 
places in the openSSL code.

That being said, this indeed not explicit in the specification (unlike 
RSA_free() which is called just after and explicitly specifies that NULL 
is okay). So you're probably right that it's generally safer to not call 
EVP_MD_CTX_destroy() with a NULL pointer.

I'll include an extra check for this in the next patch revision.
