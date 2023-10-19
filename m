Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 917407CFB20
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 15:33:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345977AbjJSNdY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 09:33:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345971AbjJSNdX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 09:33:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39CBB106
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 06:32:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697722357;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fpNttNMYuxYrg++tZJU7aHSjMPEAnzSMQI0OyzamccU=;
        b=MVysohYauDGYOKeKweDgX0MSVSvOuxv2VlspHPthcscXCk/Kfqk4POb9wKMl1ECHtHjyrY
        IKc5goVvOmodcQx791eLTUO6koyrCzrDRbuD3ukb+e0N2uWp4jEP/AESJhwXsatzr40isU
        fO0ak7DJcRCVdFfa2YQTvN8MngiWUF4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-99-_-sCw5hWM6mi0f-GtJVnBw-1; Thu, 19 Oct 2023 09:32:35 -0400
X-MC-Unique: _-sCw5hWM6mi0f-GtJVnBw-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-32d9cd6eb0bso3473338f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 06:32:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697722354; x=1698327154;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fpNttNMYuxYrg++tZJU7aHSjMPEAnzSMQI0OyzamccU=;
        b=wUtEOnXLz0HUh6QE0rTi81/VBXwOsvjnNdITQTavYxCdHkxuCZ5bWvljCzfXn6NhYW
         kvzaIVYpP1EccrW5iY59klvsStXEHUwxYSzzi0yAu3gR1rbqaZ9MVv2RHFgFQcm/Mezr
         C/NJ/zUgLoSKO0smBTPEmNBGgmNikfDdL/Q+hzQJcbzVkGvjnjFrpNSf8fxGC3To9ytD
         fJwYrFZnL1+QO/XSD4AfRNMrh+VQU7cEpQk/aag94pVFD+Khn4K67xEM8VIiFtQSjMRQ
         w1eDZcr5OUQMOStA21vueySafewzyzvP0LK/d1Mg4r7aBmyKntdO7mm4pMVU1bVk48Db
         eBig==
X-Gm-Message-State: AOJu0YzVZh1FM7mz6eeq7Bn1e6HYl4ZGX7xodQaGaCEFukWLPIm1x6w8
        283j6Zn7rUW4oYvPZy372TgstAidWhPNMjy1ilPaRL4R4w3QAQSMybfE4HpUN6CI+OitMPL+GmX
        qdCqjvVSRfwYGRgpa20eGez72
X-Received: by 2002:a5d:424e:0:b0:32d:a977:50b0 with SMTP id s14-20020a5d424e000000b0032da97750b0mr1532510wrr.41.1697722354446;
        Thu, 19 Oct 2023 06:32:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFslkzbUAqoUOogMxd09VoVqSQdX15OcXnRTo8QWDZTS0esTZfwchO0AaQAH0PHqc9G3zTUGA==
X-Received: by 2002:a5d:424e:0:b0:32d:a977:50b0 with SMTP id s14-20020a5d424e000000b0032da97750b0mr1532481wrr.41.1697722354061;
        Thu, 19 Oct 2023 06:32:34 -0700 (PDT)
Received: from starship ([89.237.100.246])
        by smtp.gmail.com with ESMTPSA id d3-20020adfef83000000b0032dc2110d01sm4500447wro.61.2023.10.19.06.32.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Oct 2023 06:32:33 -0700 (PDT)
Message-ID: <f5e41b0e277924c757c22c8ed6db19c6dddfe9f0.camel@redhat.com>
Subject: Re: [PATCH] iommu/amd: Do not flush IRTE when only updating isRun
 and destination fields
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     "Suthikulpanit, Suravee" <suravee.suthikulpanit@amd.com>,
        linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Cc:     joro@8bytes.org, seanjc@google.com, vasant.hegde@amd.com,
        jon.grimm@amd.com, santosh.shukla@amd.com,
        joao.m.martins@oracle.com, alejandro.j.jimenez@oracle.com,
        boris.ostrovsky@oracle.com
