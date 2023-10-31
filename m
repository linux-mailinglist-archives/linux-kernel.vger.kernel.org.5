Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B4F57DCCC1
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 13:14:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344130AbjJaMLx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 08:11:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231311AbjJaMLv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 08:11:51 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB7AD91;
        Tue, 31 Oct 2023 05:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
        :MIME-Version:Message-ID:References:In-Reply-To:Subject:CC:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=sZetSc9ylL0PFKinnKdf5Qp86cIZ0XZYbOJg2L3F9dQ=; b=YOoPwm/7a0smkyJZ84ssJSe7M9
        POIIOh6/RB1RMcbQCv55V/lObwCkwnadOv9NVu/bTzzng5IaVkoniS6x79H8jxT9NJmyWv6RKuw90
        p5JhcUzgz5DavQnPHSIKIIXOeIGQM/8jTykdIYHc5+pWJ/KnVMydHBTVsqQNgoFa1wGv2am8tebxt
        KpZg0Vp9yW5wagh4GmaQ+HcatrV/mnT1iCxTg9k2519D/+LsxIsiUqn4riQkJg9SKw4xXdDoMeOOK
        iHiak9vkEUywgIy0sYzZCGf4amfsAWpjwof+xNdiFpeJ3LQ7iUkO/fBo+Oj1s3i5CYSU3jDkp8Y5P
        HKMf6b9w==;
Received: from [46.18.216.58] (helo=[127.0.0.1])
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qxnau-004oSs-1P;
        Tue, 31 Oct 2023 12:11:40 +0000
Date:   Tue, 31 Oct 2023 12:11:39 +0000
From:   David Woodhouse <dwmw2@infradead.org>
To:     paul@xen.org, Paul Durrant <xadimgnik@gmail.com>,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
CC:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] KVM: x86/xen: improve accuracy of Xen timers
User-Agent: K-9 Mail for Android
In-Reply-To: <6c9671b4-d997-42ac-9821-06accb97357f@xen.org>
References: <96da7273adfff2a346de9a4a27ce064f6fe0d0a1.camel@infradead.org> <1a679274-bbff-4549-a1ea-c7ea9f1707cc@xen.org> <F80266DD-D7EF-4A26-B9F8-BC33EC65F444@infradead.org> <6c9671b4-d997-42ac-9821-06accb97357f@xen.org>
Message-ID: <1DCDC3DB-81E8-426C-AF4B-AA7CA2C1271E@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by desiato.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 31 October 2023 12:06:17 GMT, Paul Durrant <xadimgnik@gmail=2Ecom> wrot=
e:
>On 31/10/2023 11:42, David Woodhouse wrote:
>> Secondly, it's also wrong thing to do in the general case=2E Let's say =
KVM does its thing and snaps the kvmclock backwards in time on a KVM_REQ_CL=
OCK_UPDATE=2E=2E=2E do we really want to reinterpret existing timers agains=
t the new kvmclock? They were best left alone, I think=2E
>
>Do we not want to do exactly that? If the master clock is changed, why wo=
uld we not want to re-interpret the guest's idea of time? That update will =
be visible to the guest when it re-reads the PV clock source=2E

Well no, because the guest set that timer *before* we yanked the clock fro=
m under it, and probably wants it interpreted in the time scale which was i=
n force at the time it was set=2E

But more to the point, KVM shouldn't be doing that! We need to *fix* the k=
vmclock brokenness, not design further band-aids around it=2E

As I said, this patch stands even *after* we fix kvmclock, because it hand=
les the timer delta calculation from an single TSC read=2E

But overengineering a timer reset on KVM_REQ_CLOCK_UPDATE would not=2E
