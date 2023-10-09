Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28F4D7BE387
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 16:51:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344737AbjJIOvC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 10:51:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234545AbjJIOu6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 10:50:58 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4659BA
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 07:50:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696863007;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0QI01TR518bmXZ35JoYLXbNHoVx8+Aq7SAiCBhjb9JM=;
        b=cpDoz/5p+B37RW+cptORZTv43VjYxiLhDG+wOakr2s0vpr6xlf8WS+2QkxdoaYcBS5ZoF8
        UBDMxoULEDaXh2Fao6P731Qq2i4kteb0v8bSXQ0pBCPYALFyvYWVqMC9fQLBPRgeUjT4Z/
        p0By0w0k3wXP6/rAciGop7UXPLOxIP0=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-576-kn9AfhYbOUGoifR8ErbZvg-1; Mon, 09 Oct 2023 10:50:04 -0400
X-MC-Unique: kn9AfhYbOUGoifR8ErbZvg-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6557c921deeso58010686d6.2
        for <linux-kernel@vger.kernel.org>; Mon, 09 Oct 2023 07:50:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696863004; x=1697467804;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0QI01TR518bmXZ35JoYLXbNHoVx8+Aq7SAiCBhjb9JM=;
        b=FcMnVwqBxFTwMtVQWt6kPT7Ie+aP+KSaSuwCy+x2vxs1HymQFkj+dS4twlUsfYk6v8
         D95Mcc1KU2xNRcNXoBNlhL4Vfiysb5u2f+e2qdvWMHRgGXvAyr8z3spB5+fxoeQ1UaFH
         ronEFAj85l4Eh9xCobtgOasxsQ7bWfFUFdcMz7TRL1m1U4MgFOwNaPddQ+4FB/YRZoc2
         MN4C4fQiWU9oNQJOTUqYPXwzbI3JMtz14vtKfeAnQ0LxVL8MWHlELM8/+lwDyu5Ulhmc
         WfRrHwXSWA110T3c9TbjAJbR+gP8oupfXkdSzVxIgC6840pFfH89knCTZF9jGUsUUynA
         yD5Q==
X-Gm-Message-State: AOJu0YwQulj4BD/YRbp1wRtzhzbPX1DtGlWHlYhjW5P8kmgnT21NfwAV
        ce7dXX14Tg/ShrUCi5dMh5eCh2iRAHStY9dmI9xnTWFEaoGcMpvI0Yh4p1vT3Kwp+j3xOwaKrr3
        4ux1GGwvcM+ayAp5vobOATFeYH4FhsXHh
X-Received: by 2002:a05:6214:5b0e:b0:65a:f1f2:470d with SMTP id ma14-20020a0562145b0e00b0065af1f2470dmr17296792qvb.58.1696863003989;
        Mon, 09 Oct 2023 07:50:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEnMvDowT6c21TFAV40BzM0CK5NbMAXkDhmYPM3AH74OBOqDL5i5Vzxfry6kTn67iNpz4YE9A==
X-Received: by 2002:a05:6214:5b0e:b0:65a:f1f2:470d with SMTP id ma14-20020a0562145b0e00b0065af1f2470dmr17296778qvb.58.1696863003778;
        Mon, 09 Oct 2023 07:50:03 -0700 (PDT)
Received: from vschneid.remote.csb (213-44-141-166.abo.bbox.fr. [213.44.141.166])
        by smtp.gmail.com with ESMTPSA id d7-20020a0cb2c7000000b0064f5d70d072sm3956354qvf.37.2023.10.09.07.50.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 07:50:03 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     Shrikanth Hegde <sshegde@linux.vnet.ibm.com>, mingo@redhat.com,
        peterz@infradead.org, vincent.guittot@linaro.org
Cc:     sshegde@linux.vnet.ibm.com, dietmar.eggemann@arm.com,
        linux-kernel@vger.kernel.org, qperret@google.com,
        srikar@linux.vnet.ibm.com, mingo@kernel.org,
        pierre.gondois@arm.com, yu.c.chen@intel.com,
        tim.c.chen@linux.intel.com, pauld@redhat.com, lukasz.luba@arm.com,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH v6 2/2] sched/topology: change behaviour of sysctl
 sched_energy_aware based on the platform
In-Reply-To: <20231009060037.170765-3-sshegde@linux.vnet.ibm.com>
References: <20231009060037.170765-1-sshegde@linux.vnet.ibm.com>
 <20231009060037.170765-3-sshegde@linux.vnet.ibm.com>
Date:   Mon, 09 Oct 2023 16:49:59 +0200
Message-ID: <xhsmhmswronoo.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/10/23 11:30, Shrikanth Hegde wrote:
> sysctl sched_energy_aware is available for the admin to disable/enable
> energy aware scheduling(EAS). EAS is enabled only if few conditions are
> met by the platform. They are, asymmetric CPU capacity, no SMT,
> schedutil CPUfreq governor, frequency invariant load tracking etc.
> A platform may boot without EAS capability, but could gain such
> capability at runtime. For example, changing/registering the CPUfreq
> governor to schedutil.
>
> At present, though platform doesn't support EAS, this sysctl returns 1
> and it ends up calling build_perf_domains on write to 1 and
> NOP when writing to 0. That is confusing and un-necessary.
>
> Desired behavior would be to have this sysctl to enable/disable the EAS
> on supported platform. On non-supported platform write to the sysctl
> would return not supported error and read of the sysctl would return
> empty. So
> sched_energy_aware returns empty - EAS is not possible at this moment
> This will include EAS capable platforms which have at least one EAS
> condition false during startup, e.g. not using the schedutil CPUfreq governor
> sched_energy_aware returns 0 - EAS is supported but disabled by admin.
> sched_energy_aware returns 1 - EAS is supported and enabled.
>
> User can find out the reason why EAS is not possible by checking
> info messages. sched_is_eas_possible returns true if the platform
> can do EAS at this moment.
>
> Tested-by: Pierre Gondois <pierre.gondois@arm.com>
> Signed-off-by: Shrikanth Hegde <sshegde@linux.vnet.ibm.com>

Reviewed-by: Valentin Schneider <vschneid@redhat.com>

