Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6818F7F14EA
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 14:52:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233697AbjKTNwg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 08:52:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233699AbjKTNwJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 08:52:09 -0500
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ED3A1701;
        Mon, 20 Nov 2023 05:51:43 -0800 (PST)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 3AK7gLuL013978;
        Mon, 20 Nov 2023 07:51:35 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        message-id:subject:from:to:cc:date:in-reply-to:references
        :content-type:mime-version:content-transfer-encoding; s=
        PODMain02222019; bh=hHUDeNKVn2Q63s7c31O4N6WqAJjj0/zhNnzg5Jp1P0s=; b=
        apkbQCAgTMla8LcuoLIjOwfRyBCEfMNMc6VlCq3NIOEZ4jvcb4GJeqG5LharH5HT
        wBPvR58C9zkoFy8ZqTtyjTuF7Zt3VYKMt9tjALqi6+0C7I72Ug5E2VKoaCM5xmn3
        QmdXILhB1QruEQztfLVVHLgtslg3rswnIqN/CEUYRDF5pz5yotfmnnR5uQZ81rur
        RbBSRQWHux/87MvkYB6cSpTstwjOfr191JeR3JEMaAow6OtLVQXAXJP8F0zeUe7W
        tCXJN4Zj+qSJrDhmDFekHoWCuFyJkDWHO8iAaYff7hSZEx+0WElZLLzojuMR8TZl
        hqUIEloM0Dq7vLsKDp+MPQ==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3ueuj29u7m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Nov 2023 07:51:35 -0600 (CST)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Mon, 20 Nov
 2023 13:51:33 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.39 via Frontend
 Transport; Mon, 20 Nov 2023 13:51:33 +0000
Received: from ediswws03.ad.cirrus.com (ediswws03.ad.cirrus.com [198.90.251.123])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 2366515B9;
        Mon, 20 Nov 2023 13:51:33 +0000 (UTC)
Message-ID: <e9698a93d2eeae8c00cfcebdfa69f686849ded0b.camel@opensource.cirrus.com>
Subject: Re: [PATCH v2 6/7] ASoC: cs43130: Allow driver to work without IRQ
 thread
From:   Maciej Strozek <mstrozek@opensource.cirrus.com>
To:     Mark Brown <broonie@kernel.org>
CC:     James Schulman <james.schulman@cirrus.com>,
        David Rhodes <david.rhodes@cirrus.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <linux-sound@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Date:   Mon, 20 Nov 2023 13:51:33 +0000
In-Reply-To: <7d8bf03f-e9a5-405b-8753-a360f46a04df@sirena.org.uk>
References: <20231120104153.76248-1-mstrozek@opensource.cirrus.com>
         <7d8bf03f-e9a5-405b-8753-a360f46a04df@sirena.org.uk>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.3-1+deb11u2 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: GeAWVfhstnj9i4jJ6lXjygZ-GSPFwGKy
X-Proofpoint-GUID: GeAWVfhstnj9i4jJ6lXjygZ-GSPFwGKy
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

W dniu pon, 20.11.2023 o godzinie 12∶31 +0000, użytkownik Mark Brown
napisał:
> On Mon, Nov 20, 2023 at 10:41:53AM +0000, Maciej Strozek wrote:
> > This is to support systems without physical IRQ connection. The
> > device
> > only requires the IRQ for a couple of internal delays, this polling
> > mechanism is a fallback when no IRQ is specified.
> 
> Your changelog here doesn't describe the change - is then intention
> here
> to remove the IRQ thread (and presumably open code?) or to make
> interrupts entirely optional?
> 
> I'm assuming there aren't six more patches in this series?  The whole
> point in numbering patches is to order things, if you're only sending
> one patch you don't need numbering at all.

Apologies, I thought the word "fallback" would describe the intention
of making an optional way for the driver to work in absence of IRQ
rather than removing the IRQ thread. Will send an amended (and
unnumbered) v3.

