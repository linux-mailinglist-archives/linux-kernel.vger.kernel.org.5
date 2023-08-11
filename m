Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BDE7779B51
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 01:27:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235243AbjHKX13 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 19:27:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231685AbjHKX12 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 19:27:28 -0400
Received: from icts-p-cavuit-1.kulnet.kuleuven.be (icts-p-cavuit-1.kulnet.kuleuven.be [IPv6:2a02:2c40:0:c0::25:132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFD751AE
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 16:27:24 -0700 (PDT)
X-KULeuven-Envelope-From: jo.vanbulck@cs.kuleuven.be
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-KULeuven-Scanned: Found to be clean
X-KULeuven-ID: 6C72A2017C.A84F0
X-KULeuven-Information: Katholieke Universiteit Leuven
Received: from icts-p-ceifnet-smtps-0.kuleuven.be (icts-p-ceifnet-smtps.service.icts.svcd [IPv6:2a02:2c40:0:51:144:242:ac11:2f])
        by icts-p-cavuit-1.kulnet.kuleuven.be (Postfix) with ESMTP id 6C72A2017C;
        Sat, 12 Aug 2023 01:27:22 +0200 (CEST)
BCmilterd-Mark-Subject: no
BCmilterd-Errors: 
BCmilterd-Report: SA-HVU#DKIM_VALID#0.00,SA-HVU#DKIM_VALID_AU#0.00,SA-HVU#DKIM_SIGNED#0.00
X-CAV-Cluster: smtps
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cs.kuleuven.be;
        s=cav; t=1691796442;
        bh=kOIB2pFhDbje0Zp/yDS+K+1HPV/DlM2Co1PlWH+EKqM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=IQFTl1m//BXbUx2Qq9xI6NrbhwZL4aORRYw73rhgLLGW15xqeV5gv3qnpYZvMuuu+
         LHBK26ql4MgTk7y+pG3FChU6O3K6t17awIcNEuR+daXC6DBbL4NdNec3lBilw0sUA0
         2jeOIHXZbcyAv4p/SgjRbwRVElHRuvemfikY52UU=
Received: from [172.22.26.96] (unknown [68.170.73.15])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by icts-p-ceifnet-smtps-0.kuleuven.be (Postfix) with ESMTPSA id 04921D4EB2E4D;
        Sat, 12 Aug 2023 01:27:19 +0200 (CEST)
Message-ID: <295ea2ef-3480-856b-b93a-9ae36f7b2286@cs.kuleuven.be>
Date:   Fri, 11 Aug 2023 16:27:17 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 1/1] x86/pti: Fix kernel warnings for pti= and nopti
 cmdline options.
Content-Language: en-US
To:     linux-kernel@vger.kernel.org, dave.hansen@linux.intel.com,
        luto@kernel.org, peterz@infradead.org, mingo@redhat.com,
        sohil.mehta@intel.com
Cc:     x86@kernel.org, bp@alien8.de, tglx@linutronix.de, hpa@zytor.com
References: <20230811213628.40428-1-jo.vanbulck@cs.kuleuven.be>
 <20230811213628.40428-2-jo.vanbulck@cs.kuleuven.be>
X-Kuleuven: This mail passed the K.U.Leuven mailcluster
From:   Jo Van Bulck <jo.vanbulck@cs.kuleuven.be>
In-Reply-To: <20230811213628.40428-2-jo.vanbulck@cs.kuleuven.be>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11.08.23 14:36, Jo Van Bulck wrote:>   static enum pti_mode {
>   	PTI_AUTO = 0,
> +	PTI_FORCE_AUTO,
>   	PTI_FORCE_OFF,
>   	PTI_FORCE_ON
>   } pti_mode;

I introduced a new PTI_FORCE_AUTO value here to make pti=auto override 
any mitigations=off parameter. However, I realize now that this may 
inadvertently affect other functions that test for pti_mode == PTI_AUTO 
(eg in pti_kernel_image_global_ok()).

Having 2 constants PTI_AUTO and PTI_FORCE_AUTO is arguably not very 
neat, so we should better get rid of this. I see several options:

- not have pti=auto override mitigations=off
- have a global var to indicate pti= argument was passed
- set pti_mode = PTI_AUTO in the pti_mode == PTI_FORCE_AUTO if branch

Not sure which option would best match kernel coding guidelines?

Best,
Jo
