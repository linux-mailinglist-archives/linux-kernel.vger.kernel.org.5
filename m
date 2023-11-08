Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A31357E5816
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 14:45:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232187AbjKHNpR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 08:45:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230467AbjKHNpQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 08:45:16 -0500
Received: from smtp-fw-80006.amazon.com (smtp-fw-80006.amazon.com [99.78.197.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCA5D1FC1;
        Wed,  8 Nov 2023 05:45:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1699451114; x=1730987114;
  h=mime-version:content-transfer-encoding:date:message-id:
   from:to:cc:subject:references:in-reply-to;
  bh=7oMcXvDRRH2hCXgdSGg2nocFc8nVKulZe07SW3+JZuY=;
  b=nbngAOkvDFnx+3tz2BFHOJ50EANDEeFf2DhpXBU5/jTyarGnzlWtAe8h
   DnKh8u9L7bLWC0NizFNp5hmLrTQAsNKGcRWq65zTAqY9o8zGS8uI/lTf/
   9PvicqNPeGjSLx86LFcwHVk41w8Yib2qVed8z6wuHW3M0KT2ST+chSeto
   g=;
X-IronPort-AV: E=Sophos;i="6.03,286,1694736000"; 
   d="scan'208";a="250910628"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-pdx-2c-m6i4x-fad5e78e.us-west-2.amazon.com) ([10.25.36.214])
  by smtp-border-fw-80006.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2023 13:44:54 +0000
Received: from smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev (pdx2-ws-svc-p26-lb5-vlan3.pdx.amazon.com [10.39.38.70])
        by email-inbound-relay-pdx-2c-m6i4x-fad5e78e.us-west-2.amazon.com (Postfix) with ESMTPS id 6FB02A0C4A;
        Wed,  8 Nov 2023 13:44:52 +0000 (UTC)
Received: from EX19MTAEUB001.ant.amazon.com [10.0.17.79:29498]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.12.6:2525] with esmtp (Farcaster)
 id f76ffc02-2573-451f-b3a0-5e9c3913a883; Wed, 8 Nov 2023 13:44:52 +0000 (UTC)
X-Farcaster-Flow-ID: f76ffc02-2573-451f-b3a0-5e9c3913a883
Received: from EX19D004EUC001.ant.amazon.com (10.252.51.190) by
 EX19MTAEUB001.ant.amazon.com (10.252.51.26) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Wed, 8 Nov 2023 13:44:51 +0000
Received: from localhost (10.13.235.138) by EX19D004EUC001.ant.amazon.com
 (10.252.51.190) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Wed, 8 Nov
 2023 13:44:47 +0000
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date:   Wed, 8 Nov 2023 13:44:43 +0000
Message-ID: <CWTH4PZBQV0P.IEML0UZUVPZY@amazon.com>
From:   Nicolas Saenz Julienne <nsaenz@amazon.com>
To:     Alexander Graf <graf@amazon.com>, <kvm@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-hyperv@vger.kernel.org>,
        <pbonzini@redhat.com>, <seanjc@google.com>, <vkuznets@redhat.com>,
        <anelkz@amazon.com>, <dwmw@amazon.co.uk>, <jgowans@amazon.com>,
        <corbert@lwn.net>, <kys@microsoft.com>, <haiyangz@microsoft.com>,
        <decui@microsoft.com>, <x86@kernel.org>,
        <linux-doc@vger.kernel.org>
Subject: Re: [RFC 32/33] KVM: x86: hyper-v: Implement
 HVCALL_TRANSLATE_VIRTUAL_ADDRESS
X-Mailer: aerc 0.15.2-182-g389d89a9362e-dirty
References: <20231108111806.92604-1-nsaenz@amazon.com>
 <20231108111806.92604-33-nsaenz@amazon.com>
 <5ac466d6-ea71-472d-a09b-5bd54e88a398@amazon.com>
In-Reply-To: <5ac466d6-ea71-472d-a09b-5bd54e88a398@amazon.com>
X-Originating-IP: [10.13.235.138]
X-ClientProxiedBy: EX19D037UWB003.ant.amazon.com (10.13.138.115) To
 EX19D004EUC001.ant.amazon.com (10.252.51.190)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed Nov 8, 2023 at 12:49 PM UTC, Alexander Graf wrote:
>
> On 08.11.23 12:18, Nicolas Saenz Julienne wrote:
> > Introduce HVCALL_TRANSLATE_VIRTUAL_ADDRESS, the hypercall receives a
> > GVA, generally from a less privileged VTL, and returns the GPA backing
> > it. The GVA -> GPA conversion is done by walking the target VTL's vCPU
> > MMU.
> >
> > NOTE: The hypercall implementation is incomplete and only shared for
> > completion. Additionally we'd like to move the VTL aware parts to
> > user-space.
>
>
> Yes, please :). We should handle the complete hypercall in user space if=
=20
> possible. If you're afraid that gva -> gpa conversion may run out of=20
> sync between a user space and the kvm implementations, let's introduce=20
> an ioctl that allows you to perform that conversion.

I'll look into introducing a generic API that performs MMU walks. The
devil is in the details though, the hypercall introduces flags like:

=E2=80=A2 HV_TRANSLATE_GVA_TLB_FLUSH_INHIBIT: Indicates that the TlbFlushIn=
hibit
  flag in the virtual processor=E2=80=99s HvRegisterInterceptSuspend regist=
er
  should be set as a consequence of a successful return. This prevents
  other virtual processors associated with the target partition from
  flushing the stage 1 TLB of the specified virtual processor until
  after the TlbFlushInhibit flag is cleared.

Which make things trickier.

Nicolas
