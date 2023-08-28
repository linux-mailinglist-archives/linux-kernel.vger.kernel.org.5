Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C425E78A663
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 09:24:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbjH1HXf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 03:23:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjH1HXI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 03:23:08 -0400
Received: from forwardcorp1b.mail.yandex.net (forwardcorp1b.mail.yandex.net [178.154.239.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9E1BF1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 00:23:00 -0700 (PDT)
Received: from mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net (mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net [IPv6:2a02:6b8:c08:ac00:0:640:e1b9:0])
        by forwardcorp1b.mail.yandex.net (Yandex) with ESMTP id 2A091632B9;
        Mon, 28 Aug 2023 10:22:56 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:b53b::1:23] (unknown [2a02:6b8:b081:b53b::1:23])
        by mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id sMJW2N1OlmI0-jjXWCNTg;
        Mon, 28 Aug 2023 10:22:55 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1693207375; bh=Exq5huRwtFyDOI2IRKeFFQP3cuVx5hXB1qJx+jCkpm4=;
        h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
        b=QNVqU8Z2B9WCnWL+nN8KwG0Qdt0Rd773VUsy74j36GCwDIiNvSUsp7J301RzvIvMQ
         TEKTDda27DhqjPAd0+/NOj+wz2Kv80BamafBSa81BywWfmhcqu1BVgFpzXBhz7f2d9
         AHRxykRjatkd00HHoSRFvGDNtqWGpj7qq6xd2XsE=
Authentication-Results: mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net; dkim=pass header.i=@yandex-team.ru
Message-ID: <3dc7f3f3-b2a0-530d-9688-b725204e3270@yandex-team.ru>
Date:   Mon, 28 Aug 2023 12:22:54 +0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v5 2/2] PCI: Implement custom llseek for sysfs resource
 entries
To:     kernel test robot <lkp@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-kernel@vger.kernel.org
References: <20230823125834.492298-2-valesini@yandex-team.ru>
 <202308252133.YO5zs5rv-lkp@intel.com>
Content-Language: ru, en-US
From:   Valentin Sinitsyn <valesini@yandex-team.ru>
In-Reply-To: <202308252133.YO5zs5rv-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

On 25.08.2023 19:10, kernel test robot wrote:
> Hi Valentine,
> 
> kernel test robot noticed the following build warnings:
> 
[..]
> All warnings (new ones prefixed by >>):
> 
>     drivers/pci/pci-sysfs.c:1268:12: warning: no previous prototype for 'pci_create_resource_files' [-Wmissing-prototypes]
>      1268 | int __weak pci_create_resource_files(struct pci_dev *dev) { return 0; }
>           |            ^~~~~~~~~~~~~~~~~~~~~~~~~
>     drivers/pci/pci-sysfs.c:1269:13: warning: no previous prototype for 'pci_remove_resource_files' [-Wmissing-prototypes]
>      1269 | void __weak pci_remove_resource_files(struct pci_dev *dev) { return; }
>           |             ^~~~~~~~~~~~~~~~~~~~~~~~~
>>> drivers/pci/pci-sysfs.c:838:15: warning: 'pci_llseek_resource' defined but not used [-Wunused-function]
>       838 | static loff_t pci_llseek_resource(struct file *filep,
>           |               ^~~~~~~~~~~~~~~~~~~
I'm not sure if I should do anything about it: arc doesn't HAVE_* 
anything PCI-related, and pci-sysfs doesn't seem to be written with this 
case in mind. Guarding pci_llseek_resource() with an #ifdef 
HAVE_AT_LEAST_SOMETHING is trivial, but it feels more like a patch to 
silence a bot than a proper fix.

Any thoughts / objections on this?

Best,
Valentine
