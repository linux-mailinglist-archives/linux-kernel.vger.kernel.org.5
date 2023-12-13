Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5C2B811C0A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 19:13:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233600AbjLMSM5 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 13 Dec 2023 13:12:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjLMSM4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 13:12:56 -0500
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CA68A7;
        Wed, 13 Dec 2023 10:13:03 -0800 (PST)
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3b9fb227545so539587b6e.1;
        Wed, 13 Dec 2023 10:13:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702491182; x=1703095982;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EAFgk7CWRJrMFot150DQ4PnEWKGrc2Ne+IMSBPCUoM0=;
        b=fPKAi4bH1eeWjY9Jtq/TejUJkbtvlw9yXtG1SoYzKyRoXAqHBVa3N3Uc1z008hgM7P
         ZXJ6upMnB1v6LLEtDSuGIs1LHyarXEsp8XnO4fD7GHeYvscRMoP2xd30yyVcDuJNPJUa
         86JixgZGXq2TbnAcaYgzotAw1KQtLTIANmt72n3JGW18gnNqnIP0+9M7HV5FCaBYSA6d
         cncUzkj+Y1JzCtzdcxcwWQEIqAjnxn9iQWvy0mkdAjhxikOZTLAsdYg7t2kUS+5nCqSN
         3oXMmgcxPp5B0II+xJvgOBDjcKVuTlAOKnzO/BT9c7DrsvQBFslo670NGY9VKptEfieT
         VZbA==
X-Gm-Message-State: AOJu0YxuWE46LGCTrn5bPLZ04+T2DmMiPWi0aeXslpo+4dIE20b5jhK/
        SK0pbKYnBh1eEFaOBdKJGuIcnX1+dtIBkvYyi1U=
X-Google-Smtp-Source: AGHT+IExppPx+yyr9qknc/1feMCzqvgSu5iaEIadzFU33+3p4z35fi9TqMlPR5wX/xWoOQNf1lRT19tzmlzCSkThRNg=
X-Received: by 2002:a05:6870:9a8a:b0:203:36fc:6c8a with SMTP id
 hp10-20020a0568709a8a00b0020336fc6c8amr1211189oab.4.1702491182465; Wed, 13
 Dec 2023 10:13:02 -0800 (PST)
MIME-Version: 1.0
References: <20231213003614.1648343-1-imammedo@redhat.com> <20231213181115.GA1050010@bhelgaas>
In-Reply-To: <20231213181115.GA1050010@bhelgaas>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 13 Dec 2023 19:12:51 +0100
Message-ID: <CAJZ5v0iCwpqRXGFvQ8xtEoK=RaJdb-gnwkWezR7WSX7R_oyFYw@mail.gmail.com>
Subject: Re: [RFC 0/2] PCI: acpiphp: workaround race between hotplug and
 SCSI_SCAN_ASYNC job
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Igor Mammedov <imammedo@redhat.com>, linux-kernel@vger.kernel.org,
        Dongli Zhang <dongli.zhang@oracle.com>,
        linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
        mst@redhat.com, rafael@kernel.org, lenb@kernel.org,
        bhelgaas@google.com, mika.westerberg@linux.intel.com,
        boris.ostrovsky@oracle.com, joe.jin@oracle.com,
        stable@vger.kernel.org, Fiona Ebner <f.ebner@proxmox.com>,
        Thomas Lamprecht <t.lamprecht@proxmox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 13, 2023 at 7:11 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Wed, Dec 13, 2023 at 01:36:12AM +0100, Igor Mammedov wrote:
> > Hacks to mask a race between HBA scan job and bridge re-configuration(s)
> > during hotplug.
> >
> > I don't like it a bit but it something that could be done quickly
> > and solves problems that were reported.
>
> I agree, I don't like it either.  Adding a 1s delay doesn't address
> the real problem, and putting in a band-aid like this means the real
> problem would likely never be addressed.
>
> At this point the best option I see is to revert these:
>
>   cc22522fd55e2 ("PCI: acpiphp: Use pci_assign_unassigned_bridge_resources() only for non-root bus")
>   40613da52b13f ("PCI: acpiphp: Reassign resources on bridge if necessary")
>
> I hate the fact that reverting them would mean the root bus hotplug
> and ACPI bus check notifications would become issues again.
>
> But keeping these commits even though they add a new different problem
> that breaks things for somebody else seems worse to me.

Agreed.
