Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD5F5807642
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 18:15:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378682AbjLFRPq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 12:15:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379823AbjLFRPl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 12:15:41 -0500
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 322AAD7D;
        Wed,  6 Dec 2023 09:15:43 -0800 (PST)
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-6d87a83ec27so3057068a34.2;
        Wed, 06 Dec 2023 09:15:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701882942; x=1702487742;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GYp3frOVvXsJ2X/Ct957xNNutu3j7/9mfiaXXwDsyL8=;
        b=gVKbVzCAXYra62bMjIMCoZ1fft+a+UfeCRDYYZd2rzSipG2X5NFrvuHhWZvZPwtsqX
         KOLsGaPh13O/W64SjPHM3Zu/CR2D5U00gAWX8Z+PWAO/ecR6T+PneZ1oZOAY4LzjdoJN
         ANLOVgb6vpg19czs4s3O/ISivvnExXLTHhI5znK20MuRFfqB0SrmqLsMuG+JUmZid8EG
         n1yAwKrJMbeZ0YUo68i2BH4kkE8ROT0e6Ymkoul1Mx2e3VZ0KgVK1OoYXCmSW5e/81ZY
         rPtDXnlyWdhHRnSHPrFmMQIjsF928rD0+kQ1zW2Mchz69qez6eE5xae7OJzFaTTbLQ4P
         loNA==
X-Gm-Message-State: AOJu0YxKuvafD92fMpwROXvJL3MrPDBXXqPztrugyk5cOZripG0ZBgFg
        QA3DKie3JwY1nyS+WdSw+Q==
X-Google-Smtp-Source: AGHT+IG1oCexMuFyW4w0wlSNBbozqLu3b5kTesKDg8PYp6W65l111/ajQomBc1CroYb/JPZNbkf1hQ==
X-Received: by 2002:a9d:7991:0:b0:6d9:ca1e:af9a with SMTP id h17-20020a9d7991000000b006d9ca1eaf9amr1061464otm.31.1701882942455;
        Wed, 06 Dec 2023 09:15:42 -0800 (PST)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id q26-20020a9d4b1a000000b006d99c53f745sm34818otf.77.2023.12.06.09.15.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 09:15:41 -0800 (PST)
Received: (nullmailer pid 2703661 invoked by uid 1000);
        Wed, 06 Dec 2023 17:15:40 -0000
Date:   Wed, 6 Dec 2023 11:15:40 -0600
From:   Rob Herring <robh@kernel.org>
To:     Herve Codina <herve.codina@bootlin.com>,
        Saravana Kannan <saravanak@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Lizhi Hou <lizhi.hou@amd.com>, Max Zhen <max.zhen@amd.com>,
        Sonal Santan <sonal.santan@amd.com>,
        Stefano Stabellini <stefano.stabellini@xilinx.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Allan Nielsen <allan.nielsen@microchip.com>,
        Horatiu Vultur <horatiu.vultur@microchip.com>,
        Steen Hegelund <steen.hegelund@microchip.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH 0/2] Synchronize DT overlay removal with devlink removals
Message-ID: <20231206171540.GA2697853-robh@kernel.org>
References: <20231130174126.688486-1-herve.codina@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231130174126.688486-1-herve.codina@bootlin.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 30, 2023 at 06:41:07PM +0100, Herve Codina wrote:
> Hi,

+Saravana for comment

Looks okay to me though.

> 
> In the following sequence:
>   of_platform_depopulate(); /* Remove devices from a DT overlay node */
>   of_overlay_remove(); /* Remove the DT overlay node itself */
> 
> Some warnings are raised by __of_changeset_entry_destroy() which  was
> called from of_overlay_remove():
>   ERROR: memory leak, expected refcount 1 instead of 2 ...
> 
> The issue is that, during the device devlink removals triggered from the
> of_platform_depopulate(), jobs are put in a workqueue.
> These jobs drop the reference to the devices. When a device is no more
> referenced (refcount == 0), it is released and the reference to its
> of_node is dropped by a call to of_node_put().
> These operations are fully correct except that, because of the
> workqueue, they are done asynchronously with respect to function calls.
> 
> In the sequence provided, the jobs are run too late, after the call to
> __of_changeset_entry_destroy() and so a missing of_node_put() call is
> detected by __of_changeset_entry_destroy().
> 
> This series fixes this issue introducing device_link_wait_removal() in
> order to wait for the end of jobs execution (patch 1) and using this
> function to synchronize the overlay removal with the end of jobs
> execution (patch 2).
> 
> Best regards,
> Hervé
> 
> Herve Codina (2):
>   driver core: Introduce device_link_wait_removal()
>   of: overlay: Synchronize of_overlay_remove() with the devlink removals
> 
>  drivers/base/core.c    | 26 +++++++++++++++++++++++---
>  drivers/of/overlay.c   |  6 ++++++
>  include/linux/device.h |  1 +
>  3 files changed, 30 insertions(+), 3 deletions(-)
> 
> -- 
> 2.42.0
> 
