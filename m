Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7C5277FE31
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 20:54:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353725AbjHQSyT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 14:54:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354176AbjHQSyH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 14:54:07 -0400
Received: from forwardcorp1b.mail.yandex.net (forwardcorp1b.mail.yandex.net [178.154.239.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18560E48
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 11:54:02 -0700 (PDT)
Received: from mail-nwsmtp-smtp-corp-main-26.myt.yp-c.yandex.net (mail-nwsmtp-smtp-corp-main-26.myt.yp-c.yandex.net [IPv6:2a02:6b8:c12:5429:0:640:6285:0])
        by forwardcorp1b.mail.yandex.net (Yandex) with ESMTP id B28AF60BD6;
        Thu, 17 Aug 2023 21:53:59 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:6506::1:1d] (unknown [2a02:6b8:b081:6506::1:1d])
        by mail-nwsmtp-smtp-corp-main-26.myt.yp-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id vrmLf40OdCg0-d8vnfZH8;
        Thu, 17 Aug 2023 21:53:59 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1692298439; bh=r3s+B3P0FbUlxPCkOSooRayCTnB3IOUAqr1TUfQtqqk=;
        h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
        b=VDg9Zk/5YwTcjlY0Wb0Z7RMmRzFjPchUA7UuF2fen3rJAtqUTKSk7XzBiYdmsK597
         24K1P0qLmjP7M3AZTIMJVs9YW4v8jfgDLyaHqRhiBXuN0Alnr4b4vDcesf5swzo9Ub
         fXrn+OjS7NSPAMdmkvMViJgT+Ry6spMQYYJ+C7nw=
Authentication-Results: mail-nwsmtp-smtp-corp-main-26.myt.yp-c.yandex.net; dkim=pass header.i=@yandex-team.ru
Message-ID: <8d48c4aa-1bf7-3b25-99fa-3dd76cec070e@yandex-team.ru>
Date:   Thu, 17 Aug 2023 23:53:57 +0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH] kernfs: implement custom llseek method to fix userspace
 regression
Content-Language: ru, en-US
To:     Dan Williams <dan.j.williams@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-kernel@vger.kernel.org
References: <20230814190850.948032-1-valesini@yandex-team.ru>
 <64da880166403_5ea6e29449@dwillia2-xfh.jf.intel.com.notmuch>
 <2d3960a6-34fc-1951-b39b-ce41674bb4d0@yandex-team.ru>
 <64db9e495b729_5ea6e29499@dwillia2-xfh.jf.intel.com.notmuch>
From:   Valentin Sinitsyn <valesini@yandex-team.ru>
In-Reply-To: <64db9e495b729_5ea6e29499@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15.08.2023 20:48, Dan Williams wrote:
> Valentin Sinitsyn wrote:
> [..]
>>> My only concern is whether there are any scenarios where this is not
>>> appropriate. I.e. do a bit more work to define a kernfs_ops instance
>>> specifically for overriding lseek() in this scenario.
>>
>> Not sure I'm getting you here: do you mean something like this?
>>
>> struct inode *inode = is_f_mapping_redefined(file) ? file_inode(file) :
>> file->f_mapping->host;
> 
> I meant something like the patch below (incomplete, but shows the idea).
Understood, thanks. I believe the change can be localized even further, 
up to the point where battr->f_mapping is initialized with 
iomem_get_mapping, as it is the only override known to break 
generic_file_llseek().

I'll send the updated patch in a few days.

Best,
Valentin
