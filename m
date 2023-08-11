Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52CE2779872
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 22:19:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233506AbjHKUTr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 16:19:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229927AbjHKUTq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 16:19:46 -0400
Received: from abi149hd125.arn1.oracleemaildelivery.com (abi149hd125.arn1.oracleemaildelivery.com [129.149.84.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7296B10DF
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 13:19:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=oci-arn1-20220924;
 d=augustwikerfors.se;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender;
 bh=UYee5eYiAK39Q1z3nNQNBRUkESDlag9nZFyEI55xUb4=;
 b=PX+CzZOP3TYoeq/XPPc4KeU/taJiCtEtliip0vS4MaZryizYEnEp5yJEv68I8r1FbRV7hVO1l3N3
   6H+lmrST4xSxhep31t7zZZJh1Mv1riwNewos1mTsEYhpMVVzIC3gA3LGgNFBzj3AYPkSwX61QQy5
   QTMjgpBG4GMsz79/GzBSDhJbz9ctqJoohcGg7tdd+ZuFerCVL+ddGkt4dM0QeNRAvwHdyUecJefa
   L5TJ6VNclbRdaar704a0U6RluBUn6nvZtPyZbtzQ2Los7f13BvCTyMqhKFWohiKHmfFvl4ODlsw4
   3/g7f/OLajuueRYYzhf4eTND/Y+udqlvJlbdYQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=prod-arn-20211201;
 d=arn1.rp.oracleemaildelivery.com;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender;
 bh=UYee5eYiAK39Q1z3nNQNBRUkESDlag9nZFyEI55xUb4=;
 b=W+3rx2WSYISvmXfUUCd1AylM3T0PMXsoyIBlxYHyZUlYbIsLuh57hR5/woSLh1Ph1kQh44en+LOR
   RihA1cLXP8kF0n7aZeMwYMev/XpXTen96ukmgqOLXOFRIfxRkPJye9IKQwf3R2WMCs6i93SDrFzk
   fG7GdFO8oDvmH8JkugqbDyVERNGoscQBnx6MWsdhKtqiP5G3ixQxpbTtirdj1d04b5C4EtbNQOi8
   qNYvLTMKjDuDXe4R78OqvSYa7MRiZUWQ+nWV2z03a+JV8RTHoWQPj6EAAntlz+IbCcJFoEduCaDN
   votXaqcBN0dnx+7H/B2PFzniWjzssSFjstTKRg==
Received: by omta-ad1-fd1-401-eu-stockholm-1.omtaad1.vcndparn.oraclevcn.com
 (Oracle Communications Messaging Server 8.1.0.1.20230707 64bit (built Jul  7
 2023))
 with ESMTPS id <0RZ8005P3TSQPD40@omta-ad1-fd1-401-eu-stockholm-1.omtaad1.vcndparn.oraclevcn.com>
 for linux-kernel@vger.kernel.org; Fri, 11 Aug 2023 20:19:38 +0000 (GMT)
Message-id: <0f422dbe-2e3f-4401-be87-2963cbbc1234@augustwikerfors.se>
Date:   Fri, 11 Aug 2023 22:19:35 +0200
MIME-version: 1.0
From:   August Wikerfors <git@augustwikerfors.se>
Subject: Re: [PATCH] nvme: Don't fail to resume if NSIDs change
To:     stable@vger.kernel.org
Cc:     Mario Limonciello <mario.limonciello@amd.com>,
        Keith Busch <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>, axboe@fb.com, sagi@grimberg.me,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        nilskruse97@gmail.com, David.Chang@amd.com
References: <20230731185103.18436-1-mario.limonciello@amd.com>
 <ZMgHE2wu4T4OfrTR@kbusch-mbp>
 <040c5788-1a7b-26ea-23cc-ba239c76efa9@augustwikerfors.se>
 <39697f68-9dc8-7692-7210-b75cce32c6ce@amd.com> <20230731201047.GA14034@lst.de>
 <36319a0f-34a6-9353-bc52-4d4d0fac27a5@amd.com> <20230801112403.GA3972@lst.de>
 <ae7fb9b2-d692-f9b8-5130-4555cc489846@amd.com>
 <ZMlrGNw5OMW3yxId@kbusch-mbp.dhcp.thefacebook.com>
 <b2e741b3-b581-40fe-2c28-e4660f52003d@amd.com>
Content-language: en-US
In-reply-to: <b2e741b3-b581-40fe-2c28-e4660f52003d@amd.com>
Content-type: text/plain; charset=UTF-8; format=flowed
Content-transfer-encoding: 7bit
Reporting-Meta: AAE8DGuEMYrf45lHTdh54TgMaNY8+iRJQTe9hY+5T0LFf3+29Cv+oDRjYT9Xx6Yl
 nrJvLuvW/4wHxW/x225K0uH+OgeGKGJw2N7FdHWi6QjJlzveDb4Q4gk8II+M3zKq
 1zm7Jzv/Gq1T9beQZztaGUW3eH3hFQif+Nn/ggszwROpgw4VLv0gWP4AXfxjqXsc
 8hvILfMP3NkDYP0saW8vgo9t86cleeGvTZkn533XLY908iaKQZLgy1aS+NNwIWvT
 Qy56na0rvtD8lSN+TTi33Dw7WxVDNz7UPhxwsZMx7pHBJAwK5Zb6VbU3eF0HFs4I
 Jvv5V3sClQxjNSuKW/PxreBCS2peWmD0ylWMBbs59lyxxkGW6BE/AsBrwiTs1wVv
 LJKkvKM9Rsu5z0rSkzpL68ODZ0KWrmEYAdciAZ7zPTRxkQW03zIbq/IuO+GDd3+r s/OroQY=
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-08-01 22:34, Mario Limonciello wrote:
> If you can still change it before sending out can you add a stable tag 
> as well?

This didn't get added in time, so, stable team, please backport:

688b419c57c1 ("nvme-pci: add NVME_QUIRK_BOGUS_NID for Samsung PM9B1 256G and 512G")

Regards,
August Wikerfors
