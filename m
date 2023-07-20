Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DAA575B859
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 21:56:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231190AbjGTT4U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 15:56:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbjGTT4S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 15:56:18 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E12D41BC1;
        Thu, 20 Jul 2023 12:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689882977; x=1721418977;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=8IcQfvKJlM3zt5ratzwubGytP7U2WkC5wynfQAVVAUU=;
  b=dyVimnUJPlxSu76TdtF31XW0BuDZVbnbkAhoCNaWIdF6eF8LAXScpb8r
   BCG66heTjGatZc8vWElOJZuNCJghMJWrVel0ys73vXiEN0br5HpgDxpb7
   YdSiE2FEGuQU+yka3npFjp5cN1dC4AdnhHcROXqzgQRpBcX70qR2HPAKu
   b5pvx0+1vZkvVObLB6VINvSVR+/XtWDIbfNGGo4W7uBKLnp05wTn1we8F
   N0vPkU+SOsGqnI4sNDLwybpii66DWiJk5RhisSVsLxxyhN4EDy9frJVZ0
   nSa33cYmrWu+wkMmtGzBL2vfCU6bdZnxOZ36I23Ejxmv/89l7eHaCDAxT
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10777"; a="364314600"
X-IronPort-AV: E=Sophos;i="6.01,219,1684825200"; 
   d="scan'208";a="364314600"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2023 12:56:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10777"; a="701779720"
X-IronPort-AV: E=Sophos;i="6.01,219,1684825200"; 
   d="scan'208";a="701779720"
Received: from tholtx-mobl.amr.corp.intel.com (HELO [10.209.39.44]) ([10.209.39.44])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2023 12:56:16 -0700
Message-ID: <715e3263-02a8-9d0e-8b34-e79adc0595a0@intel.com>
Date:   Thu, 20 Jul 2023 12:56:16 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 0/4] selftests/sgx: Harden test enclave
Content-Language: en-US
To:     Jo Van Bulck <jo.vanbulck@cs.kuleuven.be>,
        Jarkko Sakkinen <jarkko@kernel.org>, linux-sgx@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     dave.hansen@linux.intel.com
References: <20230719142500.13623-1-jo.vanbulck@cs.kuleuven.be>
 <CU76BC9V7H3Z.TQ3L8AZY1WD@suppilovahvero>
 <a6e26927-acb0-c967-10c4-90a41d9a8cad@cs.kuleuven.be>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <a6e26927-acb0-c967-10c4-90a41d9a8cad@cs.kuleuven.be>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/20/23 12:12, Jo Van Bulck wrote:
> On 20.07.23 19:25, Jarkko Sakkinen wrote:
>> There's a lot of source code in kselftest, which probably has at least
>> some security issues.
>>
>> I'm not sure, at least based on this motivation, why would we care?
> 
> I'd argue that, in general, code examples are often used as templates
> and may thus inherit any vulnerabilities therein. This may be especially
> relevant here as your selftest enclave is in my knowledge the only
> available truly minimal SGX enclave that can be built and extended while
> only relying on standard tools and no heavy frameworks like the Intel
> SGX SDK. Thus, as noted before on this mailing list, it may be an
> attractive start for people who want to build things from scratch.
> 
> IMHO the example enclave should do a best effort to reasonably follow
> SGX coding best practices and not have _known_ security vulnerabilities
> in it.

On the other hand, if we don't leave glaring, known "security"
vulnerabilities in it, even more people will be fooled into trying to
use our example code for something that needs actual security.

I personally don't know the first thing about writing a secure enclave.
I just know it's _really_ hard and I honestly don't expect someone to do
it without the help of the SDK.
