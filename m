Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE7D3810E00
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 11:14:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233188AbjLMJrd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 04:47:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233142AbjLMJra (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 04:47:30 -0500
Received: from proxmox-new.maurer-it.com (proxmox-new.maurer-it.com [94.136.29.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55160A4;
        Wed, 13 Dec 2023 01:47:36 -0800 (PST)
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
        by proxmox-new.maurer-it.com (Proxmox) with ESMTP id C321746E6A;
        Wed, 13 Dec 2023 10:47:34 +0100 (CET)
Message-ID: <af67425d-8127-42d7-b874-099fa27f02a7@proxmox.com>
Date:   Wed, 13 Dec 2023 10:47:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 2/2] PCI: acpiphp: slowdown hotplug if hotplugging multiple
 devices at a time
Content-Language: en-US
To:     Igor Mammedov <imammedo@redhat.com>, linux-kernel@vger.kernel.org
Cc:     Dongli Zhang <dongli.zhang@oracle.com>, linux-acpi@vger.kernel.org,
        linux-pci@vger.kernel.org, mst@redhat.com, rafael@kernel.org,
        lenb@kernel.org, bhelgaas@google.com,
        mika.westerberg@linux.intel.com, boris.ostrovsky@oracle.com,
        joe.jin@oracle.com, stable@vger.kernel.org,
        Thomas Lamprecht <t.lamprecht@proxmox.com>
References: <20231213003614.1648343-1-imammedo@redhat.com>
 <20231213003614.1648343-3-imammedo@redhat.com>
From:   Fiona Ebner <f.ebner@proxmox.com>
In-Reply-To: <20231213003614.1648343-3-imammedo@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 13.12.23 um 01:36 schrieb Igor Mammedov:
> previous commit ("PCI: acpiphp: enable slot only if it hasn't been enabled already"
> introduced a workaround to avoid a race between SCSI_SCAN_ASYNC job and
> bridge reconfiguration in case of single HBA hotplug.
> However in virt environment it's possible to pause machine hotplug several
> HBAs and let machine run. That can hit the same race when 2nd hotplugged
> HBA will start re-configuring bridge.
> Do the same thing as SHPC and throttle down hotplug of 2nd and up
> devices within single hotplug event.
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>

With only the first patch applied, I could reproduce the issue described
here, i.e. pausing the vCPUs while doing multiple hotplugs and this
patch makes that scenario work too:

Tested-by: Fiona Ebner <f.ebner@proxmox.com>

