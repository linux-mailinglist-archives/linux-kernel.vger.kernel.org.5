Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9E0B78071F
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 10:26:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358582AbjHRI0E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 04:26:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358580AbjHRIZc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 04:25:32 -0400
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9330926BC;
        Fri, 18 Aug 2023 01:25:29 -0700 (PDT)
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-99c0290f0a8so73413066b.1;
        Fri, 18 Aug 2023 01:25:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692347128; x=1692951928;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HdxVuDGK8MNRwBUbE5pBkgRN8LmLA9dHWsOb6JtW7fk=;
        b=hyMYTyB15QeH0MphahI8LDwZ/wGnNqazKuQNCnkmsREA1/14Taa8VWl0WoZg2KCPtC
         vp4+wRMs78oUyUe/QhJbnCprxd+WL23P6HEReA8Sd73yjh9id3887bc3bSCdlKdjmJK4
         xfhYEayKfA4OpquCU2tnFZBoDXDPFP71PNLPPPdmorHqwESW3O5hoi4nxuyL/esFAh+o
         Hk+oX++EbHTDzMuGw4XQ8A03VB0ewnaNu38YcnY4N454hfDsgIXdIi6EbA86gtGCbTU5
         oKfX5gNNu/v/ITFSwwtQwLqUHGYW2rwWrjOEnnAI8W92nUwPq7IIefY/Dn/t3B5ZWPpA
         PgOQ==
X-Gm-Message-State: AOJu0Yzua2fPFLQpltjOihLc8kNY3YqLkzZnjYShVrWy0rleHGaB/8m3
        aRSk8WiMS5mD+ixj2KrGqTE=
X-Google-Smtp-Source: AGHT+IETgkkCpm1zCgUOvhPbG5ueBOdWPYtQvU11v5LQ1Lh7TCGI61XJORJav3wM5h5fVhzlLTBOMw==
X-Received: by 2002:a17:907:7845:b0:99d:73c2:7141 with SMTP id lb5-20020a170907784500b0099d73c27141mr1303901ejc.72.1692347127618;
        Fri, 18 Aug 2023 01:25:27 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:59? ([2a0b:e7c0:0:107::aaaa:59])
        by smtp.gmail.com with ESMTPSA id v8-20020a1709060b4800b0099bc8db97bcsm881336ejg.131.2023.08.18.01.25.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Aug 2023 01:25:27 -0700 (PDT)
Message-ID: <c6c86d68-dcae-2397-a3f3-aca7bff93d6c@kernel.org>
Date:   Fri, 18 Aug 2023 10:25:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH] kill do_each_thread()
Content-Language: en-US
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Christian Brauner <brauner@kernel.org>,
        Kees Cook <keescook@chromium.org>, linux-ia64@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230817163708.GA8248@redhat.com>
 <d92e7938-49e0-3b4c-89ab-77dcd15b8676@kernel.org>
 <20230818081617.GA5339@redhat.com>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <20230818081617.GA5339@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18. 08. 23, 10:16, Oleg Nesterov wrote:
> On 08/18, Jiri Slaby wrote:
>>
>> On 17. 08. 23, 18:37, Oleg Nesterov wrote:
>>> Eric has pointed out that we still have 3 users of do_each_thread().
>>> Change them to use for_each_process_thread() and kill this helper.
>>
>> Is there any change in behavior?
> 
> No.
> 
> Well, there is a subtle change, after do_each_thread/while_each_thread
> g == t == &init_task, while after for_each_process_thread() they both
> point to nowhere, but this doesn't matter.
> 
>> Why is for_each_process_thread() better than do_each_thread()?
> 
> Say, for_each_process_thread() is rcu safe, do_each_thread() is not.
> 
> And certainly
> 
> 	for_each_process_thread(p, t) {
> 		do_something(p, t);
> 	}
> 
> looks better than
> 
> 	do_each_thread(p, t) {
> 		do_something(p, t);
> 	} while_each_thread(p, t);
> 
> And again, there are only 3 users of this awkward helper left.
> It should have been killed years ago and in fact I thought it
> had already been killed. It uses while_each_thread() which needs
> some changes.

Sounds like a perfect commit log now... Unless squashed to the patch, it 
will be Linked at least. Thanks for explanation.

-- 
js
suse labs

