Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11CE37C6EF5
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 15:15:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378791AbjJLNPJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 09:15:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343659AbjJLNPH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 09:15:07 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D274D91
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 06:15:05 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-9b27f99a356so31446466b.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 06:15:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1697116504; x=1697721304; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Yt4vMxdhc5OiS38raoXweqMb1s/YLyfC9lsMx2p9myQ=;
        b=b24Ta8xZ1lr5BKfR3oLsXNu40rWwOA8LXtt32kroRAkwVjvTkGBfciNN2qHyNBsQcH
         XO4xeq8a/jVmzwgNs+I+ct7pgvrqEJjY0z1W8blOTRHehZVymnkUlUDpX/huoSSnI/6K
         vT5gJsejysyEW24tG63fY4jnqZq1+BhoQ6Bqc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697116504; x=1697721304;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Yt4vMxdhc5OiS38raoXweqMb1s/YLyfC9lsMx2p9myQ=;
        b=q2Huu42w6mbaOAQmn+GY0JueicQCneZbhjNyOAMietZj3gzuZchKK4LASKR4zPM6ka
         A2YQhRRXWAgGkhxZbKuds3o9ZHt71ukWVEaRtbR2u9YhsY4G4k+u8BaR8Dgi18oDZ1vf
         VbOFJPc6CEVi2+NMwUiNYt1zSyrRq3C1lyfnuORLQeWzO6RxJjgGaWi6HIVPmTxvekEm
         BnHa5cg1MKeT/5CCzMMYJkltV0fsPcbsWtBXfpcMYRpKuaghLe6xbt5VNhuaB5weUfvM
         H39Hj7s7KPPYNIJePGoUan0bMFl/FPSB0XIuFNGIZ0vyXJYqFwert/AtELU6jxN7SXNI
         Dq4w==
X-Gm-Message-State: AOJu0Yw/WCQtmevhVcvD66a5OZzpBUgayZXoIHul9FkFFFMp9yeiVg5v
        zqeiQDaQJJsvAdkAjhzWTF6nvw==
X-Google-Smtp-Source: AGHT+IG1wzY++o5tjLk6V/f5yQyOkJd2nDhrUvnp9sslLy1xRLXgeWc9DgSOIu1gb5dgIYqodHnzlg==
X-Received: by 2002:a17:906:100c:b0:9ae:6da8:181c with SMTP id 12-20020a170906100c00b009ae6da8181cmr18888342ejm.7.1697116503968;
        Thu, 12 Oct 2023 06:15:03 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id w19-20020a170906481300b009b9720a85e5sm11049401ejq.38.2023.10.12.06.15.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 06:15:02 -0700 (PDT)
Date:   Thu, 12 Oct 2023 15:15:00 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Cc:     Dave Airlie <airlied@gmail.com>,
        Thomas =?iso-8859-1?Q?Hellstr=F6m_=28Intel=29?= 
        <thomas_os@shipmail.org>, Danilo Krummrich <dakr@redhat.com>,
        daniel@ffwll.ch, matthew.brost@intel.com,
        thomas.hellstrom@linux.intel.com, sarah.walker@imgtec.com,
        donald.robson@imgtec.com, boris.brezillon@collabora.com,
        faith.ekstrand@collabora.com, bskeggs@redhat.com,
        Liam.Howlett@oracle.com, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH drm-misc-next 2/3] drm/gpuva_mgr: generalize
 dma_resv/extobj handling and GEM validation
