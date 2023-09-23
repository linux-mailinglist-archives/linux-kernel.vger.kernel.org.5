Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 516D47ABEAE
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 09:57:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230355AbjIWH5d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Sep 2023 03:57:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230114AbjIWH5a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Sep 2023 03:57:30 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73575197;
        Sat, 23 Sep 2023 00:57:24 -0700 (PDT)
Received: from localhost (unknown [217.144.90.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 8CDA0383;
        Sat, 23 Sep 2023 07:57:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 8CDA0383
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1695455844; bh=mfkLM1mZ6patzZykKGGUczfcmlxw34HJH6wQWGJWhEI=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=ORgfQWMBvcaonPYu9FXssg1eETcs/C+oNsQNKobql3vJImfFeyEdqnjoPAOMydwEX
         uUN7e6ob3s9xvarSqsvfLw48K+gDBY5u5LEGPp9koqipZy6HhAuk9NC61ks9G+lLuX
         Hh6RYjbmVX4n3Wxkh65rhWu3tZmVvQ4l8L7NCCLBEsKG1MeNaI/+cs+hswnZT0TrZV
         ntQMB6QubijYg+v6Sh5hE1VOR/dlO291XoaKR0zLh54iuR25gi6pO+y+NLWMEL+Nit
         hs7lHfZmEGp7mmtbR5PnDI+N3hcqSX5+nUjpv/o4kZjJn8R2RLZu3SqxCSpXXnX7Rc
         5UH9UaFD51BWQ==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Carlos Bilbao <carlos.bilbao@amd.com>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        ardb@kernel.org, kraxel@redhat.com, dovmurik@linux.ibm.com,
        elena.reshetova@intel.com, dave.hansen@linux.intel.com,
        Dhaval.Giani@amd.com, michael.day@amd.com,
        pavankumar.paluri@amd.com, David.Kaplan@amd.com,
        Reshma.Lal@amd.com, Jeremy.Powell@amd.com,
        sathyanarayanan.kuppuswamy@linux.intel.com,
        alexander.shishkin@linux.intel.com, thomas.lendacky@amd.com,
        tglx@linutronix.de, dgilbert@redhat.com, dinechin@redhat.com,
        linux-coco@lists.linux.dev, berrange@redhat.com, mst@redhat.com,
        tytso@mit.edu, jikos@kernel.org, joro@8bytes.org, leon@kernel.org,
        richard.weinberger@gmail.com, lukas@wunner.de, jejb@linux.ibm.com,
        cdupontd@redhat.com, jasowang@redhat.com, sameo@rivosinc.com,
        bp@alien8.de, seanjc@google.com, security@kernel.org,
        Larry Dewey <larry.dewey@amd.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [RESEND PATCH v4] docs: security: Confidential computing intro
 and threat model for x86 virtualization
In-Reply-To: <98804f27-c2e7-74d6-d671-1eda927e19fe@amd.com>
References: <20230905152656.1215119-1-carlos.bilbao@amd.com>
 <2023090537-undesired-junction-b325@gregkh>
 <4a25cfe8-39d7-1d0f-b89b-2d62bdb085c1@amd.com>
 <bb5a6655-ebaa-2ddf-0c49-6f1027ccb839@amd.com>
 <f7700d54-da02-3482-17c5-bbae36799fb5@amd.com>
 <98804f27-c2e7-74d6-d671-1eda927e19fe@amd.com>
Date:   Sat, 23 Sep 2023 01:57:20 -0600
Message-ID: <87v8c15nkv.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Carlos Bilbao <carlos.bilbao@amd.com> writes:

> Kernel developers working on confidential computing for virtualized
> environments in x86 operate under a set of assumptions regarding the Linux
> kernel threat model that differs from the traditional view. Historically,
> the Linux threat model acknowledges attackers residing in userspace, as
> well as a limited set of external attackers that are able to interact with
> the kernel through networking or limited HW-specific exposed interfaces
> (e.g. USB, thunderbolt). The goal of this document is to explain additional
> attack vectors that arise in the virtualized confidential computing space.
>
> Reviewed-by: Larry Dewey <larry.dewey@amd.com>
> Reviewed-by: David Kaplan <david.kaplan@amd.com>
> Co-developed-by: Elena Reshetova <elena.reshetova@intel.com>
> Signed-off-by: Elena Reshetova <elena.reshetova@intel.com>
> Signed-off-by: Carlos Bilbao <carlos.bilbao@amd.com>

This patch was whitespace-corrupted (something wrapped the diff lines)
making it hard to apply; I was able to fix it up and get git to swallow
it.  So applied, thanks.

jon
