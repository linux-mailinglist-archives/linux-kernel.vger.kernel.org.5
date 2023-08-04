Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B42CC77070A
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 19:27:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232122AbjHDR1N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 13:27:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231779AbjHDR1L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 13:27:11 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6254349C1
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 10:27:10 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5868992ddd4so25995467b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 04 Aug 2023 10:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691170029; x=1691774829;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=0XNCE0THmMSplRGDYFiIYwKZfHJYXKQUWjyM6yzp218=;
        b=ioU7Xhc/g9qgs9gG71lCacbcGZecZKnk09it5Wjzn2tVrX3fgSS2tCjX0UJGYNzPJl
         eXFA165dQDgVzSZPWS4dcgb+pPYBrcGh026AEPvE4uNbDgNrYZqkNSkaPZKHcTUKmwBm
         dxsmh7ephRFh1G8wQbMJXhfximF2cj4DhGKNHDjqaT8r9l6r0sL1PI0zouj9bI3atq/d
         IJ/yKmmEQrpgHKveDl5xLOedKR4ibfnJ5dvcOMP6fyU5qYsTyKBHRxxsn9JabxZo6zog
         RWwC/HqKx9pD1TcDTr3AH+U/YQ8ltr1Mrt0ZsbH+vNJ84ZndKhmF1NaKGmBGEAxeCDzw
         LOUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691170029; x=1691774829;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0XNCE0THmMSplRGDYFiIYwKZfHJYXKQUWjyM6yzp218=;
        b=B8677CH64lI+XPXQ6Bm+huaCCpQLJyMo/88Ddt92Pb8eY535rp2QHiLHdLG5KZCiXS
         CsBFJMo9ohmfNkAorPs2/iDWBw1P5mo5GH2Fh7C1wN9AxJ152Y0Ax36GWNLRugPHcRMy
         MZWSV6CEYzEzbOS13Hhlin3jMJJow7ZYQqNpJ6lKgEHc6TmmTUP+JBT0M1UWCoDvFkQq
         tr//DIpsrLMPTO/EvpLbVE69sFL3YTR1szrk5YtLcahm+GFAORhV/ytvm/0CD/X9b01H
         Qe939n7favHaDdmbhYabojiiqsARO/hGrHiE0nzhxK6TDZuyeGvz5AhS14APTvBn80Hn
         3j0g==
X-Gm-Message-State: AOJu0Yw6BFUMN0rmxwDDcEd+/Epno0WfC9VG4ZidAbxniaiNk8Dn91pE
        27FNCS5EgHVeDZQgeiYs22oYWr8Qxbo=
X-Google-Smtp-Source: AGHT+IHY1jyESYvdqjtEUOWN5kpmBlG2/bzs9/bKSXZUMXovofE5m64qKwapLGFKQLq4x4vgTmvsT5rlOJ0=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a81:ef12:0:b0:583:491b:53d3 with SMTP id
 o18-20020a81ef12000000b00583491b53d3mr15983ywm.9.1691170029578; Fri, 04 Aug
 2023 10:27:09 -0700 (PDT)
Date:   Fri, 4 Aug 2023 10:27:07 -0700
In-Reply-To: <ZM0rXgKvb912k5BE@linux.dev>
Mime-Version: 1.0
References: <20230804004226.1984505-1-seanjc@google.com> <20230804004226.1984505-3-seanjc@google.com>
 <ZM0rXgKvb912k5BE@linux.dev>
Message-ID: <ZM006zd4bpsGBtWF@google.com>
Subject: Re: [PATCH 2/4] KVM: selftests: Add helper macros for ioctl()s that
 return file descriptors
From:   Sean Christopherson <seanjc@google.com>
To:     Oliver Upton <oliver.upton@linux.dev>
Cc:     Marc Zyngier <maz@kernel.org>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        linux-kernel@vger.kernel.org, Michal Luczaj <mhal@rbox.co>
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

On Fri, Aug 04, 2023, Oliver Upton wrote:
> Hi Sean,
> 
> On Thu, Aug 03, 2023 at 05:42:24PM -0700, Sean Christopherson wrote:
> > Add KVM, VM, and vCPU scoped helpers for ioctl()s that return file
> > descriptors, i.e. deduplicate code for asserting success on ioctls() for
> > which a positive return value, not just zero, is considered success.
> > 
> > Signed-off-by: Sean Christopherson <seanjc@google.com>
> 
> I appreciate the desire to eliminate duplicate code, but I think the
> naming just muddies the waters. TBH, when I first read the diff w/o the
> changelog, I thought you were describing the input fd (i.e. 'kvm_fd',
> 'vm_fd', 'vcpu_fd'). I don't think explicitly spelling out the condition
> each time (i.e. ret >= 0) is all that difficult.

Yeah, but it's not just a desire to dedup code, I also am trying to funnel as
many "ioctl() succeeded" asserts as possible into common code so that they naturally
benefit from things like patch 4 (detecting dead/bugged VMs).

I agree the naming sucks.
