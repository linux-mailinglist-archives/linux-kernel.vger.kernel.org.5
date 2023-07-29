Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D55BF767E57
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 12:54:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230482AbjG2Kyf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jul 2023 06:54:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229895AbjG2Kye (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jul 2023 06:54:34 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2B2E2686
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jul 2023 03:54:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1690628068;
        bh=qj7XmP75mScDkL7OykesJ/+yL9NoM5v58AOWtEYqqpM=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=FmIxsPNCylPwEcg5zs/4/SiNaqiA+WFEeN+5J5/ijG/A8vRLukQAMdxajxfOy/RnI
         xblfnZUwwQ1lyddl4lju1+tnxU9b54u3CTUtzVDSi5Mtk+7sfHoKmqd/NhfqnkB7JW
         e3Z5qaMg2pYyd2HZDKZry+l6u8A8nxc4Ihnq+dgLSuIImqbAQbq783Niry5BOXcN1k
         CSMQmpcbD9bEDepBDQtxLMH1igGdzLzEJNHf6VDSoMPUAT0HmPDq3nq6CMuYKlKgCw
         sbBSxJ8lO27j1r64wi85X833ZNbgdQfrZen1g//8+GblOzuQbt0J37IuADUtZ7vcgQ
         VMeAgxDcwFhyQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4RChGD0PSdz4wy4;
        Sat, 29 Jul 2023 20:54:27 +1000 (AEST)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Gautam Menghani <Gautam.Menghani@linux.ibm.com>
Cc:     Gautam Menghani <gautam@linux.ibm.com>, npiggin@gmail.com,
        christophe.leroy@csgroup.eu, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arch/powerpc: Remove unnecessary endian conversion code
 in XICS
In-Reply-To: <jcxd7uvooawd3vadvvzmegv27owaqvrxsi66c2ds6hwraqs3zy@3ymyrpyp3q55>
References: <20230630055628.17790-1-gautam@linux.ibm.com>
 <39920b0f-f261-8417-af7a-eef791ad5726@gmail.com>
 <jcxd7uvooawd3vadvvzmegv27owaqvrxsi66c2ds6hwraqs3zy@3ymyrpyp3q55>
Date:   Sat, 29 Jul 2023 20:54:26 +1000
Message-ID: <873517dm3h.fsf@mail.lhotse>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Gautam Menghani <Gautam.Menghani@linux.ibm.com> writes:
> On Thu, Jul 06, 2023 at 05:50:57PM +1000, Jordan Niethe wrote:
>> On 30/6/23 3:56 pm, Gautam Menghani wrote:
>> > Remove an unnecessary piece of code that does an endianness conversion but
>> > does not use the result. The following warning was reported by Clang's
>> > static analyzer:
>> > 
>> > arch/powerpc/sysdev/xics/ics-opal.c:114:2: warning: Value stored to
>> > 'server' is never read [deadcode.DeadStores]
>> >          server = be16_to_cpu(oserver);
>> > 
>> > As the result of endianness conversion is never used, delete the line
>> > and fix the warning.
>> > 
>> > Signed-off-by: Gautam Menghani <gautam@linux.ibm.com>
>> 
>> 'server' was used as a parameter to opal_get_xive() in commit 5c7c1e9444d8
>> ("powerpc/powernv: Add OPAL ICS backend") when it was introduced. 'server'
>> was also used in an error message for the call to opal_get_xive().
>> 
>> 'server' was always later set by a call to ics_opal_mangle_server() before
>> being used.
>> 
>> Commit bf8e0f891a32 ("powerpc/powernv: Fix endian issues in OPAL ICS
>> backend") used a new variable 'oserver' as the parameter to opal_get_xive()
>> instead of 'server' for endian correctness. It also removed 'server' from
>> the error message for the call to opal_get_xive().
>> 
>> It was commit bf8e0f891a32 that added the unnecessary conversion and never
>> used the result.
>> 
>> Reviewed-by: Jordan Niethe <jniethe5@gmail.com>
>> 
>
> Hello Michael, 
>
> Do you have any more questions on this patch or is it good to go?

I was expecting you'd send a v2 with the changelog updated to include
all the extra detail Jordan added. I think it should also be tagged as
Fixes: bf8e0f891a32.

cheers
