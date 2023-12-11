Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5748C80BEEE
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 03:12:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232334AbjLKB6S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Dec 2023 20:58:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjLKB6Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Dec 2023 20:58:16 -0500
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09256D8
        for <linux-kernel@vger.kernel.org>; Sun, 10 Dec 2023 17:58:22 -0800 (PST)
Received: by mail-oi1-x22d.google.com with SMTP id 5614622812f47-3b9e2a014e8so2618259b6e.2
        for <linux-kernel@vger.kernel.org>; Sun, 10 Dec 2023 17:58:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vt-edu.20230601.gappssmtp.com; s=20230601; t=1702259901; x=1702864701; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zddqF/jv+/P1p4qA9Lj1Lxt1b+aJT+SCi3OQ6iYsT40=;
        b=eLQWfQz/7zKmnPyCWKdJItVcdGXv4gLtxJ0bmL9ruuB5KXXl1qfgmhMRLc12s7qp5D
         rrABFEa1IwwmaFzpq+DtFoeolJKNBzUWKfBBc2mBJFLjFRvHyacOdLPqR6usPKSudf6O
         MHQ9nLfnI9sTDBzE1hsnpjKcam1YS2IfDx6Vq5PY4lMCNaCbdJysNEti9V/V0/mpcl25
         B1Z9b5W4BTdakMuoObrNgBe+cUYwI8OhlTrrVl8Zuf9wY7w3CCNAzBz5CMpi7K+qCMLv
         SiNnE5kYCl8YFJ74hKq9BQTLFPcKQgKEYnOG/TXTiCATqV4TCvm/8/MxusHRXnVna+65
         rf7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702259901; x=1702864701;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zddqF/jv+/P1p4qA9Lj1Lxt1b+aJT+SCi3OQ6iYsT40=;
        b=PqbIkofDv4CHGgr21wAq8h/2JCzxJgfZMpfLj4+w1D1kiTxUn9++LeEj01kZbqkVhG
         jZS4PKHaVmnABSSDatGKpQsAAe5rNuq54+AKWoRKR5Sv2/Q+B9BItiYzTkJTUF6JSoxx
         kr21S+KIih3BgLl535bgaZmX2+FOltI+D32nG3cL9anPWrxBCjToJKgvi5gCfjd6eFmR
         V0NVeP+I2+UURqcJkZ5KfOl8zvjeZbnNzV9fweHkT/F8poblA6QWNGoi+z/QScQVa73q
         iRY2VgsNFnEF0YRU+mJfDoL61V6ZySsoz+JOb31EQKR4jcNN8oCajLmuntEUaTozA9tF
         rWQA==
X-Gm-Message-State: AOJu0YwVJcszhVVR8UIrNsYEwv0ODv2m0MVnY6oHaPnPkmhC1pWG3kFC
        Z2aP6bJ/nDmawxSsHnaTT6+R4Q==
X-Google-Smtp-Source: AGHT+IFQYQ70kaqsj4LZfh9zUZhHx0b1Dzrgg2GVBFkeL85kFfrrSym9AV6pmSWbEyG1G2DDrIp+Iw==
X-Received: by 2002:a05:6808:14c9:b0:3b8:b063:6ba5 with SMTP id f9-20020a05680814c900b003b8b0636ba5mr5027143oiw.84.1702259901287;
        Sun, 10 Dec 2023 17:58:21 -0800 (PST)
Received: from ?IPV6:2603:8080:2300:de:29b1:e1a0:8d3c:63c7? (2603-8080-2300-00de-29b1-e1a0-8d3c-63c7.res6.spectrum.com. [2603:8080:2300:de:29b1:e1a0:8d3c:63c7])
        by smtp.gmail.com with ESMTPSA id bg39-20020a05680817a700b003b3ec15d8ebsm1614780oib.5.2023.12.10.17.58.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 Dec 2023 17:58:20 -0800 (PST)
Message-ID: <77b25d0b-ceb4-4589-bf40-ff464e2a6b7f@vt.edu>
Date:   Sun, 10 Dec 2023 19:58:19 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1 RESEND] docs: Include simplified link titles in main
 page's index
Content-Language: en-US
To:     Randy Dunlap <rdunlap@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        alex.gaynor@gmail.com, wedsonaf@gmail.com, boqun.feng@gmail.com,
        gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me,
        a.hindborg@samsung.com, aliceryhl@google.com,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <58e78693-82d1-451d-a546-51fb64ef6eb5@vt.edu>
 <dcab1e08-c054-441b-8d4e-f46e2f22605c@vt.edu>
 <9b52c145-7466-4e81-a911-25f472c2a2ea@infradead.org>
