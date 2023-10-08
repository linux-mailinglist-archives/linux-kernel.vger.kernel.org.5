Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15D547BD11C
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 01:17:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344925AbjJHXRM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Oct 2023 19:17:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344437AbjJHXRL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Oct 2023 19:17:11 -0400
Received: from mp-relay-01.fibernetics.ca (mp-relay-01.fibernetics.ca [208.85.217.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B44B69D;
        Sun,  8 Oct 2023 16:17:10 -0700 (PDT)
Received: from mailpool-fe-02.fibernetics.ca (mailpool-fe-02.fibernetics.ca [208.85.217.145])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mp-relay-01.fibernetics.ca (Postfix) with ESMTPS id DA5F8E1947;
        Sun,  8 Oct 2023 23:17:09 +0000 (UTC)
Received: from localhost (mailpool-mx-01.fibernetics.ca [208.85.217.140])
        by mailpool-fe-02.fibernetics.ca (Postfix) with ESMTP id C39346091F;
        Sun,  8 Oct 2023 23:17:09 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at 
X-Spam-Score: -0.199
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
Received: from mailpool-fe-02.fibernetics.ca ([208.85.217.145])
        by localhost (mail-mx-01.fibernetics.ca [208.85.217.140]) (amavisd-new, port 10024)
        with ESMTP id n9tGbeY3WSBp; Sun,  8 Oct 2023 23:17:09 +0000 (UTC)
Received: from [192.168.48.17] (host-104-157-209-188.dyn.295.ca [104.157.209.188])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dgilbert@interlog.com)
        by mail.ca.inter.net (Postfix) with ESMTPSA id B336660455;
        Sun,  8 Oct 2023 23:17:08 +0000 (UTC)
Message-ID: <d61e88d3-e1b7-44e0-ba9b-f633be0b5b30@interlog.com>
Date:   Sun, 8 Oct 2023 19:17:08 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: dgilbert@interlog.com
Subject: Re: [PATCH v5 10/10] scsi: scsi_debug: Add param to control sdev's
 allow_restart
Content-Language: en-CA
To:     Wenchao Hao <haowenchao2@huawei.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        open-iscsi@googlegroups.com, linux-scsi@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, louhongxiang@huawei.com
References: <20230922092906.2645265-1-haowenchao2@huawei.com>
 <20230922092906.2645265-11-haowenchao2@huawei.com>
From:   Douglas Gilbert <dgilbert@interlog.com>
In-Reply-To: <20230922092906.2645265-11-haowenchao2@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-09-22 05:29, Wenchao Hao wrote:
> Add new module param "allow_restart" to control if setup
> scsi_device's allow_restart flag. This is used to test scsi
> command finished with sense_key 0x6, asc 0x4 and ascq 0x2
> 
> Signed-off-by: Wenchao Hao <haowenchao2@huawei.com>

Hi,
Looked at this and verified that the allow_restart flag of scsi_debug
devices (disks ?) is usually 0 and when the scsi_debug module is
started with allow_restart=1 then the allow_restart flag does indeed
change to 1. For example:
    # cat /sys/class/scsi_disk/1\:0\:0\:0/allow_restart
    1

That ASC/ASCQ code means: "Logical unit not ready, initializing command
required" according to my library. Played around with sg_start but didn't
see any change in how it reacts. According to scsi_device.h that flag's
description is: "issue START_UNIT in error handler" which implies it
changes how the EH handler reacts.

Perhaps the 3 line patch description could say a little more about how
to use this new parameter...

Tested-by: Douglas Gilbert <dgilbert@interlog.com>

<snip>




