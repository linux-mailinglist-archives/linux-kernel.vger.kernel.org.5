Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 474617DF02D
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 11:34:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346801AbjKBKcQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 06:32:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346370AbjKBKcO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 06:32:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45B5918C
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 03:31:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698921088;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uya6qCwp9TX55b7qKcTEgjZRX+1aFslaiEbQanZjulo=;
        b=EkyJeWUo5cwuqjKuQWuQKD8ReA7bDJ+HZkUusbHl52RaRc8gPu2Fd2d4rnXFVgFMXqAHxQ
        lyPWZT6TBSjcbmU9KROHtEKDjI2n25ABWZRTUacX+w5Kr4ElYRrrPcC9aOS0n5xgM/NxKb
        /HSabtg1JCfO7ZccT7yrjig39wLStiU=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-164-tJXc5c5oMuCtx2V0F0TLTg-1; Thu, 02 Nov 2023 06:31:27 -0400
X-MC-Unique: tJXc5c5oMuCtx2V0F0TLTg-1
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6754babc2c8so2511276d6.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Nov 2023 03:31:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698921086; x=1699525886;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uya6qCwp9TX55b7qKcTEgjZRX+1aFslaiEbQanZjulo=;
        b=btUaP7tFcp/5eIpy4QgwVLR9Wr3fBsRA//SiiZcqZeuT2BzHHmtobWdv6B+9TCTJ59
         YviQhL8QlFR+mIkmw+6QKX08u9RBMhBwNKkZF1iIRjZfXxjt/35Q///Z1T+NW5AAnRX3
         HTIlWEsPKxhMJKk2VebFodRYu73fChVRtQpscNAVxVFZhL+sGHKSzyOEp5LyfcpEYwth
         GYHb11gtofEZZLiBpiKJ7gmbMnVCR/eLlFWbELmrvTT97yxrpjkFxluuNc01EBoj115o
         uDChdWyUiaSmjIXMyjh46HaSltXrTAyAHErmGKv7/R1oE1qMavACIltRjI2IenbNPw5w
         5zwA==
X-Gm-Message-State: AOJu0Yxr9KWYIpeieuHzJFngKTIgSWAHviam4lf4ZbmciOI2Q6JyfgLO
        16km2s5SR7LhhN1Ju5fOVdD1y4FTKt7AEdEqHm5hYs5paW6hMQJGkWSXPH2nyuIq0V5cx0n6qih
        qS+IvHsAT/W9PYqo6dIQ155Gs
X-Received: by 2002:a05:6214:5582:b0:66d:1ff9:321f with SMTP id mi2-20020a056214558200b0066d1ff9321fmr19025170qvb.6.1698921086471;
        Thu, 02 Nov 2023 03:31:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEfwwYzxDn43o+6DdeqmVaDeLew80HGhBZMXezzUylt0dZXS6cPsK52nRgvg6FHsLPBgYaZow==
X-Received: by 2002:a05:6214:5582:b0:66d:1ff9:321f with SMTP id mi2-20020a056214558200b0066d1ff9321fmr19025152qvb.6.1698921086197;
        Thu, 02 Nov 2023 03:31:26 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-226-153.dyn.eolo.it. [146.241.226.153])
        by smtp.gmail.com with ESMTPSA id em15-20020ad44f8f000000b0065b229ecb8dsm2272455qvb.3.2023.11.02.03.31.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Nov 2023 03:31:25 -0700 (PDT)
Message-ID: <6603e0480feea2e7a28a865705da52bb99679a35.camel@redhat.com>
Subject: Re: [PATCH net 1/7] net: hns3: fix add VLAN fail issue
From:   Paolo Abeni <pabeni@redhat.com>
To:     Jijie Shao <shaojijie@huawei.com>, yisen.zhuang@huawei.com,
        salil.mehta@huawei.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org
Cc:     shenjian15@huawei.com, wangjie125@huawei.com,
        liuyonglong@huawei.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Thu, 02 Nov 2023 11:31:22 +0100
In-Reply-To: <20231028025917.314305-2-shaojijie@huawei.com>
References: <20231028025917.314305-1-shaojijie@huawei.com>
         <20231028025917.314305-2-shaojijie@huawei.com>
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

