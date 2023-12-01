Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2874801176
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 18:21:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378464AbjLAQjG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 11:39:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjLAQiw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 11:38:52 -0500
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A65ED10DF
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 08:38:27 -0800 (PST)
Received: by mail-io1-xd33.google.com with SMTP id ca18e2360f4ac-7b393fd9419so15159039f.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Dec 2023 08:38:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1701448706; x=1702053506; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=F4bReDtBqdZ7CQBg8UmEdVvEuIGOtXfeTpzV766B0GQ=;
        b=eCPvVuKUtcUML6PCcMRbRoVs9nIim4eBXq2DOUW6ltIoOSMN0LBgO83FAf+eQdrBDq
         A/PmkuhmUd7P/48s+UEf27F2Mcv2+uZTPpLM6X1n6JWoCdpMkNuT4GtaZDIrhfzxjz/p
         M4x1KAD0TWPjWfqQjKrbI4r6eByvIohNQ8quo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701448706; x=1702053506;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F4bReDtBqdZ7CQBg8UmEdVvEuIGOtXfeTpzV766B0GQ=;
        b=Ub5sRL69Um67xHKXDatE5DPG/wdMM87KSaCIh+WjALxdzTr91fdFG/CmRjIYepCVlm
         V6lJ+qMQuvouLYA9Zr+pC51ORXhi3nc3SlJc0FRD6V/ASuP0MWS5hU1nh/3QH3/crsyx
         g/O6Dk0kiQZd2X1PnW/P1g9dALCq37ar48F4j2+aV/y2BDtLwEJSpSCoqUQuj/Xen/8P
         cR6WVRhoT0CpQ6x3aFc2goCuLC2Z/rKPe3nxLSgfbczeq77ff2QMQ/Ur1MNyommX55Mp
         PQ8TcMCwBlkvzv8VheRVpORXNZV/iAZkYWT8NYC4QcMOzZRR/8DKdWwiwMF0zkkXCy/p
         pN3g==
X-Gm-Message-State: AOJu0YwU1ZR9muSGbL18Ao4NwFNaB4Ftc7uKb90qffT+PI32RZnyBaH+
        ryUuOFvQIM5txQF53s3VoZRvN8cK+ibQv74Pngk=
X-Google-Smtp-Source: AGHT+IHG40EFSnt4Yz6Knhpd28geD95aKAGL4h+gRV294CYt5W7hXqom/+d8jZtbFp7xj3MCvp4Ghw==
X-Received: by 2002:a05:6602:489a:b0:7b3:95a4:de9c with SMTP id ee26-20020a056602489a00b007b395a4de9cmr22727490iob.1.1701448706259;
        Fri, 01 Dec 2023 08:38:26 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id u1-20020a6be901000000b007b3e503d59csm1046219iof.47.2023.12.01.08.38.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Dec 2023 08:38:25 -0800 (PST)
Message-ID: <8b95b96c-6aeb-4bf0-8ee9-2ba62330c672@linuxfoundation.org>
Date:   Fri, 1 Dec 2023 09:38:24 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] selftests: livepatch: Test livepatching a heavily
 called syscall
Content-Language: en-US
To:     Marcos Paulo de Souza <mpdesouza@suse.de>
Cc:     Marcos Paulo de Souza <mpdesouza@suse.com>,
        Shuah Khan <shuah@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Jiri Kosina <jikos@kernel.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Petr Mladek <pmladek@suse.com>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        live-patching@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20231031-send-lp-kselftests-v3-0-2b1655c2605f@suse.com>
 <20231031-send-lp-kselftests-v3-3-2b1655c2605f@suse.com>
 <f9d82fa6-08d7-4ab6-badc-691987b37a82@linuxfoundation.org>
 <unpg4z7eig6qbudgulnr6sog65fq7s2dy4u2vp2dgkdrq5csdw@dltnxuw6kw5b>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <unpg4z7eig6qbudgulnr6sog65fq7s2dy4u2vp2dgkdrq5csdw@dltnxuw6kw5b>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/1/23 06:13, Marcos Paulo de Souza wrote:
> On Thu, Nov 30, 2023 at 04:24:26PM -0700, Shuah Khan wrote:

>>
>> Missing module name? Is there a reason to not name this module?
> 
> Can you please elaborate? This new module use the same MODULE_ macros used by
> the current livepatch selftests. What do you mean by module name?
> 

Pre-commit checpatch script spdx check complained about the module name.
Please run it to see the message.

thanks,
-- Shuah

