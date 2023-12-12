Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C82BB80F17C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 16:52:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232862AbjLLPwt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 10:52:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376764AbjLLPZg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 10:25:36 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D408A12E
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 07:25:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1702394735;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wIpQw8k3Ji1hQ+Q/rMJi3mOp+fmPt/8e4XsCNKHyBDU=;
        b=e4rVfJBW6SUYlK502zdXA7lDa5hPdvD86lvhUU2+qOD12w36ynGUYJ2JNiUBiaMGwsb0hQ
        /pk1234NHu6Edl+qsHsfVCj3Er6riLXTQV+XicUIhjnxjMkaJXbD4noGHbeuqK9wScY/YE
        kFflxEEYcwaq/E5VWpQv8N+hxxszijY=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-660-vD9Rb0xDPHC_Lh-FelK6wg-1; Tue, 12 Dec 2023 10:25:33 -0500
X-MC-Unique: vD9Rb0xDPHC_Lh-FelK6wg-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a1f9ab28654so100897666b.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 07:25:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702394732; x=1702999532;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wIpQw8k3Ji1hQ+Q/rMJi3mOp+fmPt/8e4XsCNKHyBDU=;
        b=fsk/Z1aDD8LymWnDBjn1vXHyUDS3HlmKQYhHn1WpY2p0z0pwrc1W9TuQm10WqKnzFR
         pb6kqOIMhIRRxh5nc62Vef+2tXFG7IJ3fBTUBDgwBJbnU/wDt7BmxY18MPtGtIqeP8vy
         YSkQWaj/8Bkv6i/kX0eGvkA+nUJwsbO6K60bWjuAPGIpUIBq3cKpnuvm7N3ACTjJRVnw
         7GU2PWafS9cCSa+XDEIsoiYTOg9xoOcSeCPE6RyNgaZ2AGQwBYPO4IO2IhQG1RVA+rJm
         3gl/pGRukhLFlkaMMKckELCIpmN+iVenPwzeyZg434jku1W1+ArSSCmq+o3U2zb1kriJ
         thCg==
X-Gm-Message-State: AOJu0Yx7BhkJLkLSyCZXFn/qLSfkSfaDxPsIs1lyDiPbaUJKBjRgfL6y
        ZkfHDth5WH5yk6omU7LOtiQ42+ibxH00wcUYtAu7IH3jelhZQEVdFoYf6Osyc5cVL3RoOuJBbkT
        CgyHpJB1kUdJ8QvNKCUIdnusl
X-Received: by 2002:a17:906:10c7:b0:a1c:e980:3c3 with SMTP id v7-20020a17090610c700b00a1ce98003c3mr2652508ejv.28.1702394732290;
        Tue, 12 Dec 2023 07:25:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGASJRN+3155/H3UvqxOv26N1RhSjlb8LnjPrXAVZ+i+Dsz6c4kdn853kkeIlOvLJ4UnqcHDA==
X-Received: by 2002:a17:906:10c7:b0:a1c:e980:3c3 with SMTP id v7-20020a17090610c700b00a1ce98003c3mr2652496ejv.28.1702394731966;
        Tue, 12 Dec 2023 07:25:31 -0800 (PST)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id vh9-20020a170907d38900b00a1d18c142eesm6445227ejc.59.2023.12.12.07.25.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 07:25:31 -0800 (PST)
Date:   Tue, 12 Dec 2023 16:25:29 +0100
From:   Igor Mammedov <imammedo@redhat.com>
To:     Fiona Ebner <f.ebner@proxmox.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        bhelgaas@google.com, lenb@kernel.org, rafael@kernel.org,
        Thomas Lamprecht <t.lamprecht@proxmox.com>, mst@redhat.com
Subject: Re: SCSI hotplug issues with UEFI VM with guest kernel >= 6.5
Message-ID: <20231212162529.09c27fdf@imammedo.users.ipa.redhat.com>
In-Reply-To: <62363899-d7aa-4f1c-abfa-1f87f0b6b43f@proxmox.com>
References: <9eb669c0-d8f2-431d-a700-6da13053ae54@proxmox.com>
        <20231207232815.GA771837@bhelgaas>
        <20231208164723.12828a96@imammedo.users.ipa.redhat.com>
        <20231211084604.25e209af@imammedo.users.ipa.redhat.com>
        <c6233df5-01d8-498f-8235-ce4b102a2e91@proxmox.com>
        <20231212122608.1b4f75ce@imammedo.users.ipa.redhat.com>
        <62363899-d7aa-4f1c-abfa-1f87f0b6b43f@proxmox.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Dec 2023 13:50:20 +0100
Fiona Ebner <f.ebner@proxmox.com> wrote:

> Am 12.12.23 um 12:26 schrieb Igor Mammedov:
> > 
> > it's not necessary, but it would help to find out what's going wrong faster.
> > Otherwise we would need to fallback to debugging over email.
> > Are you willing to help with testing/providing debug logs to track down
> > the cause?.
> >   
> 
> I submitted the dmesg logs in bugzilla:
> https://bugzilla.kernel.org/show_bug.cgi?id=218255
> 
> > Though debug over email would be slow, so our best option is to revert
> > offending patches until the cause if found/fixed.
> >   
> >>>>> Do you have to revert both cc22522fd55e2 and 40613da52b13f to make it
> >>>>> work reliably?  If we have to revert something, reverting one would be
> >>>>> better than reverting both.      
> >>>>    
> >>
> >> Just reverting cc22522fd55e2 is not enough (and cc22522fd55e2 fixes
> >> 40613da52b13f so I can't revert just 40613da52b13f).  
> > 
> > With UEFI setup, it still works for me fine with current master.
> > 
> > Kernel 6.7.0-rc5-00014-g26aff849438c on an x86_64 (ttyS0)
> >   
> 
> I also built from current master (still 26aff849438c) to verify and it's
> still broken for me.
> 
> > 
> > it still doesn't work with Fedora's 6.7.0-0.rc2.20231125git0f5cc96c367f.26.fc40.x86_64 kernel.
> > However it's necessary to have -smp 4 for it to break,
> > with -smp 1 it works fine as well.
> >   
> 
> For me it's (always with build from current master):
> 
> -smp 1 -> it worked 5 times out of 5
> -smp 2 -> it worked 3 times out of 5
> -smp 4 -> it worked 0 times out of 5
> -smp 8 -> it worked 0 times out of 5


I managed to reproduce it with upstream using fedora 40 config as is
(without converting it to mod2yesconfig).
So give me a couple of days to debug it before reverting.

> 
> Best Regards,
> Fiona
> 

