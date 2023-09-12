Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AB9479C791
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 09:04:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231315AbjILHEW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 03:04:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231217AbjILHEU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 03:04:20 -0400
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 210FF9B;
        Tue, 12 Sep 2023 00:04:17 -0700 (PDT)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38C0ONZi017891;
        Tue, 12 Sep 2023 00:04:03 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=pfpt0220;
 bh=ot6UReUqpkU9D5Gkp1Tf0pnkqUGSFAGoQN6/UDM6XS8=;
 b=ctzaDjHrsp9uC8ixnUn7Kl5veCK9F0xF7rTOkOEhbXkKVdXn65udJkpEhmJTmBLMhoxR
 DcOeP3qQ3pGcts2AUmhID7OMldKtuAjkUFB8Se9SvirX0ML6p709FMg0bpdq3/Dn3qNY
 B5Ljuyj9vJdIEcRdjPdZR8DUAUBWIN0HewmVy20g75yKZifeHtykcZv2M7bcSBLm4sbL
 qYSebhmCMPF3p67zSlSuNEgwA0OLEUIx8IRYMzQv6X/926H/TQlTLBB5s6GQTrlUfc0v
 6rxlPA2xy7eUfgV9OsNc2ToP/pF7OsFyPXSlxESiDZ3o9A9hN/Wzf7eT/8pHfQivVfNY 3w== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
        by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3t0r7krxq3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 12 Sep 2023 00:04:03 -0700
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Tue, 12 Sep
 2023 00:04:01 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Tue, 12 Sep 2023 00:04:01 -0700
Received: from ubuntu-PowerEdge-T110-II.sclab.marvell.com (unknown [10.106.27.86])
        by maili.marvell.com (Postfix) with ESMTP id EAFDC3F70EE;
        Tue, 12 Sep 2023 00:04:00 -0700 (PDT)
From:   Shinas Rasheed <srasheed@marvell.com>
To:     <horms@kernel.org>
CC:     <aayarekar@marvell.com>, <davem@davemloft.net>,
        <edumazet@google.com>, <egallen@redhat.com>, <hgani@marvell.com>,
        <kuba@kernel.org>, <linux-kernel@vger.kernel.org>,
        <mschmidt@redhat.com>, <netdev@vger.kernel.org>,
        <pabeni@redhat.com>, <sburla@marvell.com>, <sedara@marvell.com>,
        <srasheed@marvell.com>, <vburru@marvell.com>,
        <vimleshk@marvell.com>
Subject: Re: [net PATCH] octeon_ep: fix tx dma unmap len values in SG
Date:   Tue, 12 Sep 2023 00:04:00 -0700
Message-ID: <20230912070400.2136431-1-srasheed@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230911180113.GA113013@kernel.org>
References: <20230911180113.GA113013@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: V-Tx_nhuzh5QOISVLRCl8Vg3ENCMpCUe
X-Proofpoint-ORIG-GUID: V-Tx_nhuzh5QOISVLRCl8Vg3ENCMpCUe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-12_04,2023-09-05_01,2023-05-22_02
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Simon,

This change is required in octep_iq_process_completions, as given in the patch,
since the scatter gather pointer lengths arrive as big-endian in hardware.
