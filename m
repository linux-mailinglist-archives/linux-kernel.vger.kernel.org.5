Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 441EF7AB5E2
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 18:29:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232286AbjIVQ3O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 12:29:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbjIVQ3L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 12:29:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A195C198
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 09:28:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695400097;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=x72lG+xKk/KRLpNMD1Ia6gvA7sLEGeCIka5YNzmFMi0=;
        b=ACRAqJMRXm346vEEOsJfCzXjQV1PLiwrgf7jfefLqNe9T+GfwBrupnCxvu/nulUU68nF4T
        SyU62QtJZ0cBWstX2JjQvjPJQv1zRh9a7nymuKs6sW+pwdvVQwi998MGRJVdFe9rdJFyL4
        2SFfU74ynAttf1n+eNJ/TIBwRs5Pye4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-581-0GpvakwdN-WYiOskGSW5Kg-1; Fri, 22 Sep 2023 12:28:16 -0400
X-MC-Unique: 0GpvakwdN-WYiOskGSW5Kg-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-403ca0e2112so17964195e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 09:28:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695400095; x=1696004895;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x72lG+xKk/KRLpNMD1Ia6gvA7sLEGeCIka5YNzmFMi0=;
        b=FE6rc95hE9F7jTtTszec6HlFG6vMeX5SH92/74LslzVxUHpWg4Gi0Cm88qoyRl+BsB
         KFkYXC26y4wT/d6bdBrpH28/0KikNNSwpiPtzh7VSaJZQnHJ4x221qA9xy3YkNUS/DC+
         ZjoOmqyQ8/2fB1c5RO3u+TGTcuMWlXuAy5MQ0cZM1HP6cTjC3glacEUIUSoJUtkH2vng
         OvSUgSP1Qb7IchQFx+ZKQeNx6czF4dIpSg525pglisgfeye15bDwfdMI2asIzZSb5ibR
         BbEekZQudw9u8THURFge8X5hcy9Epedxns9wm9kojtB3+UYZc+TqQHf1ah+zaoiXBp3q
         TQWQ==
X-Gm-Message-State: AOJu0YwLT1QR4i033eHG41ibCcJjIirdI+M0ioKpmf5YMVDiSFaWTdFD
        gW6CSkd3Vfr8/hbj9lwTeMxdEQmnkK9BtBSRtc25QcovndRk3y44bW1oKmBe6X/3k6AcSQHzxDz
        uJMqN+HiAN6XH0TxrEhfRsJJ/wGaYpAZO
X-Received: by 2002:a05:600c:2144:b0:3fb:e2af:49f6 with SMTP id v4-20020a05600c214400b003fbe2af49f6mr7691409wml.39.1695400094911;
        Fri, 22 Sep 2023 09:28:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG+zkN+p9+ExvAygDXJgbRgOGkdEXlgk4Zzuk9d1edzxgcDsqvwCHeXS0vwpIgm/924g+QCBg==
X-Received: by 2002:a05:600c:2144:b0:3fb:e2af:49f6 with SMTP id v4-20020a05600c214400b003fbe2af49f6mr7691392wml.39.1695400094621;
        Fri, 22 Sep 2023 09:28:14 -0700 (PDT)
Received: from vschneid.remote.csb ([80.214.213.87])
        by smtp.gmail.com with ESMTPSA id 15-20020a05600c020f00b00401d8810c8bsm7876938wmi.15.2023.09.22.09.28.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Sep 2023 09:28:14 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     Eric DeVolder <eric.devolder@oracle.com>,
        linux-kernel@vger.kernel.org, bhe@redhat.com, vgoyal@redhat.com,
        dyoung@redhat.com, ebiederm@xmission.com, kexec@lists.infradead.org
Cc:     sourabhjain@linux.ibm.com, konrad.wilk@oracle.com,
        boris.ostrovsky@oracle.com, eric.devolder@oracle.com
Subject: Re: [PATCH] kexec: change locking mechanism to a mutex
In-Reply-To: <20230921215938.2192-1-eric.devolder@oracle.com>
References: <20230921215938.2192-1-eric.devolder@oracle.com>
Date:   Fri, 22 Sep 2023 18:28:12 +0200
Message-ID: <xhsmh7coiuq8z.mognet@vschneid.remote.csb>
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

On 21/09/23 17:59, Eric DeVolder wrote:
> The design decision to use the atomic lock is described in the comment
> from kexec_internal.h, cited above. However, examining the code of
> __crash_kexec():
>
>         if (kexec_trylock()) {
>                 if (kexec_crash_image) {
>                         ...
>                 }
>                 kexec_unlock();
>         }
>
> reveals that the use of kexec_trylock() here is actually a "best effort"
> due to the atomic lock.  This atomic lock, prior to crash hotplug,
> would almost always be assured (another kexec syscall could hold the lock
> and prevent this, but that is about it).
>
> So at the point where the capture kernel would be invoked, if the lock
> is not obtained, then kdump doesn't occur.
>
> It is possible to instead use a mutex with proper waiting, and utilize
> mutex_trylock() as the "best effort" in __crash_kexec(). The use of a
> mutex then avoids all the lock acquisition problems that were revealed
> by the crash hotplug activity.
>

@Dave thanks for the Cc, I'd have missed this otherwise.


Prior to the atomic thingie, we actually had a mutex and did
mutex_trylock() in __crash_kexec(). I'm a bit confused as this looks like a
revert of
  05c6257433b7 ("panic, kexec: make __crash_kexec() NMI safe")
with just the helpers kept in - this doesn't seem to address any of the
original issues regarding NMIs?

Sebastian raised some good points in [1] regarding these issues.
The main hurdle pointed out there is, if we end up in the slowpath during
the unlock, then we can can up acquiring the ->wait_lock which isn't NMI
safe.

This is even worse on PREEMPT_RT, as both trylock and the unlock can end up
acquiring the ->wait_lock.

[1]: https://lore.kernel.org/all/YqyZ%2FUf14qkYtMDX@linutronix.de/