From:   Carlos Bilbao <bilbao@vt.edu>
In-Reply-To: <9b52c145-7466-4e81-a911-25f472c2a2ea@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/10/23 7:41 PM, Randy Dunlap wrote:
> Hi Carlos,
> 
> On 12/10/23 17:20, Carlos Bilbao wrote:
>> Include simplified link titles in the main page's documentation index to
>> enhance website's readability and UX. Update the text that directs users to
>> various documents without changing the actual titles chosen by the authors.
>>
>> Signed-off-by: Carlos Bilbao <bilbao@vt.edu>
>> ---
>>  Documentation/index.rst | 50 ++++++++++++++++++++---------------------
>>  1 file changed, 25 insertions(+), 25 deletions(-)
>>
>> diff --git a/Documentation/index.rst b/Documentation/index.rst
>> index 9dfdc826618c..be395d0a4318 100644
>> --- a/Documentation/index.rst
>> +++ b/Documentation/index.rst
>> @@ -22,10 +22,10 @@ community and getting your work upstream.
>>  .. toctree::
>>     :maxdepth: 1
>>  
>> -   process/development-process
>> -   process/submitting-patches
>> +   Development process <process/development-process>
>> +   Submitting patches <process/submitting-patches>
>>     Code of conduct <process/code-of-conduct>
>> -   maintainer/index
>> +   Maintainer handbook <maintainer/index>
>>     All development-process docs <process/index>
>>  
>>  
>> @@ -38,10 +38,10 @@ kernel.
>>  .. toctree::
>>     :maxdepth: 1
>>  
>> -   core-api/index
>> -   driver-api/index
>> -   subsystem-apis
>> -   Locking in the kernel <locking/index>
>> +   Core API <core-api/index>
>> +   Driver implementation API <driver-api/index>
>> +   Subsystems <subsystem-apis>
>> +   Locking <locking/index>
>>  
>>  Development tools and processes
>>  ===============================
>> @@ -51,15 +51,15 @@ Various other manuals with useful information for all kernel developers.
>>  .. toctree::
>>     :maxdepth: 1
>>  
>> -   process/license-rules
>> -   doc-guide/index
>> -   dev-tools/index
>> -   dev-tools/testing-overview
>> -   kernel-hacking/index
>> -   trace/index
>> -   fault-injection/index
>> -   livepatch/index
>> -   rust/index
>> +   Licensing rules <process/license-rules>
>> +   Writing documentation <doc-guide/index>
>> +   Development tools <dev-tools/index>
>> +   Testing <dev-tools/testing-overview>
>> +   Hacking <kernel-hacking/index>
>> +   Tracing <trace/index>
>> +   Fault injection <fault-injection/index>
>> +   Livepatching <livepatch/index>
>> +   Rust <rust/index>
>>  
>>  
>>  User-oriented documentation
>> @@ -72,11 +72,11 @@ developers seeking information on the kernel's user-space APIs.
>>  .. toctree::
>>     :maxdepth: 1
>>  
>> -   admin-guide/index
>> -   The kernel build system <bailed/index>
> 
> Where do the subdir names "bailed" above and "bugled" below come from?


No clue how that happened. Thanks for catching it, Randy.


> 
>> -   admin-guide/reporting-issues.rst
>> +   Administration <admin-guide/index>
>> +   Build system <bugled/index>
> 
>                     ^^^^^^
> 
> 
> Thanks.
> 
>> +   Reporting issues <admin-guide/reporting-issues.rst>
>>     User-space tools <tools/index>
>> -   userspace-api/index
>> +   User-space API <userspace-api/index>
>>  
>>  See also: the `Linux man pages <https://www.kernel.org/doc/man-pages/>`_,
>>  which are kept separately from the kernel's own documentation.
>> @@ -89,8 +89,8 @@ platform firmwares.
>>  .. toctree::
>>     :maxdepth: 1
>>  
>> -   firmware-guide/index
>> -   devicetree/index
>> +   Firmware <firmware-guide/index>
>> +   Firmware and Devicetree <devicetree/index>
>>  
>>  
>>  Architecture-specific documentation
>> @@ -99,7 +99,7 @@ Architecture-specific documentation
>>  .. toctree::
>>     :maxdepth: 2
>>  
>> -   arch/index
>> +   CPU Architectures <arch/index>
>>  
>>  
>>  Other documentation
>> @@ -112,7 +112,7 @@ to ReStructured Text format, or are simply too old.
>>  .. toctree::
>>     :maxdepth: 1
>>  
>> -   staging/index
>> +   Unsorted documentation <staging/index>
>>  
>>  
>>  Translations
>> @@ -121,7 +121,7 @@ Translations
>>  .. toctree::
>>     :maxdepth: 2
>>  
>> -   translations/index
>> +   Translations <translations/index>
>>  
>>  Indices and tables
>>  ==================
> 

Best,
Carlos
