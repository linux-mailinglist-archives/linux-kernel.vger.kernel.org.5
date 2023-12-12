Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BAF780EC85
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 13:50:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376331AbjLLMuX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 07:50:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376286AbjLLMuU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 07:50:20 -0500
Received: from proxmox-new.maurer-it.com (proxmox-new.maurer-it.com [94.136.29.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8B2DF7;
        Tue, 12 Dec 2023 04:50:24 -0800 (PST)
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
        by proxmox-new.maurer-it.com (Proxmox) with ESMTP id BF6D5469C0;
        Tue, 12 Dec 2023 13:50:21 +0100 (CET)
Message-ID: <62363899-d7aa-4f1c-abfa-1f87f0b6b43f@proxmox.com>
Date:   Tue, 12 Dec 2023 13:50:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: SCSI hotplug issues with UEFI VM with guest kernel >= 6.5
Content-Language: en-US
To:     Igor Mammedov <imammedo@redhat.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        bhelgaas@google.com, lenb@kernel.org, rafael@kernel.org,
        Thomas Lamprecht <t.lamprecht@proxmox.com>
References: <9eb669c0-d8f2-431d-a700-6da13053ae54@proxmox.com>
 <20231207232815.GA771837@bhelgaas>
 <20231208164723.12828a96@imammedo.users.ipa.redhat.com>
 <20231211084604.25e209af@imammedo.users.ipa.redhat.com>
 <c6233df5-01d8-498f-8235-ce4b102a2e91@proxmox.com>
 <20231212122608.1b4f75ce@imammedo.users.ipa.redhat.com>
From:   Fiona Ebner <f.ebner@proxmox.com>
In-Reply-To: <20231212122608.1b4f75ce@imammedo.users.ipa.redhat.com>
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

Am 12.12.23 um 12:26 schrieb Igor Mammedov:
> 
> it's not necessary, but it would help to find out what's going wrong faster.
> Otherwise we would need to fallback to debugging over email.
> Are you willing to help with testing/providing debug logs to track down
> the cause?.
> 

I submitted the dmesg logs in bugzilla:
https://bugzilla.kernel.org/show_bug.cgi?id=218255

> Though debug over email would be slow, so our best option is to revert
> offending patches until the cause if found/fixed.
> 
>>>>> Do you have to revert both cc22522fd55e2 and 40613da52b13f to make it
>>>>> work reliably?  If we have to revert something, reverting one would be
>>>>> better than reverting both.    
>>>>  
>>
>> Just reverting cc22522fd55e2 is not enough (and cc22522fd55e2 fixes
>> 40613da52b13f so I can't revert just 40613da52b13f).
> 
> With UEFI setup, it still works for me fine with current master.
> 
> Kernel 6.7.0-rc5-00014-g26aff849438c on an x86_64 (ttyS0)
> 

I also built from current master (still 26aff849438c) to verify and it's
still broken for me.

> 
> it still doesn't work with Fedora's 6.7.0-0.rc2.20231125git0f5cc96c367f.26.fc40.x86_64 kernel.
> However it's necessary to have -smp 4 for it to break,
> with -smp 1 it works fine as well.
> 

For me it's (always with build from current master):

-smp 1 -> it worked 5 times out of 5
-smp 2 -> it worked 3 times out of 5
-smp 4 -> it worked 0 times out of 5
-smp 8 -> it worked 0 times out of 5

Best Regards,
Fiona