On Sat, 2023-10-28 at 10:59 +0800, Jijie Shao wrote:
> From: Jian Shen <shenjian15@huawei.com>
>=20
> The hclge_sync_vlan_filter is called in periodic task,
> trying to remove VLAN from vlan_del_fail_bmap. It can
> be concurrence with VLAN adding operation from user.
> So once user failed to delete a VLAN id, and add it
> again soon, it may be removed by the periodic task,
> which may cause the software configuration being
> inconsistent with hardware. So add mutex handling
> to avoid this.
>=20
>      user                        hns3 driver
>=20
>                                            periodic task
>                                                 =E2=94=82
>   add vlan 10 =E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80 hns3_vlan_rx_=
add_vid        =E2=94=82
>        =E2=94=82             (suppose success)          =E2=94=82
>        =E2=94=82                                        =E2=94=82
>   del vlan 10 =E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80  hns3_vlan_rx=
_kill_vid      =E2=94=82
>        =E2=94=82           (suppose fail,add to         =E2=94=82
>        =E2=94=82             vlan_del_fail_bmap)        =E2=94=82
>        =E2=94=82                                        =E2=94=82
>   add vlan 10 =E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80 hns3_vlan_rx_=
add_vid        =E2=94=82
>                      (suppose success)          =E2=94=82
>                                        foreach vlan_del_fail_bmp
>                                             del vlan 10
>=20
> Fixes: fe4144d47eef ("net: hns3: sync VLAN filter entries when kill VLAN =
ID failed")
> Signed-off-by: Jian Shen <shenjian15@huawei.com>
> Signed-off-by: Jijie Shao <shaojijie@huawei.com>
> ---
>  .../hisilicon/hns3/hns3pf/hclge_main.c        | 21 +++++++++++++------
>  .../hisilicon/hns3/hns3vf/hclgevf_main.c      | 11 ++++++++--
>  2 files changed, 24 insertions(+), 8 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/dr=
ivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
> index c42574e29747..a3230ac928a9 100644
> --- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
> +++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
> @@ -10026,8 +10026,6 @@ static void hclge_rm_vport_vlan_table(struct hclg=
e_vport *vport, u16 vlan_id,
>  	struct hclge_vport_vlan_cfg *vlan, *tmp;
>  	struct hclge_dev *hdev =3D vport->back;
> =20
> -	mutex_lock(&hdev->vport_lock);
> -
>  	list_for_each_entry_safe(vlan, tmp, &vport->vlan_list, node) {
>  		if (vlan->vlan_id =3D=3D vlan_id) {
>  			if (is_write_tbl && vlan->hd_tbl_status)
> @@ -10042,8 +10040,6 @@ static void hclge_rm_vport_vlan_table(struct hclg=
e_vport *vport, u16 vlan_id,
>  			break;
>  		}
>  	}
> -
> -	mutex_unlock(&hdev->vport_lock);
>  }
> =20
>  void hclge_rm_vport_all_vlan_table(struct hclge_vport *vport, bool is_de=
l_list)
> @@ -10452,11 +10448,16 @@ int hclge_set_vlan_filter(struct hnae3_handle *=
handle, __be16 proto,
>  	 * handle mailbox. Just record the vlan id, and remove it after
>  	 * reset finished.
>  	 */
> +	mutex_lock(&hdev->vport_lock);
>  	if ((test_bit(HCLGE_STATE_RST_HANDLING, &hdev->state) ||
>  	     test_bit(HCLGE_STATE_RST_FAIL, &hdev->state)) && is_kill) {
>  		set_bit(vlan_id, vport->vlan_del_fail_bmap);
> +		mutex_unlock(&hdev->vport_lock);
>  		return -EBUSY;
> +	} else if (!is_kill && test_bit(vlan_id, vport->vlan_del_fail_bmap)) {
> +		clear_bit(vlan_id, vport->vlan_del_fail_bmap);
>  	}
> +	mutex_unlock(&hdev->vport_lock);
> =20
>  	/* when port base vlan enabled, we use port base vlan as the vlan
>  	 * filter entry. In this case, we don't update vlan filter table
> @@ -10481,7 +10482,9 @@ int hclge_set_vlan_filter(struct hnae3_handle *ha=
ndle, __be16 proto,
>  		 * and try to remove it from hw later, to be consistence
>  		 * with stack
>  		 */
> +		mutex_lock(&hdev->vport_lock);
>  		set_bit(vlan_id, vport->vlan_del_fail_bmap);
> +		mutex_unlock(&hdev->vport_lock);

It looks like that the 'hclge_rm_vport_vlan_table()' call a few lines
above will now happen with the vport_lock unlocked.

That looks racy and would deserve at least a comment explaining why
it's safe.

Thanks,

Paolo

