Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A53207E71EB
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 20:08:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345091AbjKITIp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 14:08:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344704AbjKITIo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 14:08:44 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F47130EB;
        Thu,  9 Nov 2023 11:08:42 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id 98e67ed59e1d1-280165bba25so1063884a91.2;
        Thu, 09 Nov 2023 11:08:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699556921; x=1700161721; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=npAIX4H7GIRegyucDnBbB08OaARn4b9MKFCtEnd9Z7U=;
        b=H39Viedvuru8lFvMNT3sCYgi7QaIX4l9Y2Xm6L88HQaav9DhtYEo965P6yVeoyoIwr
         wP+mOObD/nHC/Ja1hDSLla0W0REWh3YIMhIAejeSBCV2OdH74m1ixW84sQhlW9XgQmP7
         53gDcUxtbvnpKUIJHQE7Ms6pliUUsieG2XBm19arB0UPe1PimF3kdbMGJUe7uUQZ0xXo
         fOiks2BontqSmd7aHVdinIcB0+V2VeKQb6sc0pFq0+hRo3sg4py+xQm1DKttDlM46eNI
         JX5GPpGVygcwGmOOw7CwdjoA6tOrDjLYV8W4jjv0mTZ+8ATyC0QPcA6eNKcndVINW14F
         I/lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699556921; x=1700161721;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=npAIX4H7GIRegyucDnBbB08OaARn4b9MKFCtEnd9Z7U=;
        b=T2BbfjNSQBprB+fXjdjaK1c4/R2x7E/CjxVGJhCUmrGqQFj4yRsEKHNAednHS2eWNT
         5UNv4kA0jyg2dglAOYB1RzGhtb2yGHMjefFit9wm5/8uItDq/tWvBjMy64Ofi/ptkZb9
         iH9ACRH1kG/FrUv68L1skICt1nSnQJnIKFTMJ1hmyYMPikJ8Vna9wANa0EqBqQBD2wnK
         edkUNAnLM87v25BlgzxAXzXz+c/zuP0b8eBDyDsCm3L9KNGxOVSzoyazyTa4izFJ4cGl
         5WPW13d5q34juK9U1Uzr1Ja+SE5VMZt4aNWY38K/ftBqe1reu1OXET5cIOYcpieGS0UO
         it0w==
X-Gm-Message-State: AOJu0Yz2vTr9BsCTvlcpDRovCWIW+I3XWaoIsBRBKvX9r5TZ7eXKvQA5
        qjpv6gFwG5ZeIP02w+FoJTg=
X-Google-Smtp-Source: AGHT+IHANweqCAVqfZMYyy8BrIodOf/S3c/ozotfwvar93GAbDNaJdXSTIsp1f0jdVE3vUyj50hSvA==
X-Received: by 2002:a17:90a:1a4a:b0:27d:58a8:fa7f with SMTP id 10-20020a17090a1a4a00b0027d58a8fa7fmr2559321pjl.37.1699556921602;
        Thu, 09 Nov 2023 11:08:41 -0800 (PST)
Received: from localhost ([2620:10d:c090:400::4:7384])
        by smtp.gmail.com with ESMTPSA id z10-20020a17090a8b8a00b0026b3f76a063sm117323pjn.44.2023.11.09.11.08.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 11:08:41 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Thu, 9 Nov 2023 09:08:39 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Mukesh Ojha <quic_mojha@quicinc.com>
Cc:     myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
        cw00.choi@samsung.com, jstultz@google.com, tglx@linutronix.de,
        sboyd@kernel.org, jiangshanlai@gmail.com,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: timer list corruption in devfreq
Message-ID: <ZU0uNy6l0ZuzBmlf@slm.duckdns.org>
References: <1699459797-21703-1-git-send-email-quic_mojha@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1699459797-21703-1-git-send-email-quic_mojha@quicinc.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Wed, Nov 08, 2023 at 09:39:57PM +0530, Mukesh Ojha wrote:
> We are facing an issue on 6.1 kernel while using devfreq framework
> and looks like the devfreq_monitor_stop()/devfreq_monitor_start is
> vulnerable if frequent governor change is being done from user space
> in a loop.
> 
> echo simple_ondemand > /sys/class/devfreq/1d84000.ufshc/governor
> echo performance > /sys/class/devfreq/1d84000.ufshc/governor
> 
> Here, we are using ufs device, but could be any device.
> 
> Issue is because same instance of timer is being queued from two
> places one from devfreq_monitor() and one from devfreq_monitor_start() as
> cancel_delayed_work_sync() from devfreq_monitor_stop() was not
> able to delete the delayed work time completely due to which
> devfreq_monitor() work rearmed the same timer.
> 
> But there looks to be issue in the timer framework where
> it was initially discussed in [1] and later fixed in [2]
> but not sure being whether is it issue in cancel_delayed_work_sync()
> where del_timer() inside try_to_grab_pending() need to be replaced
> with timer_delete[_sync]() or devfreq_monitor_stop() need to use
> this api's and then delete the work.

So, having shutdown can be more convenient in some cases and that'd be a
useful addition to workqueue both for immediate and delayed work items. That
said, that's usually not essential in fixing these issues - e.g. Can't you
just synchronize devfreq_monitor_start() and stop()?

Thanks.

-- 
tejun
