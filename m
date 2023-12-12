Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99B9B80F760
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 21:03:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231175AbjLLUDA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 15:03:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjLLUC7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 15:02:59 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 668BD8E
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 12:03:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1702411382;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nLTa2dYRrf09pJMNBsngii2VsJyLNKDZosllwS5YIfQ=;
        b=LzvS8TuLRxUNpoX79j0z4hqn2bRJUhI/a1kyJkaOR8ADRvxOoV6iygk0Kc9hd6y5kPTQP+
        +oYM3GJe8vx1L+6HJa7Epu46Me3RYtAadGSHHnsFaxls1z4ulswCLywd77AgwFaYxkxeRh
        RSiENNEsinwZUswhwk+T/UEqxMQdEBo=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-146-NHRPSU4JOI2iwRat8myV4w-1; Tue, 12 Dec 2023 15:03:01 -0500
X-MC-Unique: NHRPSU4JOI2iwRat8myV4w-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-9fd0a58549bso683497466b.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 12:03:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702411380; x=1703016180;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nLTa2dYRrf09pJMNBsngii2VsJyLNKDZosllwS5YIfQ=;
        b=a5KVm+nWZoiZpylhOf81audcjGXH0IvokkJBaL50hiXMi9iE1eskfTEN2sRpn3KJeP
         fHhjYDVaO/dq9xf401vR9iSBpN1r+/wWlUjEugqDBTsqDW6CDjgF9EWBBBrKYLieMGfC
         HXUZAWmmrCGzSXUcsgpYHygKOzMN7eyn51mtRg+lycLjXKbkG6Eh5VTXIWEAmXWrLKVe
         MLbYKyz0xUMdji4NPtg/51B3RgFZf4I4jZFp5JiMvpbtyDZ+OyBTeaqHJ2fqoGisVMRW
         aoQwZXofIM9kERWCK9T218vM8QDJtpCBDmN3T272k87YiIaCV+ShQUH69OT6eLfg8Scw
         2xJw==
X-Gm-Message-State: AOJu0YxIg2PyjaJXHg5YbvsHyWsUtwbGw/CYuJ5G3FWPFKDXy0gVqM08
        FxE6FoyMQXLgbcpnEnxWXTeWxxOopEUJcvp8chOyR6tnm5VIBQtOk3baQubIJdwJVCPsGtu/Qla
        Brwa1xovh0kb6wd1yaraCEMKC
X-Received: by 2002:a17:906:9588:b0:a1c:c2f9:980d with SMTP id r8-20020a170906958800b00a1cc2f9980dmr6331017ejx.27.1702411379998;
        Tue, 12 Dec 2023 12:02:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHRYpIZTRZBTE4WcrlyktfS653hxvSiRGlBv7+Y1axU2HeESlSi0L3nguCi3mJ4p5t6evrUkA==
X-Received: by 2002:a17:906:9588:b0:a1c:c2f9:980d with SMTP id r8-20020a170906958800b00a1cc2f9980dmr6331007ejx.27.1702411379730;
        Tue, 12 Dec 2023 12:02:59 -0800 (PST)
Received: from imammedo.users.ipa.redhat.com ([185.140.112.229])
        by smtp.gmail.com with ESMTPSA id tl18-20020a170907c31200b00a1da2c9b06asm6698148ejc.42.2023.12.12.12.02.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 12:02:58 -0800 (PST)
Date:   Tue, 12 Dec 2023 21:02:57 +0100
From:   Igor Mammedov <imammedo@redhat.com>
To:     Fiona Ebner <f.ebner@proxmox.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        bhelgaas@google.com, lenb@kernel.org, rafael@kernel.org,
        Thomas Lamprecht <t.lamprecht@proxmox.com>, mst@redhat.com,
        Dongli Zhang <dongli.zhang@oracle.com>
Subject: Re: SCSI hotplug issues with UEFI VM with guest kernel >= 6.5
Message-ID: <20231212210257.5ddbff0d@imammedo.users.ipa.redhat.com>
In-Reply-To: <20231212162529.09c27fdf@imammedo.users.ipa.redhat.com>
References: <9eb669c0-d8f2-431d-a700-6da13053ae54@proxmox.com>
        <20231207232815.GA771837@bhelgaas>
        <20231208164723.12828a96@imammedo.users.ipa.redhat.com>
        <20231211084604.25e209af@imammedo.users.ipa.redhat.com>
        <c6233df5-01d8-498f-8235-ce4b102a2e91@proxmox.com>
        <20231212122608.1b4f75ce@imammedo.users.ipa.redhat.com>
        <62363899-d7aa-4f1c-abfa-1f87f0b6b43f@proxmox.com>
        <20231212162529.09c27fdf@imammedo.users.ipa.redhat.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Dec 2023 16:25:29 +0100
Igor Mammedov <imammedo@redhat.com> wrote:

> On Tue, 12 Dec 2023 13:50:20 +0100
> Fiona Ebner <f.ebner@proxmox.com> wrote:
> 
> > Am 12.12.23 um 12:26 schrieb Igor Mammedov:  
> > > 
> > > it's not necessary, but it would help to find out what's going wrong faster.
> > > Otherwise we would need to fallback to debugging over email.
> > > Are you willing to help with testing/providing debug logs to track down
> > > the cause?.
> > >     
> > 
> > I submitted the dmesg logs in bugzilla:
> > https://bugzilla.kernel.org/show_bug.cgi?id=218255
> >   
> > > Though debug over email would be slow, so our best option is to revert
> > > offending patches until the cause if found/fixed.
> > >     
> > >>>>> Do you have to revert both cc22522fd55e2 and 40613da52b13f to make it
> > >>>>> work reliably?  If we have to revert something, reverting one would be
> > >>>>> better than reverting both.        
> > >>>>      
> > >>
> > >> Just reverting cc22522fd55e2 is not enough (and cc22522fd55e2 fixes
> > >> 40613da52b13f so I can't revert just 40613da52b13f).    
> > > 
> > > With UEFI setup, it still works for me fine with current master.
> > > 
> > > Kernel 6.7.0-rc5-00014-g26aff849438c on an x86_64 (ttyS0)
> > >     
> > 
> > I also built from current master (still 26aff849438c) to verify and it's
> > still broken for me.
> >   
> > > 
> > > it still doesn't work with Fedora's 6.7.0-0.rc2.20231125git0f5cc96c367f.26.fc40.x86_64 kernel.
> > > However it's necessary to have -smp 4 for it to break,
> > > with -smp 1 it works fine as well.
> > >     
> > 
> > For me it's (always with build from current master):
> > 
> > -smp 1 -> it worked 5 times out of 5
> > -smp 2 -> it worked 3 times out of 5
> > -smp 4 -> it worked 0 times out of 5
> > -smp 8 -> it worked 0 times out of 5  
> 
> 
> I managed to reproduce it with upstream using fedora 40 config as is
> (without converting it to mod2yesconfig).
> So give me a couple of days to debug it before reverting.

Actually here is another report + analysis explaining where the race is happening:
https://www.spinics.net/lists/kernel/msg5033061.html

That's the reason why my minimal config worked
(based on defconfig where CONFIG_SCSI_SCAN_ASYNC in not enabled by default for x86)

While distros (at least some) do enable it.

> 
> > 
> > Best Regards,
> > Fiona
> >   
> 

