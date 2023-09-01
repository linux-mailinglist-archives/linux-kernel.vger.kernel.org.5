Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4D3D78FD0C
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 14:19:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349379AbjIAMTy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 08:19:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349318AbjIAMTx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 08:19:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB11FE7E
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 05:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1693570747;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=b2lpmJI7A731cOdQ5saRDMek43VB/lINJ2WX/JY+s6Y=;
        b=EhRm0UrNvnu0hrgy3FaPTHudqCgi5zzOEhfEYryEUs+2oxnLzXT8yPo9hZZQLFFMlOAk/8
        cFMGIY+kZkbyYRYqb4OEmM+q1cbXq44DWWPCaUzjhibNMmPJqaaMPgtn3ZE7aFxdGcUH+t
        LZ5o4RHRIEoTlXPU9kesY1czCr7nrc0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-186-x0sOku65MqiWyjIb2P9y9A-1; Fri, 01 Sep 2023 08:19:05 -0400
X-MC-Unique: x0sOku65MqiWyjIb2P9y9A-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-3fefea09bd0so12696915e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Sep 2023 05:19:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693570744; x=1694175544;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b2lpmJI7A731cOdQ5saRDMek43VB/lINJ2WX/JY+s6Y=;
        b=H9JM92MfvxPjEIFpD8Cvm7LgwTSIsPgm8DFsqyEeiAuzULuzjKAqom4mr9kXv5bkVS
         mcwgunjYDRVV5bna3ZIscLEBvzIfkg1XHZFSMjicBo7oPLv8QILgLx6gI2GKUpFQotQu
         3zbVfEbl88DWDA1mUaZpTvb6bdGOSa610LL/Wn0wfp0Z5TOOKBWF2lJ8QX1/DN0Zs+FY
         WRHVmRj3Qu0qqbCpNouspR7i93//koo2G9np30UsOcTTImKTUK2HmFr+tegkAXmlHQ+H
         4eskz4fF4qsur8GX7kRFWvSFwl2Bdkl8B2yW42YcryZr3l1BTVY/4GK3JYxazwvVzLWH
         LdWg==
X-Gm-Message-State: AOJu0YzmlqHcO8ryBDuxMAvEiH9v6hNFDp4F1sOyDbeCX6ab78q3tijd
        +7E9zlbEB4SDH4iY7raHDzzgDFbqIUIidfRRuhuzVIGmYKdunA9abPh4VCWDf8tW6D6dAbGfQVz
        oxzz+Bn5WyqeAJZF5BbSOnQIj
X-Received: by 2002:a1c:771a:0:b0:3fe:e7b2:c97f with SMTP id t26-20020a1c771a000000b003fee7b2c97fmr1726423wmi.36.1693570744587;
        Fri, 01 Sep 2023 05:19:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHtVbvk7FwnZkok7N7tIgQ0k0moP+HWkRwiU3fwK8zuPdH5820WOut3sSNhbou5ZBSU3FxpXw==
X-Received: by 2002:a1c:771a:0:b0:3fe:e7b2:c97f with SMTP id t26-20020a1c771a000000b003fee7b2c97fmr1726410wmi.36.1693570744303;
        Fri, 01 Sep 2023 05:19:04 -0700 (PDT)
Received: from vschneid.remote.csb (anice-256-1-26-111.w86-203.abo.wanadoo.fr. [86.203.135.111])
        by smtp.gmail.com with ESMTPSA id w17-20020a05600c015100b00401d6c0505csm4693416wmm.47.2023.09.01.05.19.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Sep 2023 05:19:03 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ajay Kaher <akaher@vmware.com>,
        Eric Vaughn <ervaughn@linux.microsoft.com>,
        Sishuai Gong <sishuai.system@gmail.com>,
        Uros Bizjak <ubizjak@gmail.com>,
        Yue Haibing <yuehaibing@huawei.com>,
        Zhang Zekun <zhangzekun11@huawei.com>,
        Zheng Yejian <zhengyejian1@huawei.com>
Subject: Re: [GIT PULL] tracing: Updates for 6.6
In-Reply-To: <20230901074400.349d5c41@rorschach.local.home>
References: <20230831115635.1bdea0d7@rorschach.local.home>
 <xhsmhr0nib674.mognet@vschneid.remote.csb>
 <20230901074400.349d5c41@rorschach.local.home>
Date:   Fri, 01 Sep 2023 14:19:02 +0200
Message-ID: <xhsmho7imaxxl.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/09/23 07:44, Steven Rostedt wrote:
> On Fri, 01 Sep 2023 11:20:31 +0200
> Valentin Schneider <vschneid@redhat.com> wrote:
>> > Tracing updates for 6.6:
>> >
>> >  User visible changes:
>> >
>> >   - Added a way to easier filter with cpumasks:
>> >      # echo 'cpumask & CPUS{17-42}' > /sys/kernel/tracing/events/ipi_send_cpumask/filter
>> >
>>
>> It looks like the patches included are from v2 of [1], which still had some
>> (small) issues to fix. I have addressed these in [2], but I haven't sent
>> this out yet as I'm still working on the context_tracking/vmalloc part of
>> the series.
>>
>> I'm happy to send just the tracing bits, if that helps - or just send the
>> deltas as separate fixes, whatever makes it easier.
>
> I put these patches into linux-next for a while, so I'm not going to
> rebase them. Can you send delta patches on top of this. This shouldn't
> stop this pull request.
>

Noted, I'll get on with this.

>>
>> Apologies for not bringing this up when the patches were picked up in [3],
>> I've only just come back from PTO/moving abroad and have started catching
>> up.
>
> I'm still trying to get home from my PTO, which I spent in Tampa and
> was suppose to fly home on Tuesday. But they closed the airport in
> preparation for Idalia, which forced my wife and I to hunker down in a
> hotel room for the last few days :-p (we are now in a to hotel room in
> Syracuse, and are about to drive home).
>

Sounds like you've had an "interesting" journey :)

> -- Steve

