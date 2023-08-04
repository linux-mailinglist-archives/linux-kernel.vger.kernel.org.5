Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D211770805
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 20:36:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229736AbjHDSgK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 14:36:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjHDSfN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 14:35:13 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69C6B4ECE
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 11:33:55 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d437624b9c1so1126994276.0
        for <linux-kernel@vger.kernel.org>; Fri, 04 Aug 2023 11:33:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691174034; x=1691778834;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=SzgCQZrREJ8wwDiX6siz2qHa1/7eISD6QAlgSdu5Knw=;
        b=dafKDsAUIw0Ie3fHqOzQMKvbKji+TOslqxd+53S8Ae1ULDmkeB/ua1YPOdYXPbSr0W
         n0B0znsGS31LPviJM1SZCFmESkuTcUMny2hya9DL0xdvpWCSxSHRJCfVCbNxLfYyeFRv
         EIycdVeNgQRE7OZLu04A+9r6jEyZbrSMa/ojO+QiKtGQ5lFCv7kKrPSc1rHckvDKMSWE
         Py9HduHTpVfSHRrXxUOhd0+x82M2xiEsF5OLWY4E2sB+9UWBaFq9En3wnmE643RVcCta
         tFFvd4rXgtsTJi80YNeW/3oG4StJ9Y06uzrmvVFVFIhnYu0yb5aHuCS39qa1aL/NYiUV
         FCOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691174034; x=1691778834;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SzgCQZrREJ8wwDiX6siz2qHa1/7eISD6QAlgSdu5Knw=;
        b=Q43yFFd4AC/cQQP9HD2diZIBbRCx8ZxOm7KMG61NkkPWjSBdd0DTv3TQMSj/quhQ+h
         HyuV51rAFc2eVi1POtRYoHAtOEQf/UdKo6qaZqZ5G2UnSOSM5NboCBX2ZFkd5VNJs1UR
         RhPYeFb36seTE210+DQiaE0mtDOjY/lGAuQs/RpgTGY8xct3dAvL1nN2YHqan+0YAM5Z
         qeg6KMJr8mEQi2DD73GzIYf+BX+0M1RJ/oIyz7Mf/p8HvAtcVGIZ6Nts3YCB549/cnGy
         BFMiijrG10yw5brZ/08DBwG/Zs4gU3ELQUIwNhIQyl3g+ccWUguEI1GUof8kE2RHXp5J
         lNyA==
X-Gm-Message-State: AOJu0YxfZOt5+mzz1DSGQH0V/dWJOR/uWfa9fHG3UMvzxJkIr0ZC8Au5
        Efn5PzWRvkLU70nCetawOYjNksWV+rY=
X-Google-Smtp-Source: AGHT+IEu3d94rrVmJ78RS29lOywQDiyzD14VCrwEVoVIDv3RxrRH95F0M9gwGQrPVV9YwLdxoui14M8wTbI=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:42ca:0:b0:d07:16db:6f8f with SMTP id
 p193-20020a2542ca000000b00d0716db6f8fmr13913yba.6.1691174034726; Fri, 04 Aug
 2023 11:33:54 -0700 (PDT)
Date:   Fri, 4 Aug 2023 11:33:53 -0700
In-Reply-To: <gsnto7jm8zbu.fsf@coltonlewis-kvm.c.googlers.com>
Mime-Version: 1.0
References: <ZM0rXgKvb912k5BE@linux.dev> <gsnto7jm8zbu.fsf@coltonlewis-kvm.c.googlers.com>
Message-ID: <ZM1EkRMf23e2YUBs@google.com>
Subject: Re: [PATCH 2/4] KVM: selftests: Add helper macros for ioctl()s that
 return file descriptors
From:   Sean Christopherson <seanjc@google.com>
To:     Colton Lewis <coltonlewis@google.com>
Cc:     Oliver Upton <oliver.upton@linux.dev>, maz@kernel.org,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        linux-kernel@vger.kernel.org, mhal@rbox.co
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 04, 2023, Colton Lewis wrote:
> Oliver Upton <oliver.upton@linux.dev> writes:
> 
> > Hi Sean,
> 
> > On Thu, Aug 03, 2023 at 05:42:24PM -0700, Sean Christopherson wrote:
> > > Add KVM, VM, and vCPU scoped helpers for ioctl()s that return file
> > > descriptors, i.e. deduplicate code for asserting success on ioctls() for
> > > which a positive return value, not just zero, is considered success.
> 
> > > Signed-off-by: Sean Christopherson <seanjc@google.com>
> 
> > I appreciate the desire to eliminate duplicate code, but I think the
> > naming just muddies the waters. TBH, when I first read the diff w/o the
> > changelog, I thought you were describing the input fd (i.e. 'kvm_fd',
> > 'vm_fd', 'vcpu_fd'). I don't think explicitly spelling out the condition
> > each time (i.e. ret >= 0) is all that difficult.
> 
> Couldn't ret >= 0 be the assert condition for everything? Don't see why
> there needs to be different helpers to check == 0 and >= 0.
> 
> Unless I'm missing something, error returns are only ever negative.

Using "ret >= 0" would work in the sense that the tests wouldn't fail, but it
would degrade our test coverage, e.g. selftests wouldn't detect KVM bugs where
an ioctl() unexpectedly returns a non-zero, positive value.

The other wrinkle is that selftests need to actually consume the return value for
ioctl()s that return a positive value, i.e. the fd (or whatever it is) needs to
propagated up the stack.  I.e. all of the generic ioctl() macros would need to
"return" the value, which I really don't want to do because that would (re)open
the gates for having helpers that return an int, even though the only possible
return value is '0'.
