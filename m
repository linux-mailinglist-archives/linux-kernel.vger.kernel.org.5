Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 382277825DF
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 10:55:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234205AbjHUIzb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 04:55:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234201AbjHUIz3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 04:55:29 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE064C7;
        Mon, 21 Aug 2023 01:55:26 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 37L6TsHE030365;
        Mon, 21 Aug 2023 03:55:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=PODMain02222019; bh=7JOXqRgei7/+BMz
        BxyWR56KwLJ2l/PfbxG+feDCL4+A=; b=i8gIZ+CC4GVDpW3TJkFfr4sdVthO4LE
        fOxGQf3hHiX9Q4b0GZQij/Nv+iUWbCWdm3xPXDHz46gLACM3ZXcqiJv5kwrLnVjR
        pgUuVjMJKm6x8jAPCdHwoklKKnstnv10dIE0EEhGBm3dJNHInj9yTb+M8EuqRueA
        atIRagWS9wyV3QxmMb4MZPJTJOhQNymZaq+8vxtkK9Zax1xHhm5imkpAId80FKi6
        6Cl6bI026g71400GVdw7FaxnAVxamqgXBk9+l9yGpQ7GcWHjekeW816ZJYNHeaGT
        rBVnDUFB8kMSs3xGvkKXw2PZ+LUG+ER8wvFxEjCFg97wJhXYUq1nlHQ==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3sktwq8e1h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Aug 2023 03:55:17 -0500 (CDT)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Mon, 21 Aug
 2023 09:55:15 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.30 via Frontend Transport; Mon, 21 Aug 2023 09:55:15 +0100
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id E73E83560;
        Mon, 21 Aug 2023 08:55:14 +0000 (UTC)
Date:   Mon, 21 Aug 2023 08:55:14 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     "Goud, Srinivas" <srinivas.goud@amd.com>
CC:     "broonie@kernel.org" <broonie@kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "patches@opensource.cirrus.com" <patches@opensource.cirrus.com>
Subject: Re: [PATCH v2 1/2] spi: spi-cadence: Interleave write of TX and read
 of RX FIFO
Message-ID: <20230821085514.GC103419@ediswmail.ad.cirrus.com>
References: <20230518093927.711358-1-ckeepax@opensource.cirrus.com>
 <PH8PR12MB66758946C395E678B7599FE5E112A@PH8PR12MB6675.namprd12.prod.outlook.com>
 <20230810100941.GX103419@ediswmail.ad.cirrus.com>
 <PH8PR12MB66754DDE4373E3667B882C46E11EA@PH8PR12MB6675.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <PH8PR12MB66754DDE4373E3667B882C46E11EA@PH8PR12MB6675.namprd12.prod.outlook.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-GUID: SiyqDeUO2j7baKB50nfAgkUQT6IDWJvP
X-Proofpoint-ORIG-GUID: SiyqDeUO2j7baKB50nfAgkUQT6IDWJvP
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 21, 2023 at 07:26:57AM +0000, Goud, Srinivas wrote:
> >
> >Do you have a web link to this ticket? Would be good to get some more
> >background.
> Here AR link which contains the issue description
> https://support.xilinx.com/s/article/65885?language=en_US
> 
> Thanks,
> Srinivas

Apologies for the delay, the patch tests out fine for me. You
probably want to send it properly as a patch rather than just an
attachment. But when you do feel free to add my:

Reviewed-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Tested-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