Date:   Thu, 19 Oct 2023 16:32:31 +0300
In-Reply-To: <d0731c73-b2bb-972f-a728-f63273c4d5ab@amd.com>
References: <20231017144236.8287-1-suravee.suthikulpanit@amd.com>
         <97d106d28e4c3468912a478dba79ab2221109cbd.camel@redhat.com>
         <44477b0b-af38-569e-95d9-e78c118c9d18@amd.com>
         <d0731c73-b2bb-972f-a728-f63273c4d5ab@amd.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2023-10-19 at 16:11 +0700, Suthikulpanit, Suravee wrote:
> Maxim,
> 
> On 10/17/2023 10:36 PM, Suthikulpanit, Suravee wrote:
> > On 10/17/2023 9:51 PM, Maxim Levitsky wrote:
> > > У вт, 2023-10-17 у 09:42 -0500, Suravee Suthikulpanit пише:
> > > > According to the recent update in the AMD IOMMU spec [1], the IsRun and
> > > > Destination fields of the Interrupt Remapping Table Entry (IRTE) are not
> > > > cached by the IOMMU hardware.
> > > Is that true for all AMD hardware that supports AVIC? E.g Zen1/Zen2 
> > > hardware?
> > 
> > This is true for all AVIC/x2AVIC-capable IOMMU hardware in the past.
> > 
> > > Is there a chance that this will cause a similar errata to the is_running
> > > errata that Zen2 cpus have?
> > 
> > Please let me check on this and get back.
> 
> Just to be sure, could you please tell me which errata number are you 
> referring to here?

Hi!

The errata is this one:

https://www.amd.com/content/dam/amd/en/documents/processor-tech-docs/revision-guides/56323-PUB_1_01.pdf
(ERRATA #1235)

The errata meaning is that once the CPU sets is_running=0 in AVIC's physical ID table, 
the hardware might still not cause #incomplete_ipi vmexit, for a few times.

This means that KVM is not notified of the pending interrupt and it lets the target vCPU block instead of being woken up.


In regard to the IOMMU, the parallel errata like situation would be that CPU sets is_running=0 in the IOMMU tables, 
exactly afterwards an interrupt arrives and the IOMMU doesn't log the interrupt in the GA log.

Note that regardless if the IOMMU works correctly or not, the KVM has to check IRR after it sets is_running=0 to avoid memory
reordering races, but it does so and uses a memory barrier to ensure correctness. 


PS: Recently I realized that a very simple workaround exists for errata #1235: At expense of the performance, the KVM can
permanently set is_running=0 in the AVIC's physical id table.

This will ensure that all ICR writes except self IPIs will cause a VM exit, thus in the expense of performance will
ensure that AVIC works correctly.

And this configuration while slower than full AVIC, it's still much better than having no AVIC, 
because AVIC still accelerates the receiver side of IPIs, and also IOMMU can still post interrupts.
In fact with the workaround applied, AVIC is exactly equivalent to Intel's APICv without IPI virtualization.


This is the latest version of my patch series:

[PATCH v3 0/4] Allow AVIC's IPI virtualization to be optional
https://www.spinics.net/lists/kvm/msg328416.html

A help with a review will be highly appreciated.

In addition to that I would highly appreciate if AMD could respond to these questions:

1. Is the errata #1235 really not present on Zen1 CPUs? It doesn't appear in the revision guide,
but I still suspect that the guide might just not be up to date. I haven't tested a Zen1 machine
to see if I can reproduce it yet.

2. As I see AMD disabled AVIC on Zen3 machines, but it does appear to work just fine in my testing.
Is it possible that the reason for the disabling is also related to ICR/IPI emulation and that if I apply
the same workaround as for errata #1235, then AVIC could be safely enabled on Zen3,
despite support for it not being present in CPUID?

If I know the answer to these questions, it might be possible to enable AVIC on all current AMD hardware by default.

AFAIK (my personal opinion, based on various downstream bugs opened and their urgency) that our customers do care about APICv,
but somehow assume as a fact that AMD doesn't have such feature while in fact AMD does.

So I think that if AVIC were to be enabled by default on AMD, that would be something that AMD's (and ours) 
customers would appreciate very much.

Best regards,
	Maxim Levitsky

> 
> Thanks,
> Suravee
> 


