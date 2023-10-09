Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EF1D7BD38C
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 08:36:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232035AbjJIGg1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 02:36:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbjJIGgZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 02:36:25 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45BE1A3;
        Sun,  8 Oct 2023 23:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1696833384; x=1728369384;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=uyI1GBRwRYaf3PKDtrd6L3XsdGth2lmbbXpOUwPRAaE=;
  b=oe4Hl8ENdDB5f9uM6egRewbmMXi2z1lTuu/z5MFC1PK/3qWch3RX9eSJ
   VIj442C5Y/b9eQHkEUcGpAZoNwlWol11TtqSLXyR4ngrlxx//QG1vdHQG
   XOdUTrfHnwlPK8qGmsQewVbNviaFJ4qFHmX7uCFPmJWzI+lee80DnkesT
   ZnfVB5d37uq4+H5/3awgS5pvGQ02KFJvYcf7SA2dcW6z3DQfyM0qhCL8c
   qTbW9OXer3d8erij8tLvWBGEamxYr7WAU8EBSsJqkHVGk55BXz12grjHj
   QRnL52RnjgRuLrBATUspt74SjRI55LSqV6h4azoSYjixJzurs/x/tmPNj
   g==;
X-CSE-ConnectionGUID: 2bV9ZySXRE2QAaSa4DhkSg==
X-CSE-MsgGUID: RucYwCjpRZyg8bGFVoQ3cA==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.03,209,1694761200"; 
   d="scan'208";a="9573346"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 08 Oct 2023 23:36:22 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Sun, 8 Oct 2023 23:35:50 -0700
Received: from localhost (10.10.85.11) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.21 via Frontend
 Transport; Sun, 8 Oct 2023 23:35:50 -0700
Date:   Mon, 9 Oct 2023 08:35:49 +0200
From:   Horatiu Vultur <horatiu.vultur@microchip.com>
To:     Jamal Hadi Salim <jhs@mojatatu.com>
CC:     Chengfeng Ye <dg573847474@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>, <xiyou.wangcong@gmail.com>,
        <jiri@resnulli.us>, <davem@davemloft.net>, <edumazet@google.com>,
        <pabeni@redhat.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] net/sched: use spin_lock_bh() on &gact->tcf_lock
Message-ID: <20231009063549.gcehavudj4gxz4oc@soft-dev3-1>
References: <20230926182625.72475-1-dg573847474@gmail.com>
 <20231004170120.1c80b3b4@kernel.org>
 <CAAo+4rW=zh_d7AxJSP0uLuO7w+_PmbBfBr6D4=4X2Ays7ATqoA@mail.gmail.com>
 <CAM0EoMkgUPF751LpEij4QjwsP_Z3qBMW_Nss67OVN1hxyN0mGQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAM0EoMkgUPF751LpEij4QjwsP_Z3qBMW_Nss67OVN1hxyN0mGQ@mail.gmail.com>
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 10/05/2023 07:46, Jamal Hadi Salim wrote:

Hi Jamal,

> On Thu, Oct 5, 2023 at 5:01 AM Chengfeng Ye <dg573847474@gmail.com> wrote:
> >
> > Hi Jakub,
> >
> > Thanks for the reply,
> >
> > I inspected the code a bit more, it seems that the TC action is called from
> > tcf_proto_ops.classify() callback, which is called from Qdisc_ops enqueue
> > callback.
> >
> > Then Qdisc enqueue callback is from
> >
> > -> __dev_queue_xmit()
> > -> __dev_xmit_skb()
> > -> dev_qdisc_enqueue()
> >
> > inside the net core. It seems that this __dev_queue_xmit() callback is
> > typically called from BH context (e.g.,  NET_TX_SOFTIRQ) with BH
> > already disabled, but sometimes also can from a work queue under
> > process context, one case is the br_mrp_test_work_expired() inside
> > net/bridge/br_mrp.c. Does it indicate that this TC action could also be
> > called with BH enable? I am not a developer so really not sure about it,
> > as the networking code is a bit long and complicated.
> 
> net/bridge/br_mrp.c seems to need some love +Cc Horatiu Vultur
> <horatiu.vultur@microchip.com>
> Maybe that code needs to run in a tasklet?
> In any case your patch is incorrect.

I am currently out traveling and it would be a little bit hard for me to
look at this right now. I can have a look after I come back in office
around mid November.
But I was wondering if this is stil an issue for MRP as Cong Wang
pointed out, the function __dev_queue_xmit is already disabling the BH.

> 
> cheers,
> jamal
> 

-- 
/Horatiu
