Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 637C97D9B8D
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 16:35:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346119AbjJ0Of3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 10:35:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346103AbjJ0OfZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 10:35:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D505B128
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 07:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698417275;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=K5sokQZCAq452GDyZ2Dqlvt2GWiPurBujB1LiUqRJs0=;
        b=QVJUdEDd3JiJrOoDDqgECyRyBdOJZqliJYm39KjZws7iscRowU6YG4NjCyRNNBy1MYXrcQ
        cz2dchhwQcdsD8OVYcFp9+kTxE6cxQC757W5mT37EkcIfwIoU8SB5hCbtHlUtSsx8a8HtE
        DYJuyDIIa4pUkTRlsTPk90v3AJ+Fl/g=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-450-4A29D8LTND6ATl80FSXkKw-1; Fri, 27 Oct 2023 10:34:29 -0400
X-MC-Unique: 4A29D8LTND6ATl80FSXkKw-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-32df2fc01e8so2216103f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 07:34:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698417268; x=1699022068;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K5sokQZCAq452GDyZ2Dqlvt2GWiPurBujB1LiUqRJs0=;
        b=pAcPyFM4h4cT9JD5oH0Qc0fMUNf87yT8ttNSmRRfKbafb+orUqFypI/ol+qkUTFjIZ
         FaO1cJR2G9v+TxMtjb5U4JukSUrOBzY+ktWDA0nApfMUM0lyaWmOweSln7lrTTv9mX9Q
         c8UHjKzErU2GqvQkiCmWKGH4KjERDnTgFp7Zt+1NRgmv7HYEzNVl3CoPjbTL7ryDb2yR
         ZwYvD0vNHGFVikf4HBKEOS6jqAHdFPbfDauEWw1ZmMiRANvdcg9FBL6bvtsPVwjhoBWg
         v4gz372PkXiGAcUwU0PDBmnyqVDmZobkvaShikG+iniAyUGK465Vc0SJuEa0SgPiTEg0
         fMOg==
X-Gm-Message-State: AOJu0YxniX2VV8qMhHZ9Ti9E7+DEQQkWRDLisnN0KMFKHGFWamCXUTW9
        4mISgDKxOitg1S66/yar5QkfB/dLTtj8IwTV0uu7EAis/L+W5d7W25dEEOGuwoAdS87zMxyeP+3
        GgZmH4FjyK4zxEbGigPppObIH
X-Received: by 2002:a5d:588f:0:b0:32f:7159:c5a with SMTP id n15-20020a5d588f000000b0032f71590c5amr2390253wrf.3.1698417267848;
        Fri, 27 Oct 2023 07:34:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGJL8QPnW6lUOAA5iB5kBnMmw4h1OwKHuUzPfK0GLI3XMENVubhIB2jpyXUy23cBmNfrvDAUg==
X-Received: by 2002:a5d:588f:0:b0:32f:7159:c5a with SMTP id n15-20020a5d588f000000b0032f71590c5amr2390205wrf.3.1698417267417;
        Fri, 27 Oct 2023 07:34:27 -0700 (PDT)
Received: from ?IPV6:2a02:810d:4b3f:de9c:abf:b8ff:feee:998b? ([2a02:810d:4b3f:de9c:abf:b8ff:feee:998b])
        by smtp.gmail.com with ESMTPSA id i21-20020a05600c355500b00405959469afsm1799979wmq.3.2023.10.27.07.34.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Oct 2023 07:34:27 -0700 (PDT)
Message-ID: <794f9b45-db0d-4261-aefe-7da2ad0ed3b7@redhat.com>
Date:   Fri, 27 Oct 2023 16:34:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH drm-misc-next v3] drm/sched: implement dynamic job-flow
 control
Content-Language: en-US
To:     Boris Brezillon <boris.brezillon@collabora.com>
Cc:     airlied@gmail.com, daniel@ffwll.ch, matthew.brost@intel.com,
        christian.koenig@amd.com, faith@gfxstrand.net,
        luben.tuikov@amd.com, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20231026161431.5934-1-dakr@redhat.com>
 <20231027091755.3635be36@collabora.com>
From:   Danilo Krummrich <dakr@redhat.com>
Organization: RedHat
In-Reply-To: <20231027091755.3635be36@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/27/23 09:17, Boris Brezillon wrote:
> Hi Danilo,
> 
> On Thu, 26 Oct 2023 18:13:00 +0200
> Danilo Krummrich <dakr@redhat.com> wrote:
> 
>> +
>> +	/**
>> +	 * @update_job_credits: Called once the scheduler is considering this
>> +	 * job for execution.
>> +	 *
>> +	 * Drivers may use this to update the job's submission credits, which is
>> +	 * useful to e.g. deduct the number of native fences which have been
>> +	 * signaled meanwhile.
>> +	 *
>> +	 * The callback must either return the new number of submission credits
>> +	 * for the given job, or zero if no update is required.
>> +	 *
>> +	 * This callback is optional.
>> +	 */
>> +	u32 (*update_job_credits)(struct drm_sched_job *sched_job);
> 
> I'm copying my late reply to v2 here so it doesn't get lost:
> 
> I keep thinking it'd be simpler to make this a void function that
> updates s_job->submission_credits directly. I also don't see the
> problem with doing a sanity check on job->submission_credits. I mean,
> if the driver is doing something silly, you can't do much to prevent it
> anyway, except warn the user that something wrong has happened. If you
> want to
> 
> 	WARN_ON(job->submission_credits == 0 ||
> 		job->submission_credits > job_old_submission_credits);
> 
> that's fine. But none of this sanity checking has to do with the
> function prototype/semantics, and I'm still not comfortable with this 0
> => no-change. If there's no change, we should just leave
> job->submission_credits unchanged (or return job->submission_credits)
> instead of inventing a new special case.

If we can avoid letting drivers change fields of generic structures directly
without any drawbacks I think we should avoid it. Currently, drivers shouldn't
have the need to mess with job->credits directly. The initial value is set
through drm_sched_job_init() and is updated through the return value of
update_job_credits().

I'm fine getting rid of the 0 => no-change semantics though. Instead we can just
WARN() on 0. However, if we do that I'd also want to change it for
drm_sched_job_init() (where 0 currently defaults to 1) such that we accept 0, but
WARN() accordingly.

I think it's consequent to either consistently give 0 a different meaning or just
accept it but WARN() on it.

> 
> Regards,
> 
> Boris
> 

