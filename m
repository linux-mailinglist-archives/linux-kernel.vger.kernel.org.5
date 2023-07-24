Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F54F75EF1A
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 11:28:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231874AbjGXJ2Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 05:28:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231611AbjGXJ2N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 05:28:13 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BACDBF3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 02:27:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690190843;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1aqMAns950u+zeLChDvq/fTf6JcAIcxdD0X+X9fGaDg=;
        b=MebdwS33yJFthqXn0wZ7S4Wg57nNuzLJxVkePaEZVM3DN5Xi2FOjSAGNHee3fvDD569Xkh
        yxKD16mCJ7RYiqU40BVsdiK8IVzAjRVe/fN27WWIYXpF1MMU7QOJLalm1aHSWUF5VYEbw2
        56aMgj0/egHvpRHM46GGWByCEdIrD9Y=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-96-ereW8Y-3NVewcRgiVrh0BA-1; Mon, 24 Jul 2023 05:27:22 -0400
X-MC-Unique: ereW8Y-3NVewcRgiVrh0BA-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-993d631393fso360128966b.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 02:27:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690190841; x=1690795641;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1aqMAns950u+zeLChDvq/fTf6JcAIcxdD0X+X9fGaDg=;
        b=Z/5ty+iB5R0Fjs471gvghIBxxJ5O4NZC47u3H5FPyhtD6DpX57yO+/ppkwbttaZAAz
         2tt0iuPFlRZZQePX9vqih1MlSMbSmE8B1cBCYOfWNdoeSLWnq1tNtgSoqtpmlYODXPeT
         hl2jOc1MsuDOa7hj6JszlidEZHcgaS5W35IJOkDzzUJaqHgAjml6mFYMgEzICdBMy8N6
         44FUhkTb0GGcxW2GJ4PWvboVD0rGuEtemQQm14Zdy8JoU9mIpTlkhmj/6PpwbAveUNTd
         6LgiCU1MMoFa/faNRCVBp90jwLQ+TAqV+2Z7yL1scADRprhGwUDJsNQTp+EMadnXUlou
         /icQ==
X-Gm-Message-State: ABy/qLaN+2OZpKDuj0EKN8bQ+uP8HUoVrtnX2eERhGvCbh7SUypzO6iu
        NZUjIkz57SxVMBqYgYGcWRKXaHSYt4U2eqsim8AxOfpJaNRO0K2Td6dEeExF8la3s36yzExbkHq
        meO+dKy32T9JullV8vwr6dCuM
X-Received: by 2002:a17:906:20d5:b0:982:b920:daad with SMTP id c21-20020a17090620d500b00982b920daadmr9023035ejc.71.1690190841289;
        Mon, 24 Jul 2023 02:27:21 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGkOHHyH0ujc9pe4rnlwS2N6pWHUtZ+xEuD7FMvL62WIORJ/7vrnSFDWQ7InVEBhf+I+FviZQ==
X-Received: by 2002:a17:906:20d5:b0:982:b920:daad with SMTP id c21-20020a17090620d500b00982b920daadmr9023019ejc.71.1690190840938;
        Mon, 24 Jul 2023 02:27:20 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id r7-20020a170906c28700b0099b42c90830sm6406269ejz.36.2023.07.24.02.27.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jul 2023 02:27:20 -0700 (PDT)
Date:   Mon, 24 Jul 2023 11:27:19 +0200
From:   Igor Mammedov <imammedo@redhat.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Woody Suwalski <terraluna977@gmail.com>, bhelgaas@google.com,
        LKML <linux-kernel@vger.kernel.org>, linux-pci@vger.kernel.org,
        regressions@lists.linux.dev
Subject: Re: Kernel 6.5-rc2: system crash on suspend bisected
Message-ID: <20230724112719.3fd90eb1@imammedo.users.ipa.redhat.com>
In-Reply-To: <20230720202110.GA544761@bhelgaas>
References: <11fc981c-af49-ce64-6b43-3e282728bd1a@gmail.com>
        <20230720202110.GA544761@bhelgaas>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Jul 2023 15:21:10 -0500
Bjorn Helgaas <helgaas@kernel.org> wrote:

> [+cc regressions list]
> 
> On Wed, Jul 19, 2023 at 11:36:51PM -0400, Woody Suwalski wrote:
> > Laptop shows a kernel crash trace after a first suspend to ram, on a second
> > attempt to suspend it becomes frozen solid. This is 100% repeatable with a
> > 6.5-rc2 kernel, not happening with a 6.4 kernel - see the attached dmesg
> > output.
> > 
> > I have bisected the kernel uilds and it points to :
> > [40613da52b13fb21c5566f10b287e0ca8c12c4e9] PCI: acpiphp: Reassign resources
> > on bridge if necessary
> > 
> > Reversing this patch seems to fix the kernel crash problem on my laptop.  
> 
> Thank you very much for all your work debugging, bisecting, and
> reporting this!  This is incredibly helpful.
> 
> Original report, including complete dmesg logs for both v6.4 and
> v6.5-rc2:
> https://lore.kernel.org/r/11fc981c-af49-ce64-6b43-3e282728bd1a@gmail.com
> 
> I queued up a revert of 40613da52b13 ("PCI: acpiphp: Reassign
> resources on bridge if necessary") (on my for-linus branch for v6.5).
> 
> It looks like a NULL pointer dereference; hopefully the fix is obvious
> and I can drop the revert and replace it with the fix.

it happens here:

2145	void pci_assign_unassigned_bridge_resources(struct pci_dev *bridge)
2146	{
2147		struct pci_bus *parent = bridge->subordinate;

Let's see if it reproducable on Lenovo laptop and what reading
involved code yields.
If I can't figure it out anyways, I'll come up with a patch
to trace issue. 

> 
> Bjorn
> 

