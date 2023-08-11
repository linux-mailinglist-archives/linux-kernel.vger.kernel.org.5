Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFB80779952
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 23:20:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234550AbjHKVUv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 17:20:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjHKVUq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 17:20:46 -0400
Received: from icts-p-cavuit-4.kulnet.kuleuven.be (icts-p-cavuit-4.kulnet.kuleuven.be [IPv6:2a02:2c40:0:c0::25:134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A116E1FED
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 14:20:43 -0700 (PDT)
X-KULeuven-Envelope-From: jo.vanbulck@cs.kuleuven.be
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-KULeuven-Scanned: Found to be clean
X-KULeuven-ID: BAD57C1.ADF56
X-KULeuven-Information: Katholieke Universiteit Leuven
Received: from icts-p-ceifnet-smtps-1.kuleuven.be (icts-p-ceifnet-smtps.service.icts.svcd [IPv6:2a02:2c40:0:51:145:242:ac11:22])
        by icts-p-cavuit-4.kulnet.kuleuven.be (Postfix) with ESMTP id BAD57C1;
        Fri, 11 Aug 2023 23:20:40 +0200 (CEST)
BCmilterd-Mark-Subject: no
BCmilterd-Errors: 
BCmilterd-Report: SA-HVU#DKIM_SIGNED#0.00,SA-HVU#DKIM_VALID#0.00,SA-HVU#DKIM_VALID_AU#0.00
X-CAV-Cluster: smtps
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cs.kuleuven.be;
        s=cav; t=1691788840;
        bh=1ozwOfp6sB/GiUlXazdvd64OYcRGyi/VDeFOOHriFDU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=aYJhrz4uJU2tw+zfZHXh+TLXGAMWNgFiY5Ji1UZKrhHYS9Cc7+7TmjSj/QiC/VVkA
         5T0YylRQnLP+xk6vBxkSxLjGKd50ABI41yDUgSsBanTOOCVzaMaOxuxQEt8xF4jgrK
         2gs6vTNNwfrPL14fhZxdq7Iz7PsYKCcjwngJBG/0=
Received: from [172.22.26.96] (unknown [68.170.73.15])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by icts-p-ceifnet-smtps-1.kuleuven.be (Postfix) with ESMTPSA id CBF95D4EBF99F;
        Fri, 11 Aug 2023 23:20:38 +0200 (CEST)
Message-ID: <ce0185e8-4f5c-cff5-4e17-b967f133bc91@cs.kuleuven.be>
Date:   Fri, 11 Aug 2023 14:20:33 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH RESEND] x86/pti: Fix kernel warnings for pti= and nopti
 cmdline options.
Content-Language: en-US
To:     Sohil Mehta <sohil.mehta@intel.com>, linux-kernel@vger.kernel.org,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        mingo@redhat.com
Cc:     x86@kernel.org, bp@alien8.de, tglx@linutronix.de, hpa@zytor.com
References: <20230808195615.9795-1-jo.vanbulck@cs.kuleuven.be>
 <c0aed6a4-23e0-d947-5c17-26e580d5c40a@intel.com>
 <405927c5-91bf-144d-a3d7-b82f5527f3c9@cs.kuleuven.be>
 <c22d7613-fb2e-11ec-9544-a39ffc7fd955@intel.com>
X-Kuleuven: This mail passed the K.U.Leuven mailcluster
From:   Jo Van Bulck <jo.vanbulck@cs.kuleuven.be>
In-Reply-To: <c22d7613-fb2e-11ec-9544-a39ffc7fd955@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11.08.23 12:13, Sohil Mehta wrote:> Based on above, even when you 
split the if check only a single print
> would be enough, right?

Yes, I agree these both cases can simply print "disabled on command 
line." (as in the original code) IMHO

> I don't believe that is a requirement either. Sometimes kernel command
> lines can get very long and people make mistakes. I just thought it is
> neat that the current code is defaulting that way and we should probably
> keep the same behavior since it makes sense.

Makes sense indeed.

> I agree, in both cases pti= overriding the other option (nopti or
> mitigations=off) sounds reasonable to me.

I prepared a revised patch for this and will post this shortly.

Best,
Jo
