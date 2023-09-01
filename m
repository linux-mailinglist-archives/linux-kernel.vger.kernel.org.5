Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 506E678FFA1
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 17:05:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350106AbjIAPFA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 11:05:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230186AbjIAPFA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 11:05:00 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDDCF10CF
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 08:04:55 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4RchB85Kwyz6HJcc;
        Fri,  1 Sep 2023 23:03:44 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Fri, 1 Sep
 2023 16:04:52 +0100
Date:   Fri, 1 Sep 2023 16:04:51 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Amit Singh Tomar <amitsinght@marvell.com>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <fenghua.yu@intel.com>,
        <reinette.chatre@intel.com>, <james.morse@arm.com>,
        <gcherian@marvell.com>, <robh@kernel.org>,
        <peternewman@google.com>,
        "Wang ShaoBo" <bobo.shaobowang@huawei.com>
Subject: Re: [RFC 00/12] ARM: MPAM: add support for priority partitioning
 control
Message-ID: <20230901160451.00001f75@Huawei.com>
In-Reply-To: <20230815152712.1760046-1-amitsinght@marvell.com>
References: <20230815152712.1760046-1-amitsinght@marvell.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100005.china.huawei.com (7.191.160.25) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Aug 2023 20:57:00 +0530
Amit Singh Tomar <amitsinght@marvell.com> wrote:

> Arm Memory System Resource Partitioning and Monitoring (MPAM) supports
> different controls that can be applied to different resources in the system
> For instance, an optional priority partitioning control where priority
> value is generated from one MSC, propagates over interconnect to other MSC
> (known as downstream priority), or can be applied within an MSC for internal
> operations.

Hi Amit,

I'll most leave side commenting on the actual interface as lots of discussion has
occurred on that already so I'll wait for the next version and see where things
ended up :)

As a side note, openEuler has been carrying MPAM patches out of tree for a
long time now and have supported various features that align with available hardware.

The interface is partly described in. 
https://github.com/openeuler-mirror/kernel/commit/8139268b70398c37843a38bf8c7b243ad1f20c97

e.g.
   > mount -t resctrl resctrl /sys/fs/resctrl -o mbMax,mbMin,caPrio
   > cd /sys/fs/resctrl && cat schemata
     L3:0=0x7fff;1=0x7fff;2=0x7fff;3=0x7fff #default select cpbm as basic ctrl feature
     L3PRI:0=3;1=3;2=3;3=3
     MBMAX:0=100;1=100;2=100;3=100
     MBMIN:0=0;1=0;2=0;3=0

I'm not sure if this is the latest or not.
> 
> Marvell implementation of ARM MPAM supports priority partitioning control
> that allows LLC MSC to generate priority values that gets propagated (along with
> read/write request from upstream) to DDR Block.

This raises an interesting question of whether we should present these as controls
on the cache, or on the Memory controllers.  This is unlike INTPRI controls which
if present on the caches would definitely make sense presented there in resctrl.

If it were the case that downstream priority controls always just applied to one
block then listing them there (as DDR resource controls) might make sense -
however the section in the spec on "Through priorities" blocks that option as
these apply to everything downstream of which ever blocks set the priorities.

So whilst it's confusing I think you are right in presenting this as part of
the cache resource controls.  For the OpenEuler kernel that problem hasn't
arisen as focus is internal priority in the caches rather than downstream.


> Within the DDR block the
> priority values is mapped to different traffic class under DDR QoS strategy.
> The link[1] gives some idea about DDR QoS strategy, and terms like LPR, VPR
> and HPR.
> 

Jonathan

