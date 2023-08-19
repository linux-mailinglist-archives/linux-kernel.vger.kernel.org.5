Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 044B1781838
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Aug 2023 10:05:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344849AbjHSIE4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Aug 2023 04:04:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344755AbjHSIEX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Aug 2023 04:04:23 -0400
Received: from icts-p-cavuit-1.kulnet.kuleuven.be (icts-p-cavuit-1.kulnet.kuleuven.be [IPv6:2a02:2c40:0:c0::25:132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BC54170E;
        Sat, 19 Aug 2023 01:04:22 -0700 (PDT)
X-KULeuven-Envelope-From: jo.vanbulck@cs.kuleuven.be
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-KULeuven-Scanned: Found to be clean
X-KULeuven-ID: D71B02015E.ACB3D
X-KULeuven-Information: Katholieke Universiteit Leuven
Received: from icts-p-ceifnet-smtps-0.kuleuven.be (icts-p-ceifnet-smtps.service.icts.svcd [IPv6:2a02:2c40:0:51:144:242:ac11:2f])
        by icts-p-cavuit-1.kulnet.kuleuven.be (Postfix) with ESMTP id D71B02015E;
        Sat, 19 Aug 2023 10:04:17 +0200 (CEST)
BCmilterd-Mark-Subject: no
BCmilterd-Errors: 
BCmilterd-Report: SA-HVU#DKIM_SIGNED#0.00,SA-HVU#DKIM_VALID#0.00,SA-HVU#DKIM_VALID_AU#0.00
X-CAV-Cluster: smtps
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cs.kuleuven.be;
        s=cav; t=1692432257;
        bh=5SM0tbCLby4CXnd/iE8GVYnQDA8L2gifjHQMsNN6ft8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=af6dcF58KWJeYSBlwecEjT6DL3duqtu5GOnGTgRqOHXd3FIN2Z68QcedGdO9yk155
         Jh8qX+KLnoddToJle3ZJPf3dpWhDcz6c3E78tHfoe10pcdgfI9tFLjnPSS0ijUawZF
         r0C94BUKLolTFMww5/+1z9zJr23wxG1UZc9IJprg=
Received: from [192.168.44.147] (ptr-94-109-233-233.dyn.orange.be [94.109.233.233])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by icts-p-ceifnet-smtps-0.kuleuven.be (Postfix) with ESMTPSA id E724ED4E6A738;
        Sat, 19 Aug 2023 10:04:16 +0200 (CEST)
Message-ID: <44103bd1-47e9-0d98-770f-010a1077346c@cs.kuleuven.be>
Date:   Fri, 18 Aug 2023 18:09:19 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 6/8] selftests/sgx: Ensure expected enclave data buffer
 size and placement
Content-Language: en-US
To:     "Huang, Kai" <kai.huang@intel.com>,
        "linux-sgx@vger.kernel.org" <linux-sgx@vger.kernel.org>,
        "jarkko@kernel.org" <jarkko@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
References: <20230808193145.8860-1-jo.vanbulck@cs.kuleuven.be>
 <20230808193145.8860-7-jo.vanbulck@cs.kuleuven.be>
 <0885be8149082c17fc56261231c5210d693789af.camel@intel.com>
X-Kuleuven: This mail passed the K.U.Leuven mailcluster
From:   Jo Van Bulck <jo.vanbulck@cs.kuleuven.be>
In-Reply-To: <0885be8149082c17fc56261231c5210d693789af.camel@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18.08.23 06:10, Huang, Kai wrote:
> Firstly, these two problems are independent. Could you split this into two
> patches?  One to preserve the entire buffer, the other to always place the
> buffer at the beginning.

Makes sense, doing this for the next revision.

> Secondly, as replied to v1, I think we can use "used" gcc attribute to always
> preserve the buffer?

Thanks for the suggestion. Yes, I was not aware of this attribute, but 
it is indeed exactly what we need in this case. Applying this in the 
next revision.

Best,
Jo