Message-ID: <ZSfxVFe-cm70xM5s@phenom.ffwll.local>
Mail-Followup-To: Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Dave Airlie <airlied@gmail.com>,
        Thomas =?iso-8859-1?Q?Hellstr=F6m_=28Intel=29?= <thomas_os@shipmail.org>,
        Danilo Krummrich <dakr@redhat.com>, matthew.brost@intel.com,
        thomas.hellstrom@linux.intel.com, sarah.walker@imgtec.com,
        donald.robson@imgtec.com, boris.brezillon@collabora.com,
        faith.ekstrand@collabora.com, bskeggs@redhat.com,
        Liam.Howlett@oracle.com, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <ZO9Zq2RhbX8EeHrn@pollux>
 <736b6b6d-9e04-a27d-7d60-0c45d696b304@shipmail.org>
 <ZPB26A0/oLHTmyqk@cassiopeiae>
 <a8f28d62-daec-927a-a33d-5be3eec6a1ed@shipmail.org>
 <ZPDk/lao1JlBNGoJ@cassiopeiae>
 <8a8253ae-0b85-df90-b480-64eeebfafc6d@shipmail.org>
 <CAPM=9tz3o-m+8VJJ6hxWhykat0kpp1UE7dBJE3X91aHHo1Y2VA@mail.gmail.com>
 <76963abd-77a1-4bbd-9537-7b230e648a90@amd.com>
 <CAPM=9twSHGRoSoXxG+hz1T8iBX2VgPFvFsNCDnK_nHW9WJYBtw@mail.gmail.com>
 <1333e15b-f229-460a-8965-01ff3e778a4d@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1333e15b-f229-460a-8965-01ff3e778a4d@amd.com>
X-Operating-System: Linux phenom 6.5.0-1-amd64 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 12, 2023 at 02:35:15PM +0200, Christian König wrote:
> Am 12.10.23 um 12:33 schrieb Dave Airlie:
> > On Wed, 11 Oct 2023 at 17:07, Christian König <christian.koenig@amd.com> wrote:
> > > Am 10.10.23 um 22:23 schrieb Dave Airlie:
> > > > > I think we're then optimizing for different scenarios. Our compute
> > > > > driver will use mostly external objects only, and if shared, I don't
> > > > > forsee them bound to many VMs. What saves us currently here is that in
> > > > > compute mode we only really traverse the extobj list after a preempt
> > > > > fence wait, or when a vm is using a new context for the first time. So
> > > > > vm's extobj list is pretty large. Each bo's vma list will typically be
> > > > > pretty small.
> > > > Can I ask why we are optimising for this userspace, this seems
> > > > incredibly broken.
> > > > 
> > > > We've has this sort of problem in the past with Intel letting the tail
> > > > wag the horse, does anyone remember optimising relocations for a
> > > > userspace that didn't actually need to use relocations?
> > > > 
> > > > We need to ask why this userspace is doing this, can we get some
> > > > pointers to it? compute driver should have no reason to use mostly
> > > > external objects, the OpenCL and level0 APIs should be good enough to
> > > > figure this out.
> > > Well that is pretty normal use case, AMD works the same way.
> > > 
> > > In a multi GPU compute stack you have mostly all the data shared between
> > > different hardware devices.
> > > 
> > > As I said before looking at just the Vulcan use case is not a good idea
> > > at all.
> > > 
> > It's okay, I don't think anyone is doing that, some of the these
> > use-cases are buried in server land and you guys don't communicate
> > them very well.
> 
> Yeah, well everybody is trying very hard to get away from those approaches
> :)
> 
> But so far there hasn't been any breakthrough.
> 
> > 
> > multi-gpu compute would I'd hope be moving towards HMM/SVM type
> > solutions though?
> 
> Unfortunately not in the foreseeable future. HMM seems more and more like a
> dead end, at least for AMD.
> 
> AMD still has hardware support in all of their MI* products, but for Navi
> the features necessary for implementing HMM have been dropped. And it looks
> more and more like their are not going to come back.
> 
> Additional to that from the software side Felix summarized it in the HMM
> peer2peer discussion thread recently quite well. A buffer object based
> approach is not only simpler to handle, but also performant vise multiple
> magnitudes faster.

This matches what I'm hearing from all over. Turns out that handling page
faults in full generality in a compute/accel device (not just gpu) is just
too damn hard. At least for anyone who isn't nvidia. Usually time bound
preemption guarantees are the first to go, followed right after by a long
list of more fixed function hardware blocks that outright can't cope with
page faults.

There's so many corner cases where it breaks down that I feel like device
driver allocated memory of one flavor or another will stick around for a
very long time.

This isn't even counting the software challenges.
-Sima

> > I'm also not into looking at use-cases that used to be important but
> > might not as important going forward.
> 
> Well multimedia applications and OpenGL are still around, but it's not the
> main focus any more.
> 
> Christian.
> 
> > 
> > Dave.
> > 
> > 
> > > Christian.
> > > 
> > > > Dave.
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
