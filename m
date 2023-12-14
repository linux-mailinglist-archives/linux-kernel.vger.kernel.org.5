Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EBFA8126FF
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 06:37:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443182AbjLNFgz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 00:36:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229838AbjLNFgw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 00:36:52 -0500
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D939710B
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 21:36:57 -0800 (PST)
Received: by mail-ot1-x32e.google.com with SMTP id 46e09a7af769-6da3a585c29so813055a34.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 21:36:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702532217; x=1703137017; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rW/CLTesU9Nn+LDbwmg1S+LrWy0eO5LzJlVzZDN0NTk=;
        b=jfo+1DlFqx8LsY6i/hotCzNlUYjU1w3ZXEtYZFQbSP0KXI4qUbKIo09XJC9c10Rbnn
         Xp+iJwynQIu/0QwwzampcgNBc8dMd9Atlmd0rMys28PeomYDn9A5QIVm6CXhw+hGGaF2
         fmfQJ9ILZa9yt+SwM0u2YRM1R3wt9FPsDH2jW0fd3sKaAPD1BYR+djeV4YYi2DegDjm+
         LKZwWWQqKZ1YEJZFOehxysgPGxHsMbIuV3MM7HuqZhDniw0Zuy/4Pyqb9BZ0P2VP0+pc
         tqGbya/ImWZpBQjcU1dbPOEj3Ugjk+3CHtu61HN1ButCzD9+ds0NqrehKojA4S8MKCR1
         gsOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702532217; x=1703137017;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rW/CLTesU9Nn+LDbwmg1S+LrWy0eO5LzJlVzZDN0NTk=;
        b=UoUeyhECMPOoGHEU537b81zrUExtXiHEpTo5jrkzJgDvErEgrXYhMeXZQcVsD2SQR4
         CZEWzvLC65GgDcLUHJJz2wdhQ1cDO2jshKfp5YZayd+nc8xhK2k6VWdLWWuhbp9L3+08
         dVRfu8nDnjiDQY3hV1Fc3Io/3Jp+mv3y/28sISSTCG4w71ax/ouRmmNkkKwKw5kuJPMx
         vxgl71+vHnS9M9TTWH9TtrJz1z+01ug2RiIyPSGS8lm7fXC/ywUiJmQk7cRs3PPgjgCv
         gxvVfaL+Fu2OifdPfT7SlBhe3ljb3mPp5jcSnZwHHwQ6WXID8N+JZbYHOJEACRc0x1ni
         6g8Q==
X-Gm-Message-State: AOJu0YzUGdLV768cBQQ6pSCm2qwWdx+Oxom0KCbCVI2q/DsgIl3suPux
        cwZMk2cEOFVjgUkK1q8hFEwmLg==
X-Google-Smtp-Source: AGHT+IH+QeozbSYX0p0iXQ2G4XEln4ZOmYJ/iRjOrOBzxt3QGNJfpEqpr0j+HhoTkIB2PwvvSueIuQ==
X-Received: by 2002:a05:6358:7e8d:b0:170:6d55:e82e with SMTP id o13-20020a0563587e8d00b001706d55e82emr12607996rwn.2.1702532217124;
        Wed, 13 Dec 2023 21:36:57 -0800 (PST)
Received: from localhost ([122.172.82.6])
        by smtp.gmail.com with ESMTPSA id pv18-20020a17090b3c9200b0028b0424a4bcsm723845pjb.54.2023.12.13.21.36.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 21:36:56 -0800 (PST)
Date:   Thu, 14 Dec 2023 11:06:53 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Tim Chen <tim.c.chen@linux.intel.com>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        catalin.marinas@arm.com, will@kernel.org, sudeep.holla@arm.com,
        rafael@kernel.org, agross@kernel.org, andersson@kernel.org,
        konrad.dybcio@linaro.org, mingo@redhat.com, peterz@infradead.org,
        juri.lelli@redhat.com, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, lukasz.luba@arm.com,
        rui.zhang@intel.com, mhiramat@kernel.org,
        daniel.lezcano@linaro.org, amit.kachhap@gmail.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] cpufreq: Add a cpufreq pressure feedback for the
 scheduler
Message-ID: <20231214053653.hnyeormwu42un5sc@vireshk-i7>
References: <20231212142730.998913-1-vincent.guittot@linaro.org>
 <20231212142730.998913-2-vincent.guittot@linaro.org>
 <2e8807b68133f4b3a72227122a9d9a05f3fbf9d8.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2e8807b68133f4b3a72227122a9d9a05f3fbf9d8.camel@linux.intel.com>
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13-12-23, 16:41, Tim Chen wrote:
> Seems like the pressure value computed from the first CPU applies to all CPU.
> Will this be valid for non-homogeneous CPUs that could have different
> max_freq and max_capacity?

The will be part of different cpufreq policies and so it will work
fine.

-- 
viresh
