Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 958BB7DF799
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 17:25:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376888AbjKBQZN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 12:25:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344919AbjKBQZL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 12:25:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9635D123
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 09:24:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698942259;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NWaRCiTgkH9FLCogjLUgD1xSO/P7WPqZ0xtIfK8N4cw=;
        b=fxzJh1R7TanY4ADMhS5rxJofEQWuVIGRNz4nk5Ct7oNIMaalGuVFAhauv9sTwoV67mcfBe
        1w+Sc22Hr9T6Tt/KkAOulzoBg227Jxo35DGxzARoHvGCLRKI0ogfwk6H48cxYekcvxr3kV
        HWlA8Pvt//FoS74BKPUDqM77Idknhws=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-290-8IwlGxJTNQ6cZS6wZnuIkg-1; Thu, 02 Nov 2023 12:24:18 -0400
X-MC-Unique: 8IwlGxJTNQ6cZS6wZnuIkg-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-40778b52dbaso1368925e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Nov 2023 09:24:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698942257; x=1699547057;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NWaRCiTgkH9FLCogjLUgD1xSO/P7WPqZ0xtIfK8N4cw=;
        b=PjQgLDf9OczHB7AhIRXpg0bFAd/QIreWtP8Yw2oc5MqSWXpM8JBRBBNrF6Pkq5B4TM
         ZeBYevMpYyQTdsKtWL2zfzH8YCFLNuDBJvsIuYD3zpZTV+91qCQX2EZQ21ptN43FI1JH
         49epVqzVjxnRyG0n+Nz5kMJk/bkBDvMFc8KjueeHHfT4wgFTkjO+O+iprDLDJLIZFrLD
         jL35tLXG0rYscnLYZBmIg6EDqFVL8OOoHO/M0hX72DPskcPr2mOvCKt1Tczdty228BNr
         6lj9kYVRXnYx01Dao/sdaAYYwb8UOHP8dyx2ToJFB2g3UZD2NU75ywJTs+zTmr6NGbHt
         h7xw==
X-Gm-Message-State: AOJu0Yy1SRh4NU3mUhe+edfKoLfW1yJYCqAfbWfmNFHDZkFFfX0TivrH
        oVHNKI2lLqbGJ0G6P2AS9vWWHH0i9DzG9xRAjA8VgLzSz3A2G6/ZlUhI2B2D2jqSkmyou1vCEHe
        MP0j3bgVOjd+NA1hLstAhxoG8
X-Received: by 2002:a05:600c:1c0f:b0:408:3836:525f with SMTP id j15-20020a05600c1c0f00b004083836525fmr15589580wms.1.1698942257153;
        Thu, 02 Nov 2023 09:24:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFS/kSXGXAzQZt+dBmBSqWQ3eIDJ686Chv7gGdkVo+1l5AObtACPBG4+lVXVe1zJHlzbfxdgw==
X-Received: by 2002:a05:600c:1c0f:b0:408:3836:525f with SMTP id j15-20020a05600c1c0f00b004083836525fmr15589561wms.1.1698942256805;
        Thu, 02 Nov 2023 09:24:16 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-106-155.dyn.eolo.it. [146.241.106.155])
        by smtp.gmail.com with ESMTPSA id e5-20020a05600c4e4500b0040772934b12sm3628902wmq.7.2023.11.02.09.24.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Nov 2023 09:24:16 -0700 (PDT)
Message-ID: <97732cc0a75c0be3f2354075085e7fa6d78e82bb.camel@redhat.com>
Subject: Re: [PATCH net 6/7] net: hns3: fix VF reset fail issue
From:   Paolo Abeni <pabeni@redhat.com>
To:     Jijie Shao <shaojijie@huawei.com>, yisen.zhuang@huawei.com,
        salil.mehta@huawei.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org
Cc:     shenjian15@huawei.com, wangjie125@huawei.com,
        liuyonglong@huawei.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Thu, 02 Nov 2023 17:24:14 +0100
In-Reply-To: <c87cfcbc-8cd6-4a01-bac0-74113f7ca904@huawei.com>
References: <20231028025917.314305-1-shaojijie@huawei.com>
         <20231028025917.314305-7-shaojijie@huawei.com>
         <9bc9514044063bc57155fb786f970ca1d69758b4.camel@redhat.com>
         <c87cfcbc-8cd6-4a01-bac0-74113f7ca904@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2023-11-02 at 20:16 +0800, Jijie Shao wrote:
> on 2023/11/2 18:45, Paolo Abeni wrote:
> > On Sat, 2023-10-28 at 10:59 +0800, Jijie Shao wrote:
> > >  =20
> > > -static void hclgevf_clear_event_cause(struct hclgevf_dev *hdev, u32 =
regclr)
> > > +static void hclgevf_clear_event_cause(struct hclgevf_dev *hdev, u32 =
regclr,
> > > +				      bool need_dalay)
> > >   {
> > > +#define HCLGEVF_RESET_DELAY		5
> > > +
> > > +	if (need_dalay)
> > > +		mdelay(HCLGEVF_RESET_DELAY);
> > 5ms delay in an interrupt handler is quite a lot. What about scheduling
> > a timer from the IH to clear the register when such delay is needed?
> >=20
> > Thanks!
> >=20
> > Paolo
>=20
> Using timer in this case will complicate the code and make maintenance di=
fficult.

Why?=20

Would something alike the following be ok? (plus reset_timer
initialization at vf creation and cleanup at vf removal time):

---
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c b/dr=
ivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
index a4d68fb216fb..626bc67065fc 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
@@ -1974,6 +1974,14 @@ static enum hclgevf_evt_cause hclgevf_check_evt_caus=
e(struct hclgevf_dev *hdev,
 	return HCLGEVF_VECTOR0_EVENT_OTHER;
 }
=20
+static void hclgevf_reset_timer(struct timer_list *t)
+{
+	struct hclgevf_dev *hdev =3D from_timer(hclgevf_dev, t, reset_timer);
+
+	hclgevf_clear_event_cause(hdev, HCLGEVF_VECTOR0_EVENT_RST);
+	hclgevf_reset_task_schedule(hdev);
+}
+
 static irqreturn_t hclgevf_misc_irq_handle(int irq, void *data)
 {
 	enum hclgevf_evt_cause event_cause;
@@ -1982,13 +1990,13 @@ static irqreturn_t hclgevf_misc_irq_handle(int irq,=
 void *data)
=20
 	hclgevf_enable_vector(&hdev->misc_vector, false);
 	event_cause =3D hclgevf_check_evt_cause(hdev, &clearval);
+	if (event_cause =3D=3D HCLGEVF_VECTOR0_EVENT_RST)
+		mod_timer(hdev->reset_timer, jiffies + msecs_to_jiffies(5));
+
 	if (event_cause !=3D HCLGEVF_VECTOR0_EVENT_OTHER)
 		hclgevf_clear_event_cause(hdev, clearval);
=20
 	switch (event_cause) {
-	case HCLGEVF_VECTOR0_EVENT_RST:
-		hclgevf_reset_task_schedule(hdev);
-		break;
 	case HCLGEVF_VECTOR0_EVENT_MBX:
 		hclgevf_mbx_handler(hdev);
 		break;
---

> We consider reducing the delay time by polling. For example,
> the code cycles every 50 us to check whether the write register takes eff=
ect.
> If yes, the function returns immediately. or the code cycles until 5 ms.
>=20
> Is this method appropriate?

IMHO such solution will not remove the problem. How frequent is
expected to be the irq generating such delay?

Thanks

Paolo


