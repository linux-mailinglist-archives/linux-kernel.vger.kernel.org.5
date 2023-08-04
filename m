Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB96576FDAB
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 11:45:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231160AbjHDJo6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 05:44:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230317AbjHDJoz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 05:44:55 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D016630EA
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 02:44:53 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 3749DbxG023497;
        Fri, 4 Aug 2023 04:44:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=PODMain02222019; bh=V76O28R4V5m7Yxd
        fHvtUcqjTBQI4PdU+QGJQ89ye07s=; b=i6CgkZvQG6mvmvDUAOhXTrzBVH3vq++
        rF4i0ZUsvmlnB2c1byS8vMEjy8Vlg4ovlJyoPqlBAul063Kv+XDuRRgRzKF1mew7
        2PilUgtHxu5/5oXE4bOHy4c/nKQSDA/Tgu00Qw1GDpyAY/hnIhYUlfeSMiBxFna6
        dHMIu8Ldd+aJ5wRB13UOlEKfAwUbxKBW/Ex0sI8lMLUQAZI30S4wHvhcIxrV5hby
        Mtl00M6NbsRRh6ROpmyk6KnmQpiGLNO1R66ZmaOhnAHw8EFyX6SalJSCEnvIv03Y
        3W0BAQvyfNbL+JqI8LRX1fNgYKG1E4lGA+bnuAa6ArmMSHvy+lIZIsQ==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3s4y6jwjmr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 04 Aug 2023 04:44:43 -0500 (CDT)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Fri, 4 Aug
 2023 10:44:41 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.30 via Frontend Transport; Fri, 4 Aug 2023 10:44:41 +0100
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id A6D3C15B6;
        Fri,  4 Aug 2023 09:44:41 +0000 (UTC)
Date:   Fri, 4 Aug 2023 09:44:41 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Bard Liao <yung-chuan.liao@linux.intel.com>
CC:     <alsa-devel@alsa-project.org>, <vkoul@kernel.org>,
        <vinod.koul@linaro.org>, <linux-kernel@vger.kernel.org>,
        <pierre-louis.bossart@linux.intel.com>, <bard.liao@intel.com>
Subject: Re: [PATCH 1/2] soundwire: intel_auxdevice: enable pm_runtime
 earlier on startup
Message-ID: <20230804094441.GR103419@ediswmail.ad.cirrus.com>
References: <20230803065220.3823269-1-yung-chuan.liao@linux.intel.com>
 <20230803065220.3823269-2-yung-chuan.liao@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230803065220.3823269-2-yung-chuan.liao@linux.intel.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-GUID: 8BVtdkhWAWc7AealSFsuAe2R37e-LTBN
X-Proofpoint-ORIG-GUID: 8BVtdkhWAWc7AealSFsuAe2R37e-LTBN
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 03, 2023 at 02:52:19PM +0800, Bard Liao wrote:
> From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> 
> As soon as the bus starts, physical peripheral devices may report as
> ATTACHED and set their status with pm_runtime_set_active() in their
> update_status()/io_init().
> 
> This is problematic with the existing code, since the parent
> pm_runtime status is changed to "active" after starting the bus. This
> creates a time window where the pm_runtime framework can report an
> issue, e.g.
> 
> "rt711 sdw:0:025d:0711:00: runtime PM trying to activate child device
> sdw:0:025d:0711:00 but parent (sdw-master-0) is not active"
> 
> This patch enables runtime_pm earlier to make sure the auxiliary
> device is pm_runtime active after powering-up, but before starting the
> bus.
> 
> This problem was exposed by recent changes in the timing of the bus
> reset, but was present in this driver since we introduced pm_runtime
> support.
> 
> Closes: https://github.com/thesofproject/linux/issues/4328
> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
> Reviewed-by: Rander Wang <rander.wang@intel.com>
> Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
> ---

Doesn't seem to cause any problems on my SoundWire devices, so
very loosely:

Tested-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
